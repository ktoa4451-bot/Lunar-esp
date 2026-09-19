--========================================
-- LUNAR ESP 3.0
-- PART 1/3
--========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================
-- SETTINGS
--========================================

local Settings = {
    Enabled = true,

    BoxESP = true,
    ModelESP = false,
    NameESP = true,
    HealthESP = true,
    DistanceESP = true,
    TracerESP = false,
    SkeletonESP = false,

    TeamCheck = true,
    Rainbow = false,

    MaxDistance = 1000,

    ESPColor = Color3.fromRGB(180, 100, 255)
}

--========================================
-- COLORS
--========================================

local ESPColors = {
    Color3.fromRGB(180, 100, 255),
    Color3.fromRGB(120, 170, 255),
    Color3.fromRGB(255, 100, 180),
    Color3.fromRGB(100, 255, 180),
    Color3.fromRGB(255, 190, 80),
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(255, 255, 255)
}

local ColorNames = {
    "Purple",
    "Blue",
    "Pink",
    "Green",
    "Orange",
    "Red",
    "White"
}

local ColorIndex = 1

--========================================
-- GUI PARENT
--========================================

local function GetGuiParent()
    local Success, Result

    if gethui then
        Success, Result = pcall(gethui)

        if Success and Result then
            return Result
        end
    end

    Success, Result = pcall(function()
        return game:GetService("CoreGui")
    end)

    if Success and Result then
        return Result
    end

    return LocalPlayer:WaitForChild("PlayerGui")
end

local GuiParent = GetGuiParent()

--========================================
-- REMOVE OLD GUI
--========================================

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
Main.Size = UDim2.fromOffset(350, 540)
Main.Position = UDim2.new(0.5, -175, 0.5, -270)
Main.BackgroundColor3 = Color3.fromRGB(17, 13, 23)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.ESPColor
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.15
MainStroke.Parent = Main

--========================================
-- TOP BAR
--========================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.BackgroundColor3 = Color3.fromRGB(23, 17, 31)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 16)
TopCorner.Parent = TopBar

--========================================
-- TOP BAR MASK
--========================================

local TopMask = Instance.new("Frame")
TopMask.Size = UDim2.new(1, 0, 0, 18)
TopMask.Position = UDim2.new(0, 0, 1, -18)
TopMask.BackgroundColor3 = TopBar.BackgroundColor3
TopMask.BorderSizePixel = 0
TopMask.Parent = TopBar

--========================================
-- LOGO
--========================================

local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.fromOffset(48, 48)
LogoButton.Position = UDim2.fromOffset(11, 11)
LogoButton.BackgroundColor3 = Color3.fromRGB(31, 22, 42)
LogoButton.Text = "☾"
LogoButton.TextColor3 = Settings.ESPColor
LogoButton.TextSize = 29
LogoButton.Font = Enum.Font.GothamBold
LogoButton.AutoButtonColor = false
LogoButton.BorderSizePixel = 0
LogoButton.Parent = TopBar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 13)
LogoCorner.Parent = LogoButton

--========================================
-- TITLE
--========================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -150, 0, 28)
Title.Position = UDim2.fromOffset(70, 12)
Title.BackgroundTransparency = 1
Title.Text = "LUNAR ESP"
Title.TextColor3 = Color3.fromRGB(245, 240, 250)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -150, 0, 20)
Subtitle.Position = UDim2.fromOffset(71, 39)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Visual Player System"
Subtitle.TextColor3 = Color3.fromRGB(145, 130, 155)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

--========================================
-- CLOSE BUTTON
--========================================

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.fromOffset(32, 32)
CloseButton.Position = UDim2.new(1, -42, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(55, 27, 40)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 120, 150)
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

--========================================
-- MINIMIZE BUTTON
--========================================

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.fromOffset(32, 32)
MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(38, 29, 47)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(210, 190, 225)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.AutoButtonColor = false
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 10)
MinimizeCorner.Parent = MinimizeButton

--========================================
-- CONTENT
--========================================

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -82)
Content.Position = UDim2.fromOffset(10, 78)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Settings.ESPColor
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 2)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.Parent = Content

--========================================
-- BUTTON CREATOR
--========================================

local function CreateButton(Name, Text)
    local Button = Instance.new("TextButton")

    Button.Name = Name
    Button.Size = UDim2.new(1, -4, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(27, 21, 35)
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = Text
    Button.TextColor3 = Color3.fromRGB(225, 215, 235)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamMedium

    Button.Parent = Content

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(55, 42, 68)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.35
    Stroke.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.12),
            {
                BackgroundColor3 = Color3.fromRGB(47, 34, 61)
            }
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.12),
            {
                BackgroundColor3 = Color3.fromRGB(27, 21, 35)
            }
        ):Play()
    end)

    return Button
end

--========================================
-- BUTTONS
--========================================

local ESPButton =
    CreateButton("ESPButton", "ESP: ON")

local BoxButton =
    CreateButton("BoxButton", "Box ESP: ON")

