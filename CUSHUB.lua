local CFAHub = {}
warn("Preparing UI...")
repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.Players.LocalPlayer.Character
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
warn("UI Loaded.")

local Fully_Support_Exploits = {"Krnl", "Synapse X"}
local Tween = game:GetService("TweenService")
local Tweeninfo = TweenInfo.new
local Input = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local ms = Player:GetMouse()

local Utility = {}
local Objects = {}
local Animate = {}

function Utility:TweenObject(obj, properties, duration, ...)
    Tween:Create(obj, Tweeninfo(duration, ...), properties):Play()
end

function Utility:Pop(object, shrink)
    local clone = object:Clone()
	clone.AnchorPoint = Vector2.new(0.5, 0.5)
	clone.Size = clone.Size - UDim2.new(0, shrink, 0, shrink)
	clone.Position = UDim2.new(0.5, 0, 0.5, 0)
	clone.Parent = object
	object.BackgroundTransparency = 1
	Utility:TweenObject(clone, {Size = object.Size}, 0.2)
	spawn(function()
		wait(0.2)
		object.BackgroundTransparency = 0
		clone:Destroy()
	end)
	return clone
end

function Utility:TweenColor(obj, value, t)
  Tween:Create(obj, TweenInfo.new(.25), {BackgroundColor3 = value}):Play()
end

function Utility:TweenTransparency(obj, style, value)
    if string.lower(style) == 'bg' then
		Tween:Create(obj, TweenInfo.new(.25), {BackgroundTransparency = value}):Play()
	elseif string.lower(style) == 'img' then 
		Tween:Create(obj, TweenInfo.new(.25), {ImageTransparency = value}):Play()
	elseif string.lower(style) == 'text' then 
		Tween:Create(obj, TweenInfo.new(.25), {TextTransparency = value}):Play()
	end
end

function Utility:TweenRotation(obj, value)
  Tween:Create(obj, TweenInfo.new(.25), {Rotation = value}):Play()
end

function Animate:TypeWriter(text)
    for i = 1, #text, 1 do
        return string.sub(text, 1, i)
    end
end

function Animate:RandomString(length)
    local chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    local s = {}
    for i = 1, length do s[i] = chars[math.random(1, #chars)] end
    return table.concat(s)
end

function Animate:CreateGradient(object)
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(209, 209, 209))}
    UIGradient.Rotation = 25
    UIGradient.Parent = object
end

function CFAHub:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    Input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Utility:TweenObject(parent, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.25)
        end
    end)
end

