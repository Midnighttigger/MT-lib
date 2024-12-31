--[[local utilitysprite = table.deepcopy(data.raw["utility-sprites"]["default"].starmap_star)
if not utilitysprite.layers then
	utilitysprite = {}
	utilitysprite.layers = {data.raw["utility-sprites"]["default"].starmap_star}
end
data.raw["utility-sprites"]["default"].starmap_star = utilitysprite]]
data.raw["utility-sprites"]["default"].starmap_star = {layers={}}