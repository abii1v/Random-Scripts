-- init
if not getgenv().configuration then
    getgenv().configuration = {}
    
    configuration.ToggleKey = "RightAlt";
    configuration.FixKey = "LeftAlt";
end

repeat wait() until game:IsLoaded()

-- variables
local Players, RunService, UserInputService, StarterGui, workspace = game:GetService"Players", game:GetService"RunService", game:GetService"UserInputService", game:GetService"StarterGui", game:GetService"Workspace";
local Client = Players.LocalPlayer

local FunnyToolStealer = true

workspace.FallenPartsDestroyHeight = -math.huge

-- functions 
function Notify(Text)
    StarterGui:SetCore("SendNotification", {
        Title = "xaxa", 
        Text = Text or "Text",
        Icon = Players:GetUserThumbnailAsync(Client.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420),
        Duration = 3,
    })
end

function GetCharacter(Player)
    return Player.Character or Player.CharacterAdded:Wait()
end

function ChildAddedEvent(Child)
    if FunnyToolStealer == true then 
        if (Child and Child:IsA"Tool" and Child:FindFirstChild"Handle" and Child.Parent == workspace) --[[and (string.find(string.lower(Child.Name), "boombox") or string.find(string.lower(Child.Name), "radio"))]] then
            local RootPart = GetCharacter(Client):FindFirstChild"HumanoidRootPart";
            local OldPosition = RootPart.Position
            
            repeat RunService.RenderStepped:Wait()
                RootPart.CFrame = CFrame.new(Child.Handle.Position) -- .CFrame will flop you on the ground
                -- RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.LookVector * 2 
            until (Child.Parent == GetCharacter(Client) or Child.Parent == Client.Backpack) or UserInputService:IsKeyDown(Enum.KeyCode[configuration.FixKey])
            
            RootPart.CFrame = CFrame.new(OldPosition)
        end
    end
end
workspace.ChildAdded:Connect(ChildAddedEvent)

UserInputService.InputBegan:Connect(function(Key)
    if not UserInputService:GetFocusedTextBox() then 
        if Key.KeyCode == Enum.KeyCode[configuration.ToggleKey] then 
            FunnyToolStealer = not FunnyToolStealer
            Notify(string.format("Funny Tool Stealer: %s", tostring(FunnyToolStealer)))
        elseif Key.KeyCode == Enum.KeyCode[configuration.FixKey] then 
            Notify("Checking for Tool Stealer Glitches")
        end
    end
end)

-- end 
Notify("funny tool stealer loaded")
