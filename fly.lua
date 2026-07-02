--[[
    Flight System - Bağımsız Script
    Kurulum: ServerScriptService içerisine bir Script oluştur ve yapıştır.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- 1. Ayarlar
local SPEED = 50
local EVENT_NAME = "FlightEvent"

-- 2. Event Oluşturma
local flightEvent = Instance.new("RemoteEvent", ReplicatedStorage)
flightEvent.Name = EVENT_NAME

-- 3. Uçuş Mantığı
flightEvent.OnServerEvent:Connect(function(player, active, direction)
	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if active then
		local lv = root:FindFirstChild("FlightVelocity") or Instance.new("LinearVelocity", root)
		lv.Name = "FlightVelocity"
		lv.MaxForce = Vector3.new(1, 1, 1) * 100000
		lv.VectorVelocity = direction * SPEED
		
		local attachment = root:FindFirstChild("FlightAttachment") or Instance.new("Attachment", root)
		attachment.Name = "FlightAttachment"
		lv.Attachment0 = attachment
	else
		local lv = root:FindFirstChild("FlightVelocity")
		if lv then lv:Destroy() end
	end
end)
