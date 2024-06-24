local start_time = 0
local end_time = -1

function update_time(property, amount)
    if property == "start" then
        start_time = start_time + amount
        mp.osd_message("Start time: " .. start_time .. " seconds")
    elseif property == "end" then
        end_time = end_time + amount
        mp.osd_message("End time: " .. end_time .. " seconds")
    end
end

function set_time(property)
    if property == "start" then
        mp.set_property("start", start_time)
    elseif property == "end" then
        mp.set_property("end", end_time)
    end
end

function on_start_file()
    set_time("start")
    set_time("end")
end

mp.register_event("start-file", on_start_file)

mp.add_key_binding("Alt+]", "increase_start_time", function() update_time("start", 3) end)
mp.add_key_binding("Alt+[", "decrease_start_time", function() update_time("start", -3) end)
mp.add_key_binding("Ctrl+]", "increase_end_time", function() update_time("end", -3) end)
mp.add_key_binding("Ctrl+[", "decrease_end_time", function() update_time("end", 3) end)

set_time("start")
set_time("end") -- Set initial start and end times
