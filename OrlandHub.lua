--// OrlandHub - Single File Edition
--// LocalScript -> StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--------------------------------------------------
-- CHARACTER
--------------------------------------------------

local Character
local Humanoid
local RootPart

local function LoadCharacter(char)
	Character = char or Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	RootPart = Character:WaitForChild("HumanoidRootPart")
end

LoadCharacter()

Player.CharacterAdded:Connect(function(char)
	task.wait(.3)
	LoadCharacter(char)
end)

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local State = {
	Language = "RU",

	Speed = {
		Enabled = false,
		Value = 32
	},

	Fly = {
		Enabled = false,
		Value = 60
	},

	Noclip = {
		Enabled = false
	},

	XRay = {
		Enabled = false,
		Value = 0.65
	}
}

local L = {

	RU = {
		Utilities = "Utrlit",

		Speed = "Скорость",
		SpeedDesc = "Изменяет скорость персонажа",

		Fly = "Полёт",
		FlyDesc = "Свободное перемещение по воздуху",

		Noclip = "Ноуклип",
		NoclipDesc = "Проход сквозь объекты",

		XRay = "X-Ray",
		XRayDesc = "Прозрачность объектов мира",

		Settings = "Настройки",
		RightClick = "ПКМ — настройки",

		SpeedSetting = "Скорость",
		FlySetting = "Скорость полёта",
		XRaySetting = "Прозрачность",

		Active = "ACTIVE",
		Off = "OFF"
	},

	EN = {
		Utilities = "Utrlit",

		Speed = "Speed",
		SpeedDesc = "Changes character movement speed",

		Fly = "Fly",
		FlyDesc = "Free movement through the air",

		Noclip = "Noclip",
		NoclipDesc = "Walk through objects",

		XRay = "X-Ray",
		XRayDesc = "World object transparency",

		Settings = "Settings",
		RightClick = "RMB — settings",

		SpeedSetting = "Speed",
		FlySetting = "Fly speed",
		XRaySetting = "Transparency",

		Active = "ACTIVE",
		Off = "OFF"
	}

}

--------------------------------------------------
-- THEME
--------------------------------------------------

local Theme = {

	Background = Color3.fromRGB(9,10,15),

	Header = Color3.fromRGB(14,15,21),

	Sidebar = Color3.fromRGB(12,13,19),

	Surface = Color3.fromRGB(19,20,28),

	Hover = Color3.fromRGB(25,27,37),

	Accent = Color3.fromRGB(112,82,255),

	Accent2 = Color3.fromRGB(65,105,255),

	Text = Color3.fromRGB(244,245,250),

	Secondary = Color3.fromRGB(145,149,164),

	Muted = Color3.fromRGB(83,87,101),

	Border = Color3.fromRGB(58,62,80),

	Success = Color3.fromRGB(65,215,140)
}

--------------------------------------------------
-- HELPERS
--------------------------------------------------

local function Corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,radius)
	c.Parent = parent
	return c
end

local function Stroke(parent, color, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Transparency = transparency or 0
	s.Thickness = 1
	s.Parent = parent
	return s
end

local function Tween(object, properties, duration)
	TweenService:Create(
		object,
		TweenInfo.new(
			duration or .16,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		properties
	):Play()
end

--------------------------------------------------
-- REMOVE OLD GUI
--------------------------------------------------

local old = PlayerGui:FindFirstChild("OrlandHub")

if old then
	old:Destroy()
end

--------------------------------------------------
-- GUI
--------------------------------------------------

local GUI = Instance.new("ScreenGui")

GUI.Name = "OrlandHub"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = PlayerGui

--------------------------------------------------
-- SHADOW
--------------------------------------------------

local Shadow = Instance.new("Frame")

Shadow.Size = UDim2.fromOffset(754,504)

Shadow.Position =
	UDim2.new(.5,-377,.5,-252)

Shadow.BackgroundColor3 =
	Color3.new(0,0,0)

Shadow.BackgroundTransparency = .45

Shadow.BorderSizePixel = 0

Shadow.Parent = GUI

Corner(Shadow,18)

--------------------------------------------------
-- MAIN
--------------------------------------------------

local Main = Instance.new("Frame")

Main.Size = UDim2.fromOffset(740,490)

Main.Position =
	UDim2.new(.5,-370,.5,-245)

Main.BackgroundColor3 =
	Theme.Background

Main.BorderSizePixel = 0

Main.ClipsDescendants = true

Main.Parent = GUI

Corner(Main,16)

Stroke(
	Main,
	Theme.Border,
	.55
)

--------------------------------------------------
-- HEADER
--------------------------------------------------

local Header = Instance.new("Frame")

Header.Size =
	UDim2.new(1,0,0,66)

Header.BackgroundColor3 =
	Theme.Header

Header.BorderSizePixel = 0

Header.Parent = Main

--------------------------------------------------
-- LOGO
--------------------------------------------------

local Logo = Instance.new("Frame")

Logo.Size =
	UDim2.fromOffset(40,40)

Logo.Position =
	UDim2.fromOffset(18,13)

Logo.BackgroundColor3 =
	Theme.Accent

Logo.BorderSizePixel = 0

Logo.Parent = Header

Corner(Logo,11)

local LogoGradient =
	Instance.new("UIGradient")

LogoGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Theme.Accent
		),

		ColorSequenceKeypoint.new(
			1,
			Theme.Accent2
		)

	})

