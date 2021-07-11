local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local IS_CLIENT = RunService:IsClient()
local IS_SERVER = RunService:IsServer()

local NetworkFunction = {}
NetworkFunction.__index = NetworkFunction

local remote_folder
if IS_CLIENT then
	remote_folder = ReplicatedStorage:WaitForChild("Remote")
else
		remote_folder = ReplicatedStorage:FindFirstChild("Remote")
	if not remote_folder then
		remote_folder = Instance.new("Folder")
		remote_folder.Name = "Remote"
		remote_folder.Parent = ReplicatedStorage
	end
end

function NetworkFunction.new(name)
	local remote_function = remote_folder:FindFirstChild(name)
	
	if not remote_function then
		if IS_CLIENT then
			remote_function = remote_folder:WaitForChild(name)
		else
			remote_function = Instance.new("RemoteFunction")
			remote_function.Name = name
			remote_function.Parent = remote_folder
		end
	end
	
	local self = setmetatable({
		instance = remote_function,
	}, NetworkFunction)
	
	-- handle NetworkFunction.onServerInvoke = callback
	local mt = getmetatable(self)
	mt.__newindex = function(t, k, v)
		if k == "onServerInvoke" then
			t:setOnServerInvoke(v)
		elseif k == "onClientInvoke" then
			t:setOnClientInvoke(v)
		else
			rawset(t, k, v)
		end
	end
	setmetatable(self, mt)
	
	return self
end

function NetworkFunction:setOnServerInvoke(callback)
	if IS_CLIENT then
		warn("onServerInvoke cannot be set on the client")
		return
	end
	
	self.instance.OnServerInvoke = callback
end

function NetworkFunction:setOnClientInvoke(callback)
	if IS_SERVER then
		warn("onClientInvoke cannot be set on the server")
		return
	end

	self.instance.OnClientInvoke = callback
end

function NetworkFunction:invokeClient(...)
	if IS_CLIENT then
		warn("invokeClient cannot be called from the client")
		return
	end
	
	return self.instance:InvokeClient(...)
end

function NetworkFunction:invokeServer(...)
	if IS_SERVER then
		warn("invokeServer cannot be called from the server")
		return
	end
	
	return self.instance:InvokeServer(...)
end

return NetworkFunction