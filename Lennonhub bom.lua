--// LENON HUB - Roblox Studio
--// Coloque como LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "LenonHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(310, 300)
main.Position = UDim2.new(0.5, -155, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "LENON HUB"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 26
title.Font = Enum.Font.GothamBold
title.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 40)
status.Position = UDim2.fromOffset(10, 55)
status.BackgroundTransparency = 1
status.Text = "Melhor ovo: nenhum"
status.TextColor3 = Color3.fromRGB(190,190,190)
status.TextSize = 15
status.Font = Enum.Font.Gotham
status.Parent = main

local function button(text, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -30, 0, 45)
	b.Position = UDim2.fromOffset(15, y)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 16
	b.Font = Enum.Font.GothamSemibold
	b.Parent = main

	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)

	return b
end

-- Prioridade: Secreto > Eterno > Divino
local prioridade = {
	Secreto = 3,
	Eterno = 2,
	Divino = 1
}

local function melhorOvo()
	local pasta = workspace:FindFirstChild("Ovos")

	if not pasta then
		return nil
	end

	local escolhido
	local maior = 0

	for _, ovo in ipairs(pasta:GetChildren()) do
		local raridade = ovo:GetAttribute("Raridade")

		if raridade and prioridade[raridade] then
			if prioridade[raridade] > maior then
				maior = prioridade[raridade]
				escolhido = ovo
			end
		end
	end

	return escolhido
end

local function teleportarParaOvo(ovo)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")

	if not root or not ovo then
		return
	end

	local destino

	if ovo:IsA("BasePart") then
		destino = ovo
	elseif ovo:IsA("Model") then
		destino = ovo.PrimaryPart or ovo:FindFirstChildWhichIsA("BasePart")
	end

	if destino then
		root.CFrame = destino.CFrame + Vector3.new(0, 4, 0)
	end
end

local detectar = button("🔎 DETECTAR MELHOR OVO", 100)

detectar.MouseButton1Click:Connect(function()
	local ovo = melhorOvo()

	if ovo then
		local raridade = ovo:GetAttribute("Raridade")
		status.Text = "🥚 " .. ovo.Name .. " | " .. raridade
	else
		status.Text = "Nenhum Divino, Eterno ou Secreto encontrado."
	end
end)

local tp = button("⚡ TP INSTANTÂNEO", 155)

tp.MouseButton1Click:Connect(function()
	local ovo = melhorOvo()

	if ovo then
		teleportarParaOvo(ovo)
		status.Text = "⚡ Teleportado: " .. ovo.Name
	else
		status.Text = "Nenhum ovo prioritário encontrado."
	end
end)

local fechar = button("✕ FECHAR", 210)

fechar.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)
