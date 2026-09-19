--========================================
-- PART 1/3 - LUNAR ESP CORE / UI
--========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Settings = {
    Enabled = true,
    BoxESP = true,
    NameESP = true,
    HealthESP = true,
    DistanceESP = true,
    TracerESP = false,
    SkeletonESP = false,
    TeamCheck = true,
    MaxDistance = 1000,
    Rainbow = false
}

local Colors = {
    Background = Color3.fromRGB(17, 12, 24),
    Panel = Color3.fromRGB(25, 18, 35),
    Purple = Color3.fromRGB(175, 100, 255),
    PurpleDark = Color3.fromRGB(100, 50, 155),
    Text = Color3.fromRGB(235, 225, 245),
    SubText = Color3.fromRGB(150, 135, 165),
    Green = Color3.fromRGB(100, 255, 160),
    Red = Color3.fromRGB(255, 80, 110),
    White = Color3.fromRGB(255, 255, 255)
}

local function GetGuiParent()
    local Success, Hui = pcall(function()
        return gethui()
    end)

    if Success and Hui then
        return Hui
    end

    local CoreGui = game:GetService("CoreGui")

    if CoreGui then
        return CoreGui
    end

    return LocalPlayer:WaitForChild("PlayerGui")
end

local GuiParent = GetGuiParent()

pcall(function()
    local Old = GuiParent:FindFirstChild("LunarESP")

    if Old then
        Old:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LunarESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 500)
Main.Position = UDim2.new(0.5, -170, 0.5, -250)
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Purple
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.Size = UDim2.new(1, 45, 1, 45)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Colors.Purple
Glow.ImageTransparency = 0.82
Glow.ZIndex = 0
Glow.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 68)
TopBar.BackgroundTransparency = 1
TopBar.ZIndex = 10
TopBar.Parent = Main

local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(0, 44, 0, 44)
LogoButton.Position = UDim2.new(0, 12, 0.5, -22)
LogoButton.BackgroundTransparency = 1
LogoButton.BorderSizePixel = 0
LogoButton.Text = "🌙"
LogoButton.TextSize = 30
LogoButton.Font = Enum.Font.GothamBold
LogoButton.TextColor3 = Color3.fromRGB(190, 145, 255)
LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 20
LogoButton.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Position = UDim2.new(0, 62, 0, 13)
Title.Size = UDim2.new(1, -150, 0, 24)
Title.BackgroundTransparency = 1
Title.Text = "Lunar ESP"
Title.TextColor3 = Colors.Text
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 20
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Position = UDim2.new(0, 62, 0, 37)
Subtitle.Size = UDim2.new(1, -150, 0, 18)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Universal player visualization"
Subtitle.TextColor3 = Colors.SubText
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 20
Subtitle.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 34, 0, 34)
MinimizeButton.Position = UDim2.new(1, -75, 0.5, -17)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 180, 220)
MinimizeButton.TextSize = 22
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.AutoButtonColor = false
MinimizeButton.ZIndex = 20
MinimizeButton.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 34, 0, 34)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17)
CloseButton.BackgroundTransparency = 1
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 180, 220)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 20
CloseButton.Parent = TopBar

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Position = UDim2.new(0, 15, 0, 78)
Content.Size = UDim2.new(1, -30, 1, -90)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Colors.Purple
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ZIndex = 5
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.Parent = Content

local function CreateSection(Text, Order)
    local Label = Instance.new("TextLabel")

    Label.Name = "Section_" .. Text
    Label.Size = UDim2.new(1, -5, 0, 24)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.TextColor3 = Colors.Purple
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.LayoutOrder = Order
    Label.Parent = Content

    return Label
end

local function CreateControlButton(Name, Text, Order)
    local Button = Instance.new("TextButton")

    Button.Name = Name
    Button.Size = UDim2.new(1, -5, 0, 42)
    Button.BackgroundColor3 = Colors.Panel
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = Text
    Button.TextColor3 = Colors.Text
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamSemibold
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.LayoutOrder = Order
    Button.ZIndex = 10
    Button.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 14)
    Padding.Parent = Button

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Colors.PurpleDark
    Stroke.Transparency = 0.65
    Stroke.Thickness = 1
    Stroke.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Color3.fromRGB(34, 24, 47)
            }
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Colors.Panel
            }
        ):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.08),
            {
                Size = UDim2.new(1, -9, 0, 40)
            }
        ):Play()

        task.delay(0.08, function()
            if Button.Parent then
                TweenService:Create(
                    Button,
                    TweenInfo.new(0.12),
                    {
                        Size = UDim2.new(1, -5, 0, 42)
                    }
                ):Play()
            end
        end)
    end)

    return Button