LogoGradient.Rotation = 45
LogoGradient.Parent = Logo

local LogoText =
	Instance.new("TextLabel")

LogoText.Size =
	UDim2.fromScale(1,1)

LogoText.BackgroundTransparency = 1

LogoText.Text = "O"

LogoText.TextColor3 =
	Color3.new(1,1,1)

LogoText.Font =
	Enum.Font.GothamBold

LogoText.TextSize = 20

LogoText.Parent = Logo

--------------------------------------------------
-- TITLE
--------------------------------------------------

local Title =
	Instance.new("TextLabel")

Title.Size =
	UDim2.fromOffset(230,28)

Title.Position =
	UDim2.fromOffset(70,9)

Title.BackgroundTransparency = 1

Title.Text = "OrlandHub"

Title.TextColor3 =
	Theme.Text

Title.Font =
	Enum.Font.GothamBold

Title.TextSize = 19

Title.TextXAlignment =
	Enum.TextXAlignment.Left

Title.Parent = Header

local Subtitle =
	Instance.new("TextLabel")

Subtitle.Size =
	UDim2.fromOffset(300,20)

Subtitle.Position =
	UDim2.fromOffset(70,35)

Subtitle.BackgroundTransparency = 1

Subtitle.Text =
	"Premium Utility • v3.0"

Subtitle.TextColor3 =
	Theme.Muted

Subtitle.Font =
	Enum.Font.Gotham

Subtitle.TextSize = 10

Subtitle.TextXAlignment =
	Enum.TextXAlignment.Left

Subtitle.Parent = Header

--------------------------------------------------
-- LANGUAGE
--------------------------------------------------

local LangHolder =
	Instance.new("Frame")

LangHolder.Size =
	UDim2.fromOffset(140,38)

LangHolder.Position =
	UDim2.new(1,-195,0,14)

LangHolder.BackgroundTransparency = 1

LangHolder.ZIndex = 50

LangHolder.Parent = Header

local LangButton =
	Instance.new("TextButton")

LangButton.Size =
	UDim2.fromScale(1,1)

LangButton.BackgroundColor3 =
	Theme.Surface

LangButton.BorderSizePixel = 0

LangButton.Text = ""

LangButton.AutoButtonColor = false

LangButton.ZIndex = 51

LangButton.Parent = LangHolder

Corner(LangButton,9)
Stroke(LangButton,Theme.Border,.55)

local LangText =
	Instance.new("TextLabel")

LangText.Size =
	UDim2.new(1,-40,1,0)

LangText.Position =
	UDim2.fromOffset(12,0)

LangText.BackgroundTransparency = 1

LangText.Text = "Русский"

LangText.TextColor3 =
	Theme.Text

LangText.Font =
	Enum.Font.GothamMedium

LangText.TextSize = 11

LangText.TextXAlignment =
	Enum.TextXAlignment.Left

LangText.ZIndex = 52

LangText.Parent = LangButton

local Arrow =
	Instance.new("TextLabel")

Arrow.Size =
	UDim2.fromOffset(30,38)

Arrow.Position =
	UDim2.new(1,-34,0,0)

Arrow.BackgroundTransparency = 1

Arrow.Text = "▼"

Arrow.TextColor3 =
	Theme.Secondary

Arrow.Font =
	Enum.Font.GothamBold

Arrow.TextSize = 9

Arrow.ZIndex = 52

Arrow.Parent = LangButton

--------------------------------------------------
-- DROPDOWN
--------------------------------------------------

local LangList =
	Instance.new("Frame")

LangList.Size =
	UDim2.new(1,0,0,0)

LangList.Position =
	UDim2.fromOffset(0,44)

LangList.BackgroundColor3 =
	Color3.fromRGB(17,18,26)

LangList.BorderSizePixel = 0

LangList.ClipsDescendants = true

LangList.Visible = false

LangList.ZIndex = 100

LangList.Parent = LangHolder

Corner(LangList,9)
Stroke(LangList,Theme.Border,.45)

