--!strict

local parseSeconds = {}

function parseSeconds.SecondsToClock(seconds)
	local s = tonumber(seconds)

	if s <= 0 or s == nil then
		return "00:00:00"
	else
		local hours = math.floor(s / 3600)
		local mins = math.floor(s / 60 - (hours * 60))
		local secs = math.floor(s - hours * 3600 - mins * 60)
		return string.format("%02.f", hours)
			.. ":"
			.. string.format("%02.f", mins)
			.. ":"
			.. string.format("%02.f", secs)
	end
end

return parseSeconds
