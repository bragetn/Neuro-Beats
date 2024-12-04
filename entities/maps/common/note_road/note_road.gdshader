shader_type spatial;

uniform vec3 base_color = vec3(0.01);
uniform float road_width = 1.9;
uniform float line_width = 0.02;

varying vec3 world_position;
varying vec3 local_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	local_position = VERTEX;
}

vec3 grid() {
	if (local_position.y >= 0.099) {
		vec3 a = mod(local_position * 2.0, 1.0);
		if (a.x < line_width || a.x > 1.0 - line_width) {
			//return a;
			return vec3(1.0);
		}
		else {
			return vec3(0.0);
		}
	}
	else {
		return vec3(0.0);
	}
}

void fragment() {
	ALBEDO = base_color;
	EMISSION = grid();
}
