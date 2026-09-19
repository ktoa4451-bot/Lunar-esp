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
    ModelESP = false,

    TeamCheck = true,
    Rainbow = false,

    MaxDistance = 1000,

    ESPColor = Color3.fromRGB(175, 100, 255)
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

--========================================
-- GUI PARENT
--========================================

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

--========================================
-- SCREEN GUI
--========================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "LunarESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = GuiParent

--========================================
-- MAIN WINDOW
--========================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 520)
Main.Position = UDim2.new(0.5, -170, 0.5, -260)

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

--========================================
-- GLOW
--========================================

local Glow = Instance.new("ImageLabel")

Glow.Name = "Glow"

Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)

Glow.Size = UDim2.new(1, 50, 1, 50)

Glow.BackgroundTransparency = 1

Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Colors.Purple
Glow.ImageTransparency = 0.82

Glow.ZIndex = 0
Glow.Parent = Main

--========================================
-- TOP BAR
--========================================

local TopBar = Instance.new("Frame")

TopBar.Name = "TopBar"

TopBar.Size = UDim2.new(1, 0, 0, 68)

TopBar.BackgroundTransparency = 1
TopBar.ZIndex = 10

TopBar.Parent = Main

--========================================
-- MOON LOGO
--========================================

local LogoButton = Instance.new("TextButton")

LogoButton.Name = "LogoButton"

LogoButton.Size = UDim2.new(0, 44, 0, 44)
LogoButton.Position = UDim2.new(0, 12, 0.5, -22)

LogoButton.BackgroundTransparency = 1
LogoButton.BorderSizePixel = 0

LogoButton.Text = "🌙"
LogoButton.TextSize = 30

LogoButton.Font = Enum.Font.GothamBold

LogoButton.TextColor3 =
    Color3.fromRGB(190, 145, 255)

LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 20

LogoButton.Parent = TopBar

--========================================
-- TITLE
--========================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.Position = UDim2.new(0, 62, 0, 13)
Title.Size = UDim2.new(1, -150, 0, 24)

Title.BackgroundTransparency = 1

Title.Text = "Lunar ESP"

Title.TextColor3 = Colors.Text
Title.TextSize = 18

Title.Font = Enum.Font.GothamBold

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.ZIndex = 20
Title.Parent = TopBar

--========================================
-- SUBTITLE
--========================================

local Subtitle = Instance.new("TextLabel")

Subtitle.Name = "Subtitle"

Subtitle.Position = UDim2.new(0, 62, 0, 37)
Subtitle.Size = UDim2.new(1, -150, 0, 18)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "Universal player visualization"

Subtitle.TextColor3 = Colors.SubText
Subtitle.TextSize = 10

Subtitle.Font = Enum.Font.Gotham

Subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

Subtitle.ZIndex = 20
Subtitle.Parent = TopBar

--========================================
-- MINIMIZE
--========================================

local MinimizeButton = Instance.new("TextButton")

MinimizeButton.Name = "MinimizeButton"

MinimizeButton.Size = UDim2.new(0, 34, 0, 34)
MinimizeButton.Position = UDim2.new(1, -75, 0.5, -17)

MinimizeButton.BackgroundTransparency = 1
MinimizeButton.BorderSizePixel = 0

MinimizeButton.Text = "—"
MinimizeButton.TextColor3 =
    Color3.fromRGB(200, 180, 220)

MinimizeButton.TextSize = 22

MinimizeButton.Font =
    Enum.Font.GothamBold

MinimizeButton.AutoButtonColor = false
MinimizeButton.ZIndex = 20

MinimizeButton.Parent = TopBar

--========================================
-- CLOSE
--========================================

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "CloseButton"

CloseButton.Size = UDim2.new(0, 34, 0, 34)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17)

CloseButton.BackgroundTransparency = 1
CloseButton.BorderSizePixel = 0

CloseButton.Text = "×"

CloseButton.TextColor3 =
    Color3.fromRGB(200, 180, 220)

CloseButton.TextSize = 24

CloseButton.Font =
    Enum.Font.GothamBold

CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 20

CloseButton.Parent = TopBar

--========================================
-- CONTENT
--========================================

local Content = Instance.new("ScrollingFrame")

Content.Name = "Content"

Content.Position =
    UDim2.new(0, 15, 0, 78)

Content.Size =
    UDim2.new(1, -30, 1, -90)

Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 =
    Colors.Purple

Content.AutomaticCanvasSize =
    Enum.AutomaticSize.Y

Content.CanvasSize =
    UDim2.new(0, 0, 0, 0)

Content.ZIndex = 5
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")

ContentLayout.Padding =
    UDim.new(0, 8)

ContentLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

ContentLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding")

ContentPadding.PaddingBottom =
    UDim.new(0, 10)

ContentPadding.Parent = Content

--========================================
-- CONTROL CREATOR
--========================================

local function CreateSection(Text, Order)

    local Label = Instance.new("TextLabel")

    Label.Name = "Section_" .. Text

    Label.Size =
        UDim2.new(1, -5, 0, 24)

    Label.BackgroundTransparency = 1

    Label.Text = Text

    Label.TextColor3 =
        Colors.Purple

    Label.TextSize = 11

    Label.Font =
        Enum.Font.GothamBold

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.LayoutOrder = Order

    Label.Parent = Content

    return Label
end

