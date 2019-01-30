bot.RegisterCommand("urban", function(player, message, raw)
    -- join all of the parameters together with spaces
    local words = table.concat(message.params, " ");

    -- finalize the url with the words for encoding
    local api = "https://api.urbandictionary.com/v0/define?term="..urlencode(words);
    
    http.Get(api, function(response)
        -- decode the response from the api
        local res = json.decode(response)

        -- get the definition
        local definition = res.list[1].definition;
        
        -- check if the definition exists
        if(definition) then
            -- the api puts these weird brackets around some words, so we remove them
            definition = definition:gsub("%[", ""):gsub("%]", "");

            -- the max chat message length is 127 characters, so we calculate and replace
            -- the last three chars with ... to indicate there's more to it.
            if(definition:len() >= 127) then
                definition = string.sub(definition, 1, 124).."...";
            end

            -- replies with the definition
            message.reply(definition);
        else
            -- replies with an error message
            message.reply("The word(s) you specified was not found.");
        end
    end)
end)