local GuiName = "CFAHubPremium2022"
function CFAHub:CreateWindow(title, gameName, intro)
    title = title or "<font color=\"#1CB2F5\">CFA Hub Premium</font>"
    gameName = gameName or "N/A"
    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == GuiName then
            v:Destroy()
        end
    end
    local themes = {
        SchemaColor = Color3.fromRGB(79, 195, 247), -- Main Color
        TextColor = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(22, 22, 22),
        Container = Color3.fromRGB(34, 34, 34),
        Background = Color3.fromRGB(22, 22, 22),
        Slider = Color3.fromRGB(15, 15, 15),
        Drop = Color3.fromRGB(28, 28, 28),
        ScrollBar = Color3.fromRGB(149, 149, 149),
        NotiBackground = Color3.fromRGB(0, 0, 0),
        Logo = "rbxassetid://12847918419"
    }
    table.insert(CFAHub, title)
    function CFAHub:SetTheme(theme, color3)
        themes[theme] = color3
    end
    local CFAHubGui = Instance.new("ScreenGui")
    if intro == true then
        local Logo = Instance.new("ImageLabel")
        Logo.Parent = CFAHubGui
        Logo.AnchorPoint = Vector2.new(0.5, 0.5)
        Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Logo.BackgroundTransparency = 1.000
        Logo.ImageTransparency = 1
        Logo.Position = UDim2.new(0.5, 0, 0.6, 0)
        Logo.Size = UDim2.new(0, 200, 0, 200)
        Logo.Image = themes.Logo
        Tween:Create(Logo, Tweeninfo(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            ImageTransparency = 0
        }):Play()
        wait(1.5)
        Tween:Create(Logo, Tweeninfo(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Position = UDim2.new(0.5, 0, 0.4, 0),
            ImageTransparency = 1
        }):Play()
        wait(0.2)
        Logo:Destroy()
    end

    local Container = Instance.new("Frame")
    local UIScale = Instance.new("UIScale")
    local ContainerCorner = Instance.new("UICorner")
    local ElementContainer = Instance.new("Frame")
    local Elements = Instance.new("Frame")
    local ElementCorner = Instance.new("UICorner")

    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local logo = Instance.new("ImageLabel")
    local Title = Instance.new("TextLabel")

    local TabFrame = Instance.new("Frame")
    local TabCorner = Instance.new("UICorner")
    local TabScroll = Instance.new("ScrollingFrame")
    local TabGridLayout = Instance.new("UIGridLayout")

    local ShadowBlue = Instance.new("ImageLabel")

    -- NOTIFICATION

    local UIListLayout = Instance.new("UIListLayout")
    local CurrentAlert = Instance.new("Frame")
    
    UIListLayout.Parent = CurrentAlert
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.Padding = UDim.new(0, 8)
    
    CurrentAlert.Name = "NotiContainer"
    CurrentAlert.Parent = CFAHubGui
    CurrentAlert.AnchorPoint = Vector2.new(1, 1)
    CurrentAlert.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CurrentAlert.BackgroundTransparency = 1.000
    CurrentAlert.Position = UDim2.new(1, -10, 1, -10)
    CurrentAlert.Size = UDim2.new(1, -10, 1, -10)
    CurrentAlert.ZIndex = 9

    function CFAHub:AddNoti(header, message, duration, buttonEnable, callback)
        header = header or "Announcement"
        message = message or "Nil"
        duration = duration or 120
        callback = callback or function() end

        local Template = Instance.new("Frame")
        local Header = Instance.new("TextLabel")
        local Message = Instance.new("TextLabel")
        local UICorner = Instance.new("UICorner")
        local ButtonContainer = Instance.new("Frame")
        local YesButton = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        local YesIcon = Instance.new("ImageLabel")
        local NoButton = Instance.new("TextButton")
        local UICorner_3 = Instance.new("UICorner")
        local NoIcon = Instance.new("ImageLabel")
        local BarFrame = Instance.new("Frame")
        local Bar = Instance.new("Frame")
        local UICorner_4 = Instance.new("UICorner")
        local UICorner_5 = Instance.new("UICorner")
        
        Template.Name = "Template"
        Template.Parent = CurrentAlert
        Template.BackgroundColor3 = themes.NotiBackground
        Objects[Template] = "NotiBackground"
        Template.BackgroundTransparency = 0.200
        Template.BorderSizePixel = 0
        Template.ClipsDescendants = true
        Template.Position = UDim2.new(1.01262629, -260, 0.732447803, 50)
        Template.Size = UDim2.new(0, 250, 0, 91)
        Template.ZIndex = 99
        
        Header.Name = "Header"
        Header.Parent = Template
        Header.AnchorPoint = Vector2.new(0.5, 0)
        Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Header.BackgroundTransparency = 1.000
        Header.Position = UDim2.new(0.400000006, 0, 0.100000069, 0)
        Header.Size = UDim2.new(0.75, 0, 0, 20)
        Header.Font = Enum.Font.GothamBold
        Header.Text = header
        Header.TextColor3 = themes.TextColor
        Objects[Header] = "TextColor"
        Header.TextSize = 16.000
        Header.TextXAlignment = Enum.TextXAlignment.Left
        
        Message.Name = "Message"
        Message.Parent = Template
        Message.AnchorPoint = Vector2.new(0.5, 0)
        Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Message.BackgroundTransparency = 1.000
        Message.Position = UDim2.new(0.400000006, 0, 0.312000006, 0)
        Message.Size = UDim2.new(0.75, 0, 0.5, 0)
        Message.Font = Enum.Font.GothamSemibold
        Message.Text = message
        Message.TextColor3 = themes.TextColor
        Objects[Message] = "TextColor"
        Message.TextSize = 15.000
        Message.TextWrapped = true
        Message.TextTransparency = 0.25
        Message.TextXAlignment = Enum.TextXAlignment.Left
        Message.TextYAlignment = Enum.TextYAlignment.Top
        
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = Template
        
        ButtonContainer.Name = "ButtonContainer"
        ButtonContainer.Parent = Template
        ButtonContainer.AnchorPoint = Vector2.new(0.5, 0)
        ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonContainer.BackgroundTransparency = 1.000
        ButtonContainer.Position = UDim2.new(0.889500022, 0, 0.539560497, -40)
        ButtonContainer.Size = UDim2.new(0, 43, 0, 61)
        ButtonContainer.ZIndex = 2
        
        YesButton.Name = "YesButton"
        YesButton.Parent = ButtonContainer
        YesButton.AnchorPoint = Vector2.new(1, 0)
        YesButton.BackgroundColor3 = Color3.fromRGB(67, 116, 58)
        if buttonEnable == false then
            YesButton.BackgroundTransparency = 0.6
            YesButton.Active = false
        else
            YesButton.BackgroundTransparency = 0
        end
        YesButton.Position = UDim2.new(1, 0, 0, 0)
        YesButton.Size = UDim2.new(1, 0, 0, 27)
        YesButton.ZIndex = 2
        YesButton.AutoButtonColor = false
        YesButton.Font = Enum.Font.SourceSansSemibold
        YesButton.Text = ""
        YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesButton.TextSize = 22.000
        
        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = YesButton
        
        YesIcon.Name = "YesIcon"
        YesIcon.Parent = YesButton
        YesIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        YesIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        YesIcon.BackgroundTransparency = 1.000
        YesIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        YesIcon.Size = UDim2.new(0, 20, 0, 20)
        YesIcon.Image = "rbxassetid://7072706620"
        
        Animate:CreateGradient(YesButton)
        
        NoButton.Name = "NoButton"
        NoButton.Parent = ButtonContainer
        NoButton.AnchorPoint = Vector2.new(1, 1)
        NoButton.BackgroundColor3 = Color3.fromRGB(184, 41, 65)
        NoButton.Position = UDim2.new(1, 0, 1, 0)
        NoButton.Size = UDim2.new(1, 0, 0, 27)
        NoButton.ZIndex = 2
        NoButton.Font = Enum.Font.SourceSansSemibold
        NoButton.Text = ""
        NoButton.AutoButtonColor = false
        NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        NoButton.TextSize = 22.000
        
        UICorner_3.CornerRadius = UDim.new(0, 4)
        UICorner_3.Parent = NoButton
        
        Animate:CreateGradient(NoButton)
        
        NoIcon.Name = "NoIcon"
        NoIcon.Parent = NoButton
        NoIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        NoIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NoIcon.BackgroundTransparency = 1.000
        NoIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        NoIcon.Size = UDim2.new(0, 20, 0, 20)
        NoIcon.Image = "rbxassetid://7072725342"
        
        BarFrame.Name = "BarFrame"
        BarFrame.Parent = Template
        BarFrame.AnchorPoint = Vector2.new(0.5, 1)
        BarFrame.BackgroundColor3 = themes.NotiBackground
        Objects[BarFrame] = "NotiBackground"
        BarFrame.BackgroundTransparency = 0.200
        BarFrame.BorderSizePixel = 0
        BarFrame.Position = UDim2.new(0.5, 0, 1, -6)
        BarFrame.Size = UDim2.new(0, 240, 0, 8)
        
        Bar.Name = "Bar"
        Bar.Parent = BarFrame
        Bar.AnchorPoint = Vector2.new(0, 1)
        Bar.BackgroundColor3 = themes.SchemaColor
        Objects[Bar] = "SchemaColor"
        Bar.BorderSizePixel = 0
        Bar.Position = UDim2.new(0, 0, 1, 0)
        Bar.Size = UDim2.new(0.862500012, 0, 1, 0)
        Bar.ZIndex = 2
        
        UICorner_4.CornerRadius = UDim.new(0, 2)
        UICorner_4.Parent = Bar

        Animate:CreateGradient(Bar)
        
        UICorner_5.CornerRadius = UDim.new(0, 2)
        UICorner_5.Parent = BarFrame

        coroutine.wrap(function()
            while wait() do
                Template.BackgroundColor3 = themes.NotiBackground
                Header.TextColor3 = themes.TextColor
                Message.TextColor3 = themes.TextColor
                BarFrame.BackgroundColor3 = themes.NotiBackground
                Bar.BackgroundColor3 = themes.SchemaColor
            end
        end)()

        local close = Tween:Create(Bar,TweenInfo.new(duration),{Size = UDim2.new(0, 0, 1,0)})

        close:Play()

        local function closeNoti()
            Utility:TweenTransparency(Template,"bg",1)
            Utility:TweenTransparency(BarFrame,"bg",1)
            Utility:TweenTransparency(Bar,"bg",1)
            Utility:TweenTransparency(Header,"text",1)
            Utility:TweenTransparency(Message,"text",1)
            Utility:TweenTransparency(YesButton,"bg",1)
            Utility:TweenTransparency(YesButton,"text",1)
            Utility:TweenTransparency(YesIcon, 'img', 1)
            Utility:TweenTransparency(NoButton,"bg",1)
            Utility:TweenTransparency(NoButton,"text",1)
            Utility:TweenTransparency(NoIcon, 'img', 1)
            wait(0.25)
            Template:Destroy()
        end

        close.Completed:Connect(function()
            closeNoti()
        end)

        YesButton.MouseButton1Click:Connect(function()
            if buttonEnable == false then
                return
            else
                Utility:Pop(YesButton, 8)
                closeNoti()
                wait(0.02)
                callback()
            end
        end)

        NoButton.MouseButton1Click:Connect(function()
            Utility:Pop(NoButton, 8)
            closeNoti()
        end)
    end -- final

    function CFAHub:ToggleUI()
        if Container.Visible == true then
            Utility:TweenObject(UIScale, {Scale = 0.95}, 0.25)
            wait(0.25)
            Container.Visible = false
        else
            Utility:TweenObject(UIScale, {Scale = 1.0}, 0.25)
            Container.Visible = true
        end
    end

    CFAHub:DraggingEnabled(Header, Container)

    CFAHubGui.Name = GuiName
    CFAHubGui.Parent = CoreGui
    CFAHubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Container.Name = "Container"
    Container.Parent = CFAHubGui
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = themes.Container
    Objects[Container] = "Container"
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 673, 0, 402)

    UIScale.Parent = Container
    UIScale.Scale = 1

    ContainerCorner.CornerRadius = UDim.new(0, 4)
    ContainerCorner.Name = "ContainerCorner"
    ContainerCorner.Parent = Container

    ElementContainer.Name = "ElementContainer"
    ElementContainer.Parent = Container
    ElementContainer.AnchorPoint = Vector2.new(0, 0.5)
    ElementContainer.BackgroundColor3 = themes.Background
    Objects[ElementContainer] = "Background"
    ElementContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    ElementContainer.Position = UDim2.new(0.271515578, 0, 0.49751243, 15)
    ElementContainer.ClipsDescendants = true
    ElementContainer.Size = UDim2.new(0.71619612, 0, 0.0298507456, 348)

    Elements.Name = "Elements"
    Elements.Parent = ElementContainer
    Elements.AnchorPoint = Vector2.new(0, 0)
    Elements.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Elements.BackgroundTransparency = 1
    Elements.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Elements.Position = UDim2.new(0, 0, 0, 0)
    Elements.ClipsDescendants = true
    Elements.Size = UDim2.new(1, 0, 1, 0)

    ElementCorner.CornerRadius = UDim.new(0, 4)
    ElementCorner.Name = "ElementCorner"
    ElementCorner.Parent = ElementContainer

    local Fader = Instance.new("Frame")
    local FaderGradient = Instance.new("UIGradient")
    local Fader_2 = Instance.new("Frame")
    local FaderGradient_2 = Instance.new("UIGradient")
    
    Fader.Name = "Fader"
    Fader.Parent = ElementContainer
    Fader.AnchorPoint = Vector2.new(0, 1)
    Fader.BackgroundColor3 = themes.Background
    Objects[Fader] = "Background"
    Fader.BorderSizePixel = 0
    Fader.Position = UDim2.new(0, 0, 1, 0)
    Fader.Size = UDim2.new(1, 0, -0.0388888903, 44)
    Fader.ZIndex = 3
    
    FaderGradient.Rotation = -90
    FaderGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
    FaderGradient.Name = "FaderGradient"
    FaderGradient.Parent = Fader
    
    Fader_2.Name = "Fader"
    Fader_2.Parent = ElementContainer
    Fader_2.BackgroundColor3 = themes.Background
    Objects[Fader_2] = "Background"
    Fader_2.BorderSizePixel = 0
    Fader_2.Size = UDim2.new(1, 0, -0.0388888903, 44)
    Fader_2.ZIndex = 3
    
    FaderGradient_2.Rotation = 90
    FaderGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
    FaderGradient_2.Name = "FaderGradient"
    FaderGradient_2.Parent = Fader_2

    local UIPageLayout = Instance.new("UIPageLayout")
    
    UIPageLayout.Parent = Elements
    UIPageLayout.FillDirection = Enum.FillDirection.Vertical
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.Padding = UDim.new(0, 0)
    UIPageLayout.TweenTime = 0.500

    Header.Name = "Header"
    Header.Parent = Container
    Header.BackgroundColor3 = themes.Header
    Objects[Header] = "Header"
    Header.BorderColor3 = Color3.fromRGB(43, 43, 43)
    Header.Size = UDim2.new(0, 673, 0, 29)

    HeaderCorner.CornerRadius = UDim.new(0, 4)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    coverup.Name = "coverup"
    coverup.Parent = Header
    coverup.BackgroundColor3 = themes.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(1, 0, 0, 7)

    logo.Name = "logo"
    logo.Parent = Header
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    logo.BackgroundTransparency = 1.000
    logo.Position = UDim2.new(0.0299999993, 0, 0.5, 0)
    logo.Size = UDim2.new(0, 25, 0, 25)
    logo.ZIndex = 2
    logo.Image = themes.Logo
    Objects[logo] = "Logo"

    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0579494797, 0, 0, 0)
    Title.Size = UDim2.new(0, 625, 0, 29)
    Title.ZIndex = 2
    Title.Font = Enum.Font.SourceSansSemibold
    Title.Text = title .. " - " .. gameName
    Title.RichText = true
    Title.TextColor3 = themes.TextColor
    Objects[Title] = "TextColor"
    Title.TextSize = 22.000
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TabFrame.Name = "TabFrame"
    TabFrame.Parent = Container
    TabFrame.AnchorPoint = Vector2.new(0, 0.5)
    TabFrame.BackgroundColor3 = themes.Background
    Objects[TabFrame] = "Background"
    TabFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TabFrame.Position = UDim2.new(0.00999999978, 0, 0.49751243, 15)
    TabFrame.Size = UDim2.new(0.249628529, 0, 0.0298507456, 348)

    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Name = "TabCorner"
    TabCorner.Parent = TabFrame

    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabFrame
    TabScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabScroll.BackgroundTransparency = 1.000
    TabScroll.BorderSizePixel = 0
    TabScroll.Position = UDim2.new(0, 0, 0, 0)
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.ZIndex = 2
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.ScrollBarImageColor3 = themes.ScrollBar
    TabScroll.ScrollBarThickness = 6

    TabGridLayout.Name = "TabGridLayout"
    TabGridLayout.Parent = TabScroll
    TabGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabGridLayout.CellSize = UDim2.new(0, 150, 0, 35)

    TabGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local absoluteSize = TabGridLayout.AbsoluteContentSize
        TabScroll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y+6)
    end)

    local Tabs = {}

    local first = true
    local LayoutOrder = - 1

    function Tabs:CreatePage(tabTitle)

        LayoutOrder = LayoutOrder + 1

        tabTitle = tabTitle or "Tab"

        local TabButton = Instance.new("TextButton")
        local TabButtonCorner = Instance.new("UICorner")
        local slice = Instance.new("Frame")
        local sliceCorner = Instance.new("UICorner")

        local PageContainer = Instance.new("Frame")
        local SectionScroll = Instance.new("ScrollingFrame")
        local SectionScrollListLayout = Instance.new("UIListLayout")

        PageContainer.Name = tabTitle.."_Page"
        PageContainer.Parent = Elements
        PageContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        PageContainer.BackgroundTransparency = 1.000
        PageContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
        PageContainer.Size = UDim2.new(1, 0, 1, 0)
        PageContainer.LayoutOrder = LayoutOrder
        PageContainer.Visible = true

        SectionScroll.Name = "SectionScroll"
        SectionScroll.Parent = PageContainer
        SectionScroll.AnchorPoint = Vector2.new(0, 0.5)
        SectionScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionScroll.BackgroundTransparency = 1.000
        SectionScroll.BorderSizePixel = 0
        SectionScroll.Position = UDim2.new(0, 0, 0.5, 0)
        SectionScroll.Size = UDim2.new(1, 0, 0.961111128, 0)
        SectionScroll.ZIndex = 2
        SectionScroll.CanvasPosition = Vector2.new(0, 0)
        SectionScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        SectionScroll.ScrollBarImageColor3 = themes.ScrollBar
        Objects[SectionScroll] = "ScrollBar"
        SectionScroll.ScrollBarThickness = 6
    
        SectionScrollListLayout.Name = "SectionScrollListLayout"
        SectionScrollListLayout.Parent = SectionScroll
        SectionScrollListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        SectionScrollListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionScrollListLayout.Padding = UDim.new(0, 6)

        SectionScrollListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local absoluteSize = SectionScrollListLayout.AbsoluteContentSize
            SectionScroll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y)
        end)

        TabButton.Name = "TabButton"
        TabButton.Parent = TabScroll
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Position = UDim2.new(0.0107816709, 0, 0.0441953987, 0)
        TabButton.Size = UDim2.new(0, 141, 0, 43)
        TabButton.ZIndex = 2
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.Text = tabTitle
        TabButton.TextColor3 = themes.TextColor
        Objects[TabButton] = "TextColor"
        TabButton.TextSize = 23.000
        TabButton.TextWrapped = true
    
        TabButtonCorner.CornerRadius = UDim.new(0, 4)
        TabButtonCorner.Name = "TabButtonCorner"
        TabButtonCorner.Parent = TabButton
    
        slice.Name = "slice"
        slice.Parent = TabButton
        slice.AnchorPoint = Vector2.new(0.5, 1)
        slice.BackgroundColor3 = themes.SchemaColor
        Objects[slice] = "SchemaColor"
        slice.BackgroundTransparency = 1
        slice.Position = UDim2.new(0.5, 0, 1, 0)
        slice.Size = UDim2.new(0, 20, 0, 4)
    
        sliceCorner.CornerRadius = UDim.new(0, 4)
        sliceCorner.Name = "sliceCorner"
        sliceCorner.Parent = slice

        if first then
            first = false
            slice.Size = UDim2.new(0, 50, 0, 4)
            slice.BackgroundTransparency = 0
            TabButton.TextTransparency = 0
        else
            slice.Size = UDim2.new(0, 20, 0, 4)
            slice.BackgroundTransparency = 1
            TabButton.TextTransparency = 0.5
        end

        TabButton.MouseButton1Click:Connect(function()
            if PageContainer.Name == tabTitle.."_Page" then
                for i, v in next, Elements:GetChildren() do
                    if not v:IsA("UICorner") and not v:IsA("UIPageLayout") then
                        if v.Name == tabTitle.."_Page" then
                            UIPageLayout:JumpToIndex(PageContainer.LayoutOrder)
                        end
                    end
                end

                for i, v in next, TabScroll:GetChildren() do
                    if v:IsA("TextButton") then
                        Utility:TweenObject(v, {TextTransparency = .5}, 0.1)
                        Tween:Create(v.slice, Tweeninfo(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            Size = UDim2.new(0, 15, 0, 4)
                        }):Play()
                        Tween:Create(v.slice, Tweeninfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end
    
                Utility:TweenObject(TabButton, {TextTransparency = 0}, 0.1)
                Tween:Create(slice, Tweeninfo(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 50, 0, 4)
                }):Play()
                Tween:Create(slice, Tweeninfo(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0
                }):Play()
            end
        end)

        coroutine.wrap(function()
            while wait() do
                SectionScroll.ScrollBarImageColor3 = themes.ScrollBar
                TabButton.TextColor3 = themes.TextColor
                slice.BackgroundColor3 = themes.SchemaColor
            end
        end)()

        table.insert(Tabs, tabTitle)
        
        local Sections = {}

        function Sections:CreateSection(secName)
            secName = secName or "Section"

            local SectionFrame = Instance.new("Frame")
            local SectionFrameCorner = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local slice_3 = Instance.new("Frame")
            local SectionFrameListLayout = Instance.new("UIListLayout")
        
            SectionFrame.Name = secName .. "_Section"
            SectionFrame.Parent = SectionScroll
            SectionFrame.BackgroundColor3 = themes.Container
            Objects[SectionFrame] = "Container"
            SectionFrame.Position = UDim2.new(0.396265566, 0, 0, 0)
            SectionFrame.Size = UDim2.new(0, 470, 0, 492)
            SectionFrame.ClipsDescendants = true
        
            SectionFrameCorner.CornerRadius = UDim.new(0, 4)
            SectionFrameCorner.Name = "SectionFrameCorner"
            SectionFrameCorner.Parent = SectionFrame
        
            SectionText.Name = "SectionText"
            SectionText.Parent = SectionFrame
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Size = UDim2.new(1, 0, 0, 26)
            SectionText.ZIndex = 3
            SectionText.Font = Enum.Font.SourceSansSemibold
            SectionText.Text = secName
            SectionText.TextColor3 = themes.SchemaColor
            Objects[SectionText] = "SchemaColor"
            SectionText.TextSize = 21.000
        
            slice_3.Name = "slice"
            slice_3.Parent = SectionText
            slice_3.AnchorPoint = Vector2.new(0.5, 1)
            slice_3.BackgroundColor3 = themes.SchemaColor
            Objects[slice_3] = "SchemaColor"
            slice_3.BorderSizePixel = 0
            slice_3.Position = UDim2.new(0.5, 0, 1, 0)
            slice_3.Size = UDim2.new(0, 420, 0, 3)
        
            SectionFrameListLayout.Name = "SectionFrameListLayout"
            SectionFrameListLayout.Parent = SectionFrame
            SectionFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SectionFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionFrameListLayout.Padding = UDim.new(0, 6)

            SectionFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local absoluteSize = SectionFrameListLayout.AbsoluteContentSize
                SectionFrame.Size = UDim2.new(0, 470, 0, absoluteSize.Y+6)
            end)
            
            coroutine.wrap(function()
                while wait() do
                    SectionFrame.BackgroundColor3 = themes.Container
                    SectionText.TextColor3 = themes.SchemaColor
                    slice_3.BackgroundColor3 = themes.SchemaColor
                end
            end)()

            local Elements = {}

            function Elements:CreateButton(btitle, callback)
                btitle = btitle or "Button"
                callback = callback or function() end

                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")

                Button.Name = "Button"
                Button.Parent = SectionFrame
                Button.BackgroundColor3 = themes.Background
                Objects[Button] = "Background"
                Button.Position = UDim2.new(0.277777791, 0, 0.310000002, 0)
                Button.Size = UDim2.new(0, 440, 0, 34)
                Button.ZIndex = 2
                Button.Font = Enum.Font.SourceSansSemibold
                Button.ClipsDescendants = true
                Button.Text = " " .. btitle
                Button.AutoButtonColor = false
                Button.TextColor3 = themes.TextColor
                Objects[Button] = "TextColor"
                Button.TextSize = 22.000
                Button.TextWrapped = true
                Button.TextXAlignment = Enum.TextXAlignment.Left
            
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button

                coroutine.wrap(function()
                    while wait() do
                        Button.BackgroundColor3 = themes.Background
                        Button.TextColor3 = themes.TextColor
                    end
                end)()

                Button.MouseButton1Click:Connect(function()
                    Utility:Pop(Button, 10)
                end)

                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
            end -- Final

            function Elements:CreateToggle(togtitle, setting, callback)
                togtitle = togtitle or "Toggle"
                callback = callback or function() end

                local description = setting.Description
                local tog = setting.Toggled or false

                local ToggleButton = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local IconEnable = Instance.new("ImageLabel")
                local IconDisable = Instance.new("ImageLabel")
                local ToggleText = Instance.new("TextLabel")
            
                local ToggleDesc = Instance.new("TextLabel")

                if description == false then
                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = SectionFrame
                    ToggleButton.BackgroundColor3 = themes.Background
                    Objects[ToggleButton] = "Background"
                    ToggleButton.Position = UDim2.new(0.892671406, 0, 0.452857137, 0)
                    ToggleButton.Size = UDim2.new(0, 440, 0, 34)
                    ToggleButton.ZIndex = 2
                    ToggleButton.AutoButtonColor = false
                    ToggleButton.Font = Enum.Font.SourceSansSemibold
                    ToggleButton.ClipsDescendants = true
                    ToggleButton.Text = ""
                    ToggleButton.TextColor3 = themes.TextColor
                    Objects[ToggleButton] = "TextColor"
                    ToggleButton.TextSize = 22.000
                    ToggleButton.TextWrapped = true
                    ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
                else
                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = SectionFrame
                    ToggleButton.BackgroundColor3 = themes.Background
                    Objects[ToggleButton] = "Background"
                    ToggleButton.Position = UDim2.new(0.0319148935, 0, 0.651162803, 0)
                    ToggleButton.Size = UDim2.new(0, 440, 0, 49)
                    ToggleButton.ZIndex = 2
                    ToggleButton.AutoButtonColor = false
                    ToggleButton.Font = Enum.Font.SourceSansSemibold
                    ToggleButton.ClipsDescendants = true
                    ToggleButton.Text = ""
                    ToggleButton.TextColor3 = themes.TextColor
                    Objects[ToggleButton] = "TextColor"
                    ToggleButton.TextSize = 22.000
                    ToggleButton.TextWrapped = true
                    ToggleButton.TextXAlignment = Enum.TextXAlignment.Left

                    ToggleDesc.Name = "ToggleDesc"
                    ToggleDesc.Parent = ToggleButton
                    ToggleDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleDesc.BackgroundTransparency = 1.000
                    ToggleDesc.Position = UDim2.new(0.0129999332, 0, 0.612000108, 0)
                    ToggleDesc.Size = UDim2.new(0, 390, 0, 19)
                    ToggleDesc.ZIndex = 2
                    ToggleDesc.Font = Enum.Font.SourceSansSemibold
                    ToggleDesc.Text = description
                    ToggleDesc.TextColor3 = themes.TextColor
                    Objects[ToggleDesc] = "TextColor"
                    ToggleDesc.TextSize = 16.000
                    ToggleDesc.TextTransparency = 0.500
                    ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
                end

                ToggleCorner.CornerRadius = UDim.new(0, 4)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = ToggleButton
            
                IconEnable.Name = "IconEnable"
                IconEnable.Parent = ToggleButton
                IconEnable.AnchorPoint = Vector2.new(0.5, 0.5)
                IconEnable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                IconEnable.BackgroundTransparency = 1.000
                IconEnable.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                IconEnable.Size = UDim2.new(0, 23, 0, 23)
                IconEnable.ZIndex = 2
                IconEnable.Image = "rbxassetid://3926309567"
                IconEnable.ImageTransparency = 1
                IconEnable.ImageColor3 = themes.TextColor
                Objects[IconEnable] = "TextColor"
                IconEnable.ImageRectOffset = Vector2.new(784, 420)
                IconEnable.ImageRectSize = Vector2.new(48, 48)
            
                IconDisable.Name = "IconDisable"
                IconDisable.Parent = ToggleButton
                IconDisable.AnchorPoint = Vector2.new(0.5, 0.5)
                IconDisable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                IconDisable.BackgroundTransparency = 1.000
                IconDisable.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                IconDisable.Size = UDim2.new(0, 23, 0, 23)
                IconDisable.ZIndex = 2
                IconDisable.Image = "rbxassetid://3926309567"
                IconDisable.ImageColor3 = themes.TextColor
                Objects[IconDisable] = "TextColor"
                IconDisable.ImageRectOffset = Vector2.new(628, 420)
                IconDisable.ImageRectSize = Vector2.new(48, 48)
            
                ToggleText.Name = "ToggleText"
                ToggleText.Parent = ToggleButton
                ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.BackgroundTransparency = 1.000
                ToggleText.Size = UDim2.new(0, 396, 0, 34)
                ToggleText.ZIndex = 2
                ToggleText.Font = Enum.Font.SourceSansSemibold
                ToggleText.Text = " " .. togtitle
                ToggleText.TextColor3 = themes.TextColor
                Objects[ToggleText] = "TextColor"
                ToggleText.TextSize = 22.000
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left

                coroutine.wrap(function()
                    while wait() do
                        ToggleButton.BackgroundColor3 = themes.Background
                        ToggleButton.TextColor3 = themes.TextColor
                        IconEnable.ImageColor3 = themes.TextColor
                        IconDisable.ImageColor3 = themes.TextColor
                        ToggleDesc.TextColor3 = themes.TextColor
                        ToggleText.TextColor3 = themes.TextColor
                    end
                end)()

                local isToggle = false

                if tog == true then
                    isToggle = true
                    game.TweenService:Create(IconEnable, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                        ImageTransparency = 0
                    }):Play()
                end
                pcall(callback, isToggle)
                local OnClick= function() 
                    if isToggle == false then
                        isToggle = true
                        game.TweenService:Create(IconEnable, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                            ImageTransparency = 0
                        }):Play()
                    else
                        isToggle = false
                        game.TweenService:Create(IconEnable, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                            ImageTransparency = 1
                        }):Play()
                    end
                    pcall(callback, isToggle)
                end
                ToggleButton.MouseButton1Click:Connect(OnClick)
                return {
                    SetValue = function(val) 
                        if val~=isToggle then 
                            OnClick()
                        end
                    end
                }
            end -- Final

            function Elements:CreateDropdown(droptitle, setting, callback)
                local DropElements = {}
                droptitle = droptitle or "Dropdown"
                
                local list = setting.List or {}
                local search = setting.Search
                local default = setting.Default

                callback = callback or function() end

                local opened = false

                local TextLabel = Instance.new("TextLabel")
                local DropButton = Instance.new("TextButton")
                local DropSearch = Instance.new("TextBox")
                local Dropdown = Instance.new("Frame")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownListLayout = Instance.new("UIListLayout")
                local TopFrame = Instance.new("Frame")
                local ArrowIcon = Instance.new("ImageLabel")
                local TopFrameCorner = Instance.new("UICorner")
                local DropItemHolder = Instance.new("ScrollingFrame")
                local DropItemListLayout = Instance.new("UIListLayout")
                
                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectionFrame
                Dropdown.BackgroundColor3 = themes.Drop
                Objects[Dropdown] = "Drop"
                Dropdown.ClipsDescendants = true
                Dropdown.Position = UDim2.new(0.0319148935, 0, 0.186978295, 0)
                Dropdown.Size = UDim2.new(0, 440, 0, 34) -- 146
                Dropdown.ZIndex = 2
                
                DropdownCorner.CornerRadius = UDim.new(0, 4)
                DropdownCorner.Name = "DropdownCorner"
                DropdownCorner.Parent = Dropdown
                
                DropdownListLayout.Name = "DropdownListLayout"
                DropdownListLayout.Parent = Dropdown
                DropdownListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownListLayout.Padding = UDim.new(0, 5)
                
                TopFrame.Name = "TopFrame"
                TopFrame.Parent = Dropdown
                TopFrame.BackgroundColor3 = themes.Background
                Objects[TopFrame] = "Background"
                TopFrame.Size = UDim2.new(0, 440, 0, 34)
                TopFrame.ZIndex = 2
                
                ArrowIcon.Name = "ArrowIcon"
                ArrowIcon.Parent = TopFrame
                ArrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                ArrowIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ArrowIcon.BackgroundTransparency = 1.000
                ArrowIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                ArrowIcon.Size = UDim2.new(0, 23, 0, 23)
                ArrowIcon.ZIndex = 2
                ArrowIcon.Image = "rbxassetid://7072706663"
                ArrowIcon.ImageColor3 = themes.TextColor
                Objects[ArrowIcon] = "TextColor"
                
                TopFrameCorner.CornerRadius = UDim.new(0, 4)
                TopFrameCorner.Name = "TopFrameCorner"
                TopFrameCorner.Parent = TopFrame
                
                if search == true then
                    DropSearch.Name = "DropSearch"
                    DropSearch.Parent = TopFrame
                    DropSearch.AnchorPoint = Vector2.new(1, 0)
                    DropSearch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropSearch.BackgroundTransparency = 1.000
                    DropSearch.Position = UDim2.new(0.899999976, 0, 0, 0)
                    DropSearch.Size = UDim2.new(0, 389, 0, 34)
                    DropSearch.ZIndex = 2
                    DropSearch.Font = Enum.Font.SourceSansSemibold
                    DropSearch.Text = droptitle .. ":"
                    DropSearch.TextColor3 = themes.TextColor
                    Objects[DropSearch] = "TextColor"
                    DropSearch.TextSize = 22.000
                    DropSearch.TextXAlignment = Enum.TextXAlignment.Left
                else
                    TextLabel.Parent = TopFrame
                    TextLabel.AnchorPoint = Vector2.new(1, 0)
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.Position = UDim2.new(0.899999976, 0, 0, 0)
                    TextLabel.Size = UDim2.new(0, 389, 0, 34)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.Text = droptitle .. ":"
                    TextLabel.TextColor3 = themes.TextColor
                    Objects[TextLabel] = "TextColor"
                    TextLabel.TextSize = 22.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropButton.Name = "DropButton"
                    DropButton.Parent = TopFrame
                    DropButton.Active = false
                    DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropButton.BackgroundTransparency = 1.000
                    DropButton.Size = UDim2.new(1, 0, 0, 34)
                    DropButton.ZIndex = 2
                    DropButton.AutoButtonColor = false
                    DropButton.Font = Enum.Font.SourceSansSemibold
                    DropButton.Text = ""
                    DropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropButton.TextSize = 22.000
                    DropButton.TextWrapped = true
                    DropButton.TextXAlignment = Enum.TextXAlignment.Left
                end

                DropItemHolder.Name = "DropItemHolder"
                DropItemHolder.Parent = Dropdown
                DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropItemHolder.BackgroundTransparency = 1.000
                DropItemHolder.BorderSizePixel = 0
                DropItemHolder.Position = UDim2.new(0, 0, 0.254901975, 0)
                DropItemHolder.Size = UDim2.new(1, 0, 0.0130718956, 100)
                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropItemHolder.ScrollBarThickness = 6
                DropItemHolder.ScrollBarImageColor3 = themes.ScrollBar
                Objects[DropItemHolder] = "ScrollBar"
                
                DropItemListLayout.Name = "DropItemListLayout"
                DropItemListLayout.Parent = DropItemHolder
                DropItemListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                DropItemListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropItemListLayout.Padding = UDim.new(0, 5)

                coroutine.wrap(function()
                    while wait() do
                        Dropdown.BackgroundColor3 = themes.Drop
                        ArrowIcon.ImageColor3 = themes.TextColor
                        TopFrame.BackgroundColor3 = themes.Background
                        TextLabel.TextColor3 = themes.TextColor
                        DropItemHolder.ScrollBarImageColor3 = themes.ScrollBar
                        DropSearch.TextColor3 = themes.TextColor
                    end
                end)()

                if default then
                    callback(default)
                    TextLabel.Text = droptitle .. ": " .. default
                elseif default and search then
                    callback(default)
                    DropSearch.Text = droptitle .. ": " .. default
                end
                
                if not search then
                    DropButton.MouseButton1Click:Connect(function()
                        if opened then
                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                        else
                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 146), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
                        end
                        opened = not opened
                    end) 
                else
                    local function updateResult()
                        local search = string.lower(DropSearch.Text)
                        for i, v in pairs(DropItemHolder:GetChildren()) do
                            if v:IsA("GuiButton") then
                                if search ~= "" then
                                    local item = string.lower(v.Text)
                                    if string.find(item, search) then
                                        v.Visible = true
                                    else
                                        v.Visible = false
                                    end
                                else
                                    v.Visible = true
                                end
                            end
                        end
                    end

                    local focused

                    DropSearch.Focused:Connect(function()
                        focused = true
                        Dropdown:TweenSize(UDim2.new(0, 440, 0, 146), "Out", "Quad", 0.5, true)
                        Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
                    end)

                    DropSearch.FocusLost:Connect(function()
                        focused = false
                        Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                        Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();

                        if not tostring(DropSearch.Text) or not tonumber(DropSearch.Text) then
                            DropSearch.Text = droptitle .. ":"
                            for i, v in pairs(DropItemHolder:GetChildren()) do
                                if v:IsA("GuiButton") then
                                    v.Visible = true
                                end
                            end
                        end
                    end)

                    DropSearch.Changed:Connect(function()
                        if focused then
                            updateResult()
                        end
                    end)  
                end

                DropItemListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local absoluteSize = DropItemListLayout.AbsoluteContentSize
                    DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y)
                end)

                for i, v in next, list do
                    local DropItem = Instance.new("TextButton")
                    local DropItemCorner = Instance.new("UICorner")              

                    DropItem.Name = v .. "_DropItem"
                    DropItem.Parent = DropItemHolder
                    DropItem.BackgroundColor3 = themes.Background
                    Objects[DropItem] = "Background"
                    DropItem.Size = UDim2.new(0, 420, 0, 30)
                    DropItem.AutoButtonColor = false
                    DropItem.Font = Enum.Font.SourceSansSemibold
                    DropItem.Text = " " .. v
                    DropItem.TextColor3 = themes.TextColor
                    Objects[DropItem] = "TextColor"
                    DropItem.TextSize = 21.000
                    DropItem.TextXAlignment = Enum.TextXAlignment.Left
                    DropItem.ZIndex = 2
                
                    DropItemCorner.CornerRadius = UDim.new(0, 4)
                    DropItemCorner.Name = "ToggleCorner"
                    DropItemCorner.Parent = DropItem

                    coroutine.wrap(function()
                        while wait() do
                            DropItem.BackgroundColor3 = themes.Background
                            DropItem.TextColor3 = themes.TextColor
                        end
                    end)()

                    DropItem.MouseButton1Click:Connect(function()
                        opened = false
                        Utility:Pop(DropItem, 8)
                        callback(v)

                        if not search then
                            TextLabel.Text = droptitle .. ": " .. v
                        else
                            DropSearch.Text = droptitle .. ": " .. v

                        end

                        Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                        Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                    end)
                end

                function DropElements:Add(newlist)
                    newlist = newlist or {}

                    for i, v in next, newlist do
                        local DropItem = Instance.new("TextButton")
                        local DropItemCorner = Instance.new("UICorner")              
    
                        DropItem.Name = v .. "_DropItem"
                        DropItem.Parent = DropItemHolder
                        DropItem.BackgroundColor3 = themes.Background
                        Objects[DropItem] = "Background2"
                        DropItem.Size = UDim2.new(0, 420, 0, 30)
                        DropItem.AutoButtonColor = false
                        DropItem.Font = Enum.Font.SourceSansSemibold
                        DropItem.Text = " " .. v
                        DropItem.TextColor3 = themes.TextColor
                        Objects[DropItem] = "TextColor"
                        DropItem.TextSize = 21.000
                        DropItem.TextXAlignment = Enum.TextXAlignment.Left
                        DropItem.ZIndex = 2
                    
                        DropItemCorner.CornerRadius = UDim.new(0, 4)
                        DropItemCorner.Name = "ToggleCorner"
                        DropItemCorner.Parent = DropItem

                        coroutine.wrap(function()
                            while wait() do
                                DropItem.BackgroundColor3 = themes.Background
                                DropItem.TextColor3 = themes.TextColor
                            end
                        end)()
    
                        DropItem.MouseButton1Click:Connect(function()
                            opened = false
                            Utility:Pop(DropItem, 8)
                            callback(v)

                            if not search then
                                TextLabel.Text = droptitle .. ": " .. v
                            else
                                DropSearch.Text = droptitle .. ": " .. v
                            end

                            Dropdown:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                            Tween:Create(ArrowIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
                        end)
                    end
                end

                function DropElements:Clear()
                    for i, v in pairs(DropItemHolder:GetChildren()) do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                end

                return DropElements
            end -- Final

            function Elements:CreateSlider(slidertitle, setting, callback)
                slidertitle = slidertitle or "Slider"
                callback = callback or function() end
                local Max_Value = setting.Max or 100
                local Min_Value = setting.Min or 0
                local DefaultValue = setting.DefaultValue or 0

                local dragging = false

                local Slider = Instance.new("Frame")
                local SliderButton = Instance.new("Frame")
                local SliderPercent = Instance.new("Frame")
                local SliderPercentCorner = Instance.new("UICorner")
                local SliderDrag = Instance.new("Frame")
                local SliderDragCorner = Instance.new("UICorner")
                local UICorner = Instance.new("UICorner")
                local SliderIcon = Instance.new("ImageLabel")
                local SilderText = Instance.new("TextLabel")
                local SilderNumber = Instance.new("TextLabel")
                local SliderCorner = Instance.new("UICorner")

                Slider.Name = "Slider"
                Slider.Parent = SectionFrame
                Slider.BackgroundColor3 = themes.Background
                Objects[Slider] = "Background"
                Slider.Size = UDim2.new(0, 440, 0, 49)
            
                SliderButton.Name = "SliderBar"
                SliderButton.Parent = Slider
                SliderButton.BackgroundColor3 = themes.Container
                Objects[SliderButton] = "Container"
                SliderButton.BorderSizePixel = 0
                SliderButton.Position = UDim2.new(0.023, 0, 0.694000006, 0)
                SliderButton.Size = UDim2.new(0, 420, 0, 8)
                SliderButton.ZIndex = 2
            
                SliderPercent.Name = "SliderInBar"
                SliderPercent.Parent = SliderButton
                SliderPercent.BackgroundColor3 = themes.Slider
                Objects[SliderPercent] = "Slider"
                SliderPercent.Size = UDim2.new(0, 0, 1, 0)
                SliderPercent.ZIndex = 2
            
                SliderPercentCorner.CornerRadius = UDim.new(0, 4)
                SliderPercentCorner.Name = "SliderPercentCorner"
                SliderPercentCorner.Parent = SliderPercent
            
                SliderDrag.Name = "SliderDrag"
                SliderDrag.Parent = SliderPercent
                SliderDrag.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderDrag.BackgroundColor3 = themes.TextColor
                Objects[SliderDrag] = "TextColor"
                SliderDrag.Position = UDim2.new(1, 0, 0.5, 0)
                SliderDrag.Size = UDim2.new(0, 12, 0, 17)
            
                SliderDragCorner.CornerRadius = UDim.new(0, 4)
                SliderDragCorner.Name = "SliderDragCorner"
                SliderDragCorner.Parent = SliderDrag
            
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = SliderButton
            
                SliderIcon.Name = "SliderIcon"
                SliderIcon.Parent = Slider
                SliderIcon.AnchorPoint = Vector2.new(0.5, 0.899999976)
                SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderIcon.BackgroundTransparency = 1.000
                SliderIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
                SliderIcon.Size = UDim2.new(0, 23, 0, 23)
                SliderIcon.ZIndex = 2
                SliderIcon.Image = "rbxassetid://7072987508"
                SliderIcon.ImageColor3 = themes.TextColor
                Objects[SliderIcon] = "TextColor"
            
                SilderText.Name = "SilderText"
                SilderText.Parent = Slider
                SilderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SilderText.BackgroundTransparency = 1.000
                SilderText.Size = UDim2.new(0, 366, 0, 34)
                SilderText.ZIndex = 2
                SilderText.Font = Enum.Font.SourceSansSemibold
                SilderText.Text = " " .. slidertitle
                SilderText.TextColor3 = themes.TextColor
                Objects[SilderText] = "TextColor"
                SilderText.TextSize = 22.000
                SilderText.TextXAlignment = Enum.TextXAlignment.Left
            
                SilderNumber.Name = "SilderNumber"
                SilderNumber.Parent = Slider
                SilderNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SilderNumber.BackgroundTransparency = 1.000
                SilderNumber.Position = UDim2.new(0.831818163, 0, -0.0408163257, 0)
                SilderNumber.Size = UDim2.new(0, 30, 0, 34)
                SilderNumber.ZIndex = 2
                SilderNumber.Font = Enum.Font.SourceSansSemibold
                SilderNumber.Text = Min_Value
                SilderNumber.TextColor3 = themes.TextColor
                Objects[SilderNumber] = "TextColor"
                SilderNumber.TextSize = 22.000
                SilderNumber.TextXAlignment = Enum.TextXAlignment.Right
                SilderNumber.TextTransparency = 1
            
                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Name = "SliderCorner"
                SliderCorner.Parent = Slider

                SliderPercent.Size = UDim2.new(((DefaultValue or 0) / Max_Value),0, 1, 0)
                SilderNumber.Text = tostring(DefaultValue and math.floor((DefaultValue / Max_Value) * (Max_Value - Min_Value) + Min_Value) or 0)
                pcall(callback, DefaultValue)

                coroutine.wrap(function()
                    while wait() do
                        Slider.BackgroundColor3 = themes.Background
                        SliderPercent.BackgroundColor3 = themes.Slider
                        SliderDrag.BackgroundColor3 = themes.TextColor
                        SilderText.TextColor3 = themes.TextColor
                        SilderNumber.TextColor3 = themes.TextColor
                        SliderIcon.ImageColor3 = themes.TextColor
                    end
                end)()

                local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - SliderButton.AbsolutePosition.X) / SliderButton.AbsoluteSize.X, 0, 1),
							0,
							1,
							0
						)
                    Utility:TweenObject(SliderPercent, {Size = pos}, 0.25)
					local value = math.floor(((pos.X.Scale * Max_Value) / Max_Value) * (Max_Value - Min_Value) + Min_Value)
					SilderNumber.Text = tostring(value)
					pcall(callback, value)
				end

                SliderDrag.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
                        Utility:TweenObject(SilderNumber, {TextTransparency = 0}, 0.5)
					end
				end)

				SliderDrag.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
					    dragging = false
                        Utility:TweenObject(SilderNumber, {TextTransparency = 1}, 0.5)
					end
				end)

                Input.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
                end)

                local SliderElements = {}

                function SliderElements:Change(tochange)
                    SliderPercent.Size = UDim2.new(((tochange or 0) / Max_Value), 0, 1, 0)
					SilderNumber.Text = tostring(tochange and math.floor((tochange / Max_Value) * (Max_Value - Min_Value) + Min_Value) or 0)
					pcall(callback, tochange)
				end

            end -- Final

            function Elements:CreateTextbox(boxtitle, desc, callback,def)
                boxtitle = boxtitle or "Textbox"
                desc = desc or "Enter here!"
                callback = callback or function() end

                local TextBox = Instance.new("Frame")
                local TextBoxText = Instance.new("TextLabel")
                local TextBoxCorner = Instance.new("UICorner")
                local Box = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")
                local TextBoxIcon = Instance.new("ImageLabel")

                TextBox.Name = "TextBox"
                TextBox.Parent = SectionFrame
                TextBox.BackgroundColor3 = themes.Background
                Objects[TextBox] = "Background"
                TextBox.Position = UDim2.new(0.0319148935, 0, 0.826464236, 0)
                TextBox.Size = UDim2.new(0, 440, 0, 65)
            
                TextBoxText.Name = "TextBoxText"
                TextBoxText.Parent = TextBox
                TextBoxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBoxText.BackgroundTransparency = 1.000
                TextBoxText.Size = UDim2.new(0, 396, 0, 34)
                TextBoxText.ZIndex = 2
                TextBoxText.Font = Enum.Font.SourceSansSemibold
                TextBoxText.Text = " " .. boxtitle
                TextBoxText.TextColor3 = themes.TextColor
                Objects[TextBoxText] = "TextColor"
                TextBoxText.TextSize = 22.000
                TextBoxText.TextXAlignment = Enum.TextXAlignment.Left
            
                TextBoxCorner.CornerRadius = UDim.new(0, 4)
                TextBoxCorner.Name = "TextBoxCorner"
                TextBoxCorner.Parent = TextBox
            
                Box.Name = "Box"
                Box.Parent = TextBox
                Box.AnchorPoint = Vector2.new(0.5, 0.5)
                Box.BackgroundColor3 = themes.Container
                Objects[Box] = "Container"
                Box.Position = UDim2.new(0.5, 0, 0.714999974, 0)
                Box.Size = UDim2.new(0, 426, 0, 25)
                Box.ZIndex = 2
                Box.Font = Enum.Font.SourceSansSemibold
                Box.PlaceholderText = desc
                Box.Text = ""
                Box.TextColor3 = themes.TextColor
                Objects[Box] = "TextColor"
                Box.TextSize = 18.000
            
                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = Box
            
                TextBoxIcon.Name = "TextBoxIcon"
                TextBoxIcon.Parent = TextBox
                TextBoxIcon.AnchorPoint = Vector2.new(0.5, 0.899999976)
                TextBoxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBoxIcon.BackgroundTransparency = 1.000
                TextBoxIcon.Position = UDim2.new(0.949999988, 0, 0.392307699, 0)
                TextBoxIcon.Size = UDim2.new(0, 23, 0, 23)
                TextBoxIcon.ZIndex = 2
                TextBoxIcon.Image = "rbxassetid://7072716382"
                TextBoxIcon.ImageColor3 = themes.TextColor
                Objects[TextBoxIcon] = "TextColor"

                coroutine.wrap(function()
                    while wait() do
                        TextBox.BackgroundColor3 = themes.Background
                        TextBoxText.TextColor3 = themes.TextColor
                        Box.BackgroundColor3 = themes.Container
                        Box.TextColor3 = themes.TextColor
                        TextBoxIcon.ImageColor3 = themes.TextColor
                    end
                end)()
                if def then Box.Text=def end
                Box.FocusLost:Connect(function()
                    Utility:Pop(Box, 10)
                end)

                Box.FocusLost:Connect(function(enterPressed)
                    if not enterPressed then
                        return
                    else
                        callback(Box.Text)
                    end
                end)
            end -- Final

            function Elements:CreateKeybind(bindtitle, keycodename, callback)
                bindtitle = bindtitle or "Bind"
                callback = callback or function() end
                keycodename = keycodename or "A"

                local Default = keycodename
                local Type = tostring(Default):match("UserInputType") and "UserInputType" or "KeyCode"

                keycodename = tostring(keycodename):gsub("Enum.UserInputType.", "")
                keycodename = tostring(keycodename):gsub("Enum.KeyCode.", "")

                local BindButton = Instance.new("TextButton")
                local BindCorner = Instance.new("UICorner")
                local BindText = Instance.new("TextLabel")
                local KeyCode = Instance.new("Frame")
                local KeyCorner = Instance.new("UICorner")
                local BindKeyCode = Instance.new("TextLabel")
                
                BindButton.Name = "BindButton"
                BindButton.Parent = SectionFrame
                BindButton.BackgroundColor3 = themes.Background
                Objects[BindButton] = "Background"
                BindButton.Position = UDim2.new(0.892671406, 0, 0.452857137, 0)
                BindButton.Size = UDim2.new(0, 440, 0, 34)
                BindButton.ZIndex = 2
                BindButton.AutoButtonColor = false
                BindButton.Font = Enum.Font.SourceSansSemibold
                BindButton.Text = ""
                BindButton.TextColor3 = themes.TextColor
                Objects[BindButton] = "TextColor"
                BindButton.TextSize = 22.000
                BindButton.TextWrapped = true
                BindButton.TextXAlignment = Enum.TextXAlignment.Left
                
                BindCorner.CornerRadius = UDim.new(0, 4)
                BindCorner.Name = "BindCorner"
                BindCorner.Parent = BindButton
                
                BindText.Name = "BindText"
                BindText.Parent = BindButton
                BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindText.BackgroundTransparency = 1.000
                BindText.Size = UDim2.new(0, 283, 0, 34)
                BindText.ZIndex = 2
                BindText.Font = Enum.Font.SourceSansSemibold
                BindText.Text = " " .. bindtitle
                BindText.TextColor3 = themes.TextColor
                Objects[BindText] = "TextColor"
                BindText.TextSize = 22.000
                BindText.TextXAlignment = Enum.TextXAlignment.Left
                
                KeyCode.Name = "KeyCode"
                KeyCode.Parent = BindButton
                KeyCode.BackgroundColor3 = themes.Container
                Objects[KeyCode] = "Container"
                KeyCode.Position = UDim2.new(0.643181801, 0, 0.14705883, 0)
                KeyCode.Size = UDim2.new(0, 148, 0, 24)
                KeyCode.ZIndex = 2
                
                KeyCorner.CornerRadius = UDim.new(0, 4)
                KeyCorner.Name = "KeyCorner"
                KeyCorner.Parent = KeyCode
                
                BindKeyCode.Name = "BindKeyCode"
                BindKeyCode.Parent = KeyCode
                BindKeyCode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindKeyCode.BackgroundTransparency = 1.000
                BindKeyCode.Size = UDim2.new(1, 0, 1, 0)
                BindKeyCode.ZIndex = 2
                BindKeyCode.Font = Enum.Font.SourceSansSemibold
                BindKeyCode.Text = tostring(Default):gsub("Enum.KeyCode.", "") .. " ";
                BindKeyCode.TextColor3 = themes.TextColor
                Objects[BindKeyCode] = "TextColor"
                BindKeyCode.TextSize = 19.000
                BindKeyCode.TextWrapped = true

                coroutine.wrap(function()
                    while wait() do
                        BindButton.BackgroundColor3 = themes.Background
                        BindButton.TextColor3 = themes.TextColor
                        BindText.TextColor3 = themes.TextColor
                        KeyCode.BackgroundColor3 = themes.Container
                        BindKeyCode.TextColor3 = themes.TextColor
                    end
                end)()

                local WhitelistedType = {
                    [Enum.UserInputType.MouseButton1] = "Mouse1";
                    [Enum.UserInputType.MouseButton2] = "Mouse2";
                    [Enum.UserInputType.MouseButton3] = "Mouse3";
                };

                BindButton.MouseButton1Click:Connect(function()
                    Utility:Pop(KeyCode, 10)
                end)

                BindButton.MouseButton1Click:Connect(function()
                    local Connection;
		
                    BindKeyCode.Text = "...";

                    Connection = Input.InputBegan:Connect(function(i)
                        if WhitelistedType[i.UserInputType] then
                            Utility:Pop(KeyCode, 10)
                            BindKeyCode.Text = WhitelistedType[i.UserInputType];
                            spawn(function()
                                wait(0.1)
                                Default = i.UserInputType;
                                Type = "UserInputType";
                            end);
                        elseif i.KeyCode ~= Enum.KeyCode.Unknown then
                            Utility:Pop(KeyCode, 10)
                            BindKeyCode.Text = tostring(i.KeyCode):gsub("Enum.KeyCode.", "");
                            spawn(function()
                                wait(0.1)
                                Default = i.KeyCode;
                                Type = "KeyCode";
                            end);
                        else
                            warn("Exception: " .. i.UserInputType .. " " .. i.KeyCode);
                        end;

                        Connection:Disconnect();
                    end);
                end)

                Input.InputBegan:Connect(function(i)
                    if (Default == i.UserInputType or Default == i.KeyCode) then
                        Utility:Pop(KeyCode, 10)
                        callback(Default);
                    end;
                end);

            end -- Final

            function Elements:CreateColorPicker(colorPickerTitle, preset, callback)
                colorPickerTitle = colorPickerTitle or "Color Picker"
                preset = preset or Color3.new(255, 255, 255)
                callback = callback or function() end

                local ColorH, ColorS, ColorV = 1, 1, 1
                local ColorInput = nil
				local HueInput = nil
                local rgb = {
                    r = 255,
                    g = 255,
                    b = 255
                }
                local allowed = {
                    [""] = true
                }
                
                local function HSVtoRGBFormat(h, s, v)
                    local color = Color3.fromHSV(h, s, v)
                
                    local rgb = Color3.new(color.R * 255, color.G * 255, color.B * 255)
                
                    return math.round(rgb.R), math.round(rgb.G), math.round(rgb.B)
                end

                local r, g, b = HSVtoRGBFormat(preset:ToHSV())

                local ColorPicker = Instance.new("Frame")
                local ColorPickerCorner = Instance.new("UICorner")
                local ColorButton = Instance.new("TextButton")
                local ColorCorner_2 = Instance.new("UICorner")
                local ColorText = Instance.new("TextLabel")
                local ButtonPresetColor = Instance.new("Frame")
                local ColorContainer = Instance.new("Frame")
                local ColorFrame = Instance.new("ImageLabel")
                local ColorCorner = Instance.new("UICorner")
                local ColorSelection = Instance.new("ImageLabel")
                local PresetColor = Instance.new("Frame")
                local PresetCorner = Instance.new("UICorner")
                local Hue = Instance.new("Frame")
                local HueCorner = Instance.new("UICorner")
                local HueGradient = Instance.new("UIGradient")
                local HueSelection = Instance.new("ImageLabel")
                local Inputs = Instance.new("Frame")
                local R = Instance.new("Frame")
                local Text = Instance.new("TextLabel")
                local RCorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local B = Instance.new("Frame")
                local Text_2 = Instance.new("TextLabel")
                local BCorner = Instance.new("UICorner")
                local TextBox_2 = Instance.new("TextBox")
                local G = Instance.new("Frame")
                local Text_3 = Instance.new("TextLabel")
                local GCorner = Instance.new("UICorner")
                local TextBox_3 = Instance.new("TextBox")
                local PresetColor = Instance.new("Frame")
                local PresetCorner_2 = Instance.new("UICorner")
                local ConfirmButton = Instance.new("TextButton")
                local ConfirmCorner = Instance.new("UICorner")

                ColorPicker.Name = "ColorPicker"
                ColorPicker.Parent = SectionFrame
                ColorPicker.BackgroundColor3 = themes.Drop
                Objects[ColorPicker] = "Drop"
                ColorPicker.ClipsDescendants = true
                ColorPicker.Position = UDim2.new(0.0319148935, 0, 0.68948245, 0)
                ColorPicker.Size = UDim2.new(0, 440, 0, 34)

                ColorPickerCorner.CornerRadius = UDim.new(0, 4)
                ColorPickerCorner.Name = "ColorPickerCorner"
                ColorPickerCorner.Parent = ColorPicker
                
                ColorButton.Name = "ColorButton"
                ColorButton.Parent = ColorPicker
                ColorButton.BackgroundColor3 = themes.Background
                Objects[ColorButton] = "Background"
                ColorButton.Size = UDim2.new(0, 440, 0, 34)
                ColorButton.ZIndex = 3
                ColorButton.AutoButtonColor = false
                ColorButton.Font = Enum.Font.SourceSansSemibold
                ColorButton.Text = ""
                ColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorButton.TextSize = 22.000
                ColorButton.TextWrapped = true
                ColorButton.TextXAlignment = Enum.TextXAlignment.Left
                
                ColorCorner_2.CornerRadius = UDim.new(0, 4)
                ColorCorner_2.Name = "ColorCorner"
                ColorCorner_2.Parent = ColorButton
                
                ColorText.Name = "ColorText"
                ColorText.Parent = ColorButton
                ColorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorText.BackgroundTransparency = 1.000
                ColorText.Size = UDim2.new(0, 283, 0, 34)
                ColorText.ZIndex = 3
                ColorText.Font = Enum.Font.SourceSansSemibold
                ColorText.Text = " " .. colorPickerTitle
                ColorText.TextColor3 = themes.TextColor
                Objects[ColorText] = "TextColor"
                ColorText.TextSize = 22.000
                ColorText.TextXAlignment = Enum.TextXAlignment.Left

                ButtonPresetColor.Name = "ButtonPresetColor"
                ButtonPresetColor.Parent = ColorButton
                ButtonPresetColor.AnchorPoint = Vector2.new(0, 0.5)
                ButtonPresetColor.Position = UDim2.new(-0.0590909086, 309, 0.5, 0)
                ButtonPresetColor.Size = UDim2.new(0, 146, 0, 21)
                ButtonPresetColor.ZIndex = 2

                PresetCorner.CornerRadius = UDim.new(0, 4)
                PresetCorner.Name = "PresetCorner"
                PresetCorner.Parent = ButtonPresetColor

                ColorContainer.Name = "ColorContainer"
                ColorContainer.Parent = ColorPicker
                ColorContainer.AnchorPoint = Vector2.new(0, 1)
                ColorContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorContainer.BackgroundTransparency = 1.000
                ColorContainer.Position = UDim2.new(0, 0, 1, 0)
                ColorContainer.Size = UDim2.new(0, 438, 0, 133)
                
                ColorFrame.Name = "ColorFrame"
                ColorFrame.Parent = ColorContainer
                ColorFrame.Position = UDim2.new(0.023, 0, 0.0559999868, 0)
                ColorFrame.Size = UDim2.new(0, 227, 0, 119)
                ColorFrame.ZIndex = 2
                ColorFrame.Image = "rbxassetid://4155801252"
                
                ColorCorner.CornerRadius = UDim.new(0, 4)
                ColorCorner.Name = "ColorCorner"
                ColorCorner.Parent = ColorFrame
                
                ColorSelection.Name = "ColorSelection"
                ColorSelection.Parent = ColorFrame
                ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorSelection.BackgroundTransparency = 1.000
                ColorSelection.Size = UDim2.new(0, 19, 0, 19)
                ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
                ColorSelection.ZIndex = 2
                ColorSelection.Image = "rbxassetid://8662218920"
                ColorSelection.ScaleType = Enum.ScaleType.Fit
                
                PresetColor.Name = "PresetColor"
                PresetColor.Parent = ColorContainer
                PresetColor.AnchorPoint = Vector2.new(0, 0.5)
                PresetColor.Position = UDim2.new(-0.0593607314, 309, 0.225563914, 0)
                PresetColor.Size = UDim2.new(0, 145, 0, 47)
                PresetColor.ZIndex = 2

                PresetCorner_2.CornerRadius = UDim.new(0, 4)
                PresetCorner_2.Name = "PresetCorner"
                PresetCorner_2.Parent = PresetColor
                
                Hue.Name = "Hue"
                Hue.Parent = ColorContainer
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.Position = UDim2.new(0, 248, 0, 7)
                Hue.Size = UDim2.new(0, 25, 0, 119)
                Hue.ZIndex = 2
                
                HueCorner.CornerRadius = UDim.new(0, 4)
                HueCorner.Name = "HueCorner"
                HueCorner.Parent = Hue
                
                HueGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
                }
                HueGradient.Rotation = -90
                HueGradient.Name = "HueGradient"
                HueGradient.Parent = Hue
                
                HueSelection.Name = "HueSelection"
                HueSelection.Parent = Hue
                HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSelection.BackgroundTransparency = 1.000
                HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
                HueSelection.Size = UDim2.new(0, 19, 0, 19)
                HueSelection.ZIndex = 2
                HueSelection.Image = "rbxassetid://8662218920"
                HueSelection.ScaleType = Enum.ScaleType.Fit
                
                Inputs.Name = "Inputs"
                Inputs.Parent = ColorContainer
                Inputs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Inputs.BackgroundTransparency = 1.000
                Inputs.Position = UDim2.new(0, 283, 0, 59)
                Inputs.Size = UDim2.new(0, 145, 0, 36)
                Inputs.ZIndex = 2
                
                R.Name = "R"
                R.Parent = Inputs
                R.AnchorPoint = Vector2.new(0, 0.5)
                R.BackgroundColor3 = themes.Background
                Objects[R] = "Background"
                R.Position = UDim2.new(0, 0, 0.5, 0)
                R.Size = UDim2.new(0, 46, 0, 30)
                R.ZIndex = 2
                
                Text.Name = "Text"
                Text.Parent = R
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.Position = UDim2.new(0, 2, 0, 0)
                Text.Size = UDim2.new(0, 12, 1, 0)
                Text.Font = Enum.Font.SourceSansSemibold
                Text.Text = "R"
                Text.TextColor3 = Color3.fromRGB(255, 0, 0)
                Text.TextSize = 20.000
                Text.TextWrapped = true
                
                RCorner.CornerRadius = UDim.new(0, 4)
                RCorner.Name = "RCorner"
                RCorner.Parent = R
                
                TextBox.Name = "Textbox"
                TextBox.Parent = R
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Position = UDim2.new(0.304347813, 0, 0, 0)
                TextBox.Size = UDim2.new(0, 32, 0, 30)
                TextBox.Font = Enum.Font.SourceSansSemibold
                TextBox.Text = r
                TextBox.TextColor3 = themes.TextColor
                Objects[TextBox] = "TextColor"
                TextBox.TextSize = 20.000
                TextBox.TextWrapped = true
                
                B.Name = "B"
                B.Parent = Inputs
                B.AnchorPoint = Vector2.new(1, 0.5)
                B.BackgroundColor3 = themes.Background
                Objects[B] = "Background"
                B.Position = UDim2.new(1, 0, 0.5, 0)
                B.Size = UDim2.new(0, 46, 0, 30)
                B.ZIndex = 2
                
                Text_2.Name = "Text"
                Text_2.Parent = B
                Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text_2.BackgroundTransparency = 1.000
                Text_2.Position = UDim2.new(0, 2, 0, 0)
                Text_2.Size = UDim2.new(0, 12, 1, 0)
                Text_2.Font = Enum.Font.SourceSansSemibold
                Text_2.Text = "B"
                Text_2.TextColor3 = Color3.fromRGB(0, 0, 255)
                Text_2.TextSize = 20.000
                Text_2.TextWrapped = true
                
                BCorner.CornerRadius = UDim.new(0, 4)
                BCorner.Name = "BCorner"
                BCorner.Parent = B
                
                TextBox_2.Name = "Textbox"
                TextBox_2.Parent = B
                TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_2.BackgroundTransparency = 1.000
                TextBox_2.Position = UDim2.new(0.304347813, 0, 0, 0)
                TextBox_2.Size = UDim2.new(0, 32, 0, 30)
                TextBox_2.Font = Enum.Font.SourceSansSemibold
                TextBox_2.Text = b
                TextBox_2.TextColor3 = themes.TextColor
                Objects[TextBox_2] = "TextColor"
                TextBox_2.TextSize = 20.000
                TextBox_2.TextWrapped = true
                
                G.Name = "G"
                G.Parent = Inputs
                G.AnchorPoint = Vector2.new(0.5, 0.5)
                G.BackgroundColor3 = themes.Background
                Objects[G] = "Background"
                G.Position = UDim2.new(0.5, 0, 0.5, 0)
                G.Size = UDim2.new(0, 46, 0, 30)
                G.ZIndex = 2
                
                Text_3.Name = "Text"
                Text_3.Parent = G
                Text_3.AnchorPoint = Vector2.new(0, 0.5)
                Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text_3.BackgroundTransparency = 1.000
                Text_3.Position = UDim2.new(0, 2, 0.5, 0)
                Text_3.Size = UDim2.new(0, 12, 1, 0)
                Text_3.Font = Enum.Font.SourceSansSemibold
                Text_3.Text = "G"
                Text_3.TextColor3 = Color3.fromRGB(0, 255, 0)
                Text_3.TextSize = 20.000
                Text_3.TextWrapped = true
                
                
                GCorner.CornerRadius = UDim.new(0, 4)
                GCorner.Name = "GCorner"
                GCorner.Parent = G
                
                TextBox_3.Name = "Textbox"
                TextBox_3.Parent = G
                TextBox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_3.BackgroundTransparency = 1.000
                TextBox_3.Position = UDim2.new(0.304347813, 0, 0, 0)
                TextBox_3.Size = UDim2.new(0, 32, 0, 30)
                TextBox_3.Font = Enum.Font.SourceSansSemibold
                TextBox_3.Text = g
                TextBox_3.TextColor3 = themes.TextColor
                Objects[TextBox_3] = "TextColor"
                TextBox_3.TextSize = 20.000
                TextBox_3.TextWrapped = true
                
                ConfirmButton.Name = "ConfirmButton"
                ConfirmButton.Parent = ColorContainer
                ConfirmButton.BackgroundColor3 = themes.SchemaColor
                Objects[ConfirmButton] = "SchemaColor"
                ConfirmButton.Position = UDim2.new(0.646118701, 0, 0.744360924, 0)
                ConfirmButton.Size = UDim2.new(0, 145, 0, 27)
                ConfirmButton.Font = Enum.Font.SourceSansBold
                ConfirmButton.Text = "Confirm"
                ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ConfirmButton.TextSize = 22.000

                Animate:CreateGradient(ConfirmButton)
                
                ConfirmCorner.CornerRadius = UDim.new(0, 4)
                ConfirmCorner.Name = "ConfirmCorner"
                ConfirmCorner.Parent = ConfirmButton

                coroutine.wrap(function()
                    while wait() do
                        ColorPicker.BackgroundColor3 = themes.Drop
                        ColorButton.BackgroundColor3 = themes.Background
                        ColorText.TextColor3 = themes.TextColor
                        R.BackgroundColor3 = themes.Background
                        TextBox.TextColor3 = themes.TextColor
                        B.BackgroundColor3 = themes.Background
                        TextBox_2.TextColor3 = themes.TextColor
                        G.BackgroundColor3 = themes.Background
                        TextBox_3.TextColor3 = themes.TextColor
                        ConfirmButton.BackgroundColor3 = themes.SchemaColor
                    end
                end)()

                local function UpdateColorPicker()
					PresetColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					ColorFrame.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                    ButtonPresetColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)

                    Utility:TweenObject(HueSelection, {Position = UDim2.new(0.48, 0, 1 - ColorH)}, 0.25)
                    Utility:TweenObject(ColorSelection, {Position = UDim2.new(ColorS, 0, 1 - ColorV)}, 0.25)

                    local color = Color3.fromHSV(ColorH, ColorS, ColorV)

                    local r, g, b = HSVtoRGBFormat(color:ToHSV())

                    TextBox.Text = r
                    TextBox_3.Text = g
                    TextBox_2.Text = b

					pcall(callback, PresetColor.BackgroundColor3)
				end

                for i, container in pairs(Inputs:GetChildren()) do
                    if container:IsA("Frame") then
                        local textbox = container.Textbox
                        local focused

                        textbox.Focused:Connect(function()
                            focused = true
                        end)

                        textbox.FocusLost:Connect(function()
                            focused = false

                            if not tonumber(textbox.Text) then
                                textbox.Text = math.floor(rgb[container.Name:lower()])
                            end
                        end)

                        textbox:GetPropertyChangedSignal("Text"):Connect(function()
                            local text = textbox.Text

                            if not allowed[text] and not tonumber(text) then
                                text = text:sub(1, #text - 1)
                            elseif focused and not allowed[text] then
                                rgb[container.Name:lower()] = math.clamp(tonumber(textbox.Text), 0, 255)

                                local color3 = Color3.fromRGB(rgb.r, rgb.g, rgb.b)
                                ColorH, ColorS, ColorV = Color3.toHSV(color3)

                                UpdateColorPicker()
                                pcall(callback, color3)
                            end
                        end)
                    end
                end

                local ColorDrop = false

                ConfirmButton.MouseButton1Click:Connect(function()
                    ColorPicker:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                    ColorDrop = not ColorDrop
                end)

                ColorButton.MouseButton1Click:Connect(function()
                    if ColorDrop then
                        ColorPicker:TweenSize(UDim2.new(0, 440, 0, 34), "Out", "Quad", 0.5, true)
                    else
                        ColorPicker:TweenSize(UDim2.new(0, 440, 0, 170), "Out", "Quad", 0.5, true)
                    end
                    ColorDrop = not ColorDrop
                end)

                ColorH =
					1 -
					(math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
						Hue.AbsoluteSize.Y)
				ColorS =
					(math.clamp(ColorSelection.AbsolutePosition.X - ColorFrame.AbsolutePosition.X, 0, ColorFrame.AbsoluteSize.X) /
                    ColorFrame.AbsoluteSize.X)
				ColorV =
					1 -
					(math.clamp(ColorSelection.AbsolutePosition.Y - ColorFrame.AbsolutePosition.Y, 0, ColorFrame.AbsoluteSize.Y) /
                    ColorFrame.AbsoluteSize.Y)

                PresetColor.BackgroundColor3 = preset
				ColorFrame.BackgroundColor3 = preset
                ButtonPresetColor.BackgroundColor3 = preset
				pcall(callback, PresetColor.BackgroundColor3)
                ColorFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if ColorInput then
                                ColorInput:Disconnect()
                            end

                            ColorInput = Run.RenderStepped:Connect(function()
                                local ColorX = 
                                        (math.clamp(ms.X - ColorFrame.AbsolutePosition.X, 0, ColorFrame.AbsoluteSize.X) /
                                            ColorFrame.AbsoluteSize.X)
                                local ColorY = 
                                        (math.clamp(ms.Y - ColorFrame.AbsolutePosition.Y, 0, ColorFrame.AbsoluteSize.Y) /
                                            ColorFrame.AbsoluteSize.Y)

                                Tween:Create(ColorSelection, Tweeninfo(0.5), {
                                    Position = UDim2.new(ColorX, 0, ColorY, 0)
                                }):Play()
                                ColorS = ColorX
                                ColorV = 1 - ColorY
                                UpdateColorPicker()
                            end)
                        end
                    
                    end)
                ColorFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if ColorInput then
                                ColorInput:Disconnect()
                            end
                        end
                    end)
                Hue.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if HueInput then
                                HueInput:Disconnect()
                            end

                            HueInput = Run.RenderStepped:Connect(function()
                                local HueY = 
                                    (math.clamp(ms.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                        Hue.AbsoluteSize.Y)

                                Tween:Create(HueSelection, Tweeninfo(0.5), {
                                    Position = UDim2.new(0.48, 0, HueY, 0)
                                }):Play()
                                ColorH = 1 - HueY
                                UpdateColorPicker()
                            end)
                        end
                    end)
            Hue.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if HueInput then
                            HueInput:Disconnect()
                        end
                    end
                end)
            end
            return Elements
        end
        return Sections
    end
    return Tabs