end

CreateSection("ESP", 1)

local ESPButton = CreateControlButton(
    "ESPButton",
    "ESP: ON",
    2
)

local BoxButton = CreateControlButton(
    "BoxButton",
    "Box ESP: ON",
    3
)

local NameButton = CreateControlButton(
    "NameButton",
    "Name ESP: ON",
    4
)

local HealthButton = CreateControlButton(
    "HealthButton",
    "Health Bar: ON",
    5
)

local DistanceButton = CreateControlButton(
    "DistanceButton",
    "Distance: ON",
    6
)

CreateSection("Visuals", 7)

local TracerButton = CreateControlButton(
    "TracerButton",
    "Tracers: OFF",
    8
)

local SkeletonButton = CreateControlButton(
    "SkeletonButton",
    "Skeleton: OFF",
    9
)

local TeamButton = CreateControlButton(
    "TeamButton",
    "Team Check: ON",
    10
)

local RainbowButton = CreateControlButton(
    "RainbowButton",
    "Rainbow ESP: OFF",
    11
)

local DistanceLimitButton = CreateControlButton(
    "DistanceLimitButton",
    "Max Distance: 1000",
    12
)

local TargetColorButton = CreateControlButton(
    "TargetColorButton",
    "ESP Color: Purple",
    13
)

local FullSize = UDim2.new(0, 340, 0, 500)
local MiniSize = UDim2.new(0, 64, 0, 64)

local IsMinimized = false

Main.Size = UDim2.new(0, 0, 0, 0)

