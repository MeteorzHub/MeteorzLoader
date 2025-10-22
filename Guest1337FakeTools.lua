--// 🧠 Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// 🎮 Window Setup
local Window = Rayfield:CreateWindow({
	Name = "Forsaken Hub ⚙️",
	LoadingTitle = "Fake Tools",
	LoadingSubtitle = "Made by Meteorz 💫",
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = true,
		Invite = "V3SCUfsEym", -- Your Discord invite code
		RememberJoins = true
	},
	KeySystem = false,
})

--// 👑 Credits Tab
local CreditsTab = Window:CreateTab("👑 Credits", "star")
CreditsTab:CreateLabel("Forsaken Hub - Made by Meteorz ⚡")
CreditsTab:CreateLabel("Discord Server: https://discord.gg/V3SCUfsEym")

--// 🧰 Fake Tools Tab
local ToolsTab = Window:CreateTab("🧰 Fake Tools", "hammer")

--// Variables
local player = game.Players.LocalPlayer
local Loaded = false
local ShouldReload = false

--// 🧤 Function: Load Fake Tools
local function loadGuest1337()
	if Loaded then return end
	Loaded = true
	Rayfield:Notify({
		Title = "Forsaken Hub",
		Content = "Loading Fake Tools 🧤",
		Duration = 3
	})
	task.wait(0.3)
	local success, err = pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/MeteorzHub/Guest1337Loader/refs/heads/main/Guest1337Loader"))()
	end)
	if not success then
		warn("[ForsakenHub] Failed:", err)
		Rayfield:Notify({
			Title = "Forsaken Hub",
			Content = "❌ Failed to load Fake Tools.",
			Duration = 3
		})
		Loaded = false
	end
end

--// 🧹 Function: Unload Fake Tools
local function unloadGuest1337()
	if not Loaded then return end
	Loaded = false
	Rayfield:Notify({
		Title = "Forsaken Hub",
		Content = "Unloading Fake Tools 🧹",
		Duration = 3
	})

	local pgui = player:FindFirstChild("PlayerGui")
	if pgui then
		local gui = pgui:FindFirstChild("FakeMovesGui")
		if gui then
			gui:Destroy()
			print("[ForsakenHub] FakeMovesGui removed.")
		end
	end
end

--// ⚙️ Toggle
local GuestToggle
GuestToggle = ToolsTab:CreateToggle({
	Name = "Fake Tools 🧤",
	CurrentValue = false,
	Flag = "ForsakenFakeTools",
	Callback = function(Value)
		if Value then
			ShouldReload = true
			loadGuest1337()
		else
			ShouldReload = false
			unloadGuest1337()
		end
	end,
})

--// ♻️ Auto Reload on Respawn
player.CharacterAdded:Connect(function()
	if ShouldReload then
		task.wait(3) -- wait for PlayerGui to reload
		loadGuest1337()
	end
end)

--// 🧩 Keep UI Synced
task.spawn(function()
	while task.wait(2) do
		if not Loaded and GuestToggle.CurrentValue then
			GuestToggle:Set(false)
		end
	end
end)
