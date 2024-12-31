require("__MT-lib__.trig")
require("__MT-lib__.sprite")
local loadorder = data.raw["space-location"]["space-location-unknown"].MT.loadorder


local starmap = data.raw["utility-sprites"]["default"].starmap_star.layers
for _,star in pairs(data.raw["space-location"]) do
	if star.is_background then -- is_sprite but its on the background
		local sprite = MTsprite.manipulateS(star.starmap_icon,MTtrig.Cmul(MTtrig.Pcc(star.polar),{32,32}),64*star.magnitude)
		if sprite.layers then
			for _,layer in pairs(sprite.layers) do
				table.insert(starmap,layer)
			end
		else
			table.insert(starmap,sprite)
		end
		data.raw[star.type][star.name] = nil
	end
end
for _,porbit in pairs(loadorder) do
	local planet = data.raw[porbit.type][porbit.name]
	if planet.orbit and planet.orbit.eccentricity == 0 and not planet.orbit.no_sprite then
		planet.draw_orbit = false
		local parent = data.raw[planet.orbit.parent.type][planet.orbit.parent.name]
		local sprite = MTsprite.manipulate(planet.orbit.sprite,MTtrig.CmulS(MTtrig.Pcc(parent.polar),32),(4+64*planet.orbit.polar[1])*planet.orbit.sprite_scale)
		if sprite.layers then
			for _,layer in pairs(sprite.layers) do
				table.insert(starmap,layer)
			end
		else
			table.insert(starmap,sprite)
		end
	elseif planet.orbit and planet.orbit.eccentricity > 0 and not planet.orbit.no_sprite then
		planet.draw_orbit = false
		local parent = data.raw[planet.orbit.parent.type][planet.orbit.parent.name]
		local sprite = MTsprite.manipulate(planet.orbit.sprite,MTtrig.CmulS(MTtrig.Pcc(MTtrig.Psub(parent.polar,{(planet.orbit.polar[1]*planet.orbit.eccentricity)/(1-planet.orbit.eccentricity),planet.orbit.periapsis})),32),planet.orbit.sprite_scale*(64*planet.orbit.polar[1]*(1-planet.orbit.eccentricity^2)^0.5)/((1-planet.orbit.eccentricity)*(1-(planet.orbit.eccentricity*math.sin(planet.orbit.periapsis))^2)))
		if sprite.layers then
			for _,layer in pairs(sprite.layers) do
				table.insert(starmap,layer)
			end
		else
			table.insert(starmap,sprite)
		end
	else
		planet.draw_orbit = false
	end
end
for _,star in pairs(data.raw["space-location"]) do
	if star.barycentre then -- when "barycentre=true" it doesnt show up as a location on the starmap and will not have a sprite, useful for binary orbits
		 data.raw[star.type][star.name] = nil
	elseif star.unlandable then -- when "unlandable=true" then itle convert the starmap icon and put it into the utility sprites so it doesnt have a space platform orbit
		local sprite = {}
		sprite.filename = star.starmap_icon
		sprite.size = star.starmap_icon_size
		--sprite.scale = (star.magnitude*25.6)/(star.starmap_icon_size)
		sprite.scale = (star.magnitude*32)/(star.starmap_icon_size)
		sprite.shift = MTtrig.Cmul(MTtrig.Pcc(star.polar),{32,-32})
		table.insert(starmap,sprite)
		data.raw[star.type][star.name] = nil
	end
end
for _,star in pairs(data.raw["space-location"]) do
	if star.is_sprite then -- when "is_sprite=true" this is treated as a sprite which will be put into utility sprites, magnitude represents scale
		local sprite = MTsprite.manipulateS(star.starmap_icon,MTtrig.Cmul(MTtrig.Pcc(star.polar),{32,32}),64*star.magnitude)
		if sprite.layers then
			for _,layer in pairs(sprite.layers) do
				table.insert(starmap,layer)
			end
		else
			table.insert(starmap,sprite)
		end
		data.raw[star.type][star.name] = nil
	end
end