local function CreateLanguage(text,code,y)

	local b =
		Instance.new("TextButton")

	b.Size =
		UDim2.new(1,-12,0,34)

	b.Position =
		UDim2.fromOffset(6,y)

	b.BackgroundColor3 =
		Theme.Surface

	b.BorderSizePixel = 0

	b.Text = text

	b.TextColor3 =
		Theme.Text

	b.Font =
		Enum.Font.GothamMedium

	b.TextSize = 11

	b.AutoButtonColor = false

	b.ZIndex = 101

	b.Parent = LangList

	Corner(b,7)

	b.MouseEnter:Connect(function()

		Tween(
			b,
			{
				BackgroundColor3 =
					Theme.Hover
			},
			.1
		)

	end)

	b.MouseLeave:Connect(function()

		Tween(
			b,
			{
				BackgroundColor3 =
					Theme.Surface
			},
			.1
		)

	end)

	return b,code
end

local RUButton =
	CreateLanguage(
		"Русский",
		"RU",
		6
	)

local ENButton =
	CreateLanguage(
		"English",
		"EN",
		44
	)

local LanguageOpen = false

local Cards = {}

local function RefreshLanguage()

	local T =
		L[State.Language]

	if Cards.Speed then

		Cards.Speed.Title.Text =
			T.Speed

		Cards.Speed.Desc.Text =
			T.SpeedDesc

		Cards.Speed.Hint.Text =
			T.RightClick

	end

	if Cards.Fly then

		Cards.Fly.Title.Text =
			T.Fly

		Cards.Fly.Desc.Text =
			T.FlyDesc

		Cards.Fly.Hint.Text =
			T.RightClick

	end

	if Cards.Noclip then

		Cards.Noclip.Title.Text =
			T.Noclip

		Cards.Noclip.Desc.Text =
			T.NoclipDesc

		Cards.Noclip.Hint.Text =
			T.RightClick

	end

	if Cards.XRay then

		Cards.XRay.Title.Text =
			T.XRay

		Cards.XRay.Desc.Text =
			T.XRayDesc

		Cards.XRay.Hint.Text =
			T.RightClick

	end

end

local function CloseLanguage()

	LanguageOpen = false

	Tween(
		LangList,
		{
			Size =
				UDim2.new(1,0,0,0)
		}
	)

	Tween(
		Arrow,
		{
			Rotation = 0
		}
	)

	task.delay(.17,function()

		if not LanguageOpen then
			LangList.Visible = false
		end

	end)

end

LangButton.MouseButton1Click:Connect(function()

	LanguageOpen =
		not LanguageOpen

	if LanguageOpen then

		LangList.Visible = true

		Tween(
			LangList,
			{
				Size =
					UDim2.new(
						1,
						0,
						0,
						84
					)
			}
		)

		Tween(
			Arrow,
			{
				Rotation = 180
			}
		)

	else

		CloseLanguage()

	end

end)

RUButton.MouseButton1Click:Connect(function()

	State.Language = "RU"

	LangText.Text =
		"Русский"

	RefreshLanguage()

	CloseLanguage()

end)

ENButton.MouseButton1Click:Connect(function()

	State.Language = "EN"

	LangText.Text =
		"English"

	RefreshLanguage()

	CloseLanguage()

end)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local Minimize =
	Instance.new("TextButton")

Minimize.Size =
	UDim2.fromOffset(36,36)

Minimize.Position =
	UDim2.new(1,-45,0,15)

Minimize.BackgroundColor3 =
	Theme.Surface

Minimize.BorderSizePixel = 0

Minimize.Text = "—"

Minimize.TextColor3 =
	Theme.Text

Minimize.Font =
	Enum.Font.GothamBold

Minimize.TextSize = 15

Minimize.AutoButtonColor = false

Minimize.Parent = Header

Corner(Minimize,9)

--------------------------------------------------
-- SIDEBAR
--------------------------------------------------

local Sidebar =
	Instance.new("Frame")

Sidebar.Size =
	UDim2.new(0,180,1,-66)

Sidebar.Position =
	UDim2.fromOffset(0,66)

Sidebar.BackgroundColor3 =
	Theme.Sidebar

Sidebar.BorderSizePixel = 0

Sidebar.Parent = Main

local SideTitle =
	Instance.new("TextLabel")

SideTitle.Size =
	UDim2.new(1,-30,0,20)

SideTitle.Position =
	UDim2.fromOffset(18,18)

SideTitle.BackgroundTransparency = 1

SideTitle.Text = "MODULES"

SideTitle.TextColor3 =
	Theme.Muted

SideTitle.Font =
	Enum.Font.GothamBold

SideTitle.TextSize = 9

SideTitle.TextXAlignment =
	Enum.TextXAlignment.Left

SideTitle.Parent = Sidebar

--------------------------------------------------
-- TAB
--------------------------------------------------

local Tab =
	Instance.new("TextButton")

