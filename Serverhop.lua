local HttpService, TeleportService = game.GetService(game, "HttpService"), game.GetService(game, "TeleportService");
local JSONDecode, TeleportToPlaceInstance, format = HttpService.JSONDecode, TeleportService.TeleportToPlaceInstance, string.format;
local OtherServers = JSONDecode(HttpService, game.HttpGet(game, format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", tostring(game.PlaceId))))["data"];
local JobId, PlaceId = game.JobId, game.PlaceId;

function Serverhop()
    task.wait()
    
    for Index, Server in next, OtherServers do 
        if JobId ~= Server.id then 
            if Server.ping < 100 and Server.maxPlayers ~= Server.playing then 
                TeleportToPlaceInstance(TeleportService, PlaceId, Server.id);
                break 
            end
        end
    end
end; Serverhop()