local ModelButton =
    CreateButton("ModelButton", "Model ESP: OFF")

local NameButton =
    CreateButton("NameButton", "Name ESP: ON")

local HealthButton =
    CreateButton("HealthButton", "Health ESP: ON")

local DistanceButton =
    CreateButton("DistanceButton", "Distance ESP: ON")

local TracerButton =
    CreateButton("TracerButton", "Tracer ESP: OFF")

local SkeletonButton =
    CreateButton("SkeletonButton", "Skeleton ESP: OFF")

local TeamButton =
    CreateButton("TeamButton", "Team Check: ON")

local RainbowButton =
    CreateButton("RainbowButton", "Rainbow: OFF")

local DistanceLimitButton =
    CreateButton("DistanceLimitButton", "Max Distance: 1000")

local ColorButton =
    CreateButton("ColorButton", "ESP Color: Purple")

--========================================
-- ESP FOLDER
--========================================

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "LunarESP_Objects"
ESPFolder.Parent = ScreenGui

--========================================
-- ESP STORAGE
--========================================

local ESPObjects = {}
local SkeletonObjects = {}

--========================================
-- CHARACTER
--========================================

local function GetCharacter(Player)
    if not Player then
        return nil
    end

    local Character = Player.Character

    if not Character then
        return nil
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or not Root then
        return nil
    end

    if Humanoid.Health <= 0 then
        return nil
    end

    return Character
end

--========================================
-- TEAM CHECK
--========================================

local function IsEnemy(Player)
    if not Settings.TeamCheck then
        return true
    end

    if not Player or Player == LocalPlayer then
        return false
    end

    if LocalPlayer.Team ~= nil and Player.Team ~= nil then
        return LocalPlayer.Team ~= Player.Team
    end

    if LocalPlayer.TeamColor ~= nil and Player.TeamColor ~= nil then
        return LocalPlayer.TeamColor ~= Player.TeamColor
    end

    return true
end

--========================================
-- DISTANCE CHECK
--========================================

local function IsWithinDistance(Player)
    local Character = GetCharacter(Player)

    if not Character then
        return false
    end

    local Root = Character:FindFirstChild("HumanoidRootPart")

    local LocalCharacter = GetCharacter(LocalPlayer)

    if not Root or not LocalCharacter then
        return false
    end

    local LocalRoot =
        LocalCharacter:FindFirstChild("HumanoidRootPart")

    if not LocalRoot then
        return false
    end

    local Distance =
        (Root.Position - LocalRoot.Position).Magnitude

    return Distance <= Settings.MaxDistance
end

--========================================
-- MODEL PARTS
--========================================

local function GetModelParts(Character)
    local Parts = {}

    for _, Object in ipairs(Character:GetDescendants()) do
        if Object:IsA("BasePart") then
            if Object.Transparency < 1 then
                table.insert(Parts, Object)
            end
        end
    end

    return Parts
end

--========================================
-- SCREEN BOUNDS
--========================================

local function GetScreenBounds(Character)
    local Parts = GetModelParts(Character)

    if #Parts == 0 then
        return nil
    end

    local MinX = math.huge
    local MinY = math.huge
    local MaxX = -math.huge
    local MaxY = -math.huge

    local HasVisiblePoint = false

    for _, Part in ipairs(Parts) do
        local Size = Part.Size
        local CF = Part.CFrame

        local Corners = {
            Vector3.new(-Size.X/2, -Size.Y/2, -Size.Z/2),
            Vector3.new(-Size.X/2, -Size.Y/2,  Size.Z/2),
            Vector3.new(-Size.X/2,  Size.Y/2, -Size.Z/2),
            Vector3.new(-Size.X/2,  Size.Y/2,  Size.Z/2),
            Vector3.new( Size.X/2, -Size.Y/2, -Size.Z/2),
            Vector3.new( Size.X/2, -Size.Y/2,  Size.Z/2),
            Vector3.new( Size.X/2,  Size.Y/2, -Size.Z/2),
            Vector3.new( Size.X/2,  Size.Y/2,  Size.Z/2)
        }

        for _, Corner in ipairs(Corners) do
            local WorldPosition =
                CF:PointToWorldSpace(Corner)

            local ScreenPosition, Visible =
                Camera:WorldToViewportPoint(WorldPosition)

            if Visible and ScreenPosition.Z > 0 then
                HasVisiblePoint = true

                MinX = math.min(MinX, ScreenPosition.X)
                MinY = math.min(MinY, ScreenPosition.Y)
                MaxX = math.max(MaxX, ScreenPosition.X)
                MaxY = math.max(MaxY, ScreenPosition.Y)
            end
        end
    end

    if not HasVisiblePoint then
        return nil
    end

    return {
        MinX = MinX,
        MinY = MinY,
        MaxX = MaxX,
        MaxY = MaxY,

        Width = MaxX - MinX,
        Height = MaxY - MinY
    }
end

--========================================
-- END OF PART 1
--========================================

--========================================
-- LUNAR ESP 3.0
-- PART 2/3
-- ESP OBJECT SYSTEM
--========================================

