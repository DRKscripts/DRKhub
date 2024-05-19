
local player = game.Players.LocalPlayer

local function tweenToPlayer(targetPlayer)
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then return end
    
    local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHumanoidRootPart then return end
    
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local tweenInfo = TweenInfo.new(
        (targetHumanoidRootPart.Position - humanoidRootPart.Position).Magnitude / 400,
        Enum.EasingStyle.Linear
    )
    
    local tween = game:GetService("TweenService"):Create(
        humanoidRootPart,
        tweenInfo,
        { CFrame = targetHumanoidRootPart.CFrame }
    )
    
    tween:Play()
end

Tabs.Main:AddButton({
    Title = "Tween to Random Player",
    Description = "Tween the local player to a random player",
    Callback = function()
        local players = game.Players:GetPlayers()
        if #players <= 1 then
            print("There are no other players in the game.")
            return
        end
        
        local randomIndex = math.random(1, #players)
        local randomPlayer = players[randomIndex]
        
        tweenToPlayer(randomPlayer)
        
        print("Tweening to player:", randomPlayer.Name)
    end
})

local player = game.Players.LocalPlayer
local hitboxSize = Vector3.new(6, 10, 6)

local function createHitbox(player)
    local hitbox = Instance.new("Part")
    hitbox.Name = "ESP_Hitbox"
    hitbox.Anchored = true
    hitbox.CanCollide = false
    hitbox.Transparency = 0.5
    hitbox.Size = hitboxSize
    hitbox.Color = Color3.new(1, 0, 0)

    local function updateHitbox()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            hitbox.CFrame = CFrame.new(rootPart.Position)
        end
    end

    updateHitbox()
    hitbox.Parent = workspace.CurrentCamera

    game:GetService("RunService").RenderStepped:Connect(updateHitbox)
end
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                createHitbox(otherPlayer)
            end
        end
        print("Hitbox ESP enabled.")
    end
