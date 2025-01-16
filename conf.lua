function lovr.conf(t)
    t.modules.headset = false
    --t.headset.drivers = {desktop}
    --t.headset.drivers = { 'openxr' }

    --- set both to zero for borderless fullscreen
    t.window.width = 1600
    t.window.height  = 800
    --t.window.fullscreen = true
    
    --- headless mode
    -- t.window = nil
  end