Tab.Size =
	UDim2.new(1,-20,0,48)

Tab.Position =
	UDim2.fromOffset(10,52)

Tab.BackgroundColor3 =
	Color3.fromRGB(32,28,54)

Tab.BorderSizePixel = 0

Tab.Text = ""

Tab.AutoButtonColor = false

Tab.Parent = Sidebar

Corner(Tab,10)

local ActiveLine =
	Instance.new("Frame")

ActiveLine.Size =
	UDim2.fromOffset(3,28)

ActiveLine.Position =
	UDim2.fromOffset(0,10)

ActiveLine.BackgroundColor3 =
	Theme.Accent

ActiveLine.BorderSizePixel = 0

ActiveLine.Parent = Tab

Corner(ActiveLine,3)

local TabIcon =
	Instance.new("TextLabel")

TabIcon.Size =
	UDim2.fromOffset(35,48)

TabIcon.Position =
	UDim2.fromOffset(12,0)

TabIcon.BackgroundTransparency = 1

TabIcon.Text = "◆"

TabIcon.TextColor3 =
	Theme.Accent

TabIcon.Font =
	Enum.Font.GothamBold

TabIcon.TextSize = 12

TabIcon.Parent = Tab

local TabText =
	Instance.new("TextLabel")

TabText.Size =
	UDim2.new(1,-50,1,0)

TabText.Position =
	UDim2.fromOffset(45,0)

TabText.BackgroundTransparency = 1

TabText.Text = "Utrlit"

TabText.TextColor3 =
	Theme.Text

TabText.Font =
	Enum.Font.GothamSemibold

TabText.TextSize = 12

TabText.TextXAlignment =
	Enum.TextXAlignment.Left

TabText.Parent = Tab

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content =
	Instance.new("Frame")

Content.Size =
	UDim2.new(1,-180,1,-66)

Content.Position =
	UDim2.fromOffset(180,66)

Content.BackgroundTransparency = 1

Content.Parent = Main

local PageTitle =
	Instance.new("TextLabel")

PageTitle.Size =
	UDim2.new(1,-40,0,32)

PageTitle.Position =
	UDim2.fromOffset(24,18)

PageTitle.BackgroundTransparency = 1

PageTitle.Text = "Utrlit"

PageTitle.TextColor3 =
	Theme.Text

PageTitle.Font =
	Enum.Font.GothamBold

PageTitle.TextSize = 21

PageTitle.TextXAlignment =
	Enum.TextXAlignment.Left

PageTitle.Parent = Content

local PageSubtitle =
	Instance.new("TextLabel")

PageSubtitle.Size =
	UDim2.new(1,-40,0,20)

PageSubtitle.Position =
	UDim2.fromOffset(24,50)

PageSubtitle.BackgroundTransparency = 1

PageSubtitle.Text =
	"Movement & world utilities"

PageSubtitle.TextColor3 =
	Theme.Muted

PageSubtitle.Font =
	Enum.Font.Gotham

PageSubtitle.TextSize = 10

PageSubtitle.TextXAlignment =
	Enum.TextXAlignment.Left

PageSubtitle.Parent = Content

--------------------------------------------------
-- GRID
--------------------------------------------------

local Grid =
	Instance.new("Frame")

Grid.Size =
	UDim2.new(1,-48,1,-94)

Grid.Position =
	UDim2.fromOffset(24,82)

Grid.BackgroundTransparency = 1

Grid.Parent = Content

local GridLayout =
	Instance.new("UIGridLayout")

GridLayout.CellSize =
	UDim2.new(.5,-7,0,132)

GridLayout.CellPadding =
	UDim2.fromOffset(14,14)

GridLayout.Parent = Grid

--------------------------------------------------
-- SETTINGS PANEL
--------------------------------------------------

local SettingsPanel =
	Instance.new("Frame")

SettingsPanel.Size =
	UDim2.fromOffset(310,0)

SettingsPanel.Position =
	UDim2.new(
		1,
		-330,
		1,
		-210
	)

SettingsPanel.BackgroundColor3 =
	Color3.fromRGB(16,17,24)

SettingsPanel.BorderSizePixel = 0

SettingsPanel.ClipsDescendants = true

SettingsPanel.Visible = false

SettingsPanel.ZIndex = 200

SettingsPanel.Parent = GUI

Corner(SettingsPanel,13)

Stroke(
	SettingsPanel,
	Theme.Border,
	.35
)

local SettingsTitle =
	Instance.new("TextLabel")

SettingsTitle.Size =
	UDim2.new(1,-30,0,38)

SettingsTitle.Position =
	UDim2.fromOffset(15,10)

SettingsTitle.BackgroundTransparency = 1

SettingsTitle.TextColor3 =
	Theme.Text

SettingsTitle.Font =
	Enum.Font.GothamBold