--========================================
-- CREATE ESP
--========================================

local function CreateESP(Player)
    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return ESPObjects[Player]
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "ESP_" .. Player.Name
    Folder.Parent = ESPFolder

    local Data = {
        Folder = Folder,
        Player = Player
    }

    --========================================
    -- BOX
    --========================================

    local Box = Instance.new("Frame")
    Box.Name = "Box"
    Box.BackgroundTransparency = 1
    Box.BorderSizePixel = 0
    Box.Visible = false
    Box.ZIndex = 5
    Box.Parent = Folder

    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = Settings.ESPColor
    BoxStroke.Thickness = 1.5
    BoxStroke.Transparency = 0
    BoxStroke.Parent = Box

    Data.Box = Box
    Data.BoxStroke = BoxStroke

    --========================================
    -- CORNER BOX
    --========================================

    local Corners = {}

    for Index = 1, 8 do
        local Corner = Instance.new("Frame")
        Corner.Name = "Corner_" .. Index
        Corner.BorderSizePixel = 0
        Corner.BackgroundColor3 = Settings.ESPColor
        Corner.Visible = false
        Corner.ZIndex = 6
        Corner.Parent = Folder

        Corners[Index] = Corner
    end

    Data.Corners = Corners

    --========================================
    -- HEALTH BACKGROUND
    --========================================

    local HealthBack = Instance.new("Frame")
    HealthBack.Name = "HealthBack"
    HealthBack.BorderSizePixel = 0
    HealthBack.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    HealthBack.BackgroundTransparency = 0.25
    HealthBack.Visible = false
    HealthBack.ZIndex = 6
    HealthBack.Parent = Folder

    local HealthBackCorner = Instance.new("UICorner")
    HealthBackCorner.CornerRadius = UDim.new(0, 2)
    HealthBackCorner.Parent = HealthBack

    Data.HealthBack = HealthBack

    --========================================
    -- HEALTH FILL
    --========================================

    local HealthFill = Instance.new("Frame")
    HealthFill.Name = "HealthFill"
    HealthFill.AnchorPoint = Vector2.new(0, 1)
    HealthFill.Position = UDim2.new(0, 0, 1, 0)
    HealthFill.Size = UDim2.new(1, 0, 1, 0)
    HealthFill.BorderSizePixel = 0
    HealthFill.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
    HealthFill.Visible = false
    HealthFill.ZIndex = 7
    HealthFill.Parent = HealthBack

    local HealthCorner = Instance.new("UICorner")
    HealthCorner.CornerRadius = UDim.new(0, 2)
    HealthCorner.Parent = HealthFill

    Data.HealthFill = HealthFill

    --========================================
    -- NAME
    --========================================

    local Name = Instance.new("TextLabel")
    Name.Name = "Name"
    Name.BackgroundTransparency = 1
    Name.Text = Player.DisplayName
    Name.TextColor3 = Settings.ESPColor
    Name.TextStrokeColor3 = Color3.new(0, 0, 0)
    Name.TextStrokeTransparency = 0
    Name.TextSize = 13
    Name.Font = Enum.Font.GothamBold
    Name.AnchorPoint = Vector2.new(0.5, 1)
    Name.Visible = false
    Name.ZIndex = 8
    Name.Parent = Folder

    Data.Name = Name

    --========================================
    -- DISTANCE
    --========================================

    local Distance = Instance.new("TextLabel")
    Distance.Name = "Distance"
    Distance.BackgroundTransparency = 1
    Distance.TextColor3 = Color3.fromRGB(205, 195, 215)
    Distance.TextStrokeColor3 = Color3.new(0, 0, 0)
    Distance.TextStrokeTransparency = 0
    Distance.TextSize = 11
    Distance.Font = Enum.Font.Gotham
    Distance.AnchorPoint = Vector2.new(0.5, 0)
    Distance.Visible = false
    Distance.ZIndex = 8
    Distance.Parent = Folder

    Data.Distance = Distance

    --========================================
    -- MODEL HIGHLIGHT
    --========================================

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ModelHighlight"
    Highlight.FillColor = Settings.ESPColor
    Highlight.OutlineColor = Settings.ESPColor
    Highlight.FillTransparency = 0.78
    Highlight.OutlineTransparency = 0.05
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Enabled = false
    Highlight.Parent = Folder

    Data.Highlight = Highlight

    --========================================
    -- TRACER
    --========================================

    local Tracer = Instance.new("Frame")
    Tracer.Name = "Tracer"
    Tracer.AnchorPoint = Vector2.new(0.5, 0.5)
    Tracer.BorderSizePixel = 0
    Tracer.BackgroundColor3 = Settings.ESPColor
    Tracer.Size = UDim2.fromOffset(1.5, 1)
    Tracer.Visible = false
    Tracer.ZIndex = 4
    Tracer.Parent = Folder

    Data.Tracer = Tracer

    ESPObjects[Player] = Data

    return Data
end

--========================================
-- REMOVE ESP
--========================================