end
-- By : Deceit Hub <3

		spawn(function()
			pcall(function()
			--	if game.ReplicatedStorage.Effect.Container:FindFirstChild("Death") then
					game.ReplicatedStorage.Effect.Container.Death:Destroy()
				--end
				--if game.ReplicatedStorage.Effect.Container:FindFirstChild("Respawn") then
					game.ReplicatedStorage.Effect.Container.Respawn:Destroy()
				--end
					game.ReplicatedStorage.Effect.Container.Hit:Destroy()
			end)
		end)

function BTP(P)
	repeat wait(1)
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
		task.wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
	until (P.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500
end

function TP(P1)
	local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	Speed = 100
	if Distance < 250 then		
		Speed = 5000
	elseif Distance < 500 then
		Speed = 650
	elseif Distance < 1000 then
		Speed = 350
	elseif Distance >= 1000 then
		Speed = 250
	end
	TWEEN = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1})
	TWEEN:Play()
end

function CheckQuest()
	local Id = game.PlaceId
	local Level = game:GetService("Players").LocalPlayer.Data.Level.Value
	if Id == 2753915549 then
		if Level == 1 or Level <= 9 then
			Mon = "Bandit [Lv. 5]"
			MonPos = CFrame.new(1198.5999755859375, 38.06475830078125, 1543.47119140625)
			LQuest = 1
			NQuest = "BanditQuest1"
			NameMon = "Bandit"
			CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
		elseif Level == 10 or Level <= 14 then
			Mon = "Monkey [Lv. 14]"
			MonPos = CFrame.new(-1403.5555419921875, 98.59825134277344, 90.24476623535156)
			LQuest = 1
			NQuest = "JungleQuest"
			NameMon = "Monkey"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		elseif Level == 15 or Level <= 29 then
			Mon = "Gorilla [Lv. 20]"
			MonPos = CFrame.new(-1320.2811279296875, 81.85315704345703, -458.73248291015625)
			LQuest = 2
			NQuest = "JungleQuest"
			NameMon = "Gorilla"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		elseif Level == 30 or Level <= 39 then
			Mon = "Pirate [Lv. 35]"
			MonPos = CFrame.new(-1140.37109375, 53.04805374145508, 3972.119384765625)
			LQuest = 1
			NQuest = "BuggyQuest1"
			NameMon = "Pirate"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
		elseif Level == 40 or Level <= 59 then
			Mon = "Brute [Lv. 45]"
			MonPos = CFrame.new(-1133.1185302734375, 94.3675537109375, 4307.36376953125)
			LQuest = 2
			NQuest = "BuggyQuest1"
			NameMon = "Brute"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
		elseif Level == 60 or Level <= 74 then
			Mon = "Desert Bandit [Lv. 60]"
			MonPos = CFrame.new(978.1805419921875, 21.926359176635742, 4407.97119140625)
			LQuest = 1
			NQuest = "DesertQuest"
			NameMon = "Desert Bandit"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
		elseif Level == 75 or Level <= 89 then
			Mon = "Desert Officer [Lv. 70]"
			MonPos = CFrame.new(1558.972900390625, 15.365246772766113, 4280.10302734375)
			LQuest = 2
			NQuest = "DesertQuest"
			NameMon = "Desert Officer"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
		elseif Level == 90 or Level <= 99 then
			Mon = "Snow Bandit [Lv. 90]"
			MonPos = CFrame.new(1352.8118896484375, 105.67132568359375, -1324.64697265625)
			LQuest = 1
			NQuest = "SnowQuest"
			NameMon = "Snow Bandit"
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
		elseif Level == 100 or Level <= 119 then
			Mon = "Snowman [Lv. 100]"
			MonsPos = CFrame.new(1201.8741455078125, 144.61459350585938, -1546.5943603515625)
			LQuest = 2
			NQuest = "SnowQuest"
			NameMon = "Snowman"
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
		elseif Level == 120 or Level <= 149 then
			Mon = "Chief Petty Officer [Lv. 120]"
			MonPos = CFrame.new(-4855.8466796875, 23.68708038330078, 4308.84814453125)
			LQuest = 1
			NQuest = "MarineQuest2"
			NameMon = "Chief Petty Officer"
			CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 150 or Level <= 174 then
			Mon = "Sky Bandit [Lv. 150]"
			MonPos = CFrame.new(-4951.14501953125, 295.77923583984375, -2899.656005859375)
			LQuest = 1
			NQuest = "SkyQuest"
			NameMon = "Sky Bandit"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
		elseif Level == 175 or Level <= 189 then
			Mon = "Dark Master [Lv. 175]"
			MonPos = CFrame.new(-5224.60107421875, 429.73699951171875, -2280.69677734375)
			LQuest = 2
			NQuest = "SkyQuest"
			NameMon = "Dark Master"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
		elseif Level == 190 or Level <= 209 then
			Mon = "Prisoner [Lv. 190]"
			MonsPos = CFrame.new(5285.59033203125, 88.68693542480469, 476.51483154296875)
			LQuest = 1
			NQuest = "PrisonerQuest"
			NameMon = "Prisoner"
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
		elseif Level == 210 or Level <= 249 then
			Mon = "Dangerous Prisoner [Lv. 210]"
			MonsPos = CFrame.new(5543.451171875, 88.6868896484375, 696.1821899414062)
			LQuest = 2
			NQuest = "PrisonerQuest"
			NameMon = "Dangerous Prisoner"
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
		elseif Level == 250 or Level <= 299 then
			Mon = "Toga Warrior [Lv. 250]"
			MonPos = CFrame.new(-1772.7384033203125, 38.839969635009766, -2745.384521484375)
			LQuest = 1
			NQuest = "ColosseumQuest"
			NameMon = "Toga Warrior"
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
				--[[elseif Level == 275 or Level <= 299 then
			Mon = "Gladiator [Lv. 275]"
			MonPos = CFrame.new(-1283.224853515625, 7.567874908447266, -3253.5498046875)
			LQuest = 2
			NQuest = "ColosseumQuest"
			NameMon = "Gladiator"
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
				]]
		elseif Level == 300 or Level <= 324 then
			Mon = "Military Soldier [Lv. 300]"
			MonPos = CFrame.new(-5410.20751953125, 11.10084342956543, 8456.4111328125)
			LQuest = 1
			NQuest = "MagmaQuest"
			NameMon = "Military Soldier"
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
		elseif Level == 325 or Level <= 374 then
			Mon = "Military Spy [Lv. 325]"
			MonPos = CFrame.new(-5800.2548828125, 98.19547271728516, 8781.802734375)
			LQuest = 2
			NQuest = "MagmaQuest"
			NameMon = "Military Spy"
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
		elseif Level == 375 or Level <= 399 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
			end
			Mon = "Fishman Warrior [Lv. 375]"
			MonPos = CFrame.new(60890.0859375, 95.70665740966797, 1546.843017578125)
			LQuest = 1
			NQuest = "FishmanQuest"
			NameMon = "Fishman Warrior"
			CFrameQuest = CFrame.new(61119.890625, 18.50667381286621, 1567.489990234375)
		elseif Level == 400 or Level <= 449 then
			Mon = "Fishman Commando [Lv. 400]"
			MonPos = CFrame.new(61872.09765625, 75.50736999511719, 1403.5740966796875)
			LQuest = 2
			NQuest = "FishmanQuest"
			NameMon = "Fishman Commando"
			CFrameQuest = CFrame.new(61119.890625, 18.50667381286621, 1567.489990234375)
		elseif Level == 450 or Level <= 474 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(3864.53466796875, 5.4081878662109375, -1925.2999267578125)).Magnitude >= 17000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.53466796875, 5.4081878662109375, -1925.2999267578125))
			end
			Mon = "God's Guard [Lv. 450]"
			MonPos = CFrame.new(-4627.390625, 866.9378051757812, -1945.0068359375)
			LQuest = 1
			NQuest = "SkyExp1Quest"
			NameMon = "God's Guard"
			CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
		elseif Level == 475 or Level <= 524 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7859.09814, 5544.19043, -381.476196))
			end
			Mon = "Shanda [Lv. 475]"
			MonPos = CFrame.new(-7685.2890625, 5567.029296875, -497.586181640625)
			LQuest = 2
			NQuest = "SkyExp1Quest"
			NameMon = "Shanda"
			CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
		elseif Level == 525 or Level <= 549 then
			Mon = "Royal Squad [Lv. 525]"
			MonPos = CFrame.new(-7647.44775390625, 5637.11572265625, -1416.885009765625)
			LQuest = 1
			NQuest = "SkyExp2Quest"
			NameMon = "Royal Squad"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 550 or Level <= 624 then
			Mon = "Royal Soldier [Lv. 550]"
			MonPos = CFrame.new(-7831.77197265625, 5622.3154296875, -1777.7586669921875)
			LQuest = 2
			NQuest = "SkyExp2Quest"
			NameMon = "Royal Soldier"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 625 or Level <= 649 then
			Mon = "Galley Pirate [Lv. 625]"
			MonPos = CFrame.new(5634.70751953125, 95.40705108642578, 4037.620849609375)
			LQuest = 1
			NQuest = "FountainQuest"
			NameMon = "Galley Pirate"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
		elseif Level >= 650 then
			Mon = "Galley Captain [Lv. 650]"
			MonPos = CFrame.new(5687.47998046875, 43.858909606933594, 4886.95263671875)
			LQuest = 2
			NQuest = "FountainQuest"
			NameMon = "Galley Captain"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
				end
	elseif Id == 4442272183 then
		if Level == 700 or Level <= 724 then
			Mon = "Raider [Lv. 700]"
			LQuest = 1
			NQuest = "Area1Quest"
			NameMon = "Raider"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			MonPos = CFrame.new(-746,39,2389)
		elseif Level == 725 or Level <= 774 then
			Mon = "Mercenary [Lv. 725]"
			LQuest = 2
			NQuest = "Area1Quest"
			NameMon = "Mercenary"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)	
			--[[if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-950.9469604492188, 73.59642791748047, 1687.7239990234375)).Magnitude >= 200 then
				--repeat task.wait()
					MonPos = CFrame.new(-950.9469604492188, 73.59642791748047, 1687.7239990234375)
				--until (Vector3.new(-950.9469604492188, 73.59642791748047, 1687.7239990234375) - game.Players.LocalPlayer.Character.HumanoidRootPart).Magnitude <= 10
		elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-1101.5570068359375, 73.59659576416016, 1155.75)).Magnitude >= 200 then
				--repeat task.wait()
					MonPos = CFrame.new(-1101.5570068359375, 73.59659576416016, 1155.75)
				--until (Vector3.new(-1101.5570068359375, 73.59659576416016, 1155.75) - game.Players.LocalPlayer.Character.HumanoidRootPart).Magnitude <= 10
			end]]
			MonPos = CFrame.new(-874,141,1312)
		elseif Level == 775 or Level <= 874 then
			Mon = "Swan Pirate [Lv. 775]"
			MonPos = CFrame.new(879.0155029296875, 121.6172103881836, 1236.484619140625)
			LQuest = 1
			NQuest = "Area2Quest"
			NameMon = "Swan Pirate"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
				--[[elseif Level == 800 or Level <= 874 then
			Mon = "Factory Staff [Lv. 800]"
			MonPos = CFrame.new(-49.088504791259766, 149.4334259033203, -150.80809020996094)
			NQuest = "Area2Quest"
			LQuest = 2
			NameMon = "Factory Staff"
			CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
			]]
		elseif Level == 875 or Level <= 899 then
			Mon = "Marine Lieutenant [Lv. 875]"
			MonPos = CFrame.new(-2846.595703125, 73.00115966796875, -2985.402099609375)
			LQuest = 1
			NQuest = "MarineQuest3"
			NameMon = "Marine Lieutenant"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
		elseif Level == 900 or Level <= 949 then
			Mon = "Marine Captain [Lv. 900]"
			MonPos = CFrame.new(-1838.5380859375, 91.05396270751953, -3209.526611328125)
			LQuest = 2
			NQuest = "MarineQuest3"
			NameMon = "Marine Captain"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
		elseif Level == 950 or Level <= 974 then
			Mon = "Zombie [Lv. 950]"
			MonPos = CFrame.new(-5710, 126.0670166015625, -775)
			LQuest = 1
			NQuest = "ZombieQuest"
			NameMon = "Zombie"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
		elseif Level == 975 or Level <= 999 then
			Mon = "Vampire [Lv. 975]"
			MonPos = CFrame.new(-6037.7578125, 6.437739849090576, -1326.2755126953125)
			LQuest = 2
			NQuest = "ZombieQuest"
			NameMon = "Vampire"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
		elseif Level == 1000 or Level <= 1049 then
			Mon = "Snow Trooper [Lv. 1000]"
			MonPos = CFrame.new(609.858826, 400.119904, -5372.25928)
			LQuest = 1
			NQuest = "SnowMountainQuest"
			NameMon = "Snow Trooper"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
		elseif Level == 1050 or Level <= 1099 then
			Mon = "Winter Warrior [Lv. 1050]"
			MonPos = CFrame.new(1240.4923095703125, 460.9142761230469, -5192.29345703125)
			LQuest = 2
			NQuest = "SnowMountainQuest"
			NameMon = "Winter Warrior"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
		elseif Level == 1100 or Level <= 1124 then
			Mon = "Lab Subordinate [Lv. 1100]"
			MonPos = CFrame.new(-5780.4345703125, 42.55501174926758, -4482.74853515625)
			LQuest = 1
			NQuest = "IceSideQuest"
			NameMon = "Lab Subordinate"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
		elseif Level == 1125 or Level <= 1174 then
			Mon = "Horned Warrior [Lv. 1125]"
			MonPos = CFrame.new(-6349.41015625, 21.453861236572266, -5834.12841796875)
			LQuest = 2
			NQuest = "IceSideQuest"
			NameMon = "Horned Warrior"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
		elseif Level == 1175 or Level <= 1199 then
			Mon = "Magma Ninja [Lv. 1175]"
			--[[if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-5627.03662109375, 30.024616241455078, -5899.95654296875)).Magnitude >= 200 then
				MonPos = CFrame.new(-5627.03662109375, 30.024616241455078, -5899.95654296875)
		elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-5275.21435546875, 39.44550704956055, -6133.7392578125)).Magnitude >= 200 then
				MonPos = CFrame.new(-5275.21435546875, 39.44550704956055, -6133.7392578125)
			end]]
			LQuest = 1
			NQuest = "FireSideQuest"
			NameMon = "Magma Ninja"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			MonPos = CFrame.new(-5428, 78, -5959)
		elseif Level == 1200 or Level <= 1249 then
			Mon = "Lava Pirate [Lv. 1200]"
			MonPos = CFrame.new(-5232.8466796875, 51.79249954223633, -4729.9609375)
			LQuest = 2
			NQuest = "FireSideQuest"
			NameMon = "Lava Pirate"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
		elseif Level == 1250 or Level <= 1274 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1037.80127, 125.092171, 32911.6016)).Magnitude >= 20000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(1037.80127, 125.092171, 32911.6016))
			end
			Mon = "Ship Deckhand [Lv. 1250]"
			MonPos = CFrame.new(1197.23583984375, 125.09214782714844, 33047.83984375)
			LQuest = 1
			NQuest = "ShipQuest1"
			NameMon = "Ship Deckhand"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)         
		elseif Level == 1275 or Level <= 1299 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1037.80127, 125.092171, 32911.6016)).Magnitude >= 20000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(1037.80127, 125.092171, 32911.6016))
			end
			Mon = "Ship Engineer [Lv. 1275]"
			MonPos = CFrame.new(922.4091186523438, 43.57904052734375, 32783.21875)
			LQuest = 2
			NQuest = "ShipQuest1"
			NameMon = "Ship Engineer"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
		elseif Level == 1300 or Level <= 1324 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1037.80127, 125.092171, 32911.6016)).Magnitude >= 20000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(1037.80127, 125.092171, 32911.6016))
			end
			Mon = "Ship Steward [Lv. 1300]"
			MonPos = CFrame.new(918.0401000976562, 129.07810974121094, 33419.45703125)
			LQuest = 1
			NQuest = "ShipQuest2"
			NameMon = "Ship Steward"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
		elseif Level == 1325 or Level <= 1349 then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(1037.80127, 125.092171, 32911.6016)).Magnitude >= 20000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(1037.80127, 125.092171, 32911.6016))
			end
			Mon = "Ship Officer [Lv. 1325]"
			MonPos = CFrame.new(1188.7747802734375, 181.18414306640625, 33311.84765625)
			LQuest = 2
			NQuest = "ShipQuest2"
			NameMon = "Ship Officer"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
		elseif Level == 1350 or Level <= 1374 then
			Mon = "Arctic Warrior [Lv. 1350]"
			MonPos = CFrame.new(5984.4443359375, 59.70625686645508, -6170.4990234375)
			LQuest = 1
			NQuest = "FrostQuest"
			NameMon = "Arctic Warrior"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
		elseif Level == 1375 or Level <= 1424 then
			Mon = "Snow Lurker [Lv. 1375]"
			MonPos = CFrame.new(5656.3681640625, 43.96525573730469, -6785.47998046875)
			LQuest = 2
			NQuest = "FrostQuest"
			NameMon = "Snow Lurker"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
		elseif Level == 1425 or Level <= 1449 then
			Mon = "Sea Soldier [Lv. 1425]"
			--[[if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-3201.64599609375, 35.59043884277344, -9796.525390625)).Magnitude >= 200 then
				MonPos = CFrame.new(-3201.64599609375, 35.59043884277344, -9796.525390625)
		elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-2766.245849609375, 46.5843505859375, -9836.3525390625)).Magnitude >= 200 then
				MonPos = CFrame.new(-2766.245849609375, 46.5843505859375, -9836.3525390625)
			end]]
			LQuest = 1
			NQuest = "ForgottenQuest"
			NameMon = "Sea Soldier"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			MonPos = CFrame.new(-3038, 15, -9720)
		elseif Level >= 1450 then
			Mon = "Water Fighter [Lv. 1450]"
			MonPos = CFrame.new(-3286.5224609375, 252.3995819091797, -10515.396484375)
			LQuest = 2
			NQuest = "ForgottenQuest"
			NameMon = "Water Fighter"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
				end
	elseif Id == 7449423635 then
		if Level == 1500 or Level <= 1524 then
			Mon = "Pirate Millionaire [Lv. 1500]"
			MonPos = CFrame.new(-292.1559753417969, 43.8282470703125, 5582.9287109375)
			LQuest = 1
			NQuest = "PiratePortQuest"
			NameMon = "Pirate Millionaire"
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
		elseif Level == 1525 or Level <= 1574 then
			Mon = "Pistol Billionaire [Lv. 1525]"
			MonPos = CFrame.new(-315.38531494140625, 119.50130462646484, 6005.96630859375)
			LQuest = 2
			NQuest = "PiratePortQuest"
			NameMon = "Pistol Billionaire"
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
		elseif Level == 1575 or Level <= 1599 then
			Mon = "Dragon Crew Warrior [Lv. 1575]"
			MonPos = CFrame.new(6414.8330078125, 121.43488311767578, -807.5617065429688)
			LQuest = 1
			NQuest = "AmazonQuest"
			NameMon = "Dragon Crew Warrior"
			CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
		elseif Level == 1600 or Level <= 1624 then 
			Mon = "Dragon Crew Archer [Lv. 1600]"
			MonPos = CFrame.new(6622.6787109375, 378.4330749511719, 182.57872009277344)
			NQuest = "AmazonQuest"
			LQuest = 2
			NameMon = "Dragon Crew Archer"
			CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
		elseif Level == 1625 or Level <= 1649 then
			Mon = "Female Islander [Lv. 1625]"
			MonPos = CFrame.new(5719.08203125, 781.7914428710938, 871.026123046875)
			NQuest = "AmazonQuest2"
			LQuest = 1
			NameMon = "Female Islander"
			CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
		elseif Level == 1650 or Level <= 1699 then 
			Mon = "Giant Islander [Lv. 1650]"
			MonPos = CFrame.new(4937.7333984375, 604.96728515625, -237.5341796875)
			NQuest = "AmazonQuest2"
			LQuest = 2
			NameMon = "Giant Islander"
			CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
		elseif Level == 1700 or Level <= 1724 then
			Mon = "Marine Commodore [Lv. 1700]"
			MonPos = CFrame.new(2394.572998046875, 121.98365020751953, -7600.91943359375)
			LQuest = 1
			NQuest = "MarineTreeIsland"
			NameMon = "Marine Commodore"
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
		elseif Level == 1725 or Level <= 1774 then
			Mon = "Marine Rear Admiral [Lv. 1725]"
			MonPos = CFrame.new(3637.744873046875, 160.55908203125, -7037.28857421875)
			NameMon = "Marine Rear Admiral"
			NQuest = "MarineTreeIsland"
			LQuest = 2
			CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
		elseif Level == 1775 or Level <= 1799 then
			Mon = "Fishman Raider [Lv. 1775]"
			MonPos = CFrame.new(-10352.6923828125, 344.1450500488281, -8169.39111328125)
			LQuest = 1
			NQuest = "DeepForestIsland3"
			NameMon = "Fishman Raider"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
		elseif Level == 1800 or Level <= 1824 then
			Mon = "Fishman Captain [Lv. 1800]"
			MonPos = CFrame.new(-11087.44140625, 331.79766845703125, -8934.5576171875)
			LQuest = 2
			NQuest = "DeepForestIsland3"
			NameMon = "Fishman Captain"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
		elseif Level == 1825 or Level <= 1849 then
			Mon = "Forest Pirate [Lv. 1825]"
			MonPos = CFrame.new(-13241.498046875, 428.2030944824219, -7748.095703125)
			LQuest = 1
			NQuest = "DeepForestIsland"
			NameMon = "Forest Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
		elseif Level == 1850 or Level <= 1899 then
			Mon = "Mythological Pirate [Lv. 1850]"
			MonPos = CFrame.new(-13427.259765625, 511.83453369140625, -6943.66162109375)
			LQuest = 2
			NQuest = "DeepForestIsland"
			NameMon = "Mythological Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)   
		elseif Level == 1900 or Level <= 1924 then
			Mon = "Jungle Pirate [Lv. 1900]"
			MonPos = CFrame.new(-12113.16796875, 441.3117980957031, -10540.6298828125)
			LQuest = 1
			NQuest = "DeepForestIsland2"
			NameMon = "Jungle Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
		elseif Level == 1925 or Level <= 1974 then
			Mon = "Musketeer Pirate [Lv. 1925]"
			MonPos = CFrame.new(-13249.8271484375, 496.2460632324219, -9584.373046875)
			LQuest = 2
			NQuest = "DeepForestIsland2"
			NameMon = "Musketeer Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
		elseif Level == 1975 or Level <= 1999 then
			Mon = "Reborn Skeleton [Lv. 1975]"
			MonPos = CFrame.new(-8766.345703125, 174.2373809814453, 6169.01513671875)
			LQuest = 1
			NQuest = "HauntedQuest1"
			NameMon = "Reborn Skeleton"
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		elseif Level == 2000 or Level <= 2024 then
			Mon = "Living Zombie [Lv. 2000]"
			MonPos = CFrame.new(-9925.1884765625, 158.6781005859375, 6036.7314453125)
			LQuest = 2
			NQuest = "HauntedQuest1"
			NameMon = "Living Zombie"
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
		elseif Level == 2025 or Level <= 2049 then
			Mon = "Demonic Soul [Lv. 2025]"
			MonPos = CFrame.new(-9542.6875, 272.1398010253906, 6249.53515625)
			LQuest = 1
			NQuest = "HauntedQuest2"
			NameMon = "Demonic Soul"
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
		elseif Level == 2050 or Level <= 2074 then
			Mon = "Posessed Mummy [Lv. 2050]"
			MonPos = CFrame.new(-9544.2744140625, 60.294342041015625, 6348.95849609375)
			LQuest = 2
			NQuest = "HauntedQuest2"
			NameMon = "Posessed Mummy"
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 2075 or Level <= 2099 then
			Mon = "Peanut Scout [Lv. 2075]"
			MonPos = CFrame.new(-2063.197021484375, 78.91095733642578, -10137.9287109375)
			LQuest = 1
			NQuest = "NutsIslandQuest"
			NameMon = "Peanut Scout"
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 2100 or Level <= 2124 then
			Mon = "Peanut President [Lv. 2100]"
			MonPos = CFrame.new(-2133.56396484375, 70.31375885009766, -10523.0908203125)
			LQuest = 2
			NQuest = "NutsIslandQuest"
			NameMon = "Peanut President"
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 2125 or Level <= 2149 then
			Mon = "Ice Cream Chef [Lv. 2125]"
			MonPos = CFrame.new(-893.8236083984375, 116.68982696533203, -10938.47265625)
			LQuest = 1
			NQuest = "IceCreamIslandQuest"
			NameMon = "Ice Cream Chef"
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 2150 or Level <= 2199 then
			Mon = "Ice Cream Commander [Lv. 2150]"
			MonPos = CFrame.new(-585.1178588867188, 203.74639892578125, -11267.0107421875)
			LQuest = 2
			NQuest = "IceCreamIslandQuest"
			NameMon = "Ice Cream Commander"
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		elseif Level == 2200 or Level <= 2224 then
			Mon = "Cookie Crafter [Lv. 2200]"
			MonPos = CFrame.new(-2286.31103515625, 91.31655883789062, -12041.6884765625)
			LQuest = 1
			NQuest = "CakeQuest1"
			NameMon = "Cookie Crafter"
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
		elseif Level == 2225 or Level <= 2249 then
			Mon = "Cake Guard [Lv. 2225]"
			MonPos = CFrame.new(-1630.3675537109375, 195.69100952148438, -12275.96875)
			LQuest = 2
			NQuest = "CakeQuest1"
			NameMon = "Cake Guard"
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
		elseif Level == 2250 or Level <= 2274 then
			Mon = "Baking Staff [Lv. 2250]"
			MonPos = CFrame.new(-1824.580810546875, 95.08509826660156, -12891.3232421875)
			LQuest = 1
			NQuest = "CakeQuest2"
			NameMon = "Baking Staff"
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
		elseif Level == 2275 or Level <= 2299 then
			Mon = "Head Baker [Lv. 2275]"
			MonPos = CFrame.new(-2068.284912109375, 68.5050048828125, -12950.775390625)
			LQuest = 2
			NQuest = "CakeQuest2"
			NameMon = "Head Baker"
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
		elseif Level == 2300 or Level <= 2324 then
			Mon = "Cocoa Warrior [Lv. 2300]"
			MonPos = CFrame.new(43.3896598815918, 56.341636657714844, -12324.78515625)
			LQuest = 1
			NQuest = "ChocQuest1"
			NameMon = "Cocoa Warrior"
			CFrameQuest = CFrame.new(231.88818359375, 24.769283294677734, -12202.1337890625)
		elseif Level == 2325 or Level <= 2349 then
			Mon = "Chocolate Bar Battler [Lv. 2325]"
			MonPos = CFrame.new(719.6046752929688, 69.9678955078125, -12597.25390625)
			LQuest = 2
			NQuest = "ChocQuest1"
			NameMon = "Chocolate Bar Battler"
			CFrameQuest = CFrame.new(231.88818359375, 24.769283294677734, -12202.1337890625)
		elseif Level == 2350 or Level <= 2374 then
			Mon = "Sweet Thief [Lv. 2350]"
			MonPos = CFrame.new(155.99618530273438, 54.82904815673828, -12580.7265625)
			LQuest = 1
			NQuest = "ChocQuest2"
			NameMon = "Sweet Thief"
			CFrameQuest = CFrame.new(151.1981201171875, 24.828855514526367, -12778.08984375)
			elseif Level == 2375 or Level <= 2399 then
					Mon = "Candy Rebel [Lv. 2375]"
					MonPos = CFrame.new(-7.535787105560303, 35.526527404785156, -12896.34375)
					LQuest = 2
					NQuest = "ChocQuest2"
					NameMon = "Candy Rebel"
					CFrameQuest = CFrame.new(151.1981201171875, 24.828855514526367, -12778.08984375)
                         elseif Level == 2400 or Level <= 2424 then
                		        Mon = "Candy Pirate [Lv. 2400]"
                		        MonPos = CFrame.new(-1393.447021484375, 13.819832801818848, -14419.154296875)
                		        LQuest = 1
                		        NQuest = "CandyQuest1"
                		        NameMon = "Candy Pirate"
                		        CFrameQuest = CFrame.new(-1147.6239013671875, 16.133047103881836, -14444.970703125)
              		 elseif Level <= 2450 then
                		        Mon = "Snow Demon [Lv. 2425]"
                		        MonPos = CFrame.new(-820.8795166015625, 49.07795715332031, -14329.525390625)
                		        LQuest = 2
                		        NQuest = "CandyQuest1"
                		        NameMon = "Snow Demon"
                		        CFrameQuest = CFrame.new(-1147.6239013671875, 16.133047103881836, -14444.970703125)
				end
			end
		end

