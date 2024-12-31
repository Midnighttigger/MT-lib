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
function MTbasic.mod(a,b)
	if a < 0 then
		a = -a
	end
	if a >= b then
		return a-math.floor(a/b)
	else
		return a
	end
end
function MTbasic.table_length(table)
  tble_length = 0
  for _ in pairs(table) do 
	tble_length = tble_length + 1 
  end
  return tble_length
end
function MTbasic.space_dlc() -- returns true or false whether the dlc is enabled
	for _,mod in pairs({"space-age","elevated-rails","quality","mech-armor","enable-all-feature-flags"}) do
		if mods[mod] then
			return true
		end
	end
	return false
end
