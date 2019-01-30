local frametime = 0;
local fps = 0;

callbacks.Register("Draw", function()
    frametime = 0.9 * frametime + (1.0 - 0.9) * globals.AbsoluteFrameTime();
    fps = math.floor((1.0 / frametime) + 0.5)
end);

bot.RegisterCommand("fps", function(player, message, raw)
    message.reply("Hello, "..player.name.."! My current FPS is "..fps);
end)