local function RemoveESP(Player)
    local Data = ESPObjects[Player]

    if not Data then
        return
    end

    if Data.Folder then
        Data.Folder:Destroy()
    end

    ESPObjects[Player] = nil
end

--========================================
-- HIDE ESP
--========================================

local function HideESP(Data)
    if not Data then
        return
    end

    if Data.Box then
        Data.Box.Visible = false
    end

    if Data.Corners then
        for _, Corner in ipairs(Data.Corners) do
            Corner.Visible = false
        end
    end

    if Data.HealthBack then
        Data.HealthBack.Visible = false
    end

    if Data.Name then
        Data.Name.Visible = false
    end

    if Data.Distance then
        Data.Distance.Visible = false
    end

    if Data.Highlight then
        Data.Highlight.Enabled = false
    end

    if Data.Tracer then
        Data.Tracer.Visible = false
    end
end

--========================================
-- UPDATE BOX
--========================================

local function UpdateBox(Data, Bounds)
    if not Data or not Bounds then
        return
    end

    if not Settings.BoxESP then
        Data.Box.Visible = false

        for _, Corner in ipairs(Data.Corners) do
            Corner.Visible = false
        end

        return
    end

    local X = Bounds.MinX
    local Y = Bounds.MinY
    local W = math.max(Bounds.Width, 2)
    local H = math.max(Bounds.Height, 2)

    Data.Box.Position = UDim2.fromOffset(X, Y)
    Data.Box.Size = UDim2.fromOffset(W, H)

    Data.BoxStroke.Color = Settings.ESPColor
    Data.Box.Visible = true

    local CornerSize = math.clamp(
        math.min(W, H) * 0.22,
        5,
        18
    )

    local Thickness = 2

    local C = Data.Corners

    -- Top Left Horizontal
    C[1].Position = UDim2.fromOffset(X, Y)
    C[1].Size = UDim2.fromOffset(CornerSize, Thickness)

    -- Top Left Vertical
    C[2].Position = UDim2.fromOffset(X, Y)
    C[2].Size = UDim2.fromOffset(Thickness, CornerSize)

    -- Top Right Horizontal
    C[3].Position = UDim2.fromOffset(
        X + W - CornerSize,
        Y
    )
    C[3].Size = UDim2.fromOffset(CornerSize, Thickness)

    -- Top Right Vertical
    C[4].Position = UDim2.fromOffset(
        X + W - Thickness,
        Y
    )
    C[4].Size = UDim2.fromOffset(Thickness, CornerSize)

    -- Bottom Left Horizontal
    C[5].Position = UDim2.fromOffset(
        X,
        Y + H - Thickness
    )
    C[5].Size = UDim2.fromOffset(CornerSize, Thickness)

    -- Bottom Left Vertical
    C[6].Position = UDim2.fromOffset(
        X,
        Y + H - CornerSize
    )
    C[6].Size = UDim2.fromOffset(Thickness, CornerSize)

    -- Bottom Right Horizontal
    C[7].Position = UDim2.fromOffset(
        X + W - CornerSize,
        Y + H - Thickness
    )
    C[7].Size = UDim2.fromOffset(CornerSize, Thickness)

    -- Bottom Right Vertical
    C[8].Position = UDim2.fromOffset(
        X + W - Thickness,
        Y + H - CornerSize
    )
    C[8].Size = UDim2.fromOffset(Thickness, CornerSize)

    for _, Corner in ipairs(C) do
        Corner.BackgroundColor3 = Settings.ESPColor
        Corner.Visible = true
    end
end

--========================================
-- UPDATE HEALTH
--========================================

local function UpdateHealth(Data, Character, Bounds)
    if not Settings.HealthESP then
        Data.HealthBack.Visible = false
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        Data.HealthBack.Visible = false
        return
    end

    local MaxHealth = math.max(Humanoid.MaxHealth, 1)
    local Health = math.clamp(
        Humanoid.Health,
        0,
        MaxHealth
    )

    local HealthPercent = Health / MaxHealth

    local Height = math.max(Bounds.Height, 2)

    Data.HealthBack.Position =
        UDim2.fromOffset(
            Bounds.MinX - 7,
            Bounds.MinY
        )

    Data.HealthBack.Size =
        UDim2.fromOffset(
            4,
            Height
        )

    Data.HealthFill.Size =
        UDim2.new(
            1,
            0,
            HealthPercent,
            0
        )

    if HealthPercent > 0.6 then
        Data.HealthFill.BackgroundColor3 =
            Color3.fromRGB(70, 255, 100)
    elseif HealthPercent > 0.3 then
        Data.HealthFill.BackgroundColor3 =
            Color3.fromRGB(255, 200, 70)
    else
        Data.HealthFill.BackgroundColor3 =
            Color3.fromRGB(255, 70, 70)
    end

    Data.HealthBack.Visible = true
end

--========================================
-- UPDATE NAME
--========================================

