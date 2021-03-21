import { PrependPlayerToArgs } from "./function-types";

interface FunctionParams {
    onClientInvoke?: (...args: any[]) => any;
    onServerInvoke: (...args: any[]) => any;
}

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
    readonly invokeServer: T["onServerInvoke"];

    /**
     * Don't use this. It's an anti-pattern.
     */
    readonly invokeClient: PrependPlayerToArgs<T["onClientInvoke"]>;
}

export interface NetworkFunctionConstructor {
    new <T extends FunctionParams>(name: string): NetworkFunction<T>;
}
