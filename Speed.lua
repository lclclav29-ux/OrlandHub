local UserInputService =
	game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

function Slider.new(parent, options)

	local self =
		setmetatable({}, Slider)

	self.Min =
		options.Min or 0

	self.Max =
		options.Max or 100

	self.Value =
		options.Default or self.Min

	self.Callback =
		options.Callback

	--------------------------------

	local Container =
		Instance.new("Frame")

	Container.Size =
		UDim2.new(1, 0, 0, 58)

	Container.BackgroundTransparency = 1

	Container.Parent = parent

	--------------------------------

	local Label =
		Instance.new("TextLabel")

	Label.Size =
		UDim2.new(0.7, 0, 0, 20)

	Label.BackgroundTransparency = 1

	Label.Text =
		options.Text or "Slider"

	Label.TextColor3 =
		Color3.fromRGB(220, 222, 230)

	Label.Font =
		Enum.Font.GothamMedium

	Label.TextSize = 11

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent = Container

	--------------------------------

	local ValueText =
		Instance.new("TextLabel")

	ValueText.Size =
		UDim2.new(0.3, 0, 0, 20)

	ValueText.Position =
		UDim2.new(0.7, 0, 0, 0)

	ValueText.BackgroundTransparency = 1

	ValueText.Text =
		tostring(self.Value)

	ValueText.TextColor3 =
		Color3.fromRGB(150, 132, 255)

	ValueText.Font =
		Enum.Font.GothamBold

	ValueText.TextSize = 11

	ValueText.TextXAlignment =
		Enum.TextXAlignment.Right

	ValueText.Parent = Container

	self.ValueText = ValueText

	--------------------------------

	local Bar =
		Instance.new("Frame")

	Bar.Size =
		UDim2.new(1, 0, 0, 5)

	Bar.Position =
		UDim2.fromOffset(0, 37)

	Bar.BackgroundColor3 =
		Color3.fromRGB(35, 37, 48)

	Bar.BorderSizePixel = 0

	Bar.Parent = Container

	local Corner =
		Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(1, 0)

	Corner.Parent = Bar

	--------------------------------

	local Fill =
		Instance.new("Frame")

	Fill.Size =
		UDim2.fromScale(
			(self.Value - self.Min) /
			(self.Max - self.Min),
			1
		)

	Fill.BackgroundColor3 =
		Color3.fromRGB(112, 82, 255)

	Fill.BorderSizePixel = 0

	Fill.Parent = Bar

	local FillCorner =
		Instance.new("UICorner")

	FillCorner.CornerRadius =
		UDim.new(1, 0)

	FillCorner.Parent = Fill

	self.Fill = Fill

	--------------------------------

	local Knob =
		Instance.new("Frame")

	Knob.Size =
		UDim2.fromOffset(14, 14)

	Knob.AnchorPoint =
		Vector2.new(0.5, 0.5)

	Knob.Position =
		UDim2.new(
			Fill.Size.X.Scale,
			0,
			0.5,
			0
		)

	Knob.BackgroundColor3 =
		Color3.fromRGB(
			245,
			245,
			250
		)

	Knob.BorderSizePixel = 0

	Knob.Parent = Bar

	local KnobCorner =
		Instance.new("UICorner")

	KnobCorner.CornerRadius =
		UDim.new(1, 0)

	KnobCorner.Parent = Knob

	self.Knob = Knob

	--------------------------------

	local dragging = false

	local function update(input)

		local relative =
			math.clamp(

				(
					input.Position.X -
					Bar.AbsolutePosition.X
				)
				/
				Bar.AbsoluteSize.X,

				0,
				1
			)

		local value =
			self.Min +
			(self.Max - self.Min)
			* relative

		value =
			math.floor(value + 0.5)

		self.Value = value

		ValueText.Text =
			tostring(value)

		Fill.Size =
			UDim2.fromScale(
				relative,
				1
			)

		Knob.Position =
			UDim2.new(
				relative,
				0,
				0.5,
				0
			)

		if self.Callback then

			self.Callback(value)

		end

	end

	Bar.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = true
			update(input)

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if dragging
			and input.UserInputType ==
			Enum.UserInputType.MouseMovement then

			update(input)

		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			dragging = false

		end

	end)

	return self

end

return Slider
