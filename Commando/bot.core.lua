RunScript("bot.extensions.lua");

bot = {};
bot.commands = {};
bot.events = {};
bot.events.OnCommand = {};
bot.settings = {};
bot.settings.prefix = "!";
bot.settings.notifyInvalidCommand = true;

local backend = {};
backend.last_message = 0;
backend.HandleMessage = function(player, message, rawMessage)
    if(string.beginsWith(message.text, bot.settings.prefix)) then
        local params = string.split(message.text, " ");
        local command = string.sub(params[1], 2);
        
        table.remove(params, 1);
        message.params = params;

        for name,callback in pairs(bot.events.OnCommand) do
            print("Name: "..name)
            callback(
                player, message, rawMessage,
                {
                    ["name"] = command,
                    ["callback"] = bot.commands[command] or false
                }
            );
        end

        if(not bot.commands[command]) then
            if(bot.settings.notifyInvalidCommand) then
                message.replies.invalidCommand();
            end
            return; 
        end

        bot.commands[command](player, message, rawMessage);
        console.log("debug", "[Commando] Player "..player.name.." has triggered command '"..command.."' with params "..json.encode(params));
    end
end
backend.messages = {};
backend.messages.delay = 0.8; -- in seconds
backend.SendChatMessage = function(message, team)
    local msg = {};
    msg.text = message;
    msg.team = team;
    table.insert(backend.messages, msg);
end

bot.RegisterCommand = function(name, func)
    if(bot.commands[name]) then console.log("warn", "[Commando] Plugin '"..name.."' has already been loaded, replacing..."); end

    bot.commands[name] = func;
    console.log("info", "[Commando] Plugin '"..name.."' has been loaded successfully.");
end
bot.RemoveCommand = function(name)
    if(bot.commands[name]) then
        bot.commands.remove(name);
        console.log("info", "[Commando] Plugin '"..name.."' has been unloaded successfully.");
    else
        console.log("error", "[Commando] Something tried unloading the plugin '"..name.."' but it wasn't loaded to begin with.");
    end
end
bot.RegisterEvent = function(event, name, callback)
    if(not bot.events[event]) then console.log("error", "[Commando] Event '"..event.."' does not exist."); return; end
    if(bot.events[event][name]) then console.log("debug", "[Commando] Event '"..name.."' has already been loaded, replacing..."); end

    bot.events[event][name] = callback;
    console.log("info", "[Commando] Event '"..name.."' has been loaded successfully.");
end

callbacks.Register("DispatchUserMessage", "Bot.Core.DUM", function(message)
    if (message:GetID() == 6) then
        local pid = message:GetInt(1);
        local player = {};
        player.name = client.GetPlayerNameByIndex(pid);
        player.entity = entities.GetByIndex(pid);

        if(pid == entities.GetLocalPlayer():GetIndex()) then
            backend.last_message = globals.RealTime();
        end

        if(player) then
            local msg = {};
            msg.replies = {};
            msg.text = message:GetString(4, 1);
            msg.team = not message:GetInt(5);

            msg.reply = function(text)
                backend.SendChatMessage(text, team);
            end
            msg.replies.noPermission = function()
                msg.reply("[Commando] You don't have permission to use this command.");
            end
            msg.replies.invalidArguments = function()
                msg.reply("[Commando] You provided invalid arguments for this command.");
            end
            msg.replies.invalidCommand = function()
                msg.reply("[Commando] This command does not exist.");
            end

            backend.HandleMessage(player, msg, message);
        end
    end
end);

callbacks.Register("Draw", function()
    if(backend.messages[1]) then
        if (globals.RealTime() > backend.last_message + backend.messages.delay) then
            local message = backend.messages[1];

            if (message.team) then
                client.ChatTeamSay(message.text);
            else
                client.ChatSay(message.text);
            end

            backend.last_message = globals.RealTime();

            table.remove(backend.messages, 1);
        end
    end
end)