local function UpdateName(Data, Bounds)
    if not Settings.NameESP then
        Data.Name.Visible = false
        return
    end

    Data.Name.Text = Data.Player.DisplayName
    Data.Name.TextColor3 = Settings.ESPColor

    Data.Name.Position =
        UDim2.fromOffset(
            Bounds.MinX + Bounds.Width / 2,
            Bounds.MinY - 3
        )

    Data.Name.Size =
        UDim2.fromOffset(
            math.max(Bounds.Width + 80, 120),
            20
        )

    Data.Name.Visible = true
end

--========================================
-- UPDATE DISTANCE
--========================================

local function UpdateDistance(Data, Character, Bounds)
    if not Settings.DistanceESP then
        Data.Distance.Visible = false
        return
    end

    local LocalCharacter =
        GetCharacter(LocalPlayer)

    if not LocalCharacter then
        Data.Distance.Visible = false
        return
    end

    local LocalRoot =
        LocalCharacter:FindFirstChild("HumanoidRootPart")

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    if not LocalRoot or not Root then
        Data.Distance.Visible = false
        return
    end

    local Distance =
        (Root.Position - LocalRoot.Position).Magnitude

    Data.Distance.Text =
        string.format("%dm", math.floor(Distance))

    Data.Distance.Position =
        UDim2.fromOffset(
            Bounds.MinX + Bounds.Width / 2,
            Bounds.MaxY + 2
        )

    Data.Distance.Size =
        UDim2.fromOffset(
            math.max(Bounds.Width + 60, 100),
            18
        )

    Data.Distance.Visible = true
end

--========================================
-- UPDATE MODEL
--========================================

local function UpdateModel(Data, Character)
    if not Settings.ModelESP then
        Data.Highlight.Enabled = false
        return
    end

    Data.Highlight.Adornee = Character
    Data.Highlight.FillColor = Settings.ESPColor
    Data.Highlight.OutlineColor = Settings.ESPColor
    Data.Highlight.Enabled = true
end

--========================================
-- UPDATE TRACER
--========================================

local function UpdateTracer(Data, Bounds)
    if not Settings.TracerESP then
        Data.Tracer.Visible = false
        return
    end

    local Start =
        Vector2.new(
            Camera.ViewportSize.X / 2,
            Camera.ViewportSize.Y
        )

    local Target =
        Vector2.new(
            Bounds.MinX + Bounds.Width / 2,
            Bounds.MaxY
        )

    local Delta = Target - Start
    local Length = Delta.Magnitude

    if Length < 1 then
        Data.Tracer.Visible = false
        return
    end

    Data.Tracer.Position =
        UDim2.fromOffset(
            (Start.X + Target.X) / 2,
            (Start.Y + Target.Y) / 2
        )

    Data.Tracer.Size =
        UDim2.fromOffset(
            2,
            Length
        )

    Data.Tracer.Rotation =
        math.deg(math.atan2(Delta.Y, Delta.X)) - 90

    Data.Tracer.BackgroundColor3 =
        Settings.ESPColor

    Data.Tracer.Visible = true
end

--========================================
-- UPDATE ESP
--========================================

local function UpdateESP(Player, Data)
    if not Settings.Enabled then
        HideESP(Data)
        return
    end

    if not Player.Parent then
        HideESP(Data)
        return
    end

    if Settings.TeamCheck and not IsEnemy(Player) then
        HideESP(Data)
        return
    end

    local Character =
        GetCharacter(Player)

    if not Character then
        HideESP(Data)
        return
    end

    if not IsWithinDistance(Player) then
        HideESP(Data)
        return
    end

    local Bounds =
        GetScreenBounds(Character)

    if not Bounds then
        HideESP(Data)
        return
    end

    --========================================
    -- COLORS
    --========================================

    if Data.BoxStroke then
        Data.BoxStroke.Color = Settings.ESPColor
    end

    for _, Corner in ipairs(Data.Corners) do
        Corner.BackgroundColor3 =
            Settings.ESPColor
    end

    Data.Name.TextColor3 =
        Settings.ESPColor

    Data.Highlight.FillColor =
        Settings.ESPColor

    Data.Highlight.OutlineColor =
        Settings.ESPColor

    Data.Tracer.BackgroundColor3 =
        Settings.ESPColor

    --========================================
    -- FEATURES
    --========================================

    UpdateBox(Data, Bounds)

    UpdateHealth(
        Data,
        Character,
        Bounds
    )

    UpdateName(
        Data,
        Bounds
    )

    UpdateDistance(
        Data,
        Character,
        Bounds
    )

    UpdateModel(
        Data,
        Character
    )

    UpdateTracer(
        Data,
        Bounds
    )
end

--========================================
-- CREATE EXISTING ESP
--========================================

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        CreateESP(Player)
    end
end

--========================================
-- PLAYER ADDED
--========================================

Players.PlayerAdded:Connect(function(Player)
    if Player == LocalPlayer then
        return
    end

    task.wait(0.25)

    if Player.Parent then
        CreateESP(Player)
    end
end)

--========================================
-- PLAYER REMOVING
--========================================

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

