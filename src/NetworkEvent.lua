local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local IS_CLIENT = RunService:IsClient()
local IS_SERVER = RunService:IsServer()

local NetworkEvent = {}
NetworkEvent.__index = NetworkEvent

local remote_folder = ReplicatedStorage:WaitForChild("Remote")

function NetworkEvent.new(name)
	local remote_event = remote_folder:FindFirstChild(name)
	
	if not remote_event then
		if IS_CLIENT then
			remote_event = remote_folder:WaitForChild(name)
		else
			remote_event = Instance.new("RemoteEvent")
			remote_event.Name = name
			remote_event.Parent = remote_folder
		end
	end
	
	return setmetatable({
		instance = remote_event,
		onServerEvent = remote_event.OnServerEvent,
		onClientEvent = remote_event.OnClientEvent,
	}, NetworkEvent)
end

function NetworkEvent:fireAllClients(...)
	if IS_CLIENT then
		warn("fireAllClients cannot be called from the client")
		return
	end
							
	self.instance:FireAllClients(...)
end

function NetworkEvent:fireClient(player, ...)
	if IS_CLIENT then
		warn("fireClient cannot be called from the client")
		return
	end
							
	self.instance:FireClient(player, ...)
end

function NetworkEvent:fireServer(...)
	if IS_SERVER then
		warn("fireServer cannot be called from the server")
		return
	end
	
	self.instance:FireServer(...)
end

return NetworkEvent