function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end

	function BTP(Point)
		game.Players.LocalPlayer.Character.Humanoid.Health = 0
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		task.wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
	end

function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end                   

function isnil(thing)
    return (thing == nil)
end
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)

function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/300, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 250 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end

function GetDistance(target)
    return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
end

spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoFarm then
				CheckQuest()
				if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,NameMon) then
					print('Abandon')
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
				end

				if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					StartBring = false
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude > 1500 then
						BTP(CFrameQuest)
					else
						TP(CFrameQuest)
					end
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NQuest,LQuest)
					end
				elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					CheckQuest()
					StartBring = true
					if game.Workspace.Enemies:FindFirstChild(Mon) then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if v.Name == Mon and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
								v.HumanoidRootPart.CanCollide = false
								v.Head.CanCollide = false
								_G.Pos = v.HumanoidRootPart.CFrame
								_G.Mon = v.Name
								repeat task.wait()
									TP(v.HumanoidRootPart.CFrame * CFrame.new(0,20,-5))
                                                                        wait(0.1)
									TP(v.HumanoidRootPart.CFrame * CFrame.new(20,20,0))
                                                                        wait(0.1)
									TP(v.HumanoidRootPart.CFrame * CFrame.new(0,20,-2))
                                                                        wait(0.1)
									TP(v.HumanoidRootPart.CFrame * CFrame.new(0,20,20))
									EquipItem(_G.SelectWeapon)
								until v.Humanoid.Health <= 0 or not v.Parent or not _G.AutoFarm or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
							end
						end
					else
						TP(MonPos)
					end
				end
			end
		end)
	end	