local function CreateControlButton(Name, Text, Order)

    local Button = Instance.new("TextButton")

    Button.Name = Name

    Button.Size =
        UDim2.new(1, -5, 0, 42)

    Button.BackgroundColor3 =
        Colors.Panel

    Button.BorderSizePixel = 0

    Button.AutoButtonColor = false

    Button.Text = Text

    Button.TextColor3 =
        Colors.Text

    Button.TextSize = 12

    Button.Font =
        Enum.Font.GothamSemibold

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.LayoutOrder = Order

    Button.ZIndex = 10
    Button.Parent = Content

    local Padding = Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(0, 14)

    Padding.Parent = Button

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 11)

    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")

    Stroke.Color =
        Colors.PurpleDark

    Stroke.Transparency = 0.65
    Stroke.Thickness = 1

    Stroke.Parent = Button

    Button.MouseEnter:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(34, 24, 47)
            }
        ):Play()

    end)

    Button.MouseLeave:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Colors.Panel
            }
        ):Play()

    end)

    Button.MouseButton1Click:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.08),
            {
                Size =
                    UDim2.new(1, -9, 0, 40)
            }
        ):Play()

        task.delay(0.08, function()

            if Button.Parent then

                TweenService:Create(
                    Button,
                    TweenInfo.new(0.12),
                    {
                        Size =
                            UDim2.new(1, -5, 0, 42)
                    }
                ):Play()

            end

        end)

    end)

    return Button
end

--========================================
-- ESP SETTINGS
--========================================

CreateSection("ESP", 1)

local ESPButton =
    CreateControlButton(
        "ESPButton",
        "ESP: ON",
        2
    )

local BoxButton =
    CreateControlButton(
        "BoxButton",
        "Box ESP: ON",
        3
    )

local ModelButton =
    CreateControlButton(
        "ModelButton",
        "Model ESP: OFF",
        4
    )

local NameButton =
    CreateControlButton(
        "NameButton",
        "Name ESP: ON",
        5
    )

local HealthButton =
    CreateControlButton(
        "HealthButton",
        "Health Bar: ON",
        6
    )

local DistanceButton =
    CreateControlButton(
        "DistanceButton",
        "Distance: ON",
        7
    )

CreateSection("Visuals", 8)

local TracerButton =
    CreateControlButton(
        "TracerButton",
        "Tracers: OFF",
        9
    )

local SkeletonButton =
    CreateControlButton(
        "SkeletonButton",
        "Skeleton: OFF",
        10
    )

local TeamButton =
    CreateControlButton(
        "TeamButton",
        "Team Check: ON",
        11
    )

local RainbowButton =
    CreateControlButton(
        "RainbowButton",
        "Rainbow ESP: OFF",
        12
    )

local DistanceLimitButton =
    CreateControlButton(
        "DistanceLimitButton",
        "Max Distance: 1000",
        13
    )

local ColorButton =
    CreateControlButton(
        "ColorButton",
        "ESP Color: Purple",
        14
    )

--========================================
-- ESP DATA
--========================================

local ESPObjects = {}

local SkeletonObjects = {}

local TracerObjects = {}

local ESPFolder = Instance.new("Folder")

ESPFolder.Name = "LunarESP_Objects"
ESPFolder.Parent = ScreenGui

--========================================
-- COLOR SYSTEM
--========================================

local ESPColors = {

    Color3.fromRGB(175, 100, 255),

    Color3.fromRGB(100, 200, 255),

    Color3.fromRGB(100, 255, 160),

    Color3.fromRGB(255, 220, 100),

    Color3.fromRGB(255, 100, 150),

    Color3.fromRGB(255, 255, 255)

}

local ColorIndex = 1

local function GetESPColor()

    if Settings.Rainbow then

        return Color3.fromHSV(
            (tick() % 5) / 5,
            0.85,
            1
        )

    end

    return ESPColors[ColorIndex]
end

--========================================
-- CHARACTER VALIDATION
--========================================

local function GetCharacter(Player)

    if not Player then
        return nil
    end

    local Character =
        Player.Character

    if not Character then
        return nil
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    local Root =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not Humanoid
    or Humanoid.Health <= 0
    or not Root then

        return nil
    end

    return Character, Humanoid, Root
end

--========================================
-- TEAM CHECK
--========================================

local function IsEnemy(Player)

    if Player == LocalPlayer then
        return false
    end

    if not Settings.TeamCheck then
        return true
    end

    if LocalPlayer.Team
    and Player.Team then

        return LocalPlayer.Team ~=
            Player.Team
    end

    if LocalPlayer.TeamColor
    and Player.TeamColor then

        return LocalPlayer.TeamColor ~=
            Player.TeamColor
    end

    return true
end

--========================================
-- DISTANCE CHECK
--========================================

local function IsWithinDistance(Root)

    local Camera =
        workspace.CurrentCamera

    if not Camera or not Root then
        return false
    end

    local Distance =
        (Camera.CFrame.Position -
            Root.Position).Magnitude

    return Distance <=
        Settings.MaxDistance
end

--========================================
-- FULL MODEL PARTS
--========================================

local function GetModelParts(Character)

    local Parts = {}

    for _, Object in ipairs(
        Character:GetDescendants()
    ) do

        if Object:IsA("BasePart")
        and Object.Transparency < 1 then

            table.insert(
                Parts,
                Object
            )

        end

    end

    return Parts
end

--========================================
-- SCREEN BOUNDS
--========================================

local function GetScreenBounds(Character)

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local Parts =
        GetModelParts(Character)

    if #Parts == 0 then
        return nil
    end

    local MinX = math.huge
    local MinY = math.huge

    local MaxX = -math.huge
    local MaxY = -math.huge

    local VisiblePoints = 0

    for _, Part in ipairs(Parts) do

        local Size =
            Part.Size / 2

        local Corners = {

            Part.CFrame *
                Vector3.new(
                    Size.X,
                    Size.Y,
                    Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    -Size.X,
                    Size.Y,
                    Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    Size.X,
                    -Size.Y,
                    Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    -Size.X,
                    -Size.Y,
                    Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    Size.X,
                    Size.Y,
                    -Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    -Size.X,
                    Size.Y,
                    -Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    Size.X,
                    -Size.Y,
                    -Size.Z
                ),

            Part.CFrame *
                Vector3.new(
                    -Size.X,
                    -Size.Y,
                    -Size.Z
                )

        }

        for _, WorldPosition in ipairs(Corners) do

            local ScreenPosition,
                OnScreen =
                Camera:WorldToViewportPoint(
                    WorldPosition
                )

            if ScreenPosition.Z > 0 then

                if OnScreen then
                    VisiblePoints += 1
                end

                MinX = math.min(
                    MinX,
                    ScreenPosition.X
                )

                MinY = math.min(
                    MinY,
                    ScreenPosition.Y
                )

                MaxX = math.max(
                    MaxX,
                    ScreenPosition.X
                )

                MaxY = math.max(
                    MaxY,
                    ScreenPosition.Y
                )

            end

        end

    end

    if VisiblePoints == 0
    or MinX == math.huge then

        return nil
    end

    return MinX, MinY, MaxX, MaxY
