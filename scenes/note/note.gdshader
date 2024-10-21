shader_type spatial;
render_mode cull_disabled, depth_prepass_alpha;

instance uniform vec3 color = vec3(1.0, 0.0, 0.0);
instance uniform vec3 plane_normal = vec3(0.0, 1.0, 0.0);
instance uniform vec3 plane_position = vec3(0.0, -999.0, 0.0);

varying vec3 world_position;
varying vec3 local_position;

float point_to_plane_distance(vec3 point) {
	return (plane_normal.x * (point.x - plane_position.x) + plane_normal.y * (point.y - plane_position.y) + plane_normal.z * (point.z - plane_position.z));
}

vec3 circle(vec2 center, float radius) {
	float d = length(center - local_position.xy) - radius;
	if (d <= radius) {
		return vec3(1.0);
	}
	else {
		return color;
	}
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	local_position = VERTEX;
}

void fragment() {
	float d = point_to_plane_distance(world_position);
	if (d < 0.0) {
		ALPHA = 0.0;
	}
	else if (d < 0.025){
		EMISSION = vec3(1.0);
	}
	else {
		if (FRONT_FACING){
			if (local_position.z >= 0.0) {
				vec3 value = circle(vec2(0.0, 0.1), 0.025);
				ALBEDO = value;
				EMISSION = value;
			}
			else {
				ALBEDO = color;
				EMISSION = color;
			}
			ROUGHNESS = 0.1;
			METALLIC = 0.0;
		}
		else {
			ALBEDO = vec3(0.0);
		}
	}
}