end)

spawn(function()
	while task.wait() do
		pcall(function()
			if StartBring then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v.Name == _G.Mon and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then
						v.Humanoid.WalkSpeed = 0
						v.Humanoid.JumpPower = 0
						v.HumanoidRootPart.Size = Vector3.new(60,60,60)
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						v.HumanoidRootPart.CFrame = _G.Pos
						if v.Humanoid:FindFirstChild('Animator') then
							v.Humanoid.Animator:Destroy()
						end
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
					end
				end
			end
		end)
	end
end)

function EquipItem(Item)
	local SeItem = game.Players.LocalPlayer.Backpack:FindFirstChild(Item)
	wait()
	game.Players.LocalPlayer.Character.Humanoid:EquipTool(SeItem)
end

spawn(function()
	while task.wait() do
		pcall(function()
			if StartBring then
				for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
					if v:IsA('Part') and v:IsA('MeshPart') then
						v.Transparency = 1
					end
				end
			end
		end)
	end
end)

spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoRaid then
				if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							pcall(function()
								repeat task.wait()
									sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
									v.Humanoid.Health = 0
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(100,100,100)
									v.HumanoidRootPart.Transparency = 0.8
								until not _G.Killaura or not v.Parent or v.Humanoid.Health <= 0
							end)
						end
					end
				end
			end
		end)
	end