end

--========================================
-- WINDOW ANIMATION
--========================================

local FullSize =
    UDim2.new(0, 340, 0, 520)

local MiniSize =
    UDim2.new(0, 64, 0, 64)

local IsMinimized = false

Main.Size =
    UDim2.new(0, 0, 0, 0)

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

--========================================
-- MOON ANIMATION
--========================================

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
                TextColor3 =
                    Color3.fromRGB(
                        220,
                        180,
                        255
                    ),
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
                TextColor3 =
                    Color3.fromRGB(
                        175,
                        125,
                        240
                    ),
                Rotation = -8
            }
        ):Play()

        task.wait(1)

    end

end)

--========================================
-- PART 2/3 - BOX / HEALTH / MODEL / TRACER
--========================================

local function CreateESP(Player)

    if Player == LocalPlayer
    or ESPObjects[Player] then
        return
    end

    local Object = {}

    --========================================
    -- 2D BOX
    --========================================

    local Box = Instance.new("Frame")

    Box.Name = "Box"
    Box.BackgroundTransparency = 1
    Box.BorderSizePixel = 0
    Box.Visible = false
    Box.ZIndex = 5
    Box.Parent = ScreenGui

    local BoxStroke = Instance.new("UIStroke")

    BoxStroke.Thickness = 1.5
    BoxStroke.Color = Settings.ESPColor
    BoxStroke.Transparency = 0

    BoxStroke.Parent = Box

    Object.Box = Box
    Object.BoxStroke = BoxStroke

    --========================================
    -- BOX CORNERS
    --========================================

    local CornerTL = Instance.new("Frame")
    local CornerTR = Instance.new("Frame")
    local CornerBL = Instance.new("Frame")
    local CornerBR = Instance.new("Frame")

    local Corners = {
        CornerTL,
        CornerTR,
        CornerBL,
        CornerBR
    }

    for _, Corner in ipairs(Corners) do

        Corner.BackgroundColor3 =
            Settings.ESPColor

        Corner.BorderSizePixel = 0
        Corner.ZIndex = 6
        Corner.Parent = ScreenGui

    end

    CornerTL.Size =
        UDim2.new(0, 8, 0, 2)

    CornerTR.Size =
        UDim2.new(0, 8, 0, 2)

    CornerBL.Size =
        UDim2.new(0, 8, 0, 2)

    CornerBR.Size =
        UDim2.new(0, 8, 0, 2)

    Object.Corners = Corners

    --========================================
    -- HEALTH BAR BACKGROUND
    --========================================

    local HealthBack = Instance.new("Frame")

    HealthBack.Name = "HealthBack"

    HealthBack.BackgroundColor3 =
        Color3.fromRGB(20, 20, 25)

    HealthBack.BorderSizePixel = 0

    HealthBack.Visible = false

    HealthBack.ZIndex = 5

    HealthBack.Parent = ScreenGui

    local HealthCorner = Instance.new("UICorner")

    HealthCorner.CornerRadius =
        UDim.new(0, 2)

    HealthCorner.Parent = HealthBack

    --========================================
    -- HEALTH BAR
    --========================================

    local HealthFill = Instance.new("Frame")

    HealthFill.Name = "Health"

    HealthFill.AnchorPoint =
        Vector2.new(0, 1)

    HealthFill.Position =
        UDim2.new(0, 0, 1, 0)

    HealthFill.Size =
        UDim2.new(1, 0, 1, 0)

    HealthFill.BackgroundColor3 =
        Colors.Green

    HealthFill.BorderSizePixel = 0

    HealthFill.ZIndex = 6

    HealthFill.Parent = HealthBack

    local HealthFillCorner =
        Instance.new("UICorner")

    HealthFillCorner.CornerRadius =
        UDim.new(0, 2)

    HealthFillCorner.Parent =
        HealthFill

    Object.HealthBack = HealthBack
    Object.HealthFill = HealthFill

    --========================================
    -- NAME
    --========================================

    local Name = Instance.new("TextLabel")

    Name.Name = "Name"

    Name.AnchorPoint =
        Vector2.new(0.5, 1)

    Name.BackgroundTransparency = 1

    Name.TextColor3 =
        Settings.ESPColor

    Name.TextStrokeTransparency = 0

    Name.TextSize = 13

    Name.Font =
        Enum.Font.GothamBold

    Name.Visible = false

    Name.ZIndex = 7

    Name.Parent = ScreenGui

    Object.Name = Name

    --========================================
    -- DISTANCE
    --========================================

    local Distance = Instance.new("TextLabel")

    Distance.Name = "Distance"

    Distance.AnchorPoint =
        Vector2.new(0.5, 0)

    Distance.BackgroundTransparency = 1

    Distance.TextColor3 =
        Colors.SubText

    Distance.TextStrokeTransparency = 0

    Distance.TextSize = 10

    Distance.Font =
        Enum.Font.Gotham

    Distance.Visible = false

    Distance.ZIndex = 7

    Distance.Parent = ScreenGui

    Object.Distance = Distance

    --========================================
    -- MODEL ESP
    --========================================

    local ModelHighlight =
        Instance.new("Highlight")

    ModelHighlight.Name =
        "ModelESP"

    ModelHighlight.DepthMode =
        Enum.HighlightDepthMode.AlwaysOnTop

    ModelHighlight.FillColor =
        Settings.ESPColor

    ModelHighlight.FillTransparency =
        0.78

    ModelHighlight.OutlineColor =
        Settings.ESPColor

    ModelHighlight.OutlineTransparency =
        0

    ModelHighlight.Enabled = false

    ModelHighlight.Parent =
        ESPFolder

    Object.ModelHighlight =
        ModelHighlight

    --========================================
    -- TRACER
    --========================================

    local Tracer = Instance.new("Frame")

    Tracer.Name = "Tracer"

    Tracer.AnchorPoint =
        Vector2.new(0.5, 0.5)

    Tracer.BackgroundColor3 =
        Settings.ESPColor

    Tracer.BorderSizePixel = 0

    Tracer.Visible = false

    Tracer.ZIndex = 4

    Tracer.Parent = ScreenGui

    Object.Tracer = Tracer

    ESPObjects[Player] = Object