--========================================
-- MAIN ESP LOOP
--========================================

RunService.RenderStepped:Connect(function()
    for Player, Data in pairs(ESPObjects) do
        if Player.Parent then
            UpdateESP(Player, Data)
        else
            RemoveESP(Player)
        end
    end
end)

--========================================
-- ESP BUTTON
--========================================

ESPButton.MouseButton1Click:Connect(function()
    Settings.Enabled = not Settings.Enabled

    ESPButton.Text =
        "ESP: " ..
        (Settings.Enabled and "ON" or "OFF")

    if not Settings.Enabled then
        for _, Data in pairs(ESPObjects) do
            HideESP(Data)
        end
    end
end)

--========================================
-- BOX BUTTON
--========================================

BoxButton.MouseButton1Click:Connect(function()
    Settings.BoxESP = not Settings.BoxESP

    BoxButton.Text =
        "Box ESP: " ..
        (Settings.BoxESP and "ON" or "OFF")
end)

--========================================
-- MODEL BUTTON
--========================================

ModelButton.MouseButton1Click:Connect(function()
    Settings.ModelESP = not Settings.ModelESP

    ModelButton.Text =
        "Model ESP: " ..
        (Settings.ModelESP and "ON" or "OFF")
end)

--========================================
-- NAME BUTTON
--========================================

NameButton.MouseButton1Click:Connect(function()
    Settings.NameESP = not Settings.NameESP

    NameButton.Text =
        "Name ESP: " ..
        (Settings.NameESP and "ON" or "OFF")
end)

--========================================
-- HEALTH BUTTON
--========================================

HealthButton.MouseButton1Click:Connect(function()
    Settings.HealthESP = not Settings.HealthESP

    HealthButton.Text =
        "Health ESP: " ..
        (Settings.HealthESP and "ON" or "OFF")
end)

--========================================
-- DISTANCE BUTTON
--========================================

DistanceButton.MouseButton1Click:Connect(function()
    Settings.DistanceESP = not Settings.DistanceESP

    DistanceButton.Text =
        "Distance ESP: " ..
        (Settings.DistanceESP and "ON" or "OFF")
end)

--========================================
-- TRACER BUTTON
--========================================

TracerButton.MouseButton1Click:Connect(function()
    Settings.TracerESP = not Settings.TracerESP

    TracerButton.Text =
        "Tracer ESP: " ..
        (Settings.TracerESP and "ON" or "OFF")
end)

--========================================
-- SKELETON BUTTON
--========================================

SkeletonButton.MouseButton1Click:Connect(function()
    Settings.SkeletonESP = not Settings.SkeletonESP

    SkeletonButton.Text =
        "Skeleton ESP: " ..
        (Settings.SkeletonESP and "ON" or "OFF")
end)

--========================================
-- TEAM CHECK BUTTON
--========================================

TeamButton.MouseButton1Click:Connect(function()
    Settings.TeamCheck = not Settings.TeamCheck

    TeamButton.Text =
        "Team Check: " ..
        (Settings.TeamCheck and "ON" or "OFF")
end)

--========================================
-- RAINBOW BUTTON
--========================================

RainbowButton.MouseButton1Click:Connect(function()
    Settings.Rainbow = not Settings.Rainbow

    RainbowButton.Text =
        "Rainbow: " ..
        (Settings.Rainbow and "ON" or "OFF")
end)

--========================================
-- END OF PART 2
--========================================

--========================================
-- LUNAR ESP 3.0
-- PART 3/3
-- SKELETON + CONTROLS + MINIMIZE
--========================================

--========================================
-- BODY PART FINDER
--========================================

local function FindBodyPart(Character, Name)
    local Part = Character:FindFirstChild(Name)

    if Part and Part:IsA("BasePart") then
        return Part
    end

    return nil
end

--========================================
-- SKELETON CONNECTIONS
--========================================

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
        Player = Player,
        Lines = {}
    }

    local MaxBones = math.max(
        #R15Connections,
        #R6Connections
    )

    for Index = 1, MaxBones do
        local Line = Instance.new("Frame")

        Line.Name = "Bone_" .. Index
        Line.AnchorPoint = Vector2.new(0.5, 0.5)
        Line.BorderSizePixel = 0
        Line.BackgroundColor3 = Settings.ESPColor
        Line.Size = UDim2.fromOffset(2, 1)
        Line.Visible = false
        Line.ZIndex = 7
        Line.Parent = Folder

        Data.Lines[Index] = Line
    end

    SkeletonObjects[Player] = Data

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

    for _, Line in ipairs(Data.Lines) do
        Line.Visible = false
    end
end

--========================================
-- DRAW BONE
--========================================

local function DrawBone(Line, A, B)
    if not Line then
        return
    end

    local Delta = B - A
    local Length = Delta.Magnitude

    if Length < 1 then
        Line.Visible = false
        return
    end

    local Middle = (A + B) / 2

    Line.Position =
        UDim2.fromOffset(
            Middle.X,
            Middle.Y
        )

    Line.Size =
        UDim2.fromOffset(
            2,
            Length
        )

    Line.Rotation =
        math.deg(
            math.atan2(
                Delta.Y,
                Delta.X
            )
        ) - 90

    Line.BackgroundColor3 =
        Settings.ESPColor

    Line.Visible = true