TweenService:Create(
    Main,
    TweenInfo.new(
        0.65,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {
        Size = FullSize
    }
):Play()

task.spawn(function()
    while ScreenGui.Parent do
        TweenService:Create(
            LogoButton,
            TweenInfo.new(
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                TextColor3 = Color3.fromRGB(220, 180, 255),
                Rotation = 8
            }
        ):Play()

        task.wait(1)

        TweenService:Create(
            LogoButton,
            TweenInfo.new(
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                TextColor3 = Color3.fromRGB(175, 125, 240),
                Rotation = -8
            }
        ):Play()

        task.wait(1)
    end
end)

--========================================
-- PART 2/3 - ESP SYSTEM
--========================================

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "LunarESP_Objects"
ESPFolder.Parent = ScreenGui

local ESPObjects = {}
local ColorIndex = 1

local ESPColors = {
    Color3.fromRGB(175, 100, 255),
    Color3.fromRGB(100, 200, 255),
    Color3.fromRGB(100, 255, 160),
    Color3.fromRGB(255, 220, 100),
    Color3.fromRGB(255, 100, 150)
}

local function IsEnemy(Player)
    if Player == LocalPlayer then
        return false
    end

    if not Settings.TeamCheck then
        return true
    end

    if LocalPlayer.Team and Player.Team then
        return LocalPlayer.Team ~= Player.Team
    end

    if LocalPlayer.TeamColor and Player.TeamColor then
        return LocalPlayer.TeamColor ~= Player.TeamColor
    end

    return true
end

local function GetCharacter(Player)
    if not Player then
        return nil
    end

    local Character = Player.Character

    if not Character then
        return nil
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Root = Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or Humanoid.Health <= 0 or not Root then
        return nil
    end

    return Character, Humanoid, Root
end

local function GetESPColor()
    if Settings.Rainbow then
        return Color3.fromHSV((tick() % 5) / 5, 0.85, 1)
    end

    return ESPColors[ColorIndex]
end

local function CreateESP(Player)
    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return
    end

    local Object = {}

    local Box = Instance.new("Highlight")
    Box.Name = "BoxESP"
    Box.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Box.FillTransparency = 1
    Box.OutlineTransparency = 0
    Box.OutlineColor = GetESPColor()
    Box.Enabled = false
    Box.Parent = ESPFolder

    Object.Box = Box

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "PlayerInfo"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.new(0, 220, 0, 65)
    Billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    Billboard.Enabled = false
    Billboard.Parent = ESPFolder

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "Name"
    NameLabel.Size = UDim2.new(1, 0, 0, 22)
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextColor3 = Colors.White
    NameLabel.TextStrokeTransparency = 0
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.Text = ""
    NameLabel.Parent = Billboard

    local DistanceLabel = Instance.new("TextLabel")
    DistanceLabel.Name = "Distance"
    DistanceLabel.Position = UDim2.new(0, 0, 0, 21)
    DistanceLabel.Size = UDim2.new(1, 0, 0, 18)
    DistanceLabel.BackgroundTransparency = 1
    DistanceLabel.TextColor3 = Colors.SubText
    DistanceLabel.TextStrokeTransparency = 0
    DistanceLabel.TextSize = 10
    DistanceLabel.Font = Enum.Font.Gotham
    DistanceLabel.Text = ""
    DistanceLabel.Parent = Billboard

    local HealthBack = Instance.new("Frame")
    HealthBack.Name = "HealthBack"
    HealthBack.Position = UDim2.new(0, -7, 0, 0)
    HealthBack.Size = UDim2.new(0, 4, 0, 42)
    HealthBack.BackgroundColor3 = Color3.fromRGB(35, 25, 40)
    HealthBack.BorderSizePixel = 0
    HealthBack.Visible = false
    HealthBack.Parent = Billboard

    local HealthFill = Instance.new("Frame")
    HealthFill.Name = "HealthFill"
    HealthFill.AnchorPoint = Vector2.new(0, 1)
    HealthFill.Position = UDim2.new(0, 0, 1, 0)
    HealthFill.Size = UDim2.new(1, 0, 1, 0)
    HealthFill.BackgroundColor3 = Colors.Green
    HealthFill.BorderSizePixel = 0
    HealthFill.Parent = HealthBack

    Object.Billboard = Billboard
    Object.NameLabel = NameLabel
    Object.DistanceLabel = DistanceLabel
    Object.HealthBack = HealthBack
    Object.HealthFill = HealthFill

    ESPObjects[Player] = Object
end

local function RemoveESP(Player)
    local Object = ESPObjects[Player]

    if not Object then
        return
    end

    for _, Item in pairs(Object) do
        if typeof(Item) == "Instance" then
            pcall(function()
                Item:Destroy()
            end)
        end
    end

    ESPObjects[Player] = nil
end

local function UpdateESP(Player, Object)
    if not Settings.Enabled then
        Object.Box.Enabled = false
        Object.Billboard.Enabled = false
        return
    end

    local Character, Humanoid, Root = GetCharacter(Player)

    if not Character or not IsEnemy(Player) then
        Object.Box.Enabled = false
        Object.Billboard.Enabled = false
        return
    end

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Distance = (Camera.CFrame.Position - Root.Position).Magnitude

    if Distance > Settings.MaxDistance then
        Object.Box.Enabled = false
        Object.Billboard.Enabled = false
        return
    end

    local Color = GetESPColor()

    Object.Box.Adornee = Character
    Object.Box.OutlineColor = Color
    Object.Box.Enabled = Settings.BoxESP

    Object.Billboard.Adornee = Root
    Object.Billboard.Enabled =
        Settings.NameESP
        or Settings.DistanceESP
        or Settings.HealthESP

    Object.NameLabel.Visible = Settings.NameESP
    Object.DistanceLabel.Visible = Settings.DistanceESP

    if Settings.NameESP then
        Object.NameLabel.Text = Player.DisplayName
        Object.NameLabel.TextColor3 = Color
    end

    if Settings.DistanceESP then
        Object.DistanceLabel.Text =
            "[" .. math.floor(Distance) .. " studs]"
    end

    if Settings.HealthESP then
        Object.HealthBack.Visible = true

        local HealthPercent =
            math.clamp(
                Humanoid.Health / math.max(Humanoid.MaxHealth, 1),
                0,
                1
            )

        Object.HealthFill.Size =
            UDim2.new(1, 0, HealthPercent, 0)

        Object.HealthFill.BackgroundColor3 =
            Color3.fromRGB(
                255 * (1 - HealthPercent),
                255 * HealthPercent,
                90
            )
    else
        Object.HealthBack.Visible = false
    end
end

for _, Player in ipairs(Players:GetPlayers()) do
    CreateESP(Player)
end

Players.PlayerAdded:Connect(function(Player)
    CreateESP(Player)
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

local TracerObjects = {}

local function CreateTracer(Player)
    if TracerObjects[Player] then
        return
    end

    local Line = Instance.new("Frame")
    Line.Name = "Tracer"
    Line.AnchorPoint = Vector2.new(0.5, 0.5)
    Line.BackgroundColor3 = Colors.Purple
    Line.BorderSizePixel = 0
    Line.Size = UDim2.new(0, 2, 0, 0)
    Line.Visible = false
    Line.ZIndex = 3
    Line.Parent = ScreenGui

    TracerObjects[Player] = Line
end

local function RemoveTracer(Player)
    local Line = TracerObjects[Player]

    if Line then
        Line:Destroy()
        TracerObjects[Player] = nil
    end
end

for _, Player in ipairs(Players:GetPlayers()) do
    CreateTracer(Player)
end

Players.PlayerAdded:Connect(function(Player)
    CreateTracer(Player)
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveTracer(Player)
end)

local function UpdateTracer(Player)
    local Line = TracerObjects[Player]

    if not Line or not Settings.Enabled or not Settings.TracerESP then
        if Line then
            Line.Visible = false
        end
        return
    end

    local Character, Humanoid, Root = GetCharacter(Player)

    if not Character or not IsEnemy(Player) then
        Line.Visible = false
        return
    end

    local Camera = workspace.CurrentCamera

    if not Camera then
        Line.Visible = false
        return
    end

    local Distance =
        (Camera.CFrame.Position - Root.Position).Magnitude

    if Distance > Settings.MaxDistance then
        Line.Visible = false
        return
    end

    local ScreenPosition, OnScreen =
        Camera:WorldToViewportPoint(Root.Position)

    if not OnScreen then
        Line.Visible = false
        return
    end

    local Viewport = Camera.ViewportSize

    local Start =
        Vector2.new(Viewport.X / 2, Viewport.Y - 25)

    local Finish =
        Vector2.new(ScreenPosition.X, ScreenPosition.Y)

    local Delta = Finish - Start
    local Length = Delta.Magnitude

    Line.Position = UDim2.fromOffset(
        (Start.X + Finish.X) / 2,
        (Start.Y + Finish.Y) / 2
    )

    Line.Size = UDim2.new(0, 2, 0, Length)

    Line.Rotation =
        math.deg(math.atan2(Delta.Y, Delta.X)) - 90

    Line.BackgroundColor3 = GetESPColor()
    Line.Visible = true
end

RunService.RenderStepped:Connect(function()
    for Player, Object in pairs(ESPObjects) do
        if Player.Parent then
            UpdateESP(Player, Object)
        end
    end

    for Player in pairs(TracerObjects) do
        if Player.Parent then
            UpdateTracer(Player)
        end
    end
end)

ESPButton.MouseButton1Click:Connect(function()
    Settings.Enabled = not Settings.Enabled

    ESPButton.Text =
        "ESP: " .. (Settings.Enabled and "ON" or "OFF")
end)

BoxButton.MouseButton1Click:Connect(function()
    Settings.BoxESP = not Settings.BoxESP

    BoxButton.Text =
        "Box ESP: " .. (Settings.BoxESP and "ON" or "OFF")
end)

NameButton.MouseButton1Click:Connect(function()
    Settings.NameESP = not Settings.NameESP

    NameButton.Text =
        "Name ESP: " .. (Settings.NameESP and "ON" or "OFF")
end)

HealthButton.MouseButton1Click:Connect(function()
    Settings.HealthESP = not Settings.HealthESP

    HealthButton.Text =
        "Health Bar: " .. (Settings.HealthESP and "ON" or "OFF")
end)

DistanceButton.MouseButton1Click:Connect(function()
    Settings.DistanceESP = not Settings.DistanceESP

    DistanceButton.Text =
        "Distance: " .. (Settings.DistanceESP and "ON" or "OFF")
end)

TracerButton.MouseButton1Click:Connect(function()
    Settings.TracerESP = not Settings.TracerESP

    TracerButton.Text =
        "Tracers: " .. (Settings.TracerESP and "ON" or "OFF")
end)

TeamButton.MouseButton1Click:Connect(function()
    Settings.TeamCheck = not Settings.TeamCheck

    TeamButton.Text =
        "Team Check: " .. (Settings.TeamCheck and "ON" or "OFF")
end)

RainbowButton.MouseButton1Click:Connect(function()
    Settings.Rainbow = not Settings.Rainbow

    RainbowButton.Text =
        "Rainbow ESP: " .. (Settings.Rainbow and "ON" or "OFF")
end)

DistanceLimitButton.MouseButton1Click:Connect(function()
    local Distances = {
        100,
        250,
        500,
        1000,
        2000
    }

    local CurrentIndex = table.find(
        Distances,
        Settings.MaxDistance
    ) or 4

    CurrentIndex += 1

    if CurrentIndex > #Distances then
        CurrentIndex = 1
    end

    Settings.MaxDistance = Distances[CurrentIndex]

    DistanceLimitButton.Text =
        "Max Distance: " .. Settings.MaxDistance
end)

TargetColorButton.MouseButton1Click:Connect(function()
    ColorIndex += 1

    if ColorIndex > #ESPColors then
        ColorIndex = 1
    end

    TargetColorButton.Text = "ESP Color: Custom"
end)

--========================================
-- PART 3/3 - SKELETON / DRAG / MINIMIZE / CLEANUP
--========================================

local SkeletonObjects = {}

local function CreateSkeleton(Player)
    if SkeletonObjects[Player] then
        return
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "Skeleton_" .. Player.Name
    Folder.Parent = ScreenGui

    local Lines = {}

    local Connections = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"LeftLowerArm", "LeftHand"},
        {"UpperTorso", "RightUpperArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LeftLowerLeg", "LeftFoot"},
        {"LowerTorso", "RightUpperLeg"},
        {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"}
    }

    for Index, Connection in ipairs(Connections) do
        local Line = Instance.new("Frame")

        Line.Name = "Bone_" .. Index
        Line.AnchorPoint = Vector2.new(0.5, 0.5)
        Line.Size = UDim2.new(0, 1.5, 0, 0)
        Line.BackgroundColor3 = Colors.Purple
        Line.BorderSizePixel = 0
        Line.Visible = false
        Line.ZIndex = 4
        Line.Parent = Folder

        Lines[Index] = {
            Object = Line,
            A = Connection[1],
            B = Connection[2]
        }
    end

    SkeletonObjects[Player] = {
        Folder = Folder,
        Lines = Lines
    }
end

local function RemoveSkeleton(Player)
    local Object = SkeletonObjects[Player]

    if not Object then
        return
    end

    pcall(function()
        Object.Folder:Destroy()
    end)

    SkeletonObjects[Player] = nil
end

local function UpdateSkeleton(Player, Object)
    if not Settings.Enabled or not Settings.SkeletonESP then
        for _, Bone in ipairs(Object.Lines) do
            Bone.Object.Visible = false
        end

        return
    end

    local Character, Humanoid, Root = GetCharacter(Player)

    if not Character or not IsEnemy(Player) then
        for _, Bone in ipairs(Object.Lines) do
            Bone.Object.Visible = false
        end

        return
    end

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Distance =
        (Camera.CFrame.Position - Root.Position).Magnitude

    if Distance > Settings.MaxDistance then
        for _, Bone in ipairs(Object.Lines) do
            Bone.Object.Visible = false
        end

        return
    end

    for _, Bone in ipairs(Object.Lines) do
        local PartA = Character:FindFirstChild(Bone.A)
        local PartB = Character:FindFirstChild(Bone.B)

        if PartA and PartB then
            local PositionA, VisibleA =
                Camera:WorldToViewportPoint(PartA.Position)

            local PositionB, VisibleB =
                Camera:WorldToViewportPoint(PartB.Position)

            if VisibleA and VisibleB then
                local A = Vector2.new(
                    PositionA.X,
                    PositionA.Y
                )

                local B = Vector2.new(
                    PositionB.X,
                    PositionB.Y
                )

                local Delta = B - A
                local Length = Delta.Magnitude

                Bone.Object.Position = UDim2.fromOffset(
                    (A.X + B.X) / 2,
                    (A.Y + B.Y) / 2
                )

                Bone.Object.Size =
                    UDim2.new(0, 1.5, 0, Length)

                Bone.Object.Rotation =
                    math.deg(
                        math.atan2(
                            Delta.Y,
                            Delta.X
                        )
                    ) - 90

                Bone.Object.BackgroundColor3 =
                    GetESPColor()

                Bone.Object.Visible = true
            else
                Bone.Object.Visible = false
            end
        else
            Bone.Object.Visible = false
        end
    end
end

for _, Player in ipairs(Players:GetPlayers()) do
    CreateSkeleton(Player)
end

Players.PlayerAdded:Connect(function(Player)
    CreateSkeleton(Player)
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveSkeleton(Player)
end)

RunService.RenderStepped:Connect(function()
    for Player, Object in pairs(SkeletonObjects) do
        if Player.Parent then
            UpdateSkeleton(Player, Object)
        end
    end
end)

SkeletonButton.MouseButton1Click:Connect(function()
    Settings.SkeletonESP = not Settings.SkeletonESP

    SkeletonButton.Text =
        "Skeleton: " ..
        (Settings.SkeletonESP and "ON" or "OFF")
end)

local Dragging = false
local DragStart
local StartPosition
local DragInput

local function UpdateDrag(Input)
    local Delta = Input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

TopBar.InputBegan:Connect(function(Input)
    if IsMinimized then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
        DragInput = Input
    end
end)

TopBar.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement
    or Input.UserInputType == Enum.UserInputType.Touch then

        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and Input == DragInput then
        UpdateDrag(Input)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

local function SetContentVisible(State)
    Content.Visible = State
    Title.Visible = State
    Subtitle.Visible = State
    CloseButton.Visible = State
    MinimizeButton.Visible = State
end

local function RestoreMenu()
    if not IsMinimized then
        return
    end

    IsMinimized = false

    SetContentVisible(true)

    TopBar.Size = UDim2.new(1, 0, 0, 68)

    LogoButton.Size = UDim2.new(0, 44, 0, 44)
    LogoButton.Position = UDim2.new(0, 12, 0.5, -22)

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = FullSize
        }
    ):Play()
