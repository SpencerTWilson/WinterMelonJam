shader_type canvas_item;

uniform vec4 Team1 : source_color;
uniform vec4 Team2 : source_color;
uniform float value : hint_range(0.0, 1.0) = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = mix(Team1, Team2, smoothstep(value - 0.05,value + 0.05, UV.r));
	COLOR.a = pow(distance(vec2(0.5), UV),4) * 4.0;
}
