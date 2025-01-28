repeat task.wait() until game:IsLoaded() and game:GetService('Players').LocalPlayer.Character

local Player = game:GetService('Players').LocalPlayer
local TweenService = game:GetService('TweenService')
local TextService = game:GetService('TextChatService')

local UI = {}

function UI:GetCoreGui()
	local s, p = pcall(function()
		local ScreenGui = Instance.new('ScreenGui', game:GetService('CoreGui'))
	end)

	if not s then print('Failed to get CoreGui (no access)') end

	return not s and Player.PlayerGui or game:GetService('CoreGui')
end

function UI:CreateScreenGui()
	local ScreenGui = Instance.new('ScreenGui', UI:GetCoreGui())
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Name = tostring(math.random())

	return ScreenGui
end

local SG = UI:CreateScreenGui()

local MainFrame = Instance.new('Frame', SG)
MainFrame.Position = UDim2.fromScale(0.7, 0.6)
MainFrame.Size = UDim2.fromScale(0.13, 0.3)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
MainFrame.Active = true
MainFrame.Draggable = true

local Name = Instance.new('TextLabel', MainFrame)
Name.Size = UDim2.fromScale(1, 0.1)
Name.BackgroundTransparency = 0.9
Name.Text = '  Game Debugger'
Name.TextColor3 = Color3.fromRGB(255,255,255)
Name.TextXAlignment = Enum.TextXAlignment.Left

-- [[ MAIN INFO ]] --

local PlaceId = Instance.new('TextLabel', MainFrame)
PlaceId.Position = UDim2.fromScale(0, 0.11)
PlaceId.Size = UDim2.fromScale(1, 0.08)
PlaceId.Text = "  Place ID: " .. tostring(game.PlaceId)
PlaceId.TextColor3 = Color3.fromRGB(255,255,255)
PlaceId.TextXAlignment = Enum.TextXAlignment.Left
PlaceId.BackgroundTransparency = 1

local CreatorId = Instance.new('TextLabel', MainFrame)
CreatorId.Position = UDim2.fromScale(0, 0.19)
CreatorId.Size = UDim2.fromScale(1, 0.08)
CreatorId.Text = "  Creator ID: " .. tostring(game.CreatorId)
CreatorId.TextColor3 = Color3.fromRGB(255,255,255)
CreatorId.TextXAlignment = Enum.TextXAlignment.Left
CreatorId.BackgroundTransparency = 1

local ShowPlayerList = Instance.new('TextButton', MainFrame)
ShowPlayerList.Position = UDim2.fromScale(0, 0.27)
ShowPlayerList.Size = UDim2.fromScale(1, 0.08)
ShowPlayerList.Text = "  Show Player List"
ShowPlayerList.TextColor3 = Color3.fromRGB(255,255,255)
ShowPlayerList.TextXAlignment = Enum.TextXAlignment.Left
ShowPlayerList.BackgroundTransparency = 0.95
ShowPlayerList.BorderSizePixel = 0

local ShowChatLogs = Instance.new('TextButton', MainFrame)
ShowChatLogs.Position = UDim2.fromScale(0, 0.35)
ShowChatLogs.Size = UDim2.fromScale(1, 0.08)
ShowChatLogs.Text = "  Show Chat Logs"
ShowChatLogs.TextColor3 = Color3.fromRGB(255,255,255)
ShowChatLogs.TextXAlignment = Enum.TextXAlignment.Left
ShowChatLogs.BackgroundTransparency = 0.95
ShowChatLogs.BorderSizePixel = 0

local ChatBypassLoader = Instance.new('TextButton', MainFrame)
ChatBypassLoader.Position = UDim2.fromScale(0, 0.43)
ChatBypassLoader.Size = UDim2.fromScale(1, 0.08)
ChatBypassLoader.Text = "  Chat Bypasser"
ChatBypassLoader.TextColor3 = Color3.fromRGB(255,255,255)
ChatBypassLoader.TextXAlignment = Enum.TextXAlignment.Left
ChatBypassLoader.BackgroundTransparency = 0.95
ChatBypassLoader.BorderSizePixel = 0

-- [[ NEW TABS ]] --

-- Player List

