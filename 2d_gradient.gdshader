shader_type canvas_item;

void vertex() {	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.a = SCREEN_UV.y/2.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
