shader_type spatial;
render_mode unshaded, depth_prepass_alpha, cull_disabled;

uniform vec3 color = vec3(1.0, 0.0, 0.0);

varying vec3 local_position;

void vertex() {
	local_position = VERTEX;
}

float grid() {
	vec2 uv = mod(local_position.xy * 2.0 + vec2(0.05, 0.55), 1.0);
	return min(1.0, step(uv.x, 0.1) + step(uv.y, 0.1));
}

void fragment() {
	ALBEDO = color;
	EMISSION = color;
	ALPHA = grid();
}
