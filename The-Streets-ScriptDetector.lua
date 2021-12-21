-- init 
local Loaded = game.Loaded

if not game.IsLoaded(game) then 
    Loaded.Wait(Loaded)
end

local assert = function(case)
    if not case then 
        return error(debug.traceback());
    end
end

local notification_source = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/xaxaxaxaxaxaxaxaxa/Libraries/main/Notifications/Source.lua", true))();
notification_source.configuration = {
    FadeInTime = 0.25, -- The time it takes for the notification elements to fade into your visibility when you call the Notify function
    FadeOutTime = 0.3, -- The time it takes for the notification elements to fade out once the notification is over
    
    Font = "Code", -- The font of all the text in the notification, https://developer.roblox.com/en-us/api-reference/enum/Font
    MainColor = Color3.fromRGB(170, 0, 255), -- The main color of the notification frame, https://www.rapidtables.com/web/color/RGB_Color.html
    BackgroundColor = Color3.fromRGB(27, 27, 27), -- The background color of the notification frame, https://www.rapidtables.com/web/color/RGB_Color.html
}; local notification_library = notification_source.importmodule();

-- variables
local Players = game.GetService(game, "Players");
local GetPlayers = Players.GetPlayers(Players);
local Connect, NewInstance = Loaded.Connect, Instance.new;

local upper, find, format = string.upper, string.find, string.format;
local CyAdminUsers, CiazwareUsers, CitizenUsers, DrPoppaUsers = {}, {}, {}, {};

-- functions
function PlaySound(Id)
    assert((Id or (type(Id) == "number" or type(Id) == "string")));
    
    local Sound = NewInstance("Sound", workspace)
    Sound.SoundId = format("rbxassetid://%s", ((type(Id) == "number" and tostring(Id)) or (type(Id) == "string" and Id)));
    Sound.Volume = 1
    Sound.Play(Sound)
end

function Notify(Description)
    assert((Description or type(Description) == "string"));
    
    PlaySound("578970639");
    notification_library.Notify("xaxa's script detector", Description, 7, notification_source.configuration)
end

function IdentifyPlayersScript(Player)
	assert((Player or typeof(Player) == "Instance"));
	
	local CyAdminMessages = {"Hey I'm a cyrus' streets admin user1", "I am a CyAdmin User", "Cyrus is my god"};
	local CiazwareMessages, DrPoppaMessage = {"Citizen Man", "Ciazware Man"}, "D|U"

	local ChattedEvent = nil
	ChattedEvent = Connect(Player.Chatted, function(Message)
		if table.find(CyAdminMessages, Message) then  
			Notify(format("%s\n is using CyAdmin", Player.Name));
			warn(format("%s is using CyAdmin", Player.Name));
			
			
			CyAdminUsers[#CyAdminUsers + 1] = Player
			ChattedEvent.Disconnect(ChattedEvent)
		elseif Message == CiazwareMessages[1] then 
			Notify(format("%s\n is using Citizen", Player.Name));
			warn(format("%s is using Citizen", Player.Name));
			
			CitizenUsers[#CitizenUsers + 1] = Player
			ChattedEvent.Disconnect(ChattedEvent)
		elseif Message == CiazwareMessages[2] then 
			Notify(format("%s\n is using Ciazware", Player.Name));
			warn(format("%s is using Ciazware", Player.Name));
			
			CiazwareUsers[#CiazwareUsers + 1] = Player
			ChattedEvent.Disconnect(ChattedEvent)
		elseif find(upper(Message), DrPoppaMessage) then 
			Notify(format("%s\n is using DrPoppa", Player.Name));
			warn(format("%s is using DrPoppa", Player.Name));
			
			DrPoppaUsers[#DrPoppaUsers + 1] = Player 
			ChattedEvent.Disconnect(ChattedEvent)
		end
	end)
end

for Index, Player in next, GetPlayers do
    IdentifyPlayersScript(Player);
end; Connect(Players.PlayerAdded, IdentifyPlayersScript);