SettingsTitle.TextSize = 14

SettingsTitle.TextXAlignment =
	Enum.TextXAlignment.Left

SettingsTitle.ZIndex = 201

SettingsTitle.Parent =
	SettingsPanel

--------------------------------------------------
-- SLIDER
--------------------------------------------------

local SliderArea =
	Instance.new("Frame")

SliderArea.Size =
	UDim2.new(1,-30,0,80)

SliderArea.Position =
	UDim2.fromOffset(15,55)

SliderArea.BackgroundTransparency = 1

SliderArea.ZIndex = 201

SliderArea.Parent =
	SettingsPanel

local SliderValue =
	Instance.new("TextLabel")

SliderValue.Size =
	UDim2.new(1,0,0,25)

SliderValue.BackgroundTransparency = 1

SliderValue.TextColor3 =
	Theme.Accent

SliderValue.Font =
	Enum.Font.GothamBold

SliderValue.TextSize = 12

SliderValue.TextXAlignment =
	Enum.TextXAlignment.Right

SliderValue.ZIndex = 202

SliderValue.Parent =
	SliderArea

local SliderBar =
	Instance.new("Frame")

SliderBar.Size =
	UDim2.new(1,0,0,6)

SliderBar.Position =
	UDim2.fromOffset(0,45)

SliderBar.BackgroundColor3 =
	Color3.fromRGB(37,39,50)

SliderBar.BorderSizePixel = 0

SliderBar.ZIndex = 202

SliderBar.Parent =
	SliderArea

Corner(SliderBar,3)

local SliderFill =
	Instance.new("Frame")

SliderFill.Size =
	UDim2.fromScale(.3,1)

SliderFill.BackgroundColor3 =
	Theme.Accent

SliderFill.BorderSizePixel = 0

SliderFill.ZIndex = 203

SliderFill.Parent =
	SliderBar

Corner(SliderFill,3)

local SliderKnob =
	Instance.new("Frame")

SliderKnob.Size =
	UDim2.fromOffset(16,16)

SliderKnob.AnchorPoint =
	Vector2.new(.5,.5)

SliderKnob.Position =
	UDim2.new(.3,0,.5,0)

SliderKnob.BackgroundColor3 =
	Color3.new(1,1,1)

SliderKnob.BorderSizePixel = 0

SliderKnob.ZIndex = 204

SliderKnob.Parent =
	SliderBar

Corner(SliderKnob,8)

local CloseSettings =
	Instance.new("TextButton")

CloseSettings.Size =
	UDim2.new(1,-30,0,34)

CloseSettings.Position =
	UDim2.new(0,15,1,-47)

CloseSettings.BackgroundColor3 =
	Theme.Accent

CloseSettings.BorderSizePixel = 0

CloseSettings.Text = "OK"

CloseSettings.TextColor3 =
	Color3.new(1,1,1)

CloseSettings.Font =
	Enum.Font.GothamBold

CloseSettings.TextSize = 11

CloseSettings.ZIndex = 202

CloseSettings.AutoButtonColor = false

CloseSettings.Parent =
	SettingsPanel

Corner(CloseSettings,8)

local SliderDragging = false

local CurrentSlider = nil

local function UpdateSlider(input)

	if not CurrentSlider then
		return
	end

	local position =
		math.clamp(
			(
				input.Position.X -
				SliderBar.AbsolutePosition.X
			)
			/
			SliderBar.AbsoluteSize.X,
			0,
			1
		)

	local value =
		CurrentSlider.Min +
		(
			CurrentSlider.Max -
			CurrentSlider.Min
		)
		*
		position

	if CurrentSlider.Decimal then

		value =
			math.floor(
				value * 100
			) / 100

	else

		value =
			math.floor(
				value + .5
			)

	end

	CurrentSlider.Set(value)

	SliderValue.Text =
		tostring(value)

	SliderFill.Size =
		UDim2.fromScale(
			position,
			1
		)

	SliderKnob.Position =
		UDim2.new(
			position,
			0,
			.5,
			0
		)

end

SliderBar.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		SliderDragging = true

		UpdateSlider(input)

	end

end)

UIS.InputChanged:Connect(function(input)

	if
		SliderDragging
		and
		input.UserInputType ==
		Enum.UserInputType.MouseMovement
	then

		UpdateSlider(input)

	end

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		SliderDragging = false

	end

end)

