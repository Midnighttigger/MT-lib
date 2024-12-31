MTtrig = {}
local tau = 2*math.pi
--below functions are in radians for your information unless otherwise specified
MTtrig.tau = tau
function MTtrig.Padd(P1,P2) -- add 2 polar coords {distance,angle}
	--log(P1[1]..":"..P1[2].."+"..P2[1]..":"..P2[2])
	if P1[1] == 0 then
		return {P2[1],P2[2]%tau}
	elseif  P2[1] == 0 then
		return {P1[1],P1[2]%tau}
	else
		P1[2] = P1[2]%tau
		P2[2] = P2[2]%tau
		local z = ((P1[1])^2+(P2[1])^2+2*(P1[1])*(P2[1])*math.cos(((P2[2])-(P1[2]))%tau))^0.5
		if z == 0 then
			return {0,0}
		elseif (P2[2]-P1[2])%tau > tau*0.5 then
			local a = ((P1[2])-math.acos(((P1[1])^2+z^2-(P2[1])^2)/(2*(P1[1])*z)))%tau
			return {z,a}
		else
			local a = ((P1[2])+math.acos(((P1[1])^2+z^2-(P2[1])^2)/(2*(P1[1])*z)))%tau
			return {z,a}
		end
	end
end -- this function alone does a lot of the heavy lifting (used substantially with procederal parts of the library)
function MTtrig.Psub(P1,P2) -- subtract latter polar coord from the former
	return MTtrig.Padd(P1,{P2[1],P2[2]+tau*0.5})
end
function MTtrig.Pcc(P0) -- convert polar coordinates {distance,angle} to cartesian coords {x,y}
	local x = (P0[1])*math.sin((P0[2])%tau)
	local y = (P0[1])*math.cos((P0[2])%tau)
	return {x,y}
end
function MTtrig.Cadd(C1,C2) -- add 2 cartesian coords
	return {C1[1]+C2[1],C1[2]+C2[2]}
end
function MTtrig.Csub(C1,C2) -- subtract latter cartesian coord from the former
	return {C1[1]-C2[1],C1[2]-C2[2]}
end
function MTtrig.CmulS(C0,m) -- multiplies a cartesian coordinate by an amount
	return {m*C0[1],m*C0[2]}
end
function MTtrig.Cmul(C1,C2) -- multiplies 2 caresian coordinates together {x1*x2,y1*y2}
	return {C1[1]*C2[1],C1[2]*C2[2]}
end
function MTtrig.Cpc(C0) -- convert cartesian coords {x,y} to polar coordinates {distance,angle}
	local z = ((P0[1])^2+(P0[2])^2)^0.5
	local a = math.atan2(C0[1],C0[2])%tau
	return {z,a}
end
function MTtrig.Tr(A) -- converts turns to radians
	return A*tau
end
function MTtrig.Rt(A) -- converts radians to turns
	return A/tau
end
function MTtrig.PTp(P0) -- converts polar coords in turns to polar coords in radians
	return {P0[1],P0[2]*tau}
end
function MTtrig.Ppt(P0) -- converts polar coords in radians to polar coords in turns
	return {P0[1],P0[2]/tau}
end