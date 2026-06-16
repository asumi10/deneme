local library = loadstring(game:HttpGet("https://github.com/asumi10/asumi/blob/main/main.lua?raw=true"))()

local window = library:init("    ASUMİ HUB", true, Enum.KeyCode.RightShift, true)

window:Divider("Player")

local sectionA = window:Section("Fly")

sectionA:Divider("Fly Settings")

-- ==================== FLY SCRIPT ====================
local flyEnabled = false
local flySpeed = 250

local bv, bg

local function startFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    -- Eski body varsa temizle
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(100000, 100000, 100000)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(100000, 100000, 100000)
    bg.P = 12500
    bg.Parent = root

    humanoid.PlatformStand = true

    spawn(function()
        while flyEnabled and root and root.Parent do
            local camera = workspace.CurrentCamera
            local direction = Vector3.new(0,0,0)

            local uis = game:GetService("UserInputService")
            
            if uis:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0,1,0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.new(0,1,0) end

            if direction.Magnitude > 0 then
                direction = direction.Unit * flySpeed
            end

            bv.Velocity = direction
            bg.CFrame = camera.CFrame
            task.wait()
        end
    end)
end

local function stopFly()
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
    
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end
end

sectionA:Switch("Fly", false, function(state)
    flyEnabled = state
    if state then
        startFly()
        window:TempNotify("Fly", "Uçuş Aktif! (WASD + Space + Ctrl)", "rbxassetid://12608259004")
    else
        stopFly()
        window:TempNotify("Fly", "Uçuş Kapatıldı", "rbxassetid://12608259004")
    end
end)
-- ===================================================

window:Divider("Bildirim")

local sectionB = window:Section("Bildirim Testi")

sectionB:Divider("Bildirim Test Butonları")

sectionB:Button("Kayan Hata Bildirimi", function()
   window:TempNotify("Hata!", "Uyarı Mesajı", "rbxassetid://12608259004")
end)

sectionB:Button("Bildirim 1", function() window:Notify("Merhaba!", "Ben Bildirimim", "Buton 1", "rbxassetid://12608259004",
   function()
       print(1)
   end)
end)

sectionB:Button("Bildirim 2", function() window:Notify2("Merhaba!", "Ben Bildirimim", "Buton 1", "Buton 2", "rbxassetid://12608259004",
   function()
       print(1)
   end,
   function()
       print(2)
   end)
end)

window:GreenButton(function()
   print("You clicked the green button!")
end)

sectionA:Select()

print("✅ ASUMİ HUB Yüklendi! RightShift tuşu ile aç/kapat")
