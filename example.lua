local library = loadstring(game:HttpGet("https://github.com/asumi10/asumi/blob/main/main.lua?raw=true"))()

local window = library:init("    DarkSecret Special", true, Enum.KeyCode.RightShift, true)

window:Divider("Player")

local sectionA = window:Section("Fly")

sectionA:Divider("Uçma Sistemi")

-- ==================== YENİ FLY HİLESİ (CFrame) ====================
local flyEnabled = false
local speed = 100
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local connection = nil

sectionA:Switch("Fly", false, function(state)
    flyEnabled = state
    
    local character = player.Character or player.CharacterAdded:Wait()
    local hum = character:WaitForChild("Humanoid")
    
    if flyEnabled then
        hum.PlatformStand = true
        print("✅ Fly Aktif")
    else
        hum.PlatformStand = false
        print("❌ Fly Kapalı")
    end
end)

sectionA:TextField("Uçma Hızı", "100", function(value)
    speed = tonumber(value) or 100
end)

sectionA:Button("Hızı Sıfırla", function()
    speed = 100
end)

-- Ana Uçuş Loop
if connection then connection:Disconnect() end

connection = RunService.Heartbeat:Connect(function(dt)
    if not flyEnabled then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = character.HumanoidRootPart
    local cam = workspace.CurrentCamera
    local moveDir = Vector3.new(0, 0, 0)
    
    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end
    
    if moveDir.Magnitude > 0 then
        root.CFrame = root.CFrame + (moveDir.Unit * speed * dt * 5)
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
