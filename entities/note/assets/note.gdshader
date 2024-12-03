shader_type spatial;
render_mode cull_disabled, depth_prepass_alpha;

instance uniform bool dot_note = false;
instance uniform vec3 color = vec3(1.0, 0.0, 0.0);
instance uniform vec3 plane_normal = vec3(0.0, 1.0, 0.0);
instance uniform vec3 plane_position = vec3(0.0, -999.0, 0.0);
instance uniform float t = 0.0;

uniform sampler2D noise_texture;

varying vec3 world_position;
varying vec3 local_position;

float point_to_plane_distance(vec3 point) {
	return (plane_normal.x * (point.x - plane_position.x) + plane_normal.y * (point.y - plane_position.y) + plane_normal.z * (point.z - plane_position.z));
}

vec3 circle() {
	float d = length(local_position.xy) - 0.025;
	if (d <= 0.025) {
		return vec3(1.0);
	}
	else {
		return color;
	}
}

vec3 triangle() {
	float w = 0.13;
    float h = -0.05;
    float r = 0.25 * min(w, h) * 0.5;
	vec2 p = local_position.xy - vec2(0.0, 0.08);
	vec2 q = vec2(w, -h);
    vec2 v = vec2(abs(p.x), p.y);
    vec2 a = v - q * clamp(dot(v, q) / dot(q,q), 0.0, 1.0);
    vec2 b = v - q * vec2(clamp(v.x / q.x, 0.0, 1.0), 1.0);
    float k = sign(q.y);
    float d = min(dot(a, a), dot(b, b));
    float s = max(k * (v.x * q.y - v.y * q.x), k * (v.y - q.y));
    float tri = sqrt(d) * sign(s);

	if (min(tri + r * 2.0, 0.0) < 0.0) {
		return vec3(1.0);
	}

	return color;
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	local_position = VERTEX;
}

void fragment() {
	float d = point_to_plane_distance(local_position);
	if (d < 0.0) {
		ALPHA = 0.0;
	}
	else {
		if (d < 0.025) {
			EMISSION = vec3(1.0);
		}
		else {
			if (FRONT_FACING) {
				if (local_position.z >= 0.0) {
					vec3 value = color;
					if (dot_note == true) {
						value = circle();
					}
					else {
						value = triangle();
					}
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

			if (t > 0.0) {
				float noise = texture(noise_texture, UV).r;
				ALPHA = ceil(noise - t);
				if (noise - t < 0.025) {
					ALBEDO = vec3(1.0);
					EMISSION = vec3(1.0);
				}
			}
		}
	}
}