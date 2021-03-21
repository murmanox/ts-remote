import { PrependPlayerToArgs, FunctionArguments } from "./function-types";

interface EventParams {
    onClientEvent: (...args: any[]) => any;
    onServerEvent: (...args: any[]) => any;
}

interface NetworkEvent<T extends EventParams> {
    onClientEvent: RBXScriptSignal<T["onClientEvent"]>;
    onServerEvent: RBXScriptSignal<PrependPlayerToArgs<T["onServerEvent"]>>;

    fireAllClients(...args: FunctionArguments<T["onClientEvent"]>): void;
    fireClient(player: Player, ...args: FunctionArguments<T["onClientEvent"]>): void;
    fireServer(...args: FunctionArguments<T["onServerEvent"]>): void;
}

export interface NetworkEventConstructor {
    new <T extends EventParams>(name: string): NetworkEvent<T>;
}