end

--========================================
-- UPDATE SKELETON
--========================================

local function UpdateSkeleton(Player, Data)
    if not Data then
        return
    end

    if not Settings.Enabled
        or not Settings.SkeletonESP then

        HideSkeleton(Data)
        return
    end

    if Settings.TeamCheck
        and not IsEnemy(Player) then

        HideSkeleton(Data)
        return
    end

    if not IsWithinDistance(Player) then
        HideSkeleton(Data)
        return
    end

    local Character =
        GetCharacter(Player)

    if not Character then
        HideSkeleton(Data)
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        HideSkeleton(Data)
        return
    end

    local Connections

    if Humanoid.RigType ==
        Enum.HumanoidRigType.R15 then

        Connections = R15Connections
    else
        Connections = R6Connections
    end

    for Index, Connection in ipairs(Connections) do
        local PartA =
            FindBodyPart(
                Character,
                Connection[1]
            )

        local PartB =
            FindBodyPart(
                Character,
                Connection[2]
            )

        local Line =
            Data.Lines[Index]

        if PartA and PartB and Line then
            local PointA, VisibleA =
                Camera:WorldToViewportPoint(
                    PartA.Position
                )

            local PointB, VisibleB =
                Camera:WorldToViewportPoint(
                    PartB.Position
                )

            if PointA.Z > 0
                and PointB.Z > 0
                and (VisibleA or VisibleB) then

                DrawBone(
                    Line,
                    Vector2.new(
                        PointA.X,
                        PointA.Y
                    ),
                    Vector2.new(
                        PointB.X,
                        PointB.Y
                    )
                )
            else
                Line.Visible = false
            end
        elseif Line then
            Line.Visible = false
        end
    end

    for Index = #Connections + 1, #Data.Lines do
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
    if Player == LocalPlayer then
        return
    end

    task.wait(0.25)

    if Player.Parent then
        CreateSkeleton(Player)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveSkeleton(Player)
end)

--========================================
-- SKELETON LOOP
--========================================

RunService.RenderStepped:Connect(function()
    for Player, Data in pairs(SkeletonObjects) do
        if Player.Parent then
            UpdateSkeleton(Player, Data)
        else
            RemoveSkeleton(Player)
        end
    end
end)

--========================================
-- MAX DISTANCE
--========================================

local DistanceOptions = {
    100,
    250,
    500,
    1000,
    2000,
    math.huge
}

local DistanceIndex = 4

DistanceLimitButton.MouseButton1Click:Connect(function()
    DistanceIndex = DistanceIndex + 1

    if DistanceIndex > #DistanceOptions then
        DistanceIndex = 1
    end

    Settings.MaxDistance =
        DistanceOptions[DistanceIndex]

    if Settings.MaxDistance == math.huge then
        DistanceLimitButton.Text =
            "Max Distance: Unlimited"
    else
        DistanceLimitButton.Text =
            "Max Distance: " ..
            tostring(Settings.MaxDistance)
    end
end)

--========================================
-- COLOR
--========================================

ColorButton.MouseButton1Click:Connect(function()
    ColorIndex = ColorIndex + 1

    if ColorIndex > #ESPColors then
        ColorIndex = 1
    end

    Settings.ESPColor =
        ESPColors[ColorIndex]

    ColorButton.Text =
        "ESP Color: " ..
        ColorNames[ColorIndex]
end)

--========================================
-- RAINBOW
--========================================

local RainbowHue = 0

RunService.RenderStepped:Connect(function(Delta)
    if Settings.Rainbow then
        RainbowHue =
            RainbowHue + Delta * 0.35

        if RainbowHue >= 1 then
            RainbowHue = 0
        end

        Settings.ESPColor =
            Color3.fromHSV(
                RainbowHue,
                0.85,
                1
            )
    end
end)

--========================================
-- MINIMIZE SYSTEM
--========================================

local IsMinimized = false

local FullSize =
    UDim2.fromOffset(350, 540)

local MiniSize =
    UDim2.fromOffset(64, 64)

--========================================
-- RESTORE LOGO
--========================================

local function RestoreLogo()
    LogoButton.AnchorPoint =
        Vector2.new(0, 0)

    LogoButton.Position =
        UDim2.fromOffset(11, 11)

    LogoButton.Size =
        UDim2.fromOffset(48, 48)
end

--========================================
-- MINIMIZE
--========================================

local function MinimizeMenu()
    if IsMinimized then
        return
    end

    IsMinimized = true

    Content.Visible = false
    Title.Visible = false
    Subtitle.Visible = false
    CloseButton.Visible = false
    MinimizeButton.Visible = false

    TopMask.Visible = false

    TopBar.Size =
        UDim2.fromScale(1, 1)

    TopBar.BackgroundColor3 =
        Color3.fromRGB(20, 15, 28)

    LogoButton.AnchorPoint =
        Vector2.new(0.5, 0.5)

    LogoButton.Position =
        UDim2.fromScale(0.5, 0.5)

    LogoButton.Size =
        UDim2.fromOffset(50, 50)

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
end

