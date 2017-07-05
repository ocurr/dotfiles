local watcher = require 'watcher'
--local pomodoro = require 'pomodoro'
--pomodoro.new()

local externalDisplay = 'S24E390'
local laptopDisplay = 'Color LCD'

--[[
hs.eventtap.new({hs.eventtap.event.types.keyDown},
function(e)
    if hs.keycodes.map[e:getKeyCode()] == "f19" then
        hs.eventtap.keyStroke({"alt"}, )
        return true
    end
    print(e:getKeyCode())
    return false
end):start()
--]]

--hotkey modifiers
local hyper = {"cmd", "ctrl", "alt", "shift"}

hs.hotkey.bind(hyper, '`', hs.reload)

-- window filters
--local wf = hs.window.filter.new():setCurrentSpace(true)
--local wfExternal = hs.window.filter.new():setScreens({externalDisplay})
--local wfLaptop = hs.window.filter.new():setScreens({laptopDisplay})
--local layoutExternal = hs.window.layout.new({wfExternal,"move 1 foc [33,0,100,100] -1,0 | tile all [0,0,33,100] -1,0"}):start()

hs.hotkey.bind(hyper,"D",function() print(#wfExternal:getWindows()) end)
hs.hotkey.bind(hyper,"F",function() print(#wfLaptop:getWindows()) end)

--Grid
hs.grid.setMargins({x=0,y=0})
hs.grid.setGrid('5x4',externalDisplay)
hs.grid.setGrid('4x3',laptopDisplay)

hs.hotkey.bind(hyper, "space", hs.grid.toggleShow)

local watcherWatcher = watcher.new()

function askForSleep(compFunc)
    local c = hs.chooser.new(compFunc)

    c:rows(2)

    c:choices({
        {text="Sleep",subText="Sleep, sleep, my pretties!"},
        {text="Cancel",subText="Please, Dorothy, don't fall asleep!"},
    })

    c:show()
end

function handleSleep(chosen)
    if chosen == nil or chosen.text == "Cancel" then
        return
    end

    hs.caffeinate.systemSleep()
end

hs.hotkey.bind(hyper, "S", function() askForSleep(handleSleep) end)
hs.hotkey.bind(hyper, "L", hs.caffeinate.startScreensaver)

function preventSleep()
    hs.caffeinate.set("displayIdle", true, false)
    hs.caffeinate.set("systemIdle", true, false)
    hs.alert("Preventing Sleep")
end

function allowSleep()
    hs.caffeinate.set("displayIdle", false, false)
    hs.caffeinate.set("systemIdle", false, false)
    hs.alert("Allowing Sleep")
end

hs.hotkey.bind(hyper, "R", preventSleep)
hs.hotkey.bind(hyper, "T", allowSleep)

hs.hints.showTitleThresh = 20
hs.hints.titleMaxSize = 10
hs.hotkey.bind(hyper, "E", hs.hints.windowHints)

hs.hotkey.bind(hyper, "G", function()
    print(hs.window.focusedWindow():application():name())
end)

function appWatcherCallback(appName, event, app)
    if event == hs.application.watcher.launching then
        if appName == "Steam" then
            local external = hs.screen.find(externalDisplay)
            if external then
                external:setPrimary()
            end
        end
        hs.alert("Launching: " .. appName, 1)
    end

    if event == hs.application.watcher.activated then
    end

    if event == hs.application.watcher.terminated then
        if appName == "Steam" then
            local external = hs.screen.find(externalDisplay)
            if external then
                hs.screen.find(laptopDisplay):setPrimary()
            end
        end
        hs.alert("Quitting: " .. appName, 1)
    end
end
watcherWatcher:registerWatcher(hs.application.watcher.new(appWatcherCallback))
--local screenWatcher = hs.screen.watcher.new(screenWatcherCallback):start()

--Start the relevent layouts
--screenWatcherCallback()

local volumesList = {}
function volumesWatcher(event, info)
    volName = hs.fnutils.split(info.path,"/")[3]
    if volName == "Recovery HD" then
        return
    end

    eventType = ""

    if event == hs.fs.volume.didMount then
        eventType = "Mounted"
        volumesList[info.path] = true
    elseif event == hs.fs.volume.didUnmount then
        eventType = "Unmounted"
        volumesList[info.path] = nil
    end
    hs.notify.new(nil,
    {
        title = volName,
        subTitle = eventType,
        autoWithdraw=true,
        contentImage=hs.image.imageFromPath("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SidebarRemovableDisk.icns")

    }):send()
end
watcherWatcher:registerWatcher(hs.fs.volume.new(volumesWatcher))

function ejectVolume()
    local c = hs.chooser.new(function(choice) if volumesList[choice.path] then hs.fs.volume.eject(choice.path) print("Ejecting " .. choice.path) end end)
    local choices = {}
    for k,_ in pairs(volumesList) do
        table.insert(choices,{text=hs.fnutils.split(k,"/")[3],path=k})
    end
    c:choices(choices)
    c:show()
end

hs.hotkey.bind(hyper, "I", ejectVolume)

function formattedTime(t)
    local sec = hs.timer.minutes(t)
    return os.date("!%X",sec)
end

local bmenu = hs.menubar.new()

function batteryCallback()
    local time = ""
    if hs.battery.isCharging() then
        time = formattedTime(hs.battery.timeToFullCharge())
        if time == -1 then
            text = "⌛️"
        else
            --text = formattedTime(time) .. "⚡️"
            text = string.sub(time,1,2) .. "⚡️"
        end
        color = green
    elseif hs.battery.isCharged() then
        text = "⚡️"
    else
        time = formattedTime(hs.battery.timeRemaining())
        if time == -1 then
            text = "⌛️"
        else
            text = string.sub(time,1,2) .. "🔋"
        end

    end
    bmenu:setMenu({
        { title = time },
    })
    bmenu:setTitle(text)
end

batteryCallback()
watcherWatcher:registerWatcher(hs.battery.watcher.new(batteryCallback))

--redshift
--hs.redshift.start(2500,"18:00","06:30",hs.timer.seconds("2h"))

watcherWatcher:start()
