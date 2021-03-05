export type FunctionArguments<T> = T extends (...args: infer U) => void ? U : [];
export type ReturnType<T> = T extends (...args: any[]) => infer U ? U : any;
export type PrependPlayerToArgs<T> = T extends (...args: any[]) => any
    ? (player: Player, ...args: FunctionArguments<T>) => ReturnType<T>
    : never;