--========================================
-- RESTORE
--========================================

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

    task.delay(0.18, function()
        if not ScreenGui.Parent then
            return
        end

        TopBar.Size =
            UDim2.new(1, 0, 0, 70)

        TopBar.BackgroundColor3 =
            Color3.fromRGB(23, 17, 31)

        TopMask.Visible = true

        RestoreLogo()

        Content.Visible = true
        Title.Visible = true
        Subtitle.Visible = true
        CloseButton.Visible = true
        MinimizeButton.Visible = true
    end)
end

--========================================
-- MINIMIZE BUTTON
--========================================

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

--========================================
-- MINI DRAG
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

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        MiniDragging = true
        MiniMoved = false
        MiniStart = Input.Position
        MiniPosition = Main.Position
        MiniInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not MiniDragging
        or not IsMinimized then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            Input.Position - MiniStart

        if Delta.Magnitude > 5 then
            MiniMoved = true
        end

        Main.Position =
            UDim2.new(
                MiniPosition.X.Scale,
                MiniPosition.X.Offset + Delta.X,
                MiniPosition.Y.Scale,
                MiniPosition.Y.Offset + Delta.Y
            )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input == MiniInput then
        local Clicked =
            not MiniMoved

        MiniDragging = false
        MiniInput = nil

        if Clicked then
            RestoreMenu()
        end
    end
end)

--========================================
-- NORMAL DRAG
--========================================

local Dragging = false
local DragStart = nil
local StartPosition = nil
local DragInput = nil

TopBar.InputBegan:Connect(function(Input)
    if IsMinimized then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
        DragInput = Input
    end
end)

TopBar.InputChanged:Connect(function(Input)
    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging
        or IsMinimized then
        return
    end

    if Input == DragInput then
        local Delta =
            Input.Position - DragStart

        Main.Position =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input == DragInput then
        Dragging = false
        DragInput = nil
    end
end)

--========================================
-- CLOSE
--========================================

local Closed = false

CloseButton.MouseButton1Click:Connect(function()
    if Closed then
        return
    end

    Closed = true

    Settings.Enabled = false

    for Player, Data in pairs(ESPObjects) do
        if Data and Data.Folder then
            Data.Folder:Destroy()
        end

        ESPObjects[Player] = nil
    end

    for Player, Data in pairs(SkeletonObjects) do
        if Data and Data.Folder then
            Data.Folder:Destroy()
        end

        SkeletonObjects[Player] = nil
    end

    ScreenGui:Destroy()
end)

--========================================
-- BUTTON STATE UPDATE
--========================================

local function UpdateButtonStates()
    if not ScreenGui.Parent then
        return
    end

    ESPButton.Text =
        "ESP: " ..
        (Settings.Enabled and "ON" or "OFF")

    BoxButton.Text =
        "Box ESP: " ..
        (Settings.BoxESP and "ON" or "OFF")

    ModelButton.Text =
        "Model ESP: " ..
        (Settings.ModelESP and "ON" or "OFF")

    NameButton.Text =
        "Name ESP: " ..
        (Settings.NameESP and "ON" or "OFF")

    HealthButton.Text =
        "Health ESP: " ..
        (Settings.HealthESP and "ON" or "OFF")

    DistanceButton.Text =
        "Distance ESP: " ..
        (Settings.DistanceESP and "ON" or "OFF")

    TracerButton.Text =
        "Tracer ESP: " ..
        (Settings.TracerESP and "ON" or "OFF")

    SkeletonButton.Text =
        "Skeleton ESP: " ..
        (Settings.SkeletonESP and "ON" or "OFF")

    TeamButton.Text =
        "Team Check: " ..
        (Settings.TeamCheck and "ON" or "OFF")

    RainbowButton.Text =
        "Rainbow: " ..
        (Settings.Rainbow and "ON" or "OFF")
end

--========================================
-- FINAL RAINBOW VISUALS
--========================================

RunService.RenderStepped:Connect(function()
    if Closed or not ScreenGui.Parent then
        return
    end

    if Settings.Rainbow then
        MainStroke.Color =
            Settings.ESPColor

        LogoButton.TextColor3 =
            Settings.ESPColor

        Content.ScrollBarImageColor3 =
            Settings.ESPColor
    else
        MainStroke.Color =
            Settings.ESPColor

        LogoButton.TextColor3 =
            Settings.ESPColor

        Content.ScrollBarImageColor3 =
            Settings.ESPColor
    end
end)

--========================================
-- INITIAL BUTTON STATE
--========================================

UpdateButtonStates()

--========================================
-- LOADED
--========================================

print("Lunar ESP 3.0 loaded")

--========================================
-- END OF LUNAR ESP 3.0
--========================================
