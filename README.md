# ts-remote
Babby's first package.

A very simple TS wrapper for Remote Events and Remote Functions. Basically a 1 to 1 port from lua to Typescript. Hopefully type safe events between client and server.

Example usage:

In some type folder:
```typescript
interface ShootRemote {
    onClientEvent: (shoot_origin: CFrame, weapon: Gun, shooter: Player) => void;
    onServerEvent: (shoot_origin: CFrame) => void;
}

interface GetLevel {
    onServerInvoke: (skill: string) => number
}
```

Client:
```typescript
// remote event wrapper
const ShootRemote = new NetworkEvent<ShootRemote>("ShootRemote");
ShootRemote.onClientEvent.Connect((shoot_origin, weapon, shooter) => {
    // do client stuff
});

ShootRemote.fireServer(new CFrame());

// remote function wrapper
const ShootRemote = new NetworkEvent<GetLevel>("GetLevel");
const level = ShootRemote.invokeServer("woodcutting")
```

Server:
```typescript
// remote event wrapper
const ShootRemote = new NetworkEvent<ShootRemote>("ShootRemote");
ShootRemote.onServerEvent.Connect((player, shoot_origin) => {
    // do server stuff
});

remote function wrapper
const ShootRemote = new NetworkEvent<GetLevel>("GetLevel");
ShootRemote.onServerInvoke = (player, skill) => {
    // return player's skill level
}
```