end

MinimizeButton.MouseButton1Click:Connect(function()
    if IsMinimized then
        RestoreMenu()
        return
    end

    IsMinimized = true

    SetContentVisible(false)

    TopBar.Size = UDim2.new(1, 0, 1, 0)

    LogoButton.Size = UDim2.new(0, 52, 0, 52)
    LogoButton.Position = UDim2.new(0.5, -26, 0.5, -26)

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.4,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.InOut
        ),
        {
            Size = MiniSize
        }
    ):Play()
end)

LogoButton.MouseButton1Click:Connect(function()
    if IsMinimized then
        RestoreMenu()
    end
end)

LogoButton.MouseEnter:Connect(function()
    TweenService:Create(
        LogoButton,
        TweenInfo.new(0.15),
        {
            TextSize = 34
        }
    ):Play()
end)

LogoButton.MouseLeave:Connect(function()
    TweenService:Create(
        LogoButton,
        TweenInfo.new(0.15),
        {
            TextSize = 30
        }
    ):Play()
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(
        MinimizeButton,
        TweenInfo.new(0.12),
        {
            TextColor3 = Colors.Purple
        }
    ):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(
        MinimizeButton,
        TweenInfo.new(0.12),
        {
            TextColor3 = Color3.fromRGB(200, 180, 220)
        }
    ):Play()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.12),
        {
            TextColor3 = Colors.Red
        }
    ):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.12),
        {
            TextColor3 = Color3.fromRGB(200, 180, 220)
        }
    ):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(
        Main,
        TweenInfo.new(
            0.35,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.new(0, 0, 0, 0)
        }
    ):Play()

    task.delay(0.36, function()
        if ScreenGui then
            ScreenGui:Destroy()
        end
    end)
end)

local function CleanupLunarESP()
    pcall(function()
        for Player in pairs(ESPObjects) do
            RemoveESP(Player)
        end

        for Player in pairs(TracerObjects) do
            RemoveTracer(Player)
        end

        for Player in pairs(SkeletonObjects) do
            RemoveSkeleton(Player)
        end
    end)
end

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
    RemoveTracer(Player)
    RemoveSkeleton(Player)
end)

task.spawn(function()
    while ScreenGui.Parent do
        if Settings.Rainbow then
            MainStroke.Color = GetESPColor()
            Glow.ImageColor3 = GetESPColor()
        else
            MainStroke.Color = Colors.Purple
            Glow.ImageColor3 = Colors.Purple
        end

        task.wait(0.05)
    end
end)

print("🌙 Lunar ESP loaded successfully")
print("ESP / Box / Name / Health / Distance / Tracer / Skeleton ready")
