data:extend({
  {
    type = "space-location",
    name = "star",
    icon = "__MT-lib__/graphics/icons/starmap-star.png",
	icon_size = 512,
	starmap_icon = "__MT-lib__/graphics/icons/starmap-star.png",
	starmap_icon_size = 512,
	unlandable = true, --used so you dont get the space platform orbital thingy
	magnitude = 10,
	orbit = {
		polar={0,0},
		no_sprite=true
	}
  }
})