shader_type spatial;
render_mode cull_back;

instance uniform vec3 color = vec3(1, 0, 0);

void fragment() {
	ALBEDO = color;
	EMISSION = color;
}