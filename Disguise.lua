
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local disguiseUserID = 1074127624  -- Default

local function createDisguiseGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DisguiseGUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    
    local Disguise = Instance.new("Folder")
    Disguise.Name = "Disguise"
    Disguise.Parent = ScreenGui
    
    local DisguiseId = Instance.new("StringValue")
    DisguiseId.Name = "DisguiseId"
    DisguiseId.Value = ""
    DisguiseId.Parent = Disguise
    
    local Toggle = Instance.new("BoolValue")
    Toggle.Name = "Enabled"
    Toggle.Value = false
    Toggle.Parent = Disguise
    
    return Disguise, DisguiseId, Toggle
end

local function Disguisechar(char)
    task.spawn(function()
        if not char then return end
        local hum = char:WaitForChild("Humanoid", 9e9)
        char:WaitForChild("Head", 9e9)
        
        local Disguise = LocalPlayer.PlayerGui:FindFirstChild("DisguiseGUI")
        if not Disguise then return end
        
        local DisguiseId = Disguise.Disguise:FindFirstChild("DisguiseId")
        local targetID = DisguiseId.Value == "" and disguiseUserID or tonumber(DisguiseId.Value)
        
        local DisguiseDescription
        local suc = false
        repeat
            suc = pcall(function()
                DisguiseDescription = Players:GetHumanoidDescriptionFromUserId(targetID)
            end)
            if suc then break end
            task.wait(1)
        until suc
        
        if not Disguise.Disguise.Enabled.Value then return end
        
        local desc = hum:FindFirstChild("HumanoidDescription") or {}
        DisguiseDescription.HeightScale = desc.HeightScale or 1
        
        char.Archivable = true
        local Disguiseclone = char:Clone()
        Disguiseclone.Name = "Disguisechar"
        Disguiseclone.Parent = workspace
        
        -- Clean clone accessories/clothing
        for _, v in pairs(Disguiseclone:GetChildren()) do 
            if v:IsA("Accessory") or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then  
                v:Destroy()
            end
        end
        
        if not Disguiseclone:FindFirstChildWhichIsA("Humanoid") then 
            Disguiseclone:Destroy()
            return 
        end
        
        Disguiseclone.Humanoid:ApplyDescription(DisguiseDescription)
        
        -- Move original accessories to nil
        for _, v in pairs(char:GetChildren()) do 
            if (v:IsA("Accessory") and not v:GetAttribute("InvItem") and not v:GetAttribute("ArmorSlot")) 
            or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") 
            or v:IsA("Folder") or v:IsA("Model") then 
                v.Parent = game
            end
        end
        
        -- Handle new children
        char.ChildAdded:Connect(function(v)
            if ((v:IsA("Accessory") and not v:GetAttribute("InvItem") and not v:GetAttribute("ArmorSlot")) 
            or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors")) 
            and not v:GetAttribute("Disguise") then 
                repeat task.wait() v.Parent = game until v.Parent == game
            end
        end)
        
        -- Transfer animations
        for _, v in pairs(Disguiseclone:WaitForChild("Animate"):GetChildren()) do 
            v:SetAttribute("Disguise", true)
            local real = char.Animate:FindFirstChild(v.Name)
            if v:IsA("StringValue") and real then 
                real.Parent = game
                v.Parent = char.Animate
            end
        end
        
        -- Apply disguise parts
        for _, v in pairs(Disguiseclone:GetChildren()) do 
            v:SetAttribute("Disguise", true)
            if v:IsA("Accessory") then  
                for _, v2 in pairs(v:GetDescendants()) do 
                    if v2:IsA("Weld") and v2.Part1 then 
                        v2.Part1 = char[v2.Part1.Name]
                    end
                end
                v.Parent = char
            elseif v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then  
                v.Parent = char
            elseif v.Name == "Head" and char.Head:IsA("MeshPart") then 
                char.Head.MeshId = v.MeshId
            end
        end
        
        -- Face swap
        local localface = char:FindFirstChild("face", true)
        local cloneface = Disguiseclone:FindFirstChild("face", true)
        if localface and cloneface then 
            localface.Parent = game 
            cloneface.Parent = char.Head 
        end
        
        Disguiseclone:Destroy()
    end)
end

-- Hook character spawn
LocalPlayer.CharacterAdded:Connect(Disguisechar)
if LocalPlayer.Character then
    Disguisechar(LocalPlayer.Character)
end

Window:Notify({ Title="Disguise", Desc="Loaded! Set UserID in Options tab.", Time=3 })
