local library = loadstring(game:HttpGet("https://github.com/asumi10/asumi/blob/main/main.lua?raw=true"))()

local window = library:init("    DarkSecret Special", true, Enum.KeyCode.RightShift, true)

window:Divider("Player")

local sectionA = window:Section("Fly")

sectionA:Divider("Uçma Sistemi")

-- ==================== FLY HİLESİ ====================
local flyEnabled = false
local speed = 100
local bv, bg = nil, nil

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

sectionA:Switch("Fly", false, function(state)
    flyEnabled = state
    
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local hum = character:WaitForChild("Humanoid")
    
    if flyEnabled then
        hum.PlatformStand = true
        
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(400000, 400000, 400000)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root
        
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(400000, 400000, 400000)
        bg.P = 12500
        bg.Parent = root
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if hum then hum.PlatformStand = false end
    end
end)

sectionA:TextField("Uçma Hızı", "100", function(value)
    speed = tonumber(value) or 100
end)

sectionA:Button("Hızı Sıfırla", function()
    speed = 100
end)

-- Ana Uçuş Loop
RunService.Heartbeat:Connect(function()
    if not flyEnabled or not bv then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local cam = workspace.CurrentCamera
    local moveDir = Vector3.new(0, 0, 0)
    
    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end
    
    if moveDir.Magnitude > 0 then
        bv.Velocity = moveDir.Unit * speed
    else
        bv.Velocity = Vector3.new(0,0,0)
    end
    
    if bg then
        bg.CFrame = cam.CFrame
    end
end)
-- ===================================================

window:Divider("Bildirim")

local sectionB = window:Section("Bildirim Testi")

sectionB:Divider("Bildirim Test Butonları")

sectionB:Button("Kayan Hata Bildirimi", function()
   window:TempNotify("Hata!", "Uyarı Mesajı", "rbxassetid://12608259004")
end)

sectionB:Button("Bildirim 1", function() window:Notify("Merhaba!", "Ben Bildirimim", "Buton 1", "rbxassetid://12608259004", function() print(1) end) end)

sectionB:Button("Bildirim 2", function() window:Notify2("Merhaba!", "Ben Bildirimim", "Buton 1", "Buton 2", "rbxassetid://12608259004", function() print(1) end, function() print(2) end) end)

window:GreenButton(function()
   print("You clicked the green button!")
end)

sectionA:Select()

print("✅ DarkSecret Special Hub + Fly Hilesi yüklendi!")
