require("__MT-lib__.basic")
if MTbasic.space_dlc() then
	if mods["PlanetsLib"] then
		require("prototypes.PlanetsLib")
	end
	require("prototypes.fusion-reactor-tweaks")
	require("prototypes.standardisation")
	require("prototypes.location")
	require("prototypes.graphics")
	require("prototypes.final")
end