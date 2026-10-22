--!strict

local uptime = { startTime = 0 }

function uptime.start(startTime)
	uptime.startTime = startTime
end

function uptime.getUptime()
	return uptime.startTime
end

return uptime
