require("__MT-lib__.trig")
for _,stype in pairs({"space-location","planet"}) do
	for _,planet in pairs(data.raw[stype]) do
		local loc = MTtrig.Ppt(planet.polar)
		planet.distance = loc[1]
		planet.orientation = loc[2]
	end
end