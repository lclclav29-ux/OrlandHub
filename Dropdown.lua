local TweenService = game:GetService("TweenService")

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(parent, options)

	local self = setmetatable({}, Dropdown)

	self.Options = options.Options or {}
	self.Selected = options.Default
	self.Callback = options.Callback

	local Container = Instance.new("Frame")

	Container.Name = "Dropdown"
	Container.Size = UDim2.fromOffset(145, 38)

	Container.BackgroundTransparency = 1

	Container.ZIndex = 20
	Container.Parent = parent

	self.Container = Container

	--------------------------------

	local Main = Instance.new("TextButton")

	Main.Size = UDim2.fromScale(1, 1)

	Main.BackgroundColor3 =
		Color3.fromRGB(23, 25, 34)

	Main.Text = ""

	Main.AutoButtonColor = false

	Main.ZIndex = 21

	Main.Parent = Container

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(0, 9)

	Corner.Parent = Main

	--------------------------------

	local Text = Instance.new("TextLabel")

	Text.Size =
		UDim2.new(1, -42, 1, 0)

	Text.Position =
		UDim2.fromOffset(12, 0)

	Text.BackgroundTransparency = 1

	Text.Text =
		tostring(self.Selected)

	Text.TextColor3 =
		Color3.fromRGB(235, 236, 244)

	Text.Font =
		Enum.Font.GothamMedium

	Text.TextSize = 12

	Text.TextXAlignment =
		Enum.TextXAlignment.Left

	Text.ZIndex = 22

	Text.Parent = Main

	self.Text = Text

	--------------------------------

	local Arrow = Instance.new("TextLabel")

	Arrow.Size =
		UDim2.fromOffset(32, 38)

	Arrow.Position =
		UDim2.new(1, -36, 0, 0)

	Arrow.BackgroundTransparency = 1

	Arrow.Text = "⌄"

	Arrow.TextColor3 =
		Color3.fromRGB(145, 148, 162)

	Arrow.Font =
		Enum.Font.GothamBold

	Arrow.TextSize = 18

	Arrow.ZIndex = 22

	Arrow.Parent = Main

	self.Arrow = Arrow

	--------------------------------

	local List = Instance.new("Frame")

	List.Size =
		UDim2.new(1, 0, 0, 0)

	List.Position =
		UDim2.fromOffset(0, 44)

	List.BackgroundColor3 =
		Color3.fromRGB(17, 19, 27)

	List.BorderSizePixel = 0

	List.ClipsDescendants = true

	List.Visible = false

	List.ZIndex = 30

	List.Parent = Container

	self.List = List

	local ListCorner =
		Instance.new("UICorner")

	ListCorner.CornerRadius =
		UDim.new(0, 10)

	ListCorner.Parent = List

	local Layout =
		Instance.new("UIListLayout")

	Layout.Padding =
		UDim.new(0, 4)

	Layout.SortOrder =
		Enum.SortOrder.LayoutOrder

	Layout.Parent = List

	local Padding =
		Instance.new("UIPadding")

	Padding.PaddingTop =
		UDim.new(0, 6)

	Padding.PaddingBottom =
		UDim.new(0, 6)

	Padding.PaddingLeft =
		UDim.new(0, 6)

	Padding.PaddingRight =
		UDim.new(0, 6)

	Padding.Parent = List

	--------------------------------

	self.Opened = false

	for _, option in ipairs(self.Options) do

		local Item =
			Instance.new("TextButton")

		Item.Size =
			UDim2.new(1, 0, 0, 34)

		Item.BackgroundColor3 =
			Color3.fromRGB(24, 26, 36)

		Item.Text = option.Text

		Item.TextColor3 =
			Color3.fromRGB(230, 232, 240)

		Item.Font =
			Enum.Font.GothamMedium

		Item.TextSize = 11

		Item.AutoButtonColor = false

		Item.ZIndex = 31

		Item.Parent = List

		local ItemCorner =
			Instance.new("UICorner")

		ItemCorner.CornerRadius =
			UDim.new(0, 7)

		ItemCorner.Parent = Item

		Item.MouseEnter:Connect(function()

			TweenService:Create(

				Item,

				TweenInfo.new(0.12),

				{
					BackgroundColor3 =
						Color3.fromRGB(
							37,
							39,
							54
						)
				}

			):Play()

		end)

		Item.MouseLeave:Connect(function()

			TweenService:Create(

				Item,

				TweenInfo.new(0.12),

				{
					BackgroundColor3 =
						Color3.fromRGB(
							24,
							26,
							36
						)
				}

			):Play()

		end)

		Item.MouseButton1Click:Connect(function()

			self.Selected =
				option.Value

			self.Text.Text =
				option.Text

			self:SetOpen(false)

			if self.Callback then

				self.Callback(
					option.Value
				)

			end

		end)

	end

	Main.MouseButton1Click:Connect(function()

		self:SetOpen(
			not self.Opened
		)

	end)

	return self

end

function Dropdown:SetOpen(state)

	self.Opened = state

	if state then

		self.List.Visible = true

		local height =
			(#self.Options * 38) + 12

		TweenService:Create(

			self.List,

			TweenInfo.new(
				0.18,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out
			),

			{
				Size =
					UDim2.new(
						1,
						0,
						0,
						height
					)
			}

		):Play()

		TweenService:Create(

			self.Arrow,

			TweenInfo.new(0.18),

			{
				Rotation = 180
			}

		):Play()

	else

		TweenService:Create(

			self.List,

			TweenInfo.new(0.15),

			{
				Size =
					UDim2.new(
						1,
						0,
						0,
						0
					)
			}

		):Play()

		TweenService:Create(

			self.Arrow,

			TweenInfo.new(0.15),

			{
				Rotation = 0
			}

		):Play()

		task.delay(
			0.15,
			function()

				if not self.Opened then
					self.List.Visible = false
				end

			end
		)

	end

end

return Dropdown