end)

spawn(function()
	while wait() do
		pcall(function()
			if _G.AutoRaid then
				if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
					if not game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") and not game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.DunChip)
					end
					if not game.Workspace._WorldOrigin.Locations:FindFirstChild("Island 1") then
						if game.PlaceId == 4442272183 then
							fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
						elseif game.PlaceId == 7449423635 then
							fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)

spawn(function()
	while wait() do
		pcall(function()
			if _G.NextIsland then
				if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
					for i,v in pairs(game.Workspace._WorldOrigin.Locations:GetChildren()) do
						if v.Name == ("Island 5") then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude / 10 <= 500 then
								TP(v.CFrame)
							end
						elseif v.Name == ("Island 4") then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude / 10 <= 500 then
								TP(v.CFrame)
							end
						elseif v.Name == ("Island 3") then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude / 10 <= 500 then
								TP(v.CFrame)
							end
						elseif v.Name == ("Island 2") then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude / 10 <= 500 then
								TP(v.CFrame)
							end
						end
					end
				end
			end
		end)
	end
end)

spawn(function()
	while task.wait() do
		pcall(function()
			for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
				if v.Name == "CurvedRing" or v.Name == "SlashHit" or v.Name == "SwordSlash" or v.Name == "SlashTail" then
					v:Destroy()
				end
			end
		end)
	end
end)

spawn(function()
	while wait() do
		pcall(function()
			if _G.AutoBuso then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end)
	end
end)

function Click()
game:GetService'VirtualUser':CaptureController()
game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.AutoKen then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true)
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
		end)
	end
