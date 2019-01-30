local reference = gui.Reference("VISUALS", "MISC", "World");

local controlR = gui.Slider(reference, "nex_visuals_modulation_red", "Modulation: Red", 255, 0, 255);
local controlG = gui.Slider(reference, "nex_visuals_modulation_green", "Modulation: Green", 0, 0, 255);
local controlB = gui.Slider(reference, "nex_visuals_modulation_blue", "Modulation: Blue", 0, 0, 255);
local sli_exposure = gui.Slider(reference, "nex_bloom_exposure", "World Exposure", 100, 1, 100);
local sli_modelAmbient = gui.Slider(reference, "nex_bloom_model_ambient", "Model Ambient", 1, 1, 100);
local sli_bloom = gui.Slider(reference, "nex_bloom_scale", "Bloom Scale", 20, 1, 100);

callbacks.Register("Draw", "Nex.Modulation.Draw", function()
    if(entities.GetLocalPlayer()) then
        if(controlR:GetValue() ~= client.GetConVar("mat_ambient_light_r")) then
            client.SetConVar("mat_ambient_light_r", controlR:GetValue()/255, true);
        end
        
        if(controlG:GetValue() ~= client.GetConVar("mat_ambient_light_g")) then
            client.SetConVar("mat_ambient_light_g", controlG:GetValue()/255, true);
        end
        
        if(controlB:GetValue() ~= client.GetConVar("mat_ambient_light_b")) then
            client.SetConVar("mat_ambient_light_b", controlB:GetValue()/255, true);
        end

        local controller = entities.FindByClass("CEnvTonemapController")[1];
    
        if(controller) then
            controller:SetProp("m_bUseCustomAutoExposureMin", 1);
            controller:SetProp("m_bUseCustomAutoExposureMax", 1);
            controller:SetProp("m_bUseCustomBloomScale", 1);

            controller:SetProp("m_flCustomAutoExposureMin", sli_exposure:GetValue()/100);
            controller:SetProp("m_flCustomAutoExposureMax", sli_exposure:GetValue()/100);
            controller:SetProp("m_flCustomBloomScale", sli_bloom:GetValue()/100);

            client.SetConVar("r_modelAmbientMin", sli_modelAmbient:GetValue()/1, true);
        end
    end
end);