local zoom_levels = {0, 0, 0, 0.01, 0, 0, 0, 0.03,}  -- Define zoom levels
local current_zoom_index = 1  -- Initial zoom level index
local is_script_enabled = false  -- Flag to control script activation

function update_zoom()
    if not is_script_enabled then
        return
    end

    local time = mp.get_property_number("time-pos", 0)
    
    -- Example: Change zoom every 0.1 seconds
    local step_duration = 0.1
    
    -- Calculate the current step based on time
    local current_step = math.floor(time / step_duration) % #zoom_levels + 1
    
    -- Change zoom only when a new step is reached
    if current_step ~= current_zoom_index then
        current_zoom_index = current_step
        local new_zoom = zoom_levels[current_zoom_index]
        mp.command(string.format("no-osd set video-zoom %f", new_zoom))
    end
end

function toggle_script()
    is_script_enabled = not is_script_enabled
    
    if not is_script_enabled then
        -- Reset zoom to 1 when the script is disabled
        mp.command("no-osd set video-zoom 0.0")
    end
    
    local status = is_script_enabled and "enabled" or "disabled"
    mp.osd_message("Music Zoom Script: " .. status)
end

-- Register the update function to be called on every frame
mp.add_periodic_timer(1 / 30, update_zoom)

-- Register the key binding to toggle the script
mp.add_key_binding("p", "toggle_pulsate_zoom_script", toggle_script)
