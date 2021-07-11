import { PrependPlayerToArgs, PrependThisToArgs } from "./function-types";

interface FunctionParams {
	onClientInvoke?: (...args: any[]) => any;
	onServerInvoke: (...args: any[]) => any;
}

type OnClientInvoke<T extends FunctionParams> = T["onClientInvoke"];
type OnServerInvoke<T extends FunctionParams> = T["onServerInvoke"];
interface NetworkFunction<T extends FunctionParams> {
	/**
	 * Don't use this. It's an anti-pattern.
	 */
	onClientInvoke: T["onClientInvoke"];
	onServerInvoke: PrependPlayerToArgs<T["onServerInvoke"]>;

	/**
	 * Calls the method bound to the NetworkFunction by NetworkFunction.onServerInvoke.
	 * Can only be called from the client.
	 */
	readonly invokeServer: PrependThisToArgs<T["onServerInvoke"], this>;

	/**
	 * Don't use this. It's an anti-pattern.
	 */
	readonly invokeClient: PrependThisToArgs<PrependPlayerToArgs<T["onClientInvoke"]>, this>;
}

export interface NetworkFunctionConstructor {
	new <T extends FunctionParams>(name: string): NetworkFunction<T>;
}