end)
local CharParts = {}
game:GetService("RunService").Stepped:connect(function()
	pcall(function()
		if _G.NoClip then
			for i = 1, #CharParts do
				CharParts[i].CanCollide = false
			end
		else
			for i = 1, #CharParts do
				CharParts[i].CanCollide = true
			end
		end
	end)
end)

function SetupCharCollide(Char)
	CharParts = {}
	Char:WaitForChild("Head")
	for i, v in pairs(Char:GetChildren()) do
		if v:IsA("BasePart") then
			table.insert(CharParts, v)
		end
	end
end

if game.Players.LocalPlayer.Character then
	SetupCharCollide(game.Players.LocalPlayer.Character)
end
game.Players.LocalPlayer.CharacterAdded:connect(function(Ch)
	SetupCharCollide(Ch)
end)

spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoFarm or _G.NextIsland then
				for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
					v:Destroy()
				end
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity")
					Noclip.Name = "BodyClip"
					Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
					Noclip.MaxForce = Vector3.new(100000,100000,100000)
					Noclip.Velocity = Vector3.new(0,0,0)
				end
			else
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
			end
		end)
	end
end)
spawn(function()
	pcall(function()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
			vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end)
end)

local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()
Mouse.Button1Down:connect(function()
	if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
		return
	end
	if not Mouse.Target then
		return
	end
	if CTRL then
		Plr.Character:MoveTo(Mouse.Hit.p)
	end
end)

function TP(Pos)
    repeat wait()
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
        pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/300, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
        tween:Play()
        if Distance <= 250 then
            tween:Cancel()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        end
        if _G.StopTween == true then
            tween:Cancel()
            _G.Clip = false
        end
    until Distance <= 10
