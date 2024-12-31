require "util"
MTenergy = {}
function MTenergy.get_mw(string)
	local value = 0
	if not string then
		return 0
	end
	local vnb = string.gsub(string,"%a","")
	local vmw = string.lower(string.gsub(string,"%A",""))
	if vmw == "mj" or vmw == "mw" then
		value = vnb
	elseif vmw == "kj" or vmw == "kw" then
		value = vnb*(10^-3)
	elseif vmw == "gj" or vmw == "gw" then
		value = vnb*(10^3)
	elseif vmw == "j" or vmw == "w" then
		value = vnb*(10^-6)
	elseif vmw == "tj" or vmw == "tw" then
		value = vnb*(10^6)
	elseif vmw == "pj" or vmw == "pw" then
		value = vnb*(10^9)
	elseif vmw == "ej" or vmw == "ew" then
		value = vnb*(10^12)
	elseif vmw == "zj" or vmw == "zw" then
		value = vnb*(10^15)
	elseif vmw == "yj" or vmw == "yw" then
		value = vnb*(10^18)
	end
	return value
end
function MTenergy.get_effectivity(directry)
	if directry.type == "generator" then
		if directry.effectivity then
			return directry.effectivity
		else
			return 0
		end
	elseif directry.type == "fusion-generator" then
		local steamfluid = data.raw.fluid[directry.input_fluid_box.filter]
		return (MTenergy.get_mw(MTenergy.get_consumption(directry)))/(steamfluid.default_temperature*MTenergy.get_mw(steamfluid.heat_capacity)*60*directry.max_fluid_usage)
	elseif directry.type == "lightning-attractor" then
		if directry.efficiency then
			return directry.efficiency
		else
			return 0
		end
	elseif directry.burner then
		if directry.burner.effectivity then
			return directry.burner.effectivity
		else
			return 1
		end
	elseif directry.energy_source then
		if directry.energy_source.type == "burner" or directry.type == "fluid" then
			if directry.energy_source.effectivity then
				return directry.energy_source.effectivity
			else
				return 1
			end
		else
			return 1
		end
	else
		return 1
	end
end
function MTenergy.get_trueusage(directry)
	if MTenergy.get_effectivity(directry) == 0 then
		return "0MW"
	else
		return ((MTenergy.get_mw(MTenergy.get_usage(directry))/MTenergy.get_effectivity(directry)).."MW")
	end
end
function MTenergy.get_usage(directry)
	if directry.energy_source then
		if directry.energy_source.type == "electric" then
			if directry.energy_source.drain then
				return (MTenergy.get_mw(MTenergy.get_consumption(directry)) + MTenergy.get_mw(directry.energy_source.drain)).."MW"
			else
				return MTenergy.get_consumption(directry)
			end
		else
			return MTenergy.get_consumption(directry)
		end
	else
		return MTenergy.get_consumption(directry)
	end
