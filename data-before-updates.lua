require("__MT-lib__.basic")
if MTbasic.space_dlc() then
--define the vanilla planets to orbit the star
local tau = 2*math.pi
if mods["space-age"] then
data.raw["planet"]["vulcanus"].orbit =
{
	polar={10,0.1*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_vulcanus.png",
		size=640
	}
}
data.raw["planet"]["nauvis"].orbit = 
{
	polar={15,0.275*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_nauvis.png",
		size=960
	}
}
data.raw["planet"]["gleba"].orbit = 
{
	polar={20,0.175*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_gleba.png",
		size=1280
	}
}
data.raw["planet"]["fulgora"].orbit = 
{
	polar={25,0.325*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_fulgora.png",
		size=1600
	}
}
data.raw["planet"]["aquilo"].orbit = {
	polar={35,0.225*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_aquilo.png",
		size=2240
	}
}
data.raw["space-location"]["solar-system-edge"].orbit = {
	polar={50,0.25*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_solar-system-edge.png",
		size=3200
	}
}
data.raw["space-location"]["shattered-planet"].orbit = {
	polar={80,0.25*tau},
	parent={
		type="space-location",
		name="star"
	},
	no_sprite = true
}
else
data.raw["planet"]["nauvis"].orbit = 
{
	polar={15,0.275*tau},
	parent={
		type="space-location",
		name="star"
	},
	sprite={
		type="sprite",
		filename="__MT-lib__/graphics/orbits/orbit_nauvis.png",
		size=960
	}
}
end
end