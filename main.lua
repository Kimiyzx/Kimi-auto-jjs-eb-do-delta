if getgenv().jj_conns then
	for _, c in pairs(getgenv().jj_conns) do
		pcall(function() c:Disconnect() end)
	end
end
getgenv().jj_conns = {}
getgenv().jj_on = false

local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local vim = game:GetService("VirtualInputManager")
local lp = players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")
local poli = pg:WaitForChild("Polichinelos")
local screen = poli:WaitForChild("Screen")

local function press(key)
	vim:SendKeyEvent(true, key, false, game)
	task.wait(0.05 + math.random() * 0.05)
	vim:SendKeyEvent(false, key, false, game)
end

local function answer(btn)
	if not getgenv().jj_on then return end
	local lbl = btn:FindFirstChildWhichIsA("TextLabel")
	if not lbl then return end
	local t = lbl.Text
	local key = nil
	if t == "Q" then key = Enum.KeyCode.Q end
	if t == "E" then key = Enum.KeyCode.E end
	if not key then return end
	task.delay(0.35 + math.random() * 0.75, function()
		if not getgenv().jj_on then return end
		if not btn.Parent then return end
		if btn:GetAttribute("Completed") then return end
		press(key)
	end)
end

for _, ch in pairs(screen:GetChildren()) do
	if ch:IsA("ImageButton") then
		answer(ch)
	end
end

table.insert(getgenv().jj_conns, screen.ChildAdded:Connect(function(ch)
	if ch:IsA("ImageButton") then
		task.wait(0.1)
		answer(ch)
	end
end))

table.insert(getgenv().jj_conns, uis.InputBegan:Connect(function(inp, gpe)
	if gpe then return end
	if inp.KeyCode == Enum.KeyCode.H and not uis:GetFocusedTextBox() then
		getgenv().jj_on = not getgenv().jj_on
		print(getgenv().jj_on and "kimi auto jjs ON" or "kimi auto jjs OFF")
	end
end))

print("kimi auto jjs loaded, H liga/desliga")
