class 'PlaneReverse'

function PlaneReverse:__init()
	Network:Subscribe("PlaneReverse", self, self.PlaneReverse)
end

function PlaneReverse:PlaneReverse(args, sender)
	local vehicle = args
	
	if not sender:InVehicle() then return end
	if sender:GetState() ~= PlayerState.InVehicle then return end

	local v = sender:GetVehicle()
	local backward = v:GetAngle() * Vector3(0, 0, 1)
	local vel = v:GetLinearVelocity()
	local new_vel = vel + (backward * 1)

	v:SetLinearVelocity(new_vel)
end

-- Initialize
local planeReverse = PlaneReverse()