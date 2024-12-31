require("__MT-lib__.trig")
for _,ptype in pairs({"space-location","planet"}) do
	for _,planet in pairs(data.raw[ptype]) do
		if planet.orbit and planet.orbit.parent and type(planet.orbit.parent) == "string" then
			planet.orbit.polar = MTtrig.PTp({planet.orbit.distance,planet.orbit.orientation})
			local found = false
			for _,patype in pairs({"space-location","planet"}) do
				for _,pa in pairs(data.raw[patype]) do
					if pa.name == planet.orbit.parent then
						planet.orbit.parent = {type=pa.type,name=pa.name}
						found = true
					end
				end
			end
			if found == false then
				planet.orbit.polar = MTtrig.PTp({planet.distance,planet.orientation})
				planet.orbit.parent = false
			end
		end
	end
end