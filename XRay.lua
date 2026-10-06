local XRay = {}

local connection
local modified = {}

function XRay.Enable(context)

	if connection then
		connection:Disconnect()
	end

	connection =
		context.RunService.RenderStepped:Connect(
			function()

				for _, object in ipairs(
					workspace:GetDescendants()
				) do

					if object:IsA("BasePart") then

						if not context.Character
							or not object:IsDescendantOf(
								context.Character
							) then

							if modified[object] == nil then

								modified[object] =
									object.LocalTransparencyModifier

							end

							object.LocalTransparencyModifier =
								context.State.XRay.Value

						end

					end

				end

			end
		)

end

function XRay.Disable()

	if connection then

		connection:Disconnect()
		connection = nil

	end

	for object, value in pairs(modified) do

		if object and object.Parent then

			object.LocalTransparencyModifier =
				value

		end

	end

	table.clear(modified)

end

return XRay
