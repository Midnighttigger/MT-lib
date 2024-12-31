require("__MT-lib__.trig")
require("__MT-lib__.basic")
local planetorbits = {}
for _,locationtype in pairs({"space-location","planet"}) do
	for _,planet in pairs(data.raw[locationtype]) do
		if planet.orbit then
			table.insert(planetorbits,{type=(planet.type),name=(planet.name),orbit=(planet.orbit)})
		else
			table.insert(planetorbits,{type=(planet.type),name=(planet.name)})
		end
	end
end
local loadorder = {}
while MTbasic.table_length(planetorbits) > MTbasic.table_length(loadorder) do
	for _,thing in pairs(planetorbits) do
		if thing.orbit then
			for _,that in pairs(loadorder) do
				if thing.orbit.parent.type == that.type and thing.orbit.parent.name == that.name then
					if not MTbasic.table_contains(loadorder,thing) then
						table.insert(loadorder,thing)
					end
				end
			end
		else
			if not MTbasic.table_contains(loadorder,thing) then
				table.insert(loadorder,thing)
			end
		end
	end
end
--data:extend({loadorder})
for _,planet in pairs(loadorder) do
	if planet.orbit then
		local parent = data.raw[planet.orbit.parent.type][planet.orbit.parent.name]
		local location = data.raw[planet.type][planet.name]
		if (not planet.orbit.eccentricity) or planet.orbit.eccentricity == 0 then
			--log(planet.type .. " " .. planet.name .. "'s orbit is circular")
			location.polar = MTtrig.Padd(parent.polar,planet.orbit.polar)
			location.orbit.eccentricity = 0
		elseif planet.orbit.eccentricity > 0 then
			--log(planet.type .. " " .. planet.name .. "'s orbit is elliptical")
			location.polar = MTtrig.Padd(parent.polar,{((1+planet.orbit.eccentricity)*planet.orbit.polar[1])/(1+planet.orbit.eccentricity*math.cos((planet.orbit.polar[2]-planet.orbit.periapsis)%MTtrig.tau)),planet.orbit.polar[2]})
			--planet.orbit.eccentricity --(eccentricity 0 ≤ e < 1) (zero means its a circle, but its just easier to define it as circle orbit)
			--planet.orbit.periapsis --(orientation of closest approach)
		end
		log(location.polar[1]..":"..location.polar[2])
	end
end
--data:extend({data.raw["planet"]})
if not data.raw["space-location"]["space-location-unknown"].MT then
	data.raw["space-location"]["space-location-unknown"].MT = {}
end
data.raw["space-location"]["space-location-unknown"].MT.loadorder = loadorder