local PlayerList = Instance.new('Frame', SG)
PlayerList.Position = UDim2.fromScale(1.1, 0.6)
PlayerList.Size = UDim2.fromScale(0.13, 0.3)
PlayerList.BorderSizePixel = 0
PlayerList.BackgroundColor3 = Color3.fromRGB(50,50,50)
PlayerList.Active = true
PlayerList.Draggable = true
PlayerList.AutomaticSize = Enum.AutomaticSize.Y
PlayerList.Visible = false

local PlayerName = Instance.new('TextLabel', PlayerList)
PlayerName.Size = UDim2.fromScale(1, 0.1)
PlayerName.BackgroundTransparency = 0.9
PlayerName.Text = '  Player List'
PlayerName.TextColor3 = Color3.fromRGB(255,255,255)
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.Name = "PlrName"

local ExitPlayerList = Instance.new('TextButton', PlayerList)
ExitPlayerList.Position = UDim2.fromScale(0.85, 0)
ExitPlayerList.Size = UDim2.fromScale(0.17, 0.1)
ExitPlayerList.Text = "X"
ExitPlayerList.TextColor3 = Color3.fromRGB(255,0,0)
ExitPlayerList.BackgroundTransparency = 1
ExitPlayerList.Name = "X"

ShowPlayerList.MouseButton1Down:Connect(function()
	print("Currently unavailable due to issues.")
	if PlayerList.Position == UDim2.fromScale(1.1, 0.6) then
		TweenService:Create(PlayerList, TweenInfo.new(0.35), {
			Position = UDim2.fromScale(0.84, 0.6)
		}):Play()
	end
end)

ExitPlayerList.MouseButton1Down:Connect(function()
	TweenService:Create(PlayerList, TweenInfo.new(0.35), {
		Position = UDim2.fromScale(1.1, 0.6)
	}):Play()
end)

local Start = 0.11

function addPlayerToList(Players)
	if Players.Name == nil then
		return
	end

	local NewPlayer = Instance.new('TextLabel', PlayerList)
	NewPlayer.Position = UDim2.fromScale(0, Start)
	NewPlayer.Size = UDim2.fromScale(1, 0.08)
	NewPlayer.Text = "  ".. Players.Name
	NewPlayer.TextColor3 = Color3.fromRGB(255,255,255)
	NewPlayer.TextXAlignment = Enum.TextXAlignment.Left
	NewPlayer.BackgroundTransparency = 1
	NewPlayer.Name = Players.Name

	if Players.DisplayName ~= Players.Name then
		NewPlayer.Text = "  ".. Players.DisplayName .. " ["..Players.Name.."]"
	end

	Start += 0.08
end

for _, Players in game:GetService('Players'):GetPlayers() do
	addPlayerToList(Players)
end

-- Chat Logs

local ChatLogs = Instance.new('Frame', SG)
ChatLogs.Position = UDim2.fromScale(1.1, 0.6)
ChatLogs.Size = UDim2.fromScale(0.13, 0.3)
ChatLogs.BorderSizePixel = 0
ChatLogs.BackgroundColor3 = Color3.fromRGB(50,50,50)
ChatLogs.Active = true
ChatLogs.Draggable = true
ChatLogs.AutomaticSize = Enum.AutomaticSize.Y

local Chats = Instance.new('ScrollingFrame', ChatLogs)
Chats.Position = UDim2.fromScale(0, 0.1)
Chats.Size = UDim2.fromScale(1, 0.9)
Chats.ScrollBarThickness = 5
Chats.BackgroundTransparency = 1

local ChatLogsName = Instance.new('TextLabel', ChatLogs)
ChatLogsName.Size = UDim2.fromScale(1, 0.1)
ChatLogsName.BackgroundTransparency = 0.9
ChatLogsName.Text = '  Chat Logs'
ChatLogsName.TextColor3 = Color3.fromRGB(255,255,255)
ChatLogsName.TextXAlignment = Enum.TextXAlignment.Left

local ExitChatLogs = Instance.new('TextButton', ChatLogs)
ExitChatLogs.Position = UDim2.fromScale(0.85, 0)
ExitChatLogs.Size = UDim2.fromScale(0.17, 0.1)
ExitChatLogs.Text = "X"
ExitChatLogs.TextColor3 = Color3.fromRGB(255,0,0)
ExitChatLogs.BackgroundTransparency = 1

ShowChatLogs.MouseButton1Down:Connect(function()
	if ChatLogs.Position == UDim2.fromScale(1.1, 0.6) then
		TweenService:Create(ChatLogs, TweenInfo.new(0.35), {
			Position = UDim2.fromScale(0.84, 0.6)
		}):Play()
	end
end)