end

--========================================
-- REMOVE ESP
--========================================

local function RemoveESP(Player)

    local Object =
        ESPObjects[Player]

    if not Object then
        return
    end

    for _, Item in pairs(Object) do

        if typeof(Item) == "Instance" then

            pcall(function()
                Item:Destroy()
            end)

        elseif typeof(Item) == "table" then

            for _, Part in pairs(Item) do

                if typeof(Part) == "Instance" then

                    pcall(function()
                        Part:Destroy()
                    end)

                end

            end

        end

    end

    ESPObjects[Player] = nil
end

--========================================
-- HIDE ESP
--========================================

local function HideESP(Object)

    Object.Box.Visible = false
    Object.HealthBack.Visible = false
    Object.Name.Visible = false
    Object.Distance.Visible = false
    Object.ModelHighlight.Enabled = false
    Object.Tracer.Visible = false

    for _, Corner in ipairs(Object.Corners) do
        Corner.Visible = false
    end
end

--========================================
-- UPDATE BOX
--========================================

local function UpdateBox(
    Object,
    MinX,
    MinY,
    MaxX,
    MaxY,
    Color
)

    if not Settings.BoxESP then

        Object.Box.Visible = false

        for _, Corner in ipairs(Object.Corners) do
            Corner.Visible = false
        end

        return
    end

    local Width =
        math.max(MaxX - MinX, 2)

    local Height =
        math.max(MaxY - MinY, 2)

    Object.Box.Position =
        UDim2.fromOffset(
            MinX,
            MinY
        )

    Object.Box.Size =
        UDim2.fromOffset(
            Width,
            Height
        )

    Object.BoxStroke.Color =
        Color

    Object.Box.Visible = true

    --========================================
    -- TOP LEFT
    --========================================

    local TL =
        Object.Corners[1]

    TL.Position =
        UDim2.fromOffset(
            MinX,
            MinY
        )

    TL.Size =
        UDim2.fromOffset(
            math.min(10, Width / 3),
            2
        )

    --========================================
    -- TOP RIGHT
    --========================================

    local TR =
        Object.Corners[2]

    TR.Position =
        UDim2.fromOffset(
            MaxX - math.min(10, Width / 3),
            MinY
        )

    TR.Size =
        UDim2.fromOffset(
            math.min(10, Width / 3),
            2
        )

    --========================================
    -- BOTTOM LEFT
    --========================================

    local BL =
        Object.Corners[3]

    BL.Position =
        UDim2.fromOffset(
            MinX,
            MaxY - 2
        )

    BL.Size =
        UDim2.fromOffset(
            math.min(10, Width / 3),
            2
        )

    --========================================
    -- BOTTOM RIGHT
    --========================================

    local BR =
        Object.Corners[4]

    BR.Position =
        UDim2.fromOffset(
            MaxX - math.min(10, Width / 3),
            MaxY - 2
        )

    BR.Size =
        UDim2.fromOffset(
            math.min(10, Width / 3),
            2
        )

    for _, Corner in ipairs(Object.Corners) do
        Corner.BackgroundColor3 = Color
        Corner.Visible = true
    end
end

--========================================
-- UPDATE HEALTH
--========================================

local function UpdateHealth(
    Object,
    MinX,
    MinY,
    MaxY,
    Humanoid,
    Color
)

    if not Settings.HealthESP then

        Object.HealthBack.Visible = false

        return
    end

    local Height =
        math.max(MaxY - MinY, 5)

    local HealthPercent =
        math.clamp(
            Humanoid.Health /
            math.max(Humanoid.MaxHealth, 1),
            0,
            1
        )

    Object.HealthBack.Position =
        UDim2.fromOffset(
            MinX - 7,
            MinY
        )

    Object.HealthBack.Size =
        UDim2.fromOffset(
            4,
            Height
        )

    Object.HealthFill.Size =
        UDim2.new(
            1,
            0,
            HealthPercent,
            0
        )

    Object.HealthFill.BackgroundColor3 =
        Color3.fromRGB(
            255 * (1 - HealthPercent),
            255 * HealthPercent,
            80
        )

    Object.HealthBack.Visible = true
end

--========================================
-- UPDATE NAME / DISTANCE
--========================================

local function UpdateInfo(
    Object,
    MinX,
    MinY,
    MaxX,
    MaxY,
    Player,
    Distance,
    Color
)

    local CenterX =
        (MinX + MaxX) / 2

    if Settings.NameESP then

        Object.Name.Position =
            UDim2.fromOffset(
                CenterX,
                MinY - 4
            )

        Object.Name.Text =
            Player.DisplayName

        Object.Name.TextColor3 =
            Color

        Object.Name.Visible = true

    else

        Object.Name.Visible = false

    end

    if Settings.DistanceESP then

        Object.Distance.Position =
            UDim2.fromOffset(
                CenterX,
                MaxY + 3
            )

        Object.Distance.Text =
            "[" ..
            math.floor(Distance) ..
            " studs]"

        Object.Distance.Visible = true

    else

        Object.Distance.Visible = false

    end
