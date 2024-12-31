MTbasic = {}
function MTbasic.table_contains(table,value)
	found = false
	for _,v in pairs (table) do
		if v == value then 
			found = true 
		 end
	end
	return found
end