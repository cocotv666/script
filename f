local lplr = game.Players.LocalPlayer
local theme = Color3.new(1, 0, 0)

function nearestUser(max)
    if max == nil then max = math.huge end
    local closestDistance = math.huge
    local closestPlayer = nil
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lplr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance and distance < max and player.Character.Humanoid.Health > 0.1 and player.Team ~= lplr.Team then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

function getPFP(player)
    local userId = player.UserId
    return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(userId) .. "&width=150&height=150&format=png"
end

local TargetHuds = {}

local function getTargetHudAPI()
    return {
        drawToScreen = function(target)
            local TargetHud = Instance.new("ScreenGui")
            local Main = Instance.new("Frame")
            local Image = Instance.new("ImageLabel")
            local UICorner = Instance.new("UICorner")
            local DisplayName = Instance.new("TextLabel")
            local BackGroundBar = Instance.new("Frame")
            local MainBar = Instance.new("Frame")

            table.insert(TargetHuds, TargetHud)
            TargetHud.Name = "TargetHud"
            TargetHud.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

            Main.Name = "Main"
            Main.Parent = TargetHud
            Main.BackgroundColor3 = Color3.new(0, 0, 0)
            Main.BackgroundTransparency = 0.4
            Main.BorderSizePixel = 0
            Main.Position = UDim2.new(0.512522876, 0, 0.45243904, 0)
            Main.Size = UDim2.new(0, 207, 0, 78)

            Image.Name = "Image"
            Image.Parent = Main
            Image.BackgroundColor3 = Color3.new(1, 1, 1)
            Image.BackgroundTransparency = 1
            Image.Position = UDim2.new(0.0289855078, 0, 0.0769230798, 0)
            Image.Size = UDim2.new(0, 80, 0, 66)
            Image.Image = getPFP(target)
            UICorner.Parent = Image

            DisplayName.Name = "DisplayName"
            DisplayName.Parent = Main
            DisplayName.BackgroundColor3 = Color3.new(1, 1, 1)
            DisplayName.BackgroundTransparency = 1
            DisplayName.Position = UDim2.new(0.473429948, 0, 0.0769230798, 0)
            DisplayName.Size = UDim2.new(0, 102, 0, 21)
            DisplayName.Font = Enum.Font.SourceSans
            DisplayName.Text = target.DisplayName
            DisplayName.TextColor3 = theme
            DisplayName.TextScaled = true
            DisplayName.TextSize = 14
            DisplayName.TextWrapped = true

            BackGroundBar.Name = "BackGroundBar"
            BackGroundBar.Parent = Main
            BackGroundBar.BackgroundColor3 = Color3.new(1, 1, 1)
            BackGroundBar.BackgroundTransparency = 0.8
            BackGroundBar.BorderSizePixel = 0
            BackGroundBar.Position = UDim2.new(0.473429948, 0, 0.512820482, 0)
            BackGroundBar.Size = UDim2.new(0, 100, 0, 22)

            MainBar.Name = "MainBar"
            MainBar.Parent = BackGroundBar
            MainBar.BackgroundColor3 = theme
            MainBar.BorderSizePixel = 0
            MainBar.Position = UDim2.new(0.0134301754, 0, 0, 0)
            MainBar.Size = UDim2.new(0, target.Character.Humanoid.Health or 0, 0, 22)
        end,

        removeTargetHuds = function()
            if #TargetHuds > 0 then
                for i, v in pairs(TargetHuds) do
                    for i2, v2 in pairs(v:GetDescendants()) do
                        v2.Visible = false
                        v2:Remove()
                    end
                end
                table.clear(TargetHuds)
            end
        end
    }
end

local targetHudAPI = getTargetHudAPI()

while true do
    wait(0.1)

    local target = nearestUser()

    if target then
        targetHudAPI.drawToScreen(target)
    end
end
