class 'PlaneReverse'

function PlaneReverse:__init()
	-- Variables
	self.inPlane = false
	self.planes = {}
	self.timer = Timer()
	
	-- Add planes
	self:AddPlane(59)
	self:AddPlane(81)
	self:AddPlane(51)
	self:AddPlane(30)
	self:AddPlane(34)
	self:AddPlane(85)
	self:AddPlane(39)
	self:AddPlane(53)
	self:AddPlane(24)
	
	-- Subscribe to events
	Events:Subscribe("LocalPlayerInput", self, self.LocalPlayerInput)
	Events:Subscribe("LocalPlayerEnterVehicle", self, self.LocalPlayerEnterVehicle)
	Events:Subscribe("LocalPlayerExitVehicle", self, self.LocalPlayerExitVehicle)
end

function PlaneReverse:AddPlane(id)
	self.planes[id] = true
end

function PlaneReverse:LocalPlayerInput(args)
	if args.input ~= Action.PlaneDecTrust or
		not self.inPlane or
		not LocalPlayer:InVehicle() or
		LocalPlayer:GetState() ~= PlayerState.InVehicle or
		not IsValid(LocalPlayer:GetVehicle()) or
		self.timer:GetSeconds() < 0.2 then
		return true
	end
	
	Network:Send("PlaneReverse", true)
	self.timer:Restart()
end

function PlaneReverse:LocalPlayerEnterVehicle(args)
	self.inPlane = self.planes[args.vehicle:GetModelId()] == true
end

function PlaneReverse:LocalPlayerExitVehicle(args)
	self.inPlane = false
end

-- Initialize
local planeReverse = PlaneReverse()