if data.raw["fusion-reactor"] then
	for _,fusionreactor in pairs(data.raw["fusion-reactor"]) do
		fusionreactor.energy_source.emissions_per_minute = fusionreactor.burner.emissions_per_minute
	end
end