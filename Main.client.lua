local ReplicatedStorage =
	game:GetService("ReplicatedStorage")

local OrlandHub =
	ReplicatedStorage:WaitForChild(
		"OrlandHub"
	)

local Config =
	require(OrlandHub.Config)

local Localization =
	require(OrlandHub.Localization)

local Window =
	require(OrlandHub.UI.Window)

local Speed =
	require(OrlandHub.Features.Speed)

local Fly =
	require(OrlandHub.Features.Fly)

local Noclip =
	require(OrlandHub.Features.Noclip)

local XRay =
	require(OrlandHub.Features.XRay)

local Hub =
	Window.new({
		Name = "OrlandHub",
		Config = Config,
		Localization = Localization
	})

Hub:Start()

local SpeedCard =
	Hub:AddFeature(
		"Speed",
		Speed,
		{
			OnSettings = function(card)

				print(
					"Открываем настройки Speed"
				)

			end
		}
	)

SpeedCard:SetIcon("⚡")

local FlyCard =
	Hub:AddFeature(
		"Fly",
		Fly,
		{
			OnSettings = function()

				print(
					"Открываем настройки Fly"
				)

			end
		}
	)

FlyCard:SetIcon("▲")

local NoclipCard =
	Hub:AddFeature(
		"Noclip",
		Noclip
	)

NoclipCard:SetIcon("◇")

local XRayCard =
	Hub:AddFeature(
		"XRay",
		XRay,
		{
			OnSettings = function()

				print(
					"Открываем настройки XRay"
				)

			end
		}
	)

XRayCard:SetIcon("◉")
