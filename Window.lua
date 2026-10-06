local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Dropdown = require(script.Parent.Dropdown)
local FeatureCard = require(script.Parent.FeatureCard)

local Window = {}
Window.__index = Window

local function corner(object, radius)
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, radius)
	uiCorner.Parent = object
	return uiCorner
end

local function stroke(object, color, transparency, thickness)
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = color
	uiStroke.Transparency = transparency or 0
	uiStroke.Thickness = thickness or 1
	uiStroke.Parent = object
	return uiStroke
end

local function tween(object, duration, properties)
	TweenService:Create(
		object,
		TweenInfo.new(
			duration,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		properties
	):Play()
end

function Window.new(options)

	local self = setmetatable({}, Window)

	self.Name = options.Name or "OrlandHub"
	self.Config = options.Config
	self.Localization = options.Localization

	self.Language =
		self.Config.DefaultLanguage or "RU"

	self.Features = {}

	self.State = {
		Speed = {
			Enabled = false,
			Value = self.Config.Features.Speed.Default
		},

		Fly = {
			Enabled = false,
			Value = self.Config.Features.Fly.Default
		},

		Noclip = {
			Enabled = false
		},

		XRay = {
			Enabled = false,
			Value = self.Config.Features.XRay.Default
		}
	}

	self:_createGUI()

	return self
end

function Window:_createGUI()

	local player = game:GetService("Players").LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local theme = self.Config.Theme

	------------------------------------------------
	-- ScreenGui
	------------------------------------------------

	local GUI = Instance.new("ScreenGui")
	GUI.Name = self.Name
	GUI.ResetOnSpawn = false
	GUI.IgnoreGuiInset = true
	GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	GUI.Parent = playerGui

	self.GUI = GUI

	------------------------------------------------
	-- Shadow
	------------------------------------------------

	local Shadow = Instance.new("Frame")

	Shadow.Size = UDim2.fromOffset(754, 504)

	Shadow.Position =
		UDim2.new(
			0.5,
			-377,
			0.5,
			-252
		)

	Shadow.BackgroundColor3 =
		Color3.fromRGB(0, 0, 0)

	Shadow.BackgroundTransparency = 0.45

	Shadow.BorderSizePixel = 0

	Shadow.Parent = GUI

	corner(Shadow, 18)

	self.Shadow = Shadow

	------------------------------------------------
	-- Main
	------------------------------------------------

	local Main = Instance.new("Frame")

	Main.Size =
		UDim2.fromOffset(740, 490)

	Main.Position =
		UDim2.new(
			0.5,
			-370,
			0.5,
			-245
		)

	Main.BackgroundColor3 =
		theme.Background

	Main.BorderSizePixel = 0

	Main.ClipsDescendants = true

	Main.Parent = GUI

	corner(Main, 16)

	stroke(
		Main,
		theme.Border,
		0.6,
		1
	)

	self.Main = Main

	------------------------------------------------
	-- Header
	------------------------------------------------

	local Header = Instance.new("Frame")

	Header.Size =
		UDim2.new(1, 0, 0, 66)

	Header.BackgroundColor3 =
		Color3.fromRGB(15, 16, 22)

	Header.BorderSizePixel = 0

	Header.Parent = Main

	self.Header = Header

	------------------------------------------------
	-- Logo
	------------------------------------------------

	local Logo = Instance.new("Frame")

	Logo.Size =
		UDim2.fromOffset(40, 40)

	Logo.Position =
		UDim2.fromOffset(18, 13)

	Logo.BackgroundColor3 =
		theme.Accent

	Logo.BorderSizePixel = 0

	Logo.Parent = Header

	corner(Logo, 11)

	local LogoGradient =
		Instance.new("UIGradient")

	LogoGradient.Color =
		ColorSequence.new({
			ColorSequenceKeypoint.new(
				0,
				theme.Accent
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(
					69,
					106,
					255
				)
			)
		})

	LogoGradient.Rotation = 45

	LogoGradient.Parent = Logo

	local LogoText =
		Instance.new("TextLabel")

	LogoText.Size =
		UDim2.fromScale(1, 1)

	LogoText.BackgroundTransparency = 1

	LogoText.Text = "O"

	LogoText.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	LogoText.Font =
		Enum.Font.GothamBold

	LogoText.TextSize = 20

	LogoText.Parent = Logo

	------------------------------------------------
	-- title
	------------------------------------------------

	local Title = Instance.new("TextLabel")

	Title.Size =
		UDim2.fromOffset(240, 28)

	Title.Position =
		UDim2.fromOffset(70, 10)

	Title.BackgroundTransparency = 1

	Title.Text = self.Name

	Title.TextColor3 =
		theme.Text

	Title.Font =
		Enum.Font.GothamBold

	Title.TextSize = 19

	Title.TextXAlignment =
		Enum.TextXAlignment.Left

	Title.Parent = Header

	local Version = Instance.new("TextLabel")

	Version.Size =
		UDim2.fromOffset(250, 20)

	Version.Position =
		UDim2.fromOffset(70, 36)

	Version.BackgroundTransparency = 1

	Version.Text =
		"Premium Utility • v"
		.. tostring(
			self.Config.Version or "1.0"
		)

	Version.TextColor3 =
		theme.TextMuted

	Version.Font =
		Enum.Font.Gotham

	Version.TextSize = 10

	Version.TextXAlignment =
		Enum.TextXAlignment.Left

	Version.Parent = Header

	------------------------------------------------
	-- language
	------------------------------------------------

	local LangHolder =
		Instance.new("Frame")

	LangHolder.Size =
		UDim2.fromOffset(150, 38)

	LangHolder.Position =
		UDim2.new(
			1,
			-205,
			0,
			14
		)

	LangHolder.BackgroundTransparency = 1

	LangHolder.ZIndex = 50

	LangHolder.Parent = Header

	self.LanguageDropdown =
		Dropdown.new(
			LangHolder,
			{
				Default = "Русский",

				Options = {
					{
						Text = "Русский",
						Value = "RU"
					},

					{
						Text = "English",
						Value = "EN"
					}
				},

				Callback = function(language)

					self.Language =
						language

					self:_refreshLanguage()

				end
			}
		)

	------------------------------------------------
	-- minimize
	------------------------------------------------

	local Minimize =
		Instance.new("TextButton")

	Minimize.Size =
		UDim2.fromOffset(36, 36)

	Minimize.Position =
		UDim2.new(
			1,
			-46,
			0,
			15
		)

	Minimize.BackgroundColor3 =
		theme.Surface

	Minimize.BorderSizePixel = 0

	Minimize.Text = "—"

	Minimize.TextColor3 =
		theme.TextSecondary

	Minimize.Font =
		Enum.Font.GothamBold

	Minimize.TextSize = 16

	Minimize.AutoButtonColor = false

	Minimize.Parent = Header

	corner(Minimize, 9)

	Minimize.MouseEnter:Connect(function()

		tween(
			Minimize,
			0.12,
			{
				BackgroundColor3 =
					theme.SurfaceHover
			}
		)

	end)

	Minimize.MouseLeave:Connect(function()

		tween(
			Minimize,
			0.12,
			{
				BackgroundColor3 =
					theme.Surface
			}
		)

	end)

	self.MinimizeButton = Minimize

	------------------------------------------------
	-- Sidebar
	------------------------------------------------

	local Sidebar =
		Instance.new("Frame")

	Sidebar.Size =
		UDim2.new(
			0,
			182,
			1,
			-66
		)

	Sidebar.Position =
		UDim2.fromOffset(
			0,
			66
		)

	Sidebar.BackgroundColor3 =
		theme.Sidebar

	Sidebar.BorderSizePixel = 0

	Sidebar.Parent = Main

	self.Sidebar = Sidebar

	local SidebarTitle =
		Instance.new("TextLabel")

	SidebarTitle.Size =
		UDim2.new(
			1,
			-30,
			0,
			24
		)

	SidebarTitle.Position =
		UDim2.fromOffset(
			18,
			18
		)

	SidebarTitle.BackgroundTransparency = 1

	SidebarTitle.Text = "MODULES"

	SidebarTitle.TextColor3 =
		theme.TextMuted

	SidebarTitle.Font =
		Enum.Font.GothamBold

	SidebarTitle.TextSize = 9

	SidebarTitle.TextXAlignment =
		Enum.TextXAlignment.Left

	SidebarTitle.Parent = Sidebar

	------------------------------------------------
	-- Utrlit Tab
	------------------------------------------------

	local Tab =
		Instance.new("TextButton")

	Tab.Size =
		UDim2.new(
			1,
			-20,
			0,
			48
		)

	Tab.Position =
		UDim2.fromOffset(
			10,
			53
		)

	Tab.BackgroundColor3 =
		theme.SurfaceActive

	Tab.BorderSizePixel = 0

	Tab.Text = ""

	Tab.AutoButtonColor = false

	Tab.Parent = Sidebar

	corner(Tab, 11)

	local ActiveLine =
		Instance.new("Frame")

	ActiveLine.Size =
		UDim2.fromOffset(
			3,
			28
		)

	ActiveLine.Position =
		UDim2.fromOffset(
			0,
			10
		)

	ActiveLine.BackgroundColor3 =
		theme.Accent

	ActiveLine.BorderSizePixel = 0

	ActiveLine.Parent = Tab

	corner(ActiveLine, 3)

	local TabIcon =
		Instance.new("TextLabel")

	TabIcon.Size =
		UDim2.fromOffset(
			32,
			48
		)

	TabIcon.Position =
		UDim2.fromOffset(
			12,
			0
		)

	TabIcon.BackgroundTransparency = 1

	TabIcon.Text = "◆"

	TabIcon.TextColor3 =
		theme.Accent

	TabIcon.Font =
		Enum.Font.GothamBold

	TabIcon.TextSize = 12

	TabIcon.Parent = Tab

	local TabText =
		Instance.new("TextLabel")

	TabText.Size =
		UDim2.new(
			1,
			-50,
			1,
			0
		)

	TabText.Position =
		UDim2.fromOffset(
			44,
			0
		)

	TabText.BackgroundTransparency = 1

	TabText.Text = "Utrlit"

	TabText.TextColor3 =
		theme.Text

	TabText.Font =
		Enum.Font.GothamSemibold

	TabText.TextSize = 12

	TabText.TextXAlignment =
		Enum.TextXAlignment.Left

	TabText.Parent = Tab

	self.TabText = TabText

	------------------------------------------------
	-- Content
	------------------------------------------------

	local Content =
		Instance.new("Frame")

	Content.Size =
		UDim2.new(
			1,
			-182,
			1,
			-66
		)

	Content.Position =
		UDim2.fromOffset(
			182,
			66
		)

	Content.BackgroundTransparency = 1

	Content.Parent = Main

	self.Content = Content

	------------------------------------------------
	-- Page header
	------------------------------------------------

	local PageTitle =
		Instance.new("TextLabel")

	PageTitle.Size =
		UDim2.new(
			1,
			-44,
			0,
			32
		)

	PageTitle.Position =
		UDim2.fromOffset(
			24,
			18
		)

	PageTitle.BackgroundTransparency = 1

	PageTitle.Text = "Utrlit"

	PageTitle.TextColor3 =
		theme.Text

	PageTitle.Font =
		Enum.Font.GothamBold

	PageTitle.TextSize = 21

	PageTitle.TextXAlignment =
		Enum.TextXAlignment.Left

	PageTitle.Parent = Content

	self.PageTitle = PageTitle

	local PageDescription =
		Instance.new("TextLabel")

	PageDescription.Size =
		UDim2.new(
			1,
			-44,
			0,
			22
		)

	PageDescription.Position =
		UDim2.fromOffset(
			24,
			50
		)

	PageDescription.BackgroundTransparency = 1

	PageDescription.Text =
		"Movement & world utilities"

	PageDescription.TextColor3 =
		theme.TextMuted

	PageDescription.Font =
		Enum.Font.Gotham

	PageDescription.TextSize = 10

	PageDescription.TextXAlignment =
		Enum.TextXAlignment.Left

	PageDescription.Parent = Content

	self.PageDescription =
		PageDescription

	------------------------------------------------
	-- Cards grid
	------------------------------------------------

	local Grid =
		Instance.new("Frame")

	Grid.Size =
		UDim2.new(
			1,
			-48,
			1,
			-96
		)

	Grid.Position =
		UDim2.fromOffset(
			24,
			82
		)

	Grid.BackgroundTransparency = 1

	Grid.Parent = Content

	self.Grid = Grid

	local GridLayout =
		Instance.new("UIGridLayout")

	GridLayout.CellSize =
		UDim2.new(
			0.5,
			-7,
			0,
			132
		)

	GridLayout.CellPadding =
		UDim2.fromOffset(
			14,
			14
		)

	GridLayout.SortOrder =
		Enum.SortOrder.LayoutOrder

	GridLayout.Parent = Grid

	------------------------------------------------
	-- dragging
	------------------------------------------------

	local dragging = false
	local dragStart
	local startPosition

	Header.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = true

			dragStart =
				input.Position

			startPosition =
				Main.Position

		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = false

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if
			dragging
			and input.UserInputType ==
			Enum.UserInputType.MouseMovement
		then

			local delta =
				input.Position - dragStart

			Main.Position =
				UDim2.new(
					startPosition.X.Scale,
					startPosition.X.Offset + delta.X,

					startPosition.Y.Scale,
					startPosition.Y.Offset + delta.Y
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

	------------------------------------------------
	-- minimize
	------------------------------------------------

	self.Minimized = false

	Minimize.MouseButton1Click:Connect(function()

		self.Minimized =
			not self.Minimized

		if self.Minimized then

			Content.Visible = false
			Sidebar.Visible = false

			tween(
				Main,
				0.2,
				{
					Size =
						UDim2.fromOffset(
							740,
							66
						)
				}
			)

			tween(
				Shadow,
				0.2,
				{
					Size =
						UDim2.fromOffset(
							754,
							80
						)
				}
			)

		else

			tween(
				Main,
				0.2,
				{
					Size =
						UDim2.fromOffset(
							740,
							490
						)
				}
			)

			tween(
				Shadow,
				0.2,
				{
					Size =
						UDim2.fromOffset(
							754,
							504
						)
				}
			)

			task.delay(
				0.1,
				function()

					Content.Visible = true
					Sidebar.Visible = true

				end
			)

		end

	end)

end

function Window:AddFeature(
	name,
	module,
	options
)

	options = options or {}

	self.Features[name] = {
		Module = module
	}

	local localization =
		self.Localization[
			self.Language
		]

	local Card =
		FeatureCard.new(
			self.Grid,
			{
				Name =
					localization[name]
					or name,

				Description =
					localization[
						name
						.. "Description"
					]
					or "",

				Hint =
					localization.RightClick
					or "RMB — settings",

				Theme =
					self.Config.Theme,

				Enabled =
					self.State[name]
					and
					self.State[name].Enabled
					or false,

				OnToggle = function(enabled)

					if self.State[name] then

						self.State[name].Enabled =
							enabled

					end

					local feature =
						self.Features[name]

					if feature then

						if enabled then

							if
								feature.Module.Enable
							then

								feature.Module.Enable(
									self.Context
								)

							end

						else

							if
								feature.Module.Disable
							then

								feature.Module.Disable(
									self.Context
								)

							end

						end

					end

				end,

				OnSettings =
					options.OnSettings
			}
		)

	self.Features[name].Card =
		Card

	return Card
end

function Window:_refreshLanguage()

	local text =
		self.Localization[
			self.Language
		]

	if not text then
		return
	end

	self.TabText.Text =
		text.Utrlit or "Utrlit"

	self.PageTitle.Text =
		text.Utrlit or "Utrlit"

	for name, data
		in pairs(self.Features)
	do

		if data.Card then

			data.Card:SetText(
				text[name] or name,
				text[
					name
					.. "Description"
				]
				or "",
				text.RightClick
					or "RMB — settings"
			)

		end

	end

end

function Window:Start()

	local Players =
		game:GetService("Players")

	local RunService =
		game:GetService("RunService")

	local player =
		Players.LocalPlayer

	local function updateCharacter()

		local character =
			player.Character
			or player.CharacterAdded:Wait()

		self.Context.Character =
			character

		self.Context.Humanoid =
			character:WaitForChild(
				"Humanoid"
			)

		self.Context.RootPart =
			character:WaitForChild(
				"HumanoidRootPart"
			)

	end

	self.Context = {

		Player = player,

		RunService =
			RunService,

		UserInputService =
			UserInputService,

		State =
			self.State,

		Character = nil,

		Humanoid = nil,

		RootPart = nil
	}

	updateCharacter()

	player.CharacterAdded:Connect(
		function()

			task.wait(0.2)

			updateCharacter()

		end
	)

end

return Window