local function OpenSlider(
	title,
	value,
	minimum,
	maximum,
	decimal,
	setter
)

	CurrentSlider = {

		Min = minimum,

		Max = maximum,

		Decimal = decimal,

		Set = setter

	}

	SettingsTitle.Text = title

	SliderValue.Text =
		tostring(value)

	local ratio =
		(value-minimum)
		/
		(maximum-minimum)

	SliderFill.Size =
		UDim2.fromScale(
			ratio,
			1
		)

	SliderKnob.Position =
		UDim2.new(
			ratio,
			0,
			.5,
			0
		)

	SettingsPanel.Visible = true

	SettingsPanel.Size =
		UDim2.fromOffset(
			310,
			0
		)

	Tween(
		SettingsPanel,
		{
			Size =
				UDim2.fromOffset(
					310,
					190
				)
		},
		.22
	)

end

CloseSettings.MouseButton1Click:Connect(function()

	Tween(
		SettingsPanel,
		{
			Size =
				UDim2.fromOffset(
					310,
					0
				)
		}
	)

	task.delay(.17,function()

		SettingsPanel.Visible =
			false

	end)

end)

--------------------------------------------------
-- FEATURE CARDS
--------------------------------------------------

local function CreateCard(
	id,
	title,
	description,
	icon,
	stateTable,
	settingsCallback
)

	local Card =
		Instance.new("TextButton")

	Card.BackgroundColor3 =
		Theme.Surface

	Card.BorderSizePixel = 0

	Card.Text = ""

	Card.AutoButtonColor = false

	Card.Parent = Grid

	Corner(Card,13)

	local CardStroke =
		Stroke(
			Card,
			Theme.Border,
			.7
		)

	local IconHolder =
		Instance.new("Frame")

	IconHolder.Size =
		UDim2.fromOffset(38,38)

	IconHolder.Position =
		UDim2.fromOffset(14,14)

	IconHolder.BackgroundColor3 =
		Color3.fromRGB(32,29,54)

	IconHolder.BorderSizePixel = 0

	IconHolder.Parent = Card

	Corner(IconHolder,10)

	local Icon =
		Instance.new("TextLabel")

	Icon.Size =
		UDim2.fromScale(1,1)

	Icon.BackgroundTransparency = 1

	Icon.Text = icon

	Icon.TextColor3 =
		Theme.Accent

	Icon.Font =
		Enum.Font.GothamBold

	Icon.TextSize = 13

	Icon.Parent = IconHolder

	local Name =
		Instance.new("TextLabel")

	Name.Size =
		UDim2.new(1,-76,0,26)

	Name.Position =
		UDim2.fromOffset(62,11)

	Name.BackgroundTransparency = 1

	Name.Text = title

	Name.TextColor3 =
		Theme.Text

	Name.Font =
		Enum.Font.GothamSemibold

	Name.TextSize = 13

	Name.TextXAlignment =
		Enum.TextXAlignment.Left

	Name.Parent = Card

	local Status =
		Instance.new("TextLabel")

	Status.Size =
		UDim2.fromOffset(60,18)

	Status.Position =
		UDim2.new(1,-74,0,37)

	Status.BackgroundTransparency = 1

	Status.Text = "OFF"

	Status.TextColor3 =
		Theme.Muted

	Status.Font =
		Enum.Font.GothamBold

	Status.TextSize = 8

	Status.TextXAlignment =
		Enum.TextXAlignment.Right

	Status.Parent = Card

	local Desc =
		Instance.new("TextLabel")

	Desc.Size =
		UDim2.new(1,-28,0,30)

	Desc.Position =
		UDim2.fromOffset(14,61)

	Desc.BackgroundTransparency = 1

	Desc.Text = description

	Desc.TextColor3 =
		Theme.Secondary

	Desc.Font =
		Enum.Font.Gotham

	Desc.TextSize = 10

	Desc.TextWrapped = true

	Desc.TextXAlignment =
		Enum.TextXAlignment.Left

	Desc.TextYAlignment =
		Enum.TextYAlignment.Top

	Desc.Parent = Card

	local Hint =
		Instance.new("TextLabel")

	Hint.Size =
		UDim2.new(1,-90,0,25)

	Hint.Position =
		UDim2.new(0,14,1,-30)

	Hint.BackgroundTransparency = 1

	Hint.Text =
		L[State.Language].RightClick

	Hint.TextColor3 =
		Theme.Muted

	Hint.Font =
		Enum.Font.Gotham

	Hint.TextSize = 9

	Hint.TextXAlignment =
		Enum.TextXAlignment.Left

	Hint.Parent = Card

	local Toggle =
		Instance.new("Frame")

	Toggle.Size =
		UDim2.fromOffset(42,22)

	Toggle.Position =
		UDim2.new(1,-56,1,-30)

	Toggle.BackgroundColor3 =
		Color3.fromRGB(40,42,53)

	Toggle.BorderSizePixel = 0

	Toggle.Parent = Card

	Corner(Toggle,11)

	local Knob =
		Instance.new("Frame")

	Knob.Size =
		UDim2.fromOffset(16,16)

	Knob.Position =
		UDim2.fromOffset(3,3)

	Knob.BackgroundColor3 =
		Color3.fromRGB(137,141,154)

	Knob.BorderSizePixel = 0

	Knob.Parent = Toggle

	Corner(Knob,8)

	local function Update()

		if stateTable.Enabled then

			Status.Text = "ACTIVE"

			Status.TextColor3 =
				Theme.Success

			CardStroke.Color =
				Theme.Accent

			CardStroke.Transparency =
				.45

			Tween(
				Toggle,
				{
					BackgroundColor3 =
						Theme.Accent
				}
			)

			Tween(
				Knob,
				{
					Position =
						UDim2.fromOffset(
							23,
							3
						),

					BackgroundColor3 =
						Color3.new(1,1,1)
				}
			)

		else

			Status.Text = "OFF"

			Status.TextColor3 =
				Theme.Muted

			CardStroke.Color =
				Theme.Border

			CardStroke.Transparency =
				.7

			Tween(
				Toggle,
				{
					BackgroundColor3 =
						Color3.fromRGB(
							40,
							42,
							53
						)
				}
			)

			Tween(
				Knob,
				{
					Position =
						UDim2.fromOffset(
							3,
							3
						),

					BackgroundColor3 =
						Color3.fromRGB(
							137,
							141,
							154
						)
				}
			)

		end

	end

	Card.MouseButton1Click:Connect(function()

		stateTable.Enabled =
			not stateTable.Enabled

		Update()

	end)

	Card.InputBegan:Connect(function(input)

		if
			input.UserInputType ==
			Enum.UserInputType.MouseButton2
			and settingsCallback
		then

			settingsCallback()

		end

	end)

	Card.MouseEnter:Connect(function()

		Tween(
			Card,
			{
				BackgroundColor3 =
					Theme.Hover
			}
		)

	end)

	Card.MouseLeave:Connect(function()

		Tween(
			Card,
			{
				BackgroundColor3 =
					Theme.Surface
			}
		)

	end)

	Cards[id] = {

		Title = Name,

		Desc = Desc,

		Hint = Hint,

		Update = Update

	}

	Update()

