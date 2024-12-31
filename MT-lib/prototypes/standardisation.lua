require("__MT-lib__.trig")
for _,locationtype in pairs({"space-location","planet"}) do
	for _,planet in pairs(data.raw[locationtype]) do
		local nilify = false
		if planet.orbit then
			if planet.orbit.polar then
				--
			elseif planet.orbit.Tpolar then
				planet.orbit.polar = MTtrig.PTp(planet.orbit.Tpolar)
			elseif planet.polar then
				planet.orbit.polar = planet.polar
			elseif planet.orientation and planet.distance then
				planet.orbit.polar = MTtrig.PTp({planet.distance,planet.orientation})
			else
				log(planet.type.." "..planet.name.." doesnt have nessessary requirements to be in an orbit and hence it wont be in an orbit")
				local nilify = true
			end
			if planet.orbit.eccentricity then
				if planet.orbit.eccentricity > 0 then
					if planet.orbit.periapsis then
						--
					elseif planet.orbit.Tperiapsis then
						planet.orbit.periapsis = MTtrig.Tr(planet.orbit.Tperiapsis)
					else
						log(planet.type.." "..planet.name.." doesnt have nessessary requirements to be in an elliptical orbit and hence it will be circular")
						planet.orbit.eccentricity = 0
					end
				end
			end
			if not planet.orbit.sprite then
				planet.orbit.no_sprite = true
			end
			if not planet.orbit.sprite_scale then
				planet.orbit.sprite_scale = 1
			end
			if not planet.orbit.parent then
				planet.polar = planet.orbit.polar
				planet.orbit = nil
			end
		else
			if planet.polar then
				--
			elseif planet.orientation and planet.distance then
				planet.polar = MTtrig.PTp({planet.distance,planet.orientation})
			end
		end
		if nilify then planet.orbit = nil end
	end
end