end

--========================================
-- UPDATE TRACER
--========================================

local function UpdateTracer(
    Object,
    Root,
    Color
)

    if not Settings.TracerESP then

        Object.Tracer.Visible = false

        return
    end

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        Object.Tracer.Visible = false
        return
    end

    local ScreenPosition,
        OnScreen =
        Camera:WorldToViewportPoint(
            Root.Position
        )

    if not OnScreen
    or ScreenPosition.Z <= 0 then

        Object.Tracer.Visible = false

        return
    end

    local Viewport =
        Camera.ViewportSize

    local Start =
        Vector2.new(
            Viewport.X / 2,
            Viewport.Y - 20
        )

    local Finish =
        Vector2.new(
            ScreenPosition.X,
            ScreenPosition.Y
        )

    local Delta =
        Finish - Start

    local Length =
        Delta.Magnitude

    Object.Tracer.Position =
        UDim2.fromOffset(
            (Start.X + Finish.X) / 2,
            (Start.Y + Finish.Y) / 2
        )

    Object.Tracer.Size =
        UDim2.fromOffset(
            2,
            Length
        )

    Object.Tracer.Rotation =
        math.deg(
            math.atan2(
                Delta.Y,
                Delta.X
            )
        ) - 90

    Object.Tracer.BackgroundColor3 =
        Color

    Object.Tracer.Visible = true
end

--========================================
-- UPDATE PLAYER
--========================================

local function UpdateESP(
    Player,
    Object
)

    if not Settings.Enabled then

        HideESP(Object)

        return
    end

    local Character,
        Humanoid,
        Root =
        GetCharacter(Player)

    if not Character
    or not Humanoid
    or not Root then

        HideESP(Object)

        return
    end

    if not IsEnemy(Player) then

        HideESP(Object)

        return
    end

    if not IsWithinDistance(Root) then

        HideESP(Object)

        return
    end

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        HideESP(Object)
        return
    end

    local Distance =
        (Camera.CFrame.Position -
            Root.Position).Magnitude

    local MinX,
        MinY,
        MaxX,
        MaxY =
        GetScreenBounds(Character)

    if not MinX then

        HideESP(Object)

        return
    end

    local Color =
        GetESPColor()

    --========================================
    -- BOX
    --========================================

    UpdateBox(
        Object,
        MinX,
        MinY,
        MaxX,
        MaxY,
        Color
    )

    --========================================
    -- HEALTH
    --========================================

    UpdateHealth(
        Object,
        MinX,
        MinY,
        MaxY,
        Humanoid,
        Color
    )

    --========================================
    -- NAME / DISTANCE
    --========================================

    UpdateInfo(
        Object,
        MinX,
        MinY,
        MaxX,
        MaxY,
        Player,
        Distance,
        Color
    )

    --========================================
    -- MODEL ESP
    --========================================

    if Settings.ModelESP then

        Object.ModelHighlight.Adornee =
            Character

        Object.ModelHighlight.FillColor =
            Color

        Object.ModelHighlight.OutlineColor =
            Color

        Object.ModelHighlight.Enabled =
            true

    else

        Object.ModelHighlight.Enabled =
            false

    end

    --========================================
    -- TRACER
    --========================================

    UpdateTracer(
        Object,
        Root,
        Color
    )
end

--========================================
-- CREATE EXISTING PLAYERS
--========================================

for _, Player in ipairs(
    Players:GetPlayers()
) do

    CreateESP(Player)

end

--========================================
-- NEW PLAYERS
--========================================

Players.PlayerAdded:Connect(
    function(Player)

        CreateESP(Player)

    end
)

--========================================
-- PLAYER REMOVAL
--========================================

Players.PlayerRemoving:Connect(
    function(Player)

        RemoveESP(Player)

    end
)

--========================================
-- ESP RENDER LOOP
--========================================

RunService.RenderStepped:Connect(
    function()

        for Player, Object in pairs(
            ESPObjects
        ) do

            if Player.Parent then

                UpdateESP(
                    Player,
                    Object
                )

            else

                RemoveESP(Player)

            end

        end

    end
)

--========================================
-- ESP TOGGLE
--========================================

