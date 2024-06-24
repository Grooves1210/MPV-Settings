local mp = require 'mp'

-- Define upper and lower limits for random time intervals
local lower_limit_interval = 1   -- Lower limit for interval in seconds
local upper_limit_interval = 2   -- Upper limit for interval in seconds
local lower_limit_skip = 3      -- Lower limit for skip amount in seconds
local upper_limit_skip = 12      -- Upper limit for skip amount in seconds

-- Initialize the script state
local enabled = false

-- Function to generate random time intervals
local function randomTime(min, max)
    return math.random(min, max)
end

-- Function to generate a non-zero skip amount
local function generateSkipAmount()
    local skip_amount
    repeat
        skip_amount = randomTime(lower_limit_skip, upper_limit_skip) -- Random skip amount in seconds
    until skip_amount ~= 0 -- Repeat until skip_amount is not 0
    return skip_amount
end

-- Function to perform the zoom effects
local function performZoomEffects()
    local cur_zoom = mp.get_property_number("video-zoom")
    mp.set_property("video-zoom", cur_zoom + 0.03) -- Zoom in by 0.05
    mp.add_timeout(0.1, function()
        mp.set_property("video-zoom", cur_zoom) -- Zoom back to original zoom
        mp.add_timeout(0.1, function()
            mp.set_property("video-zoom", cur_zoom + 0.02) -- Zoom in by 0.05 again
            mp.add_timeout(0.1, function()
                mp.set_property("video-zoom", cur_zoom) -- Zoom back to original zoom
            end)
        end)
    end)
end

-- Function to skip forward after a random time interval
local function skipForward()
    if enabled and not mp.get_property_bool("pause") then
        local skip_amount = generateSkipAmount() -- Get non-zero skip amount
        performZoomEffects() -- Perform zoom effects after skipping		
        mp.commandv("seek", skip_amount)
    end
    mp.add_timeout(randomTime(lower_limit_interval, upper_limit_interval), skipForward)
end

-- Toggle the script on/off with a hotkey
mp.add_key_binding("Ctrl+Shift+S", "toggle_script", function()
    enabled = not enabled
    mp.osd_message(enabled and "Skipping Script Enabled" or "Skipping Script Disabled")
end)

-- Start the skipping process initially
skipForward()
