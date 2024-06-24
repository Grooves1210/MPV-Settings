-- MPV Vignette Control Script

angle = 1.3
aspect = 0.7

-- Upper and lower limits for angle and aspect
angleUpperLimit = 2.0
angleLowerLimit = 0.8
aspectUpperLimit = 3.0
aspectLowerLimit = 0.1

function increaseAngle()
    angle = math.min(angle + 0.1, angleUpperLimit)
    updateVignette()
end

function decreaseAngle()
    angle = math.max(angle - 0.1, angleLowerLimit)
    updateVignette()
end

function increaseAspect()
    aspect = math.min(aspect + 0.1, aspectUpperLimit)
    updateVignette()
end

function decreaseAspect()
    aspect = math.max(aspect - 0.1, aspectLowerLimit)
    updateVignette()
end

function updateVignette()
    mp.set_property("vf", "vignette=angle=" .. angle .. ":aspect=" .. aspect)
    displayValues()
end

function displayValues()
    mp.osd_message("Vignette - Angle: " .. angle .. ", Aspect: " .. aspect, 2)
end

mp.add_key_binding(nil, "increaseAngle", increaseAngle)
mp.add_key_binding(nil, "decreaseAngle", decreaseAngle)
mp.add_key_binding(nil, "increaseAspect", increaseAspect)
mp.add_key_binding(nil, "decreaseAspect", decreaseAspect)
