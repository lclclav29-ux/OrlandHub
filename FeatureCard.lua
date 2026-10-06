local TweenService =
	game:GetService("TweenService")

local FeatureCard = {}
FeatureCard.__index = FeatureCard

local function corner(object, radius)

	local c =
		Instance.new("UICorner")

	c.CornerRadius =
		UDim.new(0, radius)

	c.Parent = object

	return c

end

local function stroke(
	object,
	color,
	transparency,
	thickness
)

	local s =
		Instance.new("UIStroke")

	s.Color =
		color

	s.Transparency =
		transparency or 0

	s.Thickness =
		thickness or 1

	s.Parent =
		object

	return s

end

local function tween(
	object,
	duration,
	properties
)

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

function FeatureCard.new(
	parent,
	options
)

	local self =
		setmetatable(
			{},
			FeatureCard
		)

	self.Theme =
		options.Theme

	self.Enabled =
		options.Enabled or false

	self.OnToggle =
		options.OnToggle

	self.OnSettings =
		options.OnSettings

	local theme =
		self.Theme

	------------------------------------------------
	-- main card
	------------------------------------------------

	local Card =
		Instance.new("TextButton")

	Card.BackgroundColor3 =
		theme.Surface

	Card.BorderSizePixel = 0

	Card.AutoButtonColor = false

	Card.Text = ""

	Card.Parent = parent

	corner(Card, 13)

	local CardStroke =
		stroke(
			Card,
			theme.Border,
			0.72,
			1
		)

	self.Card =
		Card

	self.CardStroke =
		CardStroke

	------------------------------------------------
	-- subtle gradient
	------------------------------------------------

	local Gradient =
		Instance.new("UIGradient")

	Gradient.Color =
		ColorSequence.new({
			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(
					24,
					25,
					34
				)
			),

			ColorSequenceKeypoint.new(
				1,
				theme.Surface
			)
		})

	Gradient.Rotation = 125

	Gradient.Parent =
		Card

	------------------------------------------------
	-- icon
	------------------------------------------------

	local IconHolder =
		Instance.new("Frame")

	IconHolder.Size =
		UDim2.fromOffset(
			38,
			38
		)

	IconHolder.Position =
		UDim2.fromOffset(
			14,
			14
		)

	IconHolder.BackgroundColor3 =
		theme.SurfaceActive

	IconHolder.BorderSizePixel = 0

	IconHolder.Parent =
		Card

	corner(
		IconHolder,
		10
	)

	local Icon =
		Instance.new("TextLabel")

	Icon.Size =
		UDim2.fromScale(
			1,
			1
		)

	Icon.BackgroundTransparency = 1

	Icon.Text = "◆"

	Icon.TextColor3 =
		theme.Accent

	Icon.Font =
		Enum.Font.GothamBold

	Icon.TextSize = 13

	Icon.Parent =
		IconHolder

	self.IconHolder =
		IconHolder

	self.Icon =
		Icon

	------------------------------------------------
	-- title
	------------------------------------------------

	local Title =
		Instance.new("TextLabel")

	Title.Size =
		UDim2.new(
			1,
			-78,
			0,
			25
		)

	Title.Position =
		UDim2.fromOffset(
			62,
			12
		)

	Title.BackgroundTransparency = 1

	Title.Text =
		options.Name or "Feature"

	Title.TextColor3 =
		theme.Text

	Title.Font =
		Enum.Font.GothamSemibold

	Title.TextSize = 13

	Title.TextXAlignment =
		Enum.TextXAlignment.Left

	Title.Parent =
		Card

	self.Title =
		Title

	------------------------------------------------
	-- status
	------------------------------------------------

	local Status =
		Instance.new("TextLabel")

	Status.Size =
		UDim2.fromOffset(
			58,
			18
		)

	Status.Position =
		UDim2.new(
			1,
			-72,
			0,
			38
		)

	Status.BackgroundTransparency = 1

	Status.Font =
		Enum.Font.GothamBold

	Status.TextSize = 8

	Status.TextXAlignment =
		Enum.TextXAlignment.Right

	Status.Parent =
		Card

	self.Status =
		Status

	------------------------------------------------
	-- description
	------------------------------------------------

	local Description =
		Instance.new("TextLabel")

	Description.Size =
		UDim2.new(
			1,
			-28,
			0,
			32
		)

	Description.Position =
		UDim2.fromOffset(
			14,
			60
		)

	Description.BackgroundTransparency = 1

	Description.Text =
		options.Description
		or ""

	Description.TextColor3 =
		theme.TextSecondary

	Description.Font =
		Enum.Font.Gotham

	Description.TextSize = 10

	Description.TextWrapped = true

	Description.TextXAlignment =
		Enum.TextXAlignment.Left

	Description.TextYAlignment =
		Enum.TextYAlignment.Top

	Description.Parent =
		Card

	self.Description =
		Description

	------------------------------------------------
	-- bottom line
	------------------------------------------------

	local BottomLine =
		Instance.new("Frame")

	BottomLine.Size =
		UDim2.new(
			1,
			-28,
			0,
			1
		)

	BottomLine.Position =
		UDim2.new(
			0,
			14,
			1,
			-34
		)

	BottomLine.BackgroundColor3 =
		theme.Border

	BottomLine.BackgroundTransparency =
		0.76

	BottomLine.BorderSizePixel = 0

	BottomLine.Parent =
		Card

	------------------------------------------------
	-- RMB hint
	------------------------------------------------

	local Hint =
		Instance.new("TextLabel")

	Hint.Size =
		UDim2.new(
			1,
			-90,
			0,
			24
		)

	Hint.Position =
		UDim2.new(
			0,
			14,
			1,
			-30
		)

	Hint.BackgroundTransparency = 1

	Hint.Text =
		options.Hint
		or "RMB — settings"

	Hint.TextColor3 =
		theme.TextMuted

	Hint.Font =
		Enum.Font.Gotham

	Hint.TextSize = 9

	Hint.TextXAlignment =
		Enum.TextXAlignment.Left

	Hint.Parent =
		Card

	self.Hint =
		Hint

	------------------------------------------------
	-- toggle
	------------------------------------------------

	local Toggle =
		Instance.new("Frame")

	Toggle.Size =
		UDim2.fromOffset(
			42,
			22
		)

	Toggle.Position =
		UDim2.new(
			1,
			-56,
			1,
			-29
		)

	Toggle.BackgroundColor3 =
		Color3.fromRGB(
			40,
			42,
			53
		)

	Toggle.BorderSizePixel = 0

	Toggle.Parent =
		Card

	corner(
		Toggle,
		11
	)

	local Knob =
		Instance.new("Frame")

	Knob.Size =
		UDim2.fromOffset(
			16,
			16
		)

	Knob.Position =
		UDim2.fromOffset(
			3,
			3
		)

	Knob.BackgroundColor3 =
		Color3.fromRGB(
			137,
			141,
			154
		)

	Knob.BorderSizePixel = 0

	Knob.Parent =
		Toggle

	corner(
		Knob,
		8
	)

	self.Toggle =
		Toggle

	self.Knob =
		Knob

	------------------------------------------------
	-- update
	------------------------------------------------

	function self:SetEnabled(enabled)

		self.Enabled =
			enabled

		if enabled then

			tween(
				Toggle,
				0.16,
				{
					BackgroundColor3 =
						theme.Accent
				}
			)

			tween(
				Knob,
				0.16,
				{
					Position =
						UDim2.fromOffset(
							23,
							3
						),

					BackgroundColor3 =
						Color3.fromRGB(
							255,
							255,
							255
						)
				}
			)

			tween(
				IconHolder,
				0.16,
				{
					BackgroundColor3 =
						theme.Accent
				}
			)

			tween(
				Icon,
				0.16,
				{
					TextColor3 =
						Color3.fromRGB(
							255,
							255,
							255
						)
				}
			)

			CardStroke.Color =
				theme.Accent

			CardStroke.Transparency =
				0.48

			Status.Text =
				"ACTIVE"

			Status.TextColor3 =
				theme.Success

		else

			tween(
				Toggle,
				0.16,
				{
					BackgroundColor3 =
						Color3.fromRGB(
							40,
							42,
							53
						)
				}
			)

			tween(
				Knob,
				0.16,
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

			tween(
				IconHolder,
				0.16,
				{
					BackgroundColor3 =
						theme.SurfaceActive
				}
			)

			tween(
				Icon,
				0.16,
				{
					TextColor3 =
						theme.Accent
				}
			)

			CardStroke.Color =
				theme.Border

			CardStroke.Transparency =
				0.72

			Status.Text =
				"OFF"

			Status.TextColor3 =
				theme.TextMuted

		end

	end

	self:SetEnabled(
		self.Enabled
	)

	------------------------------------------------
	-- hover
	------------------------------------------------

	Card.MouseEnter:Connect(
		function()

			tween(
				Card,
				0.14,
				{
					BackgroundColor3 =
						theme.SurfaceHover
				}
			)

			tween(
				IconHolder,
				0.14,
				{
					Size =
						UDim2.fromOffset(
							41,
							41
						)
				}
			)

		end
	)

	Card.MouseLeave:Connect(
		function()

			tween(
				Card,
				0.14,
				{
					BackgroundColor3 =
						theme.Surface
				}
			)

			tween(
				IconHolder,
				0.14,
				{
					Size =
						UDim2.fromOffset(
							38,
							38
						)
				}
			)

		end
	)

	------------------------------------------------
	-- left click toggle
	------------------------------------------------

	Card.MouseButton1Click:Connect(
		function()

			self:SetEnabled(
				not self.Enabled
			)

			if self.OnToggle then

				self.OnToggle(
					self.Enabled
				)

			end

		end
	)

	------------------------------------------------
	-- right click settings
	------------------------------------------------

	Card.InputBegan:Connect(
		function(input)

			if
				input.UserInputType ==
				Enum.UserInputType.MouseButton2
			then

				if self.OnSettings then

					self.OnSettings(
						self
					)

				end

			end

		end
	)

	return self

end

function FeatureCard:SetText(
	title,
	description,
	hint
)

	if title then
		self.Title.Text = title
	end

	if description then
		self.Description.Text =
			description
	end

	if hint then
		self.Hint.Text = hint
	end

end

function FeatureCard:SetIcon(icon)

	self.Icon.Text =
		icon

end

return FeatureCard