end

CreateCard(
	"Speed",
	L.RU.Speed,
	L.RU.SpeedDesc,
	"⚡",
	State.Speed,
	function()

		OpenSlider(
			L[State.Language].SpeedSetting,
			State.Speed.Value,
			8,
			150,
			false,
			function(value)

				State.Speed.Value =
					value

			end
		)

	end
)

CreateCard(
	"Fly",
	L.RU.Fly,
	L.RU.FlyDesc,
	"▲",
	State.Fly,
	function()

		OpenSlider(
			L[State.Language].FlySetting,
			State.Fly.Value,
			10,
			250,
			false,
			function(value)

				State.Fly.Value =
					value

			end
		)

	end
)

CreateCard(
	"Noclip",
	L.RU.Noclip,
	L.RU.NoclipDesc,
	"◇",
	State.Noclip
)

CreateCard(
	"XRay",
	L.RU.XRay,
	L.RU.XRayDesc,
	"◉",
	State.XRay,
	function()

		OpenSlider(
			L[State.Language].XRaySetting,
			State.XRay.Value,
			0,
			.95,
			true,
			function(value)

				State.XRay.Value =
					value

			end
		)

	end
)

--------------------------------------------------
-- WINDOW DRAG
--------------------------------------------------

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

	if
		input.UserInputType ==
		Enum.UserInputType.MouseButton1
	then

		Dragging = true

		DragStart =
			input.Position

		StartPosition =
			Main.Position

	end

end)

UIS.InputEnded:Connect(function(input)

	if
		input.UserInputType ==
		Enum.UserInputType.MouseButton1
	then

		Dragging = false

	end

end)

UIS.InputChanged:Connect(function(input)

	if
		Dragging
		and
		input.UserInputType ==
		Enum.UserInputType.MouseMovement
	then

		local delta =
			input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + delta.X,

				StartPosition.Y.Scale,
				StartPosition.Y.Offset + delta.Y
			)

		Shadow.Position =
			UDim2.new(
				Main.Position.X.Scale,
				Main.Position.X.Offset - 7,

				Main.Position.Y.Scale,
				Main.Position.Y.Offset - 7
			)

	end

end)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

	Minimized =
		not Minimized

	if Minimized then

		Content.Visible = false
		Sidebar.Visible = false

		Tween(
			Main,
			{
				Size =
					UDim2.fromOffset(
						740,
						66
					)
			},
			.2
		)

		Tween(
			Shadow,
			{
				Size =
					UDim2.fromOffset(
						754,
						80
					)
			},
			.2
		)

	else

		Tween(
			Main,
			{
				Size =
					UDim2.fromOffset(
						740,
						490
					)
			},
			.2
		)

		Tween(
			Shadow,
			{
				Size =
					UDim2.fromOffset(
						754,
						504
					)
			},
			.2
		)

		task.delay(.1,function()

			Content.Visible = true
			Sidebar.Visible = true

		end)

	end

