local guiElements = {};
local current;

local checkboxNames = {
    ["\"\""] = "Automatic",
    ["ams"] = "AMS: Amsterdam",
    ["atl"] = "ATL: Atlanta",
    ["bom"] = "BOM: Bombay",
    ["dxb"] = "DXB: Dubai",
    ["eat"] = "EAT: Moses Lake (old)",
    ["fra"] = "FRA: Frankfurt",
    ["ggru"] = "GGRU: Google Cloud SA-East",
    ["ghel"] = "GHEL: Google Cloud EU-North",
    ["gru"] = "GRU: Sao Paulo",
    ["hkg"] = "HKG: Hong Kong",
    ["iad"] = "IAD: Sterling",
    ["jnb"] = "JNB: Johannesburg",
    ["lax"] = "LAX: Los Angeles",
    ["lhr"] = "LHR: London",
    ["lim"] = "LIM: Lima",
    ["lux"] = "LUX: Luxembourg",
    ["maa"] = "MAA: Chennai",
    ["mad"] = "MAD: Madrid",
    ["man"] = "MAN: Manilla",
    ["mwh"] = "MWH: Moses Lake",
    ["okc"] = "OKC: Oklahoma City",
    ["ord"] = "ORD: Chicago",
    ["par"] = "PAR: Paris",
    ["scl"] = "SCL: Santiago",
    ["sea"] = "SEA: Seattle",
    ["sgp"] = "SGP: Singapore",
    ["sha"] = "SHA: Shanghai",
    ["shb"] = "SHB: Shanghai Backbone",
    ["sto"] = "STO: Stockholm (Kista)",
    ["sto2"] = "STO2: Stockholm (Bromma)",
    ["syd"] = "SYD: Sydney",
    ["tyo"] = "TYO: Tokyo",
    ["tyo1"] = "TYO1: Tokyo 2",
    ["vie"] = "VIE: Vienna",
    ["waw"] = "WAW: Warsaw",
};

local main_reference = gui.Reference("MISC", "GENERAL", "Main");
local groupbox_reference = gui.Groupbox(main_reference, "Matchmaking Servers", 0, 250, 215, 175);

guiElements["automatic"] = gui.Checkbox(groupbox_reference, "nex_matchmaking_server_automatic", "Automatic", 1);
current = "automatic";

for k,v in pairs(checkboxNames) do
    local value = false;
    if(v ~= "Automatic") then
        guiElements[k] = gui.Checkbox(groupbox_reference, "nex_matchmaking_server_"..k, v, 0);
    end
end

local last_region;

callbacks.Register("Draw", function()
    for k,checkbox in pairs(guiElements) do
        if(checkbox:GetValue() and k ~= current) then
            gui.SetValue("nex_matchmaking_server_"..current, 0);
            current = k;
        elseif (not checkbox:GetValue() and k == current) then
            current = "automatic";
            gui.SetValue("nex_matchmaking_server_automatic", 1);
        end

        if(checkbox:GetValue() and last_region ~= k) then
            if(k == "automatic") then k = "\"\""; end
            client.Command("sdr ClientForceRelayCluster "..k, true);
            last_region = k;
        end
    end


end)