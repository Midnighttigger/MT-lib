require "util"
MTpollution = {}
function MTpollution.get_pollution(emissiondirectry,type)
	if emissiondirectry then
		if emissiondirectry[type] then
			return emissiondirectry[type]
		else
			return 0
		end
	else
		return 0
	end
end
--such as MTpollution.get_pollution({pollution=10,spores=6},"pollution")
function MTpollution.set_pollution(emissiondirectry,amount,type)
	local emission = table.deepcopy(emissiondirectry)
	if emissiondirectry then
		emission[type] = amount
	else
		emission = {}
		emission[type] = amount
	end
	return emission
end
--such as MTpollution.set_pollution({pollution=5,spores=10},20,"pollution"} returns {pollution=20,spores=10}