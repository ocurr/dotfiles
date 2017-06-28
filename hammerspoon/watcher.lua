local watcher = {}
watcher.__index = watcher

function watcher.new()
    local self = setmetatable({}, watcher)
    self.list = {}
    self.hsCaff = hs.caffeinate.watcher.new(function(event)
        if event == hs.caffeinate.watcher.screensDidLock or event == hs.caffeinate.watcher.screensDidSleep or event == hs.caffeinate.watcher.screensaverDidStart or event == hs.caffeinate.watcher.systemWillSleep then
            for _,w in pairs(self.list) do
                w:stop()
            end
        end

        if event == hs.caffeinate.watcher.screensDidUnlock or event == hs.caffeinate.watcher.screensDidWake or event == hs.caffeinate.watcher.screensaverDidStop or event == hs.caffeinate.watcher.systemDidWake then
            for _,w in pairs(self.list) do
                w:start()
            end
        end
    end)
    return self
end

function watcher:registerWatcher(w)
    table.insert(self.list, w)
    w:start()
end

function watcher:start()
    self.hsCaff:start()
end

function watcher:stop()
    self.hsCaff:stop()
end

return watcher
