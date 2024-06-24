local speed_levels = {1, 2, 1, 1, 1, 1.5, 1, 1, 1, 1.5, 1, 1, 1, 1.3, 1, 1, 1,}  -- Define speed levels
local current_speed_index = 1  -- Initial speed level index
local is_script_enabled = false  -- Flag to control script activation

function update_speed()
    if not is_script_enabled then
        return
    end

    local time = mp.get_property_number("time-pos", 0)
    
    -- Example: Change speed every x.x seconds
    local step_duration = 0.9
    
    -- Calculate the current step based on time
    local current_step = math.floor(time / step_duration) % #speed_levels + 1
    
    -- Change speed only when a new step is reached
    if current_step ~= current_speed_index then
        current_speed_index = current_step
        local new_speed = speed_levels[current_speed_index]
        mp.set_property("speed", new_speed)
    end
end

function toggle_script()
    is_script_enabled = not is_script_enabled
    
    if not is_script_enabled then
        -- Reset speed to 1 when the script is disabled
        mp.set_property("speed", 1.0)
    end
    
    local status = is_script_enabled and "enabled" or "disabled"
    mp.osd_message("Music Speed Script: " .. status)
end

-- Register the update function to be called on every frame
mp.add_periodic_timer(1 / 30, update_speed)

-- Register the key binding to toggle the script
mp.add_key_binding("o", "toggle_pulsate_speed_script", toggle_script)