end
function MTenergy.get_consumption(directry)
	if directry.type == "assembling-machine" or directry.type == "furnace" or directry.type == "lab" or directry.type == "mining-drill" or directry.type == "pump" or directry.type == "radar" or directry.type == "beacon" or directry.type == "agricultural-tower" or directry.type == "offshore-pump" or directry.type == "roboport" then
		return directry.energy_usage
	elseif directry.type == "burner-generator" or directry.type == "generator" then
		if directry.max_power_output then
			return directry.max_power_output
		elseif not directry.burns_fluid then
			local steamfluid = data.raw.fluid[directry.fluid_box.filter]
			return (directry.maximum_temperature-steamfluid.default_temperature)*MTenergy.get_mw(steamfluid.heat_capacity)*60*directry.fluid_usage_per_tick.."MW"
		elseif directry.burns_fluid == "true" then
			local steamfluid = data.raw.fluid[directry.fluid_box.filter]
			return MTenergy.get_mw(steamfluid.fuel_value)*60*directry.fluid_usage_per_tick.."MW"
		end
	elseif directry.type == "fusion-generator" then
		return directry.energy_source.output_flow_limit
	elseif directry.type == "fusion-reactor" then
		local steamfluid = data.raw.fluid[directry.output_fluid_box.filter]
		return steamfluid.default_temperature*MTenergy.get_mw(steamfluid.heat_capacity)*60*directry.max_fluid_usage.."MW"
		--returns burner fuel usage
	elseif directry.type == "generator-equipment" or directry.type == "solar-panel-equipment" then
		return directry.power
	elseif directry.type == "reactor" or directry.type == "car" then
		return directry.consumption
	elseif directry.type == "boiler" then
		return directry.energy_consumption
	elseif directry.type == "solar-panel" then
		return directry.production
	elseif directry.type == "locomotive" then
		return directry.max_power
	elseif directry.type == "spider-vehicle" then
		return directry.movement_energy_consumption
	elseif directry.type == "lamp" then
		return string.gsub(directry.energy_usage_per_tick,"%a","")*60 .. string.gsub(directry.energy_usage_per_tick,"%A","")
	elseif directry.type == "inserter" then
		return (directry.rotation_speed*MTenergy.get_mw(directry.energy_per_rotation)+directry.extension_speed*MTenergy.get_mw(directry.energy_per_movement))*60 .. "MW"
	elseif directry.type == "arithmetic-combinator" or directry.type == "decider-combinator" or directry.type == "selector-combinator" then
		return active_energy_usage
	elseif directry.type == "active-defense-equipment" or directry.type == "battery-equipment" or directry.type == "belt-immunity-equipment" or directry.type == "energy-shield-equipment" or directry.type == "equipment-ghost" or directry.type == "inventory-bonus-equipment" or directry.type == "movement-bonus-equipment" or directry.type == "night-vision-equipment" or directry.type == "roboport-equipment" then
		if directry.energy_source then
			if directry.energy_source.input_flow_limit then
				return directry.energy_source.input_flow_limit
			else
				return 0
			end
		else
			return 0
		end
	elseif directry.type == "lightning-attractor" then
		if directry.energy_source then
			if directry.energy_source.output_flow_limit then
				return directry.energy_source.output_flow_limit
			else
				return 0
			end
		else
			return 0
		end
	elseif directry.type == "loader" or directry.type == "loader-1x1" then
		if directry.energy_per_item then
			return directry.speed*MTenergy.get_mw(directry.energy_per_item).."MW"
		else
			return 0
		end
	elseif directry.type == "electric-turret" or directry.type == "ammo-turret" then
		if directry.energy_source then
			return directry.energy_source.input_flow_limit
		else
			return 0
		end
	elseif directry.type == "rocket-silo" then
		return MTenergy.get_mw(directry.energy_usage) + MTenergy.get_mw(directry.active_energy_usage) + MTenergy.get_mw(directry.lamp_energy_usage) .."MW"
	else
		return 0
	end
end
function MTenergy.boilerassembles(name,category,step)
	local bmp = data.raw["boiler"][name]
	local hmp = table.deepcopy(bmp)
	data:extend({
	{
		type = "recipe",
		name = hmp.name.."-recipe",
		icon = hmp.icon,
		icon_size = hmp.icon_size, icon_mipmaps = hmp.icon_mipmaps,
		energy_required = (hmp.target_temperature-data.raw.fluid[hmp.fluid_box.filter].default_temperature)*MTenergy.get_mw(data.raw.fluid[hmp.output_fluid_box.filter].heat_capacity)*step,
		category = category,
		hide_from_player_crafting = true,
		hidden = true,
		subgroup = "other",
		ingredients = {{type="fluid",name=hmp.fluid_box.filter,amount=step}},
		results = {{type="fluid",name=hmp.output_fluid_box.filter,temperature=hmp.target_temperature,amount=step}},
		enabled = true
	}})
	hmp.type = "assembling-machine"
	if bmp.energy_source.effectivity then
	hmp.energy_usage = (MTenergy.get_mw(bmp.energy_consumption)/bmp.energy_source.effectivity) .. "MW"
	else
	hmp.energy_usage = bmp.energy_consumption
	end
	hmp.crafting_speed = MTenergy.get_mw(bmp.energy_consumption)
	hmp.crafting_categories = {category}
	hmp.show_recipe_icon = false
	hmp.show_recipe_icon_on_map = false
	bmp.fluid_box.production_type = "input"
	hmp.fluid_boxes = {bmp.fluid_box,bmp.output_fluid_box}
	hmp.output_fluid_box = nil
	hmp.fluid_box = nil
	hmp.energy_consumption = nil
	hmp.target_temperature = nil
	hmp.fixed_recipe = hmp.name.."-recipe"
	hmp.idle_animation = hmp.structure
	hmp.always_draw_idle_animation = true
	hmp.structure = nil
	hmp.working_visualisations = {hmp.fire_glow,hmp.fire}
	hmp.fire_glow = nil
	hmp.fire = nil
	data.raw["boiler"][name] = nil
	data:extend({hmp})
end
	