ESPButton.MouseButton1Click:Connect(
    function()

        Settings.Enabled =
            not Settings.Enabled

        ESPButton.Text =
            "ESP: " ..
            (
                Settings.Enabled
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- BOX TOGGLE
--========================================

BoxButton.MouseButton1Click:Connect(
    function()

        Settings.BoxESP =
            not Settings.BoxESP

        BoxButton.Text =
            "Box ESP: " ..
            (
                Settings.BoxESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- MODEL TOGGLE
--========================================

ModelButton.MouseButton1Click:Connect(
    function()

        Settings.ModelESP =
            not Settings.ModelESP

        ModelButton.Text =
            "Model ESP: " ..
            (
                Settings.ModelESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- NAME TOGGLE
--========================================

NameButton.MouseButton1Click:Connect(
    function()

        Settings.NameESP =
            not Settings.NameESP

        NameButton.Text =
            "Name ESP: " ..
            (
                Settings.NameESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- HEALTH TOGGLE
--========================================

HealthButton.MouseButton1Click:Connect(
    function()

        Settings.HealthESP =
            not Settings.HealthESP

        HealthButton.Text =
            "Health Bar: " ..
            (
                Settings.HealthESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- DISTANCE TOGGLE
--========================================

DistanceButton.MouseButton1Click:Connect(
    function()

        Settings.DistanceESP =
            not Settings.DistanceESP

        DistanceButton.Text =
            "Distance: " ..
            (
                Settings.DistanceESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- TRACER TOGGLE
--========================================

TracerButton.MouseButton1Click:Connect(
    function()

        Settings.TracerESP =
            not Settings.TracerESP

        TracerButton.Text =
            "Tracers: " ..
            (
                Settings.TracerESP
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- TEAM CHECK
--========================================

TeamButton.MouseButton1Click:Connect(
    function()

        Settings.TeamCheck =
            not Settings.TeamCheck

        TeamButton.Text =
            "Team Check: " ..
            (
                Settings.TeamCheck
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- RAINBOW
--========================================

RainbowButton.MouseButton1Click:Connect(
    function()

        Settings.Rainbow =
            not Settings.Rainbow

        RainbowButton.Text =
            "Rainbow ESP: " ..
            (
                Settings.Rainbow
                and "ON"
                or "OFF"
            )

    end
)

--========================================
-- MAX DISTANCE
--========================================

DistanceLimitButton.MouseButton1Click:Connect(
    function()

        local Distances = {
            100,
            250,
            500,
            1000,
            2000
        }

        local Current =
            table.find(
                Distances,
                Settings.MaxDistance
            ) or 4

        Current += 1

        if Current > #Distances then
            Current = 1
        end

        Settings.MaxDistance =
            Distances[Current]

        DistanceLimitButton.Text =
            "Max Distance: " ..
            Settings.MaxDistance

    end
)

--========================================
-- COLOR
--========================================

ColorButton.MouseButton1Click:Connect(function()
    ColorIndex = ColorIndex + 1

    if ColorIndex > #ESPColors then
        ColorIndex = 1
    end

    Settings.ESPColor = ESPColors[ColorIndex]
    ColorButton.Text = "ESP Color: " .. ColorNames[ColorIndex]
end)

--========================================
-- RAINBOW
--========================================

RainbowButton.MouseButton1Click:Connect(function()
    Settings.Rainbow = not Settings.Rainbow
    RainbowButton.Text = "Rainbow: " .. (Settings.Rainbow and "ON" or "OFF")
end)

--========================================
-- MAX DISTANCE
--========================================

DistanceLimitButton.MouseButton1Click:Connect(function()
    local distances = {
        100,
        250,
        500,
        1000,
        2000,
        math.huge
    }

    local current = Settings.MaxDistance
    local nextDistance = distances[1]

    for i, distance in ipairs(distances) do
        if distance == current then
            nextDistance = distances[i + 1] or distances[1]
            break
        end
    end

    Settings.MaxDistance = nextDistance

    if nextDistance == math.huge then
        DistanceLimitButton.Text = "Max Distance: Unlimited"
    else
        DistanceLimitButton.Text = "Max Distance: " .. tostring(nextDistance)
    end
end)

--========================================
-- TEAM CHECK
--========================================

TeamButton.MouseButton1Click:Connect(function()
    Settings.TeamCheck = not Settings.TeamCheck
    TeamButton.Text = "Team Check: " .. (Settings.TeamCheck and "ON" or "OFF")
end)

--========================================
-- TRACER
--========================================

TracerButton.MouseButton1Click:Connect(function()
    Settings.TracerESP = not Settings.TracerESP
    TracerButton.Text = "Tracer ESP: " .. (Settings.TracerESP and "ON" or "OFF")
end)

--========================================
-- SKELETON
--========================================

SkeletonButton.MouseButton1Click:Connect(function()
    Settings.SkeletonESP = not Settings.SkeletonESP
    SkeletonButton.Text = "Skeleton ESP: " .. (Settings.SkeletonESP and "ON" or "OFF")
end)

--========================================
-- HEALTH
--========================================

HealthButton.MouseButton1Click:Connect(function()
    Settings.HealthESP = not Settings.HealthESP
    HealthButton.Text = "Health ESP: " .. (Settings.HealthESP and "ON" or "OFF")
end)

--========================================
-- DISTANCE
--========================================

DistanceButton.MouseButton1Click:Connect(function()
    Settings.DistanceESP = not Settings.DistanceESP
    DistanceButton.Text = "Distance ESP: " .. (Settings.DistanceESP and "ON" or "OFF")
end)

--========================================
-- NAME
--========================================

NameButton.MouseButton1Click:Connect(function()
    Settings.NameESP = not Settings.NameESP
    NameButton.Text = "Name ESP: " .. (Settings.NameESP and "ON" or "OFF")
end)

--========================================
-- MODEL ESP
--========================================

ModelButton.MouseButton1Click:Connect(function()
    Settings.ModelESP = not Settings.ModelESP
    ModelButton.Text = "Model ESP: " .. (Settings.ModelESP and "ON" or "OFF")
end)

--========================================
-- BOX ESP
--========================================

BoxButton.MouseButton1Click:Connect(function()
    Settings.BoxESP = not Settings.BoxESP
    BoxButton.Text = "Box ESP: " .. (Settings.BoxESP and "ON" or "OFF")
end)

--========================================
-- MAIN ESP
--========================================

ESPButton.MouseButton1Click:Connect(function()
    Settings.Enabled = not Settings.Enabled
    ESPButton.Text = "ESP: " .. (Settings.Enabled and "ON" or "OFF")

    for _, Data in pairs(ESPObjects) do
        if Data then
            if not Settings.Enabled then
                HideESP(Data)
            end
        end
    end

    for _, Data in pairs(SkeletonObjects) do
        if Data then
            for _, Line in pairs(Data.Lines or {}) do
                Line.Visible = false
            end
        end
    end

    for _, Data in pairs(TracerObjects) do
        if Data then
            Data.Visible = false
        end
    end
end)

--========================================
-- BUTTON HOVER
--========================================

local function SetupHover(Button)
    if not Button then
        return
    end

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                BackgroundColor3 = Color3.fromRGB(55, 38, 75)
            }
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                BackgroundColor3 = Color3.fromRGB(28, 22, 38)
            }
        ):Play()
    end)
end

SetupHover(ESPButton)
SetupHover(BoxButton)
SetupHover(ModelButton)
SetupHover(NameButton)
SetupHover(HealthButton)
SetupHover(DistanceButton)
SetupHover(TracerButton)
SetupHover(SkeletonButton)
SetupHover(TeamButton)
SetupHover(RainbowButton)
SetupHover(DistanceLimitButton)
SetupHover(ColorButton)

--========================================
-- PLAYER CONNECTIONS
--========================================

Players.PlayerAdded:Connect(function(Player)
    task.wait(0.5)

    if Player ~= LocalPlayer then
        CreateESP(Player)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

--========================================
-- EXISTING PLAYERS
--========================================

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        CreateESP(Player)
    end
end

--========================================
-- RAINBOW COLOR UPDATE
--========================================

local RainbowHue = 0

RunService.RenderStepped:Connect(function(Delta)
    if Settings.Rainbow then
        RainbowHue = RainbowHue + Delta * 0.35

        if RainbowHue >= 1 then
            RainbowHue = 0
        end

        Settings.ESPColor = Color3.fromHSV(RainbowHue, 0.85, 1)
    end
end)

--========================================
-- ESP UPDATE LOOP
--========================================

RunService.RenderStepped:Connect(function()
    for Player, Data in pairs(ESPObjects) do
        if Player and Player.Parent then
            UpdateESP(Player, Data)
        else
            RemoveESP(Player)
        end
    end

    for Player, Data in pairs(SkeletonObjects) do
        if Player and Player.Parent then
            if UpdateSkeleton then
                UpdateSkeleton(Player, Data)
            end
        end
    end
end)

--========================================
-- FINAL STATE
--========================================

ESPButton.Text = "ESP: " .. (Settings.Enabled and "ON" or "OFF")
BoxButton.Text = "Box ESP: " .. (Settings.BoxESP and "ON" or "OFF")
ModelButton.Text = "Model ESP: " .. (Settings.ModelESP and "ON" or "OFF")
NameButton.Text = "Name ESP: " .. (Settings.NameESP and "ON" or "OFF")
HealthButton.Text = "Health ESP: " .. (Settings.HealthESP and "ON" or "OFF")
DistanceButton.Text = "Distance ESP: " .. (Settings.DistanceESP and "ON" or "OFF")
TracerButton.Text = "Tracer ESP: " .. (Settings.TracerESP and "ON" or "OFF")
SkeletonButton.Text = "Skeleton ESP: " .. (Settings.SkeletonESP and "ON" or "OFF")
TeamButton.Text = "Team Check: " .. (Settings.TeamCheck and "ON" or "OFF")
RainbowButton.Text = "Rainbow: " .. (Settings.Rainbow and "ON" or "OFF")

--========================================
-- END OF PART 2
--========================================

--========================================
-- SKELETON ESP
--========================================

local function FindBodyPart(Character, Names)
    for _, Name in ipairs(Names) do
        local Part = Character:FindFirstChild(Name)

        if Part and Part:IsA("BasePart") then
            return Part
        end
    end

    return nil
end

local R15Connections = {
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

local R6Connections = {
    {"Head", "Torso"},
    {"Torso", "Left Arm"},
    {"Torso", "Right Arm"},
    {"Torso", "Left Leg"},
    {"Torso", "Right Leg"}
}

--========================================
-- CREATE SKELETON
--========================================

local function CreateSkeleton(Player)
    if Player == LocalPlayer then
        return
    end

    if SkeletonObjects[Player] then
        return SkeletonObjects[Player]
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "Skeleton_" .. Player.Name
    Folder.Parent = ESPFolder

    local Data = {
        Folder = Folder,
        Lines = {},
        Player = Player
    }

    SkeletonObjects[Player] = Data

    for Index = 1, 14 do
        local Line = Instance.new("Frame")
        Line.Name = "Bone_" .. Index
        Line.AnchorPoint = Vector2.new(0.5, 0.5)
        Line.BorderSizePixel = 0
        Line.BackgroundColor3 = Settings.ESPColor
        Line.Size = UDim2.fromOffset(2, 1)
        Line.Visible = false
        Line.ZIndex = 8
        Line.Parent = Folder

        Data.Lines[Index] = Line
    end

    return Data
end

--========================================
-- REMOVE SKELETON
--========================================

local function RemoveSkeleton(Player)
    local Data = SkeletonObjects[Player]

    if not Data then
        return
    end

    if Data.Folder then
        Data.Folder:Destroy()
    end

    SkeletonObjects[Player] = nil
end

--========================================
-- HIDE SKELETON
--========================================

local function HideSkeleton(Data)
    if not Data then
        return
    end

    for _, Line in pairs(Data.Lines) do
        Line.Visible = false
    end
end

--========================================
-- DRAW BONE
--========================================

local function DrawBone(Line, PositionA, PositionB)
    if not Line then
        return
    end

    local Delta = PositionB - PositionA
    local Length = Delta.Magnitude

    if Length < 1 then
        Line.Visible = false
        return
    end

    local Middle = (PositionA + PositionB) / 2
    local Angle = math.deg(math.atan2(Delta.Y, Delta.X)) - 90

    Line.Position = UDim2.fromOffset(Middle.X, Middle.Y)
    Line.Size = UDim2.fromOffset(2, Length)
    Line.Rotation = Angle
    Line.BackgroundColor3 = Settings.ESPColor
    Line.Visible = true
end

--========================================
-- UPDATE SKELETON
--========================================

UpdateSkeleton = function(Player, Data)
    if not Data then
        return
    end

    if not Settings.Enabled or not Settings.SkeletonESP then
        HideSkeleton(Data)
        return
    end

    if Settings.TeamCheck and not IsEnemy(Player) then
        HideSkeleton(Data)
        return
    end

    local Character = GetCharacter(Player)

    if not Character then
        HideSkeleton(Data)
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid or Humanoid.Health <= 0 then
        HideSkeleton(Data)
        return
    end

    if not IsWithinDistance(Player) then
        HideSkeleton(Data)
        return
    end

    local Connections

    if Humanoid.RigType == Enum.HumanoidRigType.R15 then
        Connections = R15Connections
    else
        Connections = R6Connections
    end

    local Used = 0

    for _, Connection in ipairs(Connections) do
        Used = Used + 1

        local PartA = FindBodyPart(Character, {Connection[1]})
        local PartB = FindBodyPart(Character, {Connection[2]})

        local Line = Data.Lines[Used]

        if PartA and PartB and Line then
            local PointA, VisibleA =
                Camera:WorldToViewportPoint(PartA.Position)

            local PointB, VisibleB =
                Camera:WorldToViewportPoint(PartB.Position)

            if VisibleA or VisibleB then
                DrawBone(
                    Line,
                    Vector2.new(PointA.X, PointA.Y),
                    Vector2.new(PointB.X, PointB.Y)
                )
            else
                Line.Visible = false
            end
        elseif Line then
            Line.Visible = false
        end
    end

    for Index = Used + 1, #Data.Lines do
        Data.Lines[Index].Visible = false
    end
end

--========================================
-- CREATE SKELETONS
--========================================

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        CreateSkeleton(Player)
    end
end

Players.PlayerAdded:Connect(function(Player)
    task.wait(0.5)

    if Player ~= LocalPlayer then
        CreateSkeleton(Player)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveSkeleton(Player)
end)

--========================================
-- MINIMIZE SYSTEM
--========================================

local IsMinimized = false
local FullSize = UDim2.fromOffset(340, 520)
local MiniSize = UDim2.fromOffset(64, 64)

local function SetVisible(Object, State)
    if Object then
        Object.Visible = State
    end
end

local function MinimizeMenu()
    if IsMinimized then
        return
    end

    IsMinimized = true

    SetVisible(Content, false)
    SetVisible(Title, false)
    SetVisible(Subtitle, false)
    SetVisible(CloseButton, false)
    SetVisible(MinimizeButton, false)

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.35,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Size = MiniSize
        }
    ):Play()

    TweenService:Create(
        LogoButton,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    ):Play()
end

local function RestoreMenu()
    if not IsMinimized then
        return
    end

    IsMinimized = false

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.4,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Size = FullSize
        }
    ):Play()

    task.delay(0.15, function()
        SetVisible(Content, true)
        SetVisible(Title, true)
        SetVisible(Subtitle, true)
        SetVisible(CloseButton, true)
        SetVisible(MinimizeButton, true)

        LogoButton.AnchorPoint = Vector2.new(0, 0)
        LogoButton.Position = UDim2.fromOffset(14, 8)
    end)
end

--========================================
-- MINIMIZE BUTTON
--========================================

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

--========================================
-- MINI MOON CLICK / DRAG
--========================================

local MiniDragging = false
local MiniMoved = false
local MiniStart = nil
local MiniPosition = nil
local MiniInput = nil

LogoButton.InputBegan:Connect(function(Input)
    if not IsMinimized then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        MiniDragging = true
        MiniMoved = false
        MiniStart = Input.Position
        MiniPosition = Main.Position
        MiniInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not MiniDragging or not IsMinimized then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta = Input.Position - MiniStart

        if Delta.Magnitude > 5 then
            MiniMoved = true
        end

        Main.Position = UDim2.new(
            MiniPosition.X.Scale,
            MiniPosition.X.Offset + Delta.X,
            MiniPosition.Y.Scale,
            MiniPosition.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input == MiniInput
        or Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        if MiniDragging then
            local WasMoved = MiniMoved

            MiniDragging = false
            MiniInput = nil

            if not WasMoved then
                RestoreMenu()
            end
        end
    end
end)

--========================================
-- NORMAL MENU DRAG
--========================================

local Dragging = false
local DragStart = nil
local StartPosition = nil
local DragInput = nil

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
    if not Dragging or IsMinimized then
        return
    end

    if Input == DragInput then
        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input == DragInput
        or Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
        DragInput = nil
    end
end)

--========================================
-- CLOSE
--========================================

CloseButton.MouseButton1Click:Connect(function()
    Settings.Enabled = false

    for Player in pairs(ESPObjects) do
        RemoveESP(Player)
    end

    for Player in pairs(SkeletonObjects) do
        RemoveSkeleton(Player)
    end

    for _, Data in pairs(TracerObjects) do
        if Data then
            Data:Destroy()
        end
    end

    if ScreenGui then
        ScreenGui:Destroy()
    end
end)

--========================================
-- LOGO EFFECT
--========================================

LogoButton.MouseEnter:Connect(function()
    if IsMinimized then
        TweenService:Create(
            LogoButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {
                BackgroundColor3 = Color3.fromRGB(65, 42, 90)
            }
        ):Play()
    end
end)

LogoButton.MouseLeave:Connect(function()
    if IsMinimized then
        TweenService:Create(
            LogoButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {
                BackgroundColor3 = Color3.fromRGB(32, 22, 45)
            }
        ):Play()
    end
end)

--========================================
-- RAINBOW UI UPDATE
--========================================

RunService.RenderStepped:Connect(function()
    if Settings.Rainbow then
        local Color = Settings.ESPColor

        if MainStroke then
            MainStroke.Color = Color
        end

        if LogoButton then
            LogoButton.TextColor3 = Color
        end
    end
end)

--========================================
-- FINAL INITIALIZATION
--========================================

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        task.wait(1)

        if not Settings.Enabled then
            for _, Data in pairs(SkeletonObjects) do
                HideSkeleton(Data)
            end
        end
    end
end)

print("Lunar ESP loaded successfully")

--========================================
-- END OF LUNAR ESP
--========================================
