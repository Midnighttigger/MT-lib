require "util"
MTenergy = {}
function MTenergy.get_mw(string)
	if not string then
		return 0
	end
	local vnb = string.gsub(string,"%a","")
	local vmw = string.lower(string.gsub(string,"%A",""))
	if vmw == "mj" or vmw == "mw" then
		return vnb
	elseif vmw == "kj" or vmw == "kw" then
		return vnb*(10^-3)
	elseif vmw == "gj" or vmw == "gw" then
		return vnb*(10^3)
	elseif vmw == "j" or vmw == "w" then
		return vnb*(10^-6)
	elseif vmw == "tj" or vmw == "tw" then
		return vnb*(10^6)
	elseif vmw == "pj" or vmw == "pw" then
		return vnb*(10^9)
	elseif vmw == "ej" or vmw == "ew" then
		return vnb*(10^12)
	elseif vmw == "zj" or vmw == "zw" then
		return vnb*(10^15)
	elseif vmw == "yj" or vmw == "yj" then
		return vnb*(10^18)
	end
end
function MTenergy.get_consumption(directry)
	if directry.type == "burner-generator" or directry.type == "generator" then
		return directry.max_power_output
	elseif directry.type == "assembling-machine" or directry.type == "furnace" or directry.type == "lab" or directry.type == "mining-drill" or directry.type == "pump" or directry.type == "radar" or directry.type == "beacon" then
		return directry.energy_usage
	elseif directry.type == "generator-equipment" then
		return directry.power
	elseif directry.type == "reactor" or directry.type == "car" then
		return directry.consumption
	elseif directry.type == "boiler" then
		return directry.energy_consumption
	elseif directry.type == "locomotive" then
		return directry.max_power
	elseif directry.type == "lamp" then
		return string.gsub(directry.energy_usage_per_tick,"%a","")*60 .. string.gsub(directry.energy_usage_per_tick,"%A","")
	elseif directry.type == "inserter" then
		return (directry.rotation_speed*MTenergy.get_mw(directry.energy_per_rotation)+directry.extension_speed*MTenergy.get_mw(directry.energy_per_movement))*60 .. "MW"
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
	