end)

--------------------------------------------------
-- SPEED
--------------------------------------------------

RunService.RenderStepped:Connect(function()

	if not Humanoid then
		return
	end

	if State.Speed.Enabled then

		Humanoid.WalkSpeed =
			State.Speed.Value

	else

		Humanoid.WalkSpeed = 16

	end

end)

--------------------------------------------------
-- NOCLIP
--------------------------------------------------

local CollisionCache = {}

RunService.Stepped:Connect(function()

	if not Character then
		return
	end

	if State.Noclip.Enabled then

		for _,object
			in ipairs(
				Character:GetDescendants()
			)
		do

			if object:IsA("BasePart") then

				if CollisionCache[object] == nil then

					CollisionCache[object] =
						object.CanCollide

				end

				object.CanCollide =
					false

			end

		end

	else

		for object,value
			in pairs(CollisionCache)
		do

			if object
				and object.Parent
			then

				object.CanCollide =
					value

			end

		end

		table.clear(
			CollisionCache
		)

	end

end)

--------------------------------------------------
-- FLY
--------------------------------------------------

local FlyVelocity
local FlyGyro

local function StopFly()

	if FlyVelocity then

		FlyVelocity:Destroy()
		FlyVelocity = nil

	end

	if FlyGyro then

		FlyGyro:Destroy()
		FlyGyro = nil

	end

	if Humanoid then

		Humanoid.PlatformStand =
			false

	end

end

RunService.RenderStepped:Connect(function()

	if not RootPart
		or not Humanoid
	then
		return
	end

	if State.Fly.Enabled then

		if not FlyVelocity then

			FlyVelocity =
				Instance.new(
					"BodyVelocity"
				)

			FlyVelocity.MaxForce =
				Vector3.new(
					1e6,
					1e6,
					1e6
				)

			FlyVelocity.Parent =
				RootPart

		end

		if not FlyGyro then

			FlyGyro =
				Instance.new(
					"BodyGyro"
				)

			FlyGyro.MaxTorque =
				Vector3.new(
					1e6,
					1e6,
					1e6
				)

			FlyGyro.P =
				9000

			FlyGyro.Parent =
				RootPart

		end

		local Camera =
			workspace.CurrentCamera

		local Direction =
			Vector3.zero

		if UIS:IsKeyDown(
			Enum.KeyCode.W
		) then

			Direction +=
				Camera.CFrame.LookVector

		end

		if UIS:IsKeyDown(
			Enum.KeyCode.S
		) then

			Direction -=
				Camera.CFrame.LookVector

		end

		if UIS:IsKeyDown(
			Enum.KeyCode.A
		) then

			Direction -=
				Camera.CFrame.RightVector

		end

		if UIS:IsKeyDown(
			Enum.KeyCode.D
		) then

			Direction +=
				Camera.CFrame.RightVector

		end

		if UIS:IsKeyDown(
			Enum.KeyCode.Space
		) then

			Direction +=
				Vector3.new(
					0,
					1,
					0
				)

		end

		if UIS:IsKeyDown(
			Enum.KeyCode.LeftControl
		) then

			Direction -=
				Vector3.new(
					0,
					1,
					0
				)

		end

		if Direction.Magnitude > 0 then

			Direction =
				Direction.Unit

		end

		FlyVelocity.Velocity =
			Direction
			*
			State.Fly.Value

		FlyGyro.CFrame =
			Camera.CFrame

		Humanoid.PlatformStand =
			true

	else

		StopFly()

	end

end)

--------------------------------------------------
-- XRAY
--------------------------------------------------

local XRayCache = {}

local function EnableXRay()

	for _,object
		in ipairs(
			workspace:GetDescendants()
		)
	do

		if object:IsA("BasePart") then

			if not Character
				or not object:IsDescendantOf(
					Character
				)
			then

				if
					XRayCache[object]
					== nil
				then

					XRayCache[object] =
						object.LocalTransparencyModifier

				end

				object.LocalTransparencyModifier =
					State.XRay.Value

			end

		end

	end

end

local function DisableXRay()

	for object,value
		in pairs(XRayCache)
	do

		if object
			and object.Parent
		then

			object.LocalTransparencyModifier =
				value

		end

	end

	table.clear(XRayCache)

end

local PreviousXRay = false

RunService.RenderStepped:Connect(function()

	if State.XRay.Enabled then

		EnableXRay()

	elseif PreviousXRay then

		DisableXRay()

	end

	PreviousXRay =
		State.XRay.Enabled

end)

RefreshLanguage()

print("OrlandHub loaded")
