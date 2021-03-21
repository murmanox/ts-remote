# ts-remote
Babby's first package.

A very simple TS wrapper for Remote Events. Basically a 1 to 1 port from lua to Typescript. Hopefully type safe events between client and server.

Example usage:

In some type folder:
```typescript
interface ShootRemote {
    onClientEvent: (shoot_origin: CFrame, weapon: Gun, shooter: Player) => void;
    onServerEvent: (shoot_origin: CFrame) => void;
}
```

Client:
```typescript
const ShootRemote = new NetworkEvent<ShootRemote>("ShootRemote");
ShootRemote.onClientEvent.Connect((shoot_origin, weapon, shooter) => {
    // do client stuff
});

ShootRemote.fireServer(new CFrame());
```

Server:
```typescript
const ShootRemote = new NetworkEvent<ShootRemote>("ShootRemote");
ShootRemote.onServerEvent.Connect((player, shoot_origin) => {
    // do server stuff
});
```
