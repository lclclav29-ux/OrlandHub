local Speed = {}

local connection

function Speed.Enable(context)

	if connection then
		connection:Disconnect()
	end

	connection =
		context.RunService.RenderStepped:Connect(
			function()

				if context.Humanoid then

					context.Humanoid.WalkSpeed =
						context.State.Speed.Value

				end

			end
		)

end

function Speed.Disable(context)

	if connection then

		connection:Disconnect()
		connection = nil

	end

	if context.Humanoid then
		context.Humanoid.WalkSpeed = 16
	end

end

return Speed
