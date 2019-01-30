# Commando
A modular chatbot framework for the AIMWARE Lua API.

## Example Scripts
I provided three example scripts that produce a message containing your current FPS, Ping and a lookup for a specific word on Urban Dictionary.
Using these examples, you should be able to create your scripts. They are well-documented and easy to read.

[cmd.fps.lua](cmd.fps.lua)
[cmd.ping.lua](cmd.ping.lua)
[cmd.urban.lua](cmd.urban.lua)

## Documentation
### bot.RegisterCommand(name, callback(player, message, raw))
This registers a new command with the framework that calls the provided callback function when that command has been triggered.


### bot.RemoveCommand(name)
This removes the specified command from the framework, making it unable to be triggered.


### bot.RegisterEvent(event, name, callback(player, message, raw, command))
This registers a new event to be triggered when someone types a command.
This gets called even if the specified command didn't exist, so you should check the callbacks command.callback property, which will be nil if not a valid command.


### bot.settings.prefix *(Default: "!")*
The prefix the bot will use to identify commands. (e.g. !urban aimware)


### bot.settings.notifyInvalidCommand *(Default: true)*
Whether or not the bot will send a message in the chat if the specified command didn't exist. (e.g. !invalidcommand)


### message.text
The text of the message that triggered the command.


### message.team *(true|false)*
Whether or not the message was sent in team chat.


### message.reply(text)
Adds a message to the chat queue via Message Dispatcher to get around spam protection.


### message.replies *(noPermission, invalidArguments, invalidCommand)*
A vairety of pre-defined error messages.


### message.params
A table containing every parameter to the command that was issued.


### message.player.name
The name of the player who issued the command.


### message.player.entity
The entity of the player who issued the command.
Might be nil depending on dormancy state.