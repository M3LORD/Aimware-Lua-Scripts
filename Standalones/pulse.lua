-- AIMWARE: Pulsating Glow
-- Credits: Nexxed & Quantiom

-- Change this to your liking, it's how fast it pulses.
-- min, max = opacity/alpha minimum and maximum
local speed = 1;
local min, max = 25, 120;

-- PUT YOUR GUI ELEMENTS HERE --
-- v = vector (so shit like cham colors where R, G, B and A are all in one var)
-- s = single (stuff that takes a single value - e.g. vis_viewfov)
-- sf = single-float (like glow alpha (0.000 - 1.000))
local guiElements = {
    ["clr_chams_historyticks"] = "v",
    ["clr_chams_ct_vis"] = "v",
    ["clr_chams_ct_invis"] = "v",
    ["clr_chams_t_vis"] = "v",
    ["clr_chams_t_invis"] = "v",
};


-- Don't edit anything down here.
local setValue = gui.SetValue;
local getValue = gui.GetValue;

-- cs = current step/value
-- cd = current direction (0-up/1-down)
local cs, cd = min, 0;
local function updateAlpha()
    for k, v in pairs(guiElements) do
        if (v == "v") then
            local r, g, b, a = getValue(k);
            setValue(k, r, g, b, cs);
        elseif (v == "s") then
            setValue(k, cs);
        elseif (v == "sf") then
            local p = cs / 255;
            setValue(k, p);
        end
    end
end

callbacks.Register("Draw", "Nex.Pulse.Draw", function()
    if (cs >= max) then
        cd = 1;
    elseif (cs <= min+speed) then
        cd = 0;
    end
    
    if (cd == 0) then
        cs = cs + speed;
    elseif (cd == 1) then
        cs = cs - speed;
    end

    updateAlpha();
end);