end

	function TelePBoss(p)
		pcall(function()
			if (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 and not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
				if NameQuest == "FishmanQuest" then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
					_G.Stop_Tween = nil
				elseif Ms == "God's Guard [Lv. 450]"  then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
					_G.Stop_Tween = nil
				elseif NameQuest == "SkyExp1Quest" then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
					_G.Stop_Tween = nil
				elseif NameQuest == "ShipQuest1" then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					_G.Stop_Tween = nil
				elseif NameQuest == "ShipQuest2" then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					_G.Stop_Tween = nil
				elseif NameQuest == "FrostQuest" then
					_G.Stop_Tween = true
					TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
					wait()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
					_G.Stop_Tween = nil
				else
					Mix_Farm = true
					_G.Stop_Tween = true
					repeat wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
						wait(.05)
						game.Players.LocalPlayer.Character.Head:Destroy()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
					until (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
					wait()
					_G.Stop_Tween = nil
					Mix_Farm = nil
				end
			end
		end)
	end

 function toTarget(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 360 then
        Speed = 1200
    elseif Distance < 1000 then
        Speed = 360
    elseif Distance < 360 then
        Speed = 1200
    elseif Distance >= 1000 then
        Speed = 360
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end



local UIWindow = CFAHub:CreateWindow("<font color=\"#4fc3f7\">ZPS </font>Hub", "Blox Fruit - X KEY", true)
local MainZ = UIWindow:CreatePage("Main")
local V4Z = UIWindow:CreatePage("V4")
local PlayerZ = UIWindow:CreatePage("Player")
local StatsZ = UIWindow:CreatePage("Stats")
local RaidZ = UIWindow:CreatePage("Raid")
local MiscZ = UIWindow:CreatePage("Misc")
local ShopZ = UIWindow:CreatePage("Shop")
local TeleportZ = UIWindow:CreatePage("Teleport Sea 3")
local SettingZ = UIWindow:CreatePage("Setting")
--
local MainZpage = MainZ:CreateSection("Main")
local V4Zpage = V4Z:CreateSection("Main")
local PlayerZpage = PlayerZ:CreateSection("Main")
local StatsZpage = StatsZ:CreateSection("Main")
local RaidZpage = RaidZ:CreateSection("Dungeon")
local MiscZpage = MiscZ:CreateSection("Main")
local ShopZpage = ShopZ:CreateSection("Shop")
local TeleportZpage = TeleportZ:CreateSection("Main")
local SettingZpage = SettingZ:CreateSection("Main")

spawn(function()
while wait() do
pcall(function()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v:IsA('Tool') then
		if v.ToolTip == _G.WeaponType then
			_G.SelectWeapon = v.Name
		end
	end
end
end)
end
end)

MainZpage:CreateDropdown("Select Weapon Sytem", {List = {"Melee","Blox Fruit","Sword","Gun"}, Default = Melee}, function(value)
_G.WeaponType = value
end)

MainZpage:CreateToggle("Auto Farm", {Toggled = false, Description = "Auto Farm Level"}, function(value)
_G.AutoFarm = value
end)

MainZpage:CreateToggle("Auto Bone", {Toggled = false, Description = "Auto Farm Bone / Auto Farm Bone Not Auto Ramdom Bone"}, function(value)
Auto_Farm_Bone = value
end)


	spawn(function()
		game:GetService("RunService").Heartbeat:Connect(function()
			pcall(function()
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if (Auto_Farm_Bone or _G.Settings.Mastery["Farm Mastery SwordList"]) and StatrMagnetBoneMon and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - PosMonBone.Position).magnitude <= 350 then
						v.HumanoidRootPart.CFrame = PosMonBone
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(50,50,50)
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					end
				end
			end)
		end)
	end)


	spawn(function()
		while wait() do
			if Auto_Farm_Bone then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Domenic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]" then
								if v.Humanoid.Health > 0 then
									FastAttack = true
									repeat wait()
                                                                                _G.AutoBuso = true
										EquipWeapon(_G.SelectWeapon)
										StatrMagnetBoneMon = true
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										PosMonBone = v.HumanoidRootPart.CFrame
										TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,-5))
                                                                                wait()
										TP(v.HumanoidRootPart.CFrame * CFrame.new(20,30,0))
                                                                                wait()
										TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,20))
                                                                                wait()
										TP(v.HumanoidRootPart.CFrame * CFrame.new(-20,30,0))
                                                                                wait()
										TP(v.HumanoidRootPart.CFrame * CFrame.new(-5,30,20))
                                                                                wait()
										TP(v.HumanoidRootPart.CFrame * CFrame.new(20,30,-5))
									until Auto_Farm_Bone == false or not v.Parent or v.Humanoid.Health <= 0
									FastAttack = false
								end
							end
						end
					else
						StatrMagnetBoneMon = false
						if (CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
							TP(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
						else
							TelePBoss(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
						end
					end
				end)
			end
		end
	end)

MainZpage:CreateToggle("Auto Pirate", {Toggled = false, Description = "Auto Kill Pirate"}, function(value)
Auto_Quest_Tushita_2 = value
end)

spawn(function()
	while wait() do
		if Auto_Quest_Tushita_2 then
			pcall(function()
				local CFrameBoss = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
				if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
					for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if Auto_Quest_Tushita_2 and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
								repeat wait()
								    _G.AutoFarm = false
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                                        wait()
									TP(v.HumanoidRootPart.CFrame * CFrame.new(20,30,0))
									                                   wait()
									TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,20))
								until v.Humanoid.Health <= 0 or not v.Parent or Auto_Quest_Tushita_2 == false
							end
						end
					end
				else
					if ((CFrameBoss).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
						TP(CFrameBoss)
					else
						TelePBoss(CFrameBoss)
					end
				end
			end)
		end
	end
end)

V4Zpage:CreateToggle("Tween Mirage", {Toggled = false, Description = "Tween Mirage / Mystic island"}, function(value)
_G.Mirage = value
end)

spawn(function()
        pcall(function()
            while wait() do
             if _G.Mirage then
              if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                function toTargetWait(a)local b=(a.p-game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude;tweenrach=game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"),TweenInfo.new(b/250,Enum.EasingStyle.Linear),{CFrame=a})tweenrach:Play()end;toTargetWait(workspace.Map.MysticIsland.PrimaryPart.CFrame*CFrame.new(0,250,0))
                else
game.StarterGui:SetCore("SendNotification", {
        Title = "ZPS Hub"; 
        Text = "Mirage not Spawn!"; 
        Icon = "rbxassetid://12847918419",
        Duration = 3;
        })
                if _G.MirageHop then
                wait(6)
                Hop()
                end
            end
end
end
end)
end)

V4Zpage:CreateToggle("Tween Gear", {Toggled = false, Description = "Tween Gear / Bule Gear"}, function(value)
TP(game:GetService("Workspace").Map.MysticIsland:FindFirstChildOfClass("MeshPart").CFrame)
end)

V4Zpage:CreateButton("Complete Rabbit Trial",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-5,0)
end)

V4Zpage:CreateButton("Complete Cyborg Trial",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,300,0)
end)

V4Zpage:CreateButton("Complete Sky Trial",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.SkyTrial.Model.FinishPart.CFrame
end)

V4Zpage:CreateToggle("Complete Human / Ghoul Trial", {Toggled = false, Description = "Kill aura"}, function(value)
_G.Killaura = value
end)


_G.Point = 1000

		StatsZpage:CreateToggle("Auto Stats Melee", {Toggled = false, Description = "AuTo stats melee"}, function(value)
_G.Auto_Stats_Melee = value
end)

spawn(function()
	while wait() do
		if _G.Auto_Stats_Melee then
			local args = {
				[1] = "AddPoint",
				[2] = "Melee",
				[3] = _G.Point
			}
						
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
		end
	end
end)

		StatsZpage:CreateToggle("Auto Stats Defense", {Toggled = false, Description = "AuTo stats Defense"}, function(value)
_G.Auto_Stats_Defense = value
end)

spawn(function()
	while wait() do
		if _G.Auto_Stats_Defense then
			local args = {
				[1] = "AddPoint",
				[2] = "Defense",
				[3] = _G.Point
			}
						
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
		end
	end
end)

		StatsZpage:CreateToggle("Auto Stats Sword", {Toggled = false, Description = "AuTo stats Sword"}, function(value)
_G.Auto_Stats_Sword = value
end)

spawn(function()
	while wait() do
		if _G.Auto_Stats_Sword then
			local args = {
				[1] = "AddPoint",
				[2] = "Sword",
				[3] = _G.Point
			}
						
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
		end
	end
end)

		StatsZpage:CreateToggle("Auto Stats Gun", {Toggled = false, Description = "AuTo stats Gun"}, function(value)
_G.Auto_Stats_Gun = value
end)


spawn(function()
	while wait() do
		if _G.Auto_Stats_Gun then
			local args = {
				[1] = "AddPoint",
				[2] = "Gun",
				[3] = _G.Point
			}
						
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
		end
	end
end)

		StatsZpage:CreateToggle("Auto Stats Fruit", {Toggled = false, Description = "AuTo stats Fruit"}, function(value)
_G.Auto_Stats_Devil_Fruit = value
end)

spawn(function()
	while wait() do
		if _G.Auto_Stats_Devil_Fruit then
			local args = {
				[1] = "AddPoint",
				[2] = "Demon Fruit",
				[3] = _G.Point
			}
						
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
		end
	end
end)

		RaidZpage:CreateToggle("Kill Aura", {Toggled = false, Description = "Kill Aura | Start Raid"}, function(value)
_G.Killaura = value
end)
		
				spawn(function()
			while task.wait() do
				pcall(function()
					if _G.Killaura then
						for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								pcall(function()
									repeat task.wait()
										sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
										v.Humanoid.Health = 0
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(100,100,100)
										v.HumanoidRootPart.Transparency = 0.8
									until not _G.Killaura or not v.Parent or v.Humanoid.Health <= 0
								end)
							end
						end
					end
				end)
			end
		end)


		MiscZpage:CreateButton("Rejoin Server",function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
		end)
		MiscZpage:CreateButton("Hop Server",function()
			Hop()
		end)
		MiscZpage:CreateButton("Remove Fog",function()
			game.Lighting.Sky:Destroy()
		end)
		MiscZpage:CreateButton("Join Pirate",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam","Pirates")
		end)
		MiscZpage:CreateButton("Join Marine",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam","Marines")
		end)

local player = game:GetService("Players").LocalPlayer

local blackscreen = function(enable)
    local playerGui = player:WaitForChild("PlayerGui")
    if not enable then
        local sUi = playerGui:FindFirstChild("Blackscreen")
        if sUi then sUi:Destroy() end
        return
    elseif playerGui:FindFirstChild("Blackscreen") then
        return
    end
    local sUi = Instance.new("ScreenGui", playerGui)
    sUi.Name = "Blackscreen"
    sUi.DisplayOrder = -727

    local uiFrame = Instance.new("Frame", sUi)
    uiFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    uiFrame.Size = UDim2.new(0, 72727, 0, 72727)
    uiFrame.Position = UDim2.new(0, 0, -5, 0)
end

		MiscZpage:CreateButton("Off blackscreen",function()
blackscreen(false)
		end)
			MiscZpage:CreateButton("ON Black screen",function()
blackscreen(true)
		end)	
		


MiscZpage:CreateToggle("White Screen", {Toggled = false, Description = "White screen | Boost Fps"}, function(value)
_G.WhiteScreen = value
end)
		
				spawn(function()
			while task.wait() do
				pcall(function()
					if _G.WhiteScreen then
						game:GetService("RunService"):Set3dRenderingEnabled(false)
					else
						game:GetService("RunService"):Set3dRenderingEnabled(true)
					end
				end)
			end
				end)
				
						function MeleeZBuy(N1,N2,N3,N4)
			BuyMelee:AddButton(N1,function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(N2,N3,N4)
			end)
						end
	
		ShopZpage:CreateButton("Buy Geppo [Sky Jump]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
		end)
				ShopZpage:CreateButton("Buy Buso Haki",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
		end)		ShopZpage:CreateButton("Buy Soru",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
		end)		ShopZpage:CreateButton("Buy Observation [ken]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
		end)
		
		ShopZpage:CreateButton("Buy Black Leg [v1]",function()
		    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
		end)
	    ShopZpage:CreateButton("Buy Electro [v1]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
		end)
		ShopZpage:CreateButton("Buy FishmanKarate [v1]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
		end)
		ShopZpage:CreateButton("Buy Dragon Claw [v1]",function()
		    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
		end)
	    ShopZpage:CreateButton("Buy Super Human",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
		end)
		ShopZpage:CreateButton("Buy Buy Death Step [v2]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
		end)
		ShopZpage:CreateButton("Buy SharkManKarate [v2]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
		end)
		ShopZpage:CreateButton("Buy Buy Electric Claw [v2]",function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
		end)
		ShopZpage:CreateButton("Buy Dragon Talon [v2]",function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
		end)
		ShopZpage:CreateButton("Buy God Human",function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
		end)
		
		
			function BTPZ(Point)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		task.wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
			end

		TeleportZpage:CreateButton("Teleport Mainsion",function()
		BTPZ(CFrame.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
		end)
		TeleportZpage:CreateButton("Teleport Sea Castle",function()
		BTPZ(CFrame.new(-5075.50927734375, 314.5155029296875, -3150.0224609375))
		end)
		TeleportZpage:CreateButton("Teleport Hydra",function()
		BTPZ(CFrame.new(5753.5478515625, 610.7880859375, -282.33172607421875))
		end)
		TeleportZpage:CreateButton("Teleport Florentino Room",function()
		BTPZ(CFrame.new(5312.90625, 22.53643226623535, -125.82667541503906))
		end)
		TeleportZpage:CreateButton("Teleport Temple",function()
		BTPZ(CFrame.new(28286.35546875, 14896.5078125, 102.62469482421875))
		end)
		
SettingZpage:CreateDropdown("Select Fast attack", {List = {'Normal','Super','Fast'}, Default = Normal}, function(value)
	if t == 'Normal' then
		_G.FastDelay = 0.3
	end
	if t == 'Fast' then
		_G.FastDelay = 0.1
	end
	if t == 'Super' then
		_G.FastDelay = 100000
	end
end)

	SettingZpage:CreateToggle("Fast Attack", {Toggled = true, Description = "Fast Attack select"}, function(value)
_G.FastAttack = value
end)

function NormalAttack()
	if not _G.FastAttack then
		game:GetService'VirtualUser':CaptureController()
		game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
	end
end
	
	
	spawn(function()
while true do task.wait()
pcall(function()
if _G.FastAttack then
repeat wait(_G.FastDelay) AttackNoCD() until not _G.FastAttack

end
end)
end
end)


		
	SettingZpage:CreateToggle("Auto Buso", {Toggled = true, Description = "Auto ON BUSO HAKI"}, function(value)
_G.AutoBuso = value
end)	
	SettingZpage:CreateToggle("Auto KEN", {Toggled = true, Description = "Auto ON Ken HAKI"}, function(value)
_G.AutoKen = value
end)
	SettingZpage:CreateToggle("No Clip", {Toggled = true, Description = "No lip"}, function(value)
_G.NoClip = value
end)
		local CharParts = {}
		game:GetService("RunService").Stepped:connect(function()
			pcall(function()
				if _G.NoClip then
					for i = 1, #CharParts do
						CharParts[i].CanCollide = false
					end
				else
					for i = 1, #CharParts do
						CharParts[i].CanCollide = true
					end
				end
			end)
		end)

		function SetupCharCollide(Char)
			CharParts = {}
			Char:WaitForChild("Head")
			for i, v in pairs(Char:GetChildren()) do
				if v:IsA("BasePart") then
					table.insert(CharParts, v)
				end
			end
		end

		if game.Players.LocalPlayer.Character then
			SetupCharCollide(game.Players.LocalPlayer.Character)
		end
		game.Players.LocalPlayer.CharacterAdded:connect(function(Ch)
			SetupCharCollide(Ch)
		end)

		spawn(function()
			pcall(function()
				local vu = game:GetService("VirtualUser")
				game:GetService("Players").LocalPlayer.Idled:connect(function()
					vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
					task.wait(0.5)
					vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				end)
			end)
		end)
		

		SettingZpage:CreateToggle("Auto Rejoin", {Toggled = true, Description = "Auto Rejoin"}, function(value)
_G.UseAwakenZ = value
end)

spawn(function()
	while wait() do
		if _G.AutoRejoin then
			_G.AutoRejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
				if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
					print("Rejoin!")
					game:GetService("TeleportService"):Teleport(game.PlaceId)
				end
			end)
		end
	end
end)
		SettingZpage:CreateToggle("Auto V4", {Toggled = false, Description = "Auto Use Awakening Race"}, function(value)
_G.UseAwakenZ = value
end)
		
if game.Players.LocalPlayer.Character.RaceEnergy.Value >= 1 and game.Players.LocalPlayer.Character.RaceTransformed.Value == false then
                    repeat task.wait()
                        EquipItem('Awakening')
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.UseAwakenZ or game.Players.LocalPlayer.Character.RaceTransformed.Value == true    
            end
        
            
return CFAHub
