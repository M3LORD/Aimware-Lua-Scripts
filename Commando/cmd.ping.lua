bot.RegisterCommand("ping", function(player, message, raw)
    local latency = entities.GetPlayerResources():GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex());
    message.reply("Hello, "..player.name.."! I currently have "..latency.."ms ping to this server.");
end)