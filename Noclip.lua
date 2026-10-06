local Noclip = {}

local connection
local original = {}

function Noclip.Enable(context)

	if connection then
		connection:Disconnect()
	end

	connection =
		context.RunService.Stepped:Connect(
			function()

				local character =
					context.Character

				if not character then
					return
				end

				for _, object in ipairs(
					character:GetDescendants()
				) do

					if object:IsA("BasePart") then

						if original[object] == nil then

							original[object] =
								object.CanCollide

						end

						object.CanCollide = false

					end

				end

			end
		)

end

function Noclip.Disable()

	if connection then

		connection:Disconnect()
		connection = nil

	end

	for object, value in pairs(original) do

		if object and object.Parent then

			object.CanCollide = value

		end

	end

	table.clear(original)

end

return Noclip