ExitChatLogs.MouseButton1Down:Connect(function()
	TweenService:Create(ChatLogs, TweenInfo.new(0.35), {
		Position = UDim2.fromScale(1.1, 0.6)
	}):Play()
end)

local Start2 = 0
local lastMessageTick = tick()

function addChatToFrame(Message : TextChatMessage)
	if #Chats:GetChildren() > 12 then
		for i,v in Chats:GetChildren() do
			v:Remove()
		end
		Start2 = 0
	end

	local NewChat = Instance.new('TextLabel', Chats)
	NewChat.Position = UDim2.fromScale(0, Start2)
	NewChat.Size = UDim2.fromScale(1, 0.08)
	NewChat.Text = "  ["..Message.TextSource.Name.."]: "..Message.Text
	NewChat.TextColor3 = Color3.fromRGB(255,255,255)
	NewChat.TextXAlignment = Enum.TextXAlignment.Left
	NewChat.BackgroundTransparency = 1
	NewChat.TextWrapped = true

	Start2 += 0.08
end

TextService.OnIncomingMessage = function(MSG)
	if (tick() - lastMessageTick) > 0.05 then
		addChatToFrame(MSG)
	end

	lastMessageTick = tick()
end

-- Chat Bypass

local ChatBypassFrame = Instance.new('Frame', SG)
ChatBypassFrame.Position = UDim2.fromScale(1.1, 0.6)
ChatBypassFrame.Size = UDim2.fromScale(0.13, 0.3)
ChatBypassFrame.BorderSizePixel = 0
ChatBypassFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
ChatBypassFrame.Active = true
ChatBypassFrame.Draggable = true

local ChatBypassName = Instance.new('TextLabel', ChatBypassFrame)
ChatBypassName.Size = UDim2.fromScale(1, 0.1)
ChatBypassName.BackgroundTransparency = 0.9
ChatBypassName.Text = '  Chat Bypass'
ChatBypassName.TextColor3 = Color3.fromRGB(255,255,255)
ChatBypassName.TextXAlignment = Enum.TextXAlignment.Left

local ExitChatBypass = Instance.new('TextButton', ChatBypassFrame)
ExitChatBypass.Position = UDim2.fromScale(0.85, 0)
ExitChatBypass.Size = UDim2.fromScale(0.17, 0.1)
ExitChatBypass.Text = "X"
ExitChatBypass.TextColor3 = Color3.fromRGB(255,0,0)
ExitChatBypass.BackgroundTransparency = 1

ChatBypassLoader.MouseButton1Down:Connect(function()
	if ChatBypassFrame.Position == UDim2.fromScale(1.1, 0.6) then
		TweenService:Create(ChatBypassFrame, TweenInfo.new(0.35), {
			Position = UDim2.fromScale(0.84, 0.6)
		}):Play()
	end
end)

ExitChatBypass.MouseButton1Down:Connect(function()
	TweenService:Create(ChatBypassFrame, TweenInfo.new(0.35), {
		Position = UDim2.fromScale(1.1, 0.6)
	}):Play()
end)

local TextToBypass = Instance.new('TextBox', ChatBypassFrame)
TextToBypass.Position = UDim2.fromScale(0, 0.1)
TextToBypass.Size = UDim2.fromScale(1, 0.9)
TextToBypass.TextXAlignment = Enum.TextXAlignment.Left
TextToBypass.TextYAlignment = Enum.TextYAlignment.Top
TextToBypass.TextWrapped = true
TextToBypass.TextColor3 = Color3.fromRGB(255,255,255)
TextToBypass.BackgroundTransparency = 1

TextToBypass.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local Message = TextToBypass.Text:lower()
		
		Message = Message:gsub("a", "ȧ")
		Message = Message:gsub("b", "ḃ")
		Message = Message:gsub("c", "ċ")
		Message = Message:gsub("d", "ḋ")
		Message = Message:gsub("g", "ǥ")
		Message = Message:gsub("e", "ḗ")
		Message = Message:gsub("i", "ǐ")
		Message = Message:gsub("n", "ṇ")
		Message = Message:gsub("u", "ȗ")
		Message = Message:gsub("k", "ǩ")
		Message = Message:gsub("f", "ḟ")
		
		pcall(function()
			TextService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(Message)
		end)
		pcall(function()
			game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, "All")
		end)
	end
end)
