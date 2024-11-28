shader_type spatial;
render_mode unshaded, depth_prepass_alpha;

uniform vec3 color_1 = vec3(1.0, 0.0, 0.0);
uniform vec3 color_2 = vec3(0.1, 0.0, 0.0);
uniform float outline_width = 0.1;
uniform float note_width = 0.4;

uniform float bpm = 110.0;
uniform float song_speed = 1.0;
uniform float beat_tempo = 2.0;
uniform float note_speed = 3.0;
uniform float spawn_distance = 15.0;

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

vec4 get_color() {
	if (abs(world_position.x) > 0.95) {
		return vec4(color_1, 1.0);
	}

	float velocity = ((spawn_distance - 1.5) / ((60.0 / bpm) * pow(2.0, 6.0 - note_speed))) * song_speed;
	float time_between_notes = (60.0 * pow(2.0, 4.0 - beat_tempo)) / (bpm * song_speed);
	float line_time = mod(TIME, time_between_notes * ceil(spawn_distance / velocity / time_between_notes));
	float z_position = spawn_distance - velocity * line_time;
	float relative_position = mod(world_position.z + z_position, time_between_notes * velocity);

	if (relative_position >= 0.0 && relative_position < note_width) {
	    return vec4(color_1, 1.0);
	} else {
	    return vec4(color_2, 0.9);
	}
}

void fragment() {
	vec4 color = get_color();
	ALBEDO = color.rgb;
	EMISSION = color.rgb;
	ALPHA = color.a;
}
