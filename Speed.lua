local Speed = {}

function Speed.Start(context)
	local humanoid = context.Humanoid
	local settings = context.Settings

	context.RunService:BindToRenderStep(
		"OrlandHub_Speed",
		Enum.RenderPriority.Character.Value + 1,
		function()
			if humanoid then
				humanoid.WalkSpeed =
					settings.Speed.Enabled and settings.Speed.Value or 16
			end
		end
	)
end

function Speed.Stop(context)
	context.RunService:UnbindFromRenderStep("OrlandHub_Speed")

	if context.Humanoid then
		context.Humanoid.WalkSpeed = 16
	end
end

return Speed
