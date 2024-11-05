shader_type spatial;
render_mode unshaded, depth_prepass_alpha;

uniform vec3 color = vec3(1.0, 0.0, 0.0);
uniform vec2 size = vec2(2.02, 10.0);
uniform float outline_width = 0.1;
uniform float note_width = 0.4;

uniform float delta = 0.0;

uniform float bpm = 110.0;
uniform float song_speed = 1.0;
uniform float beat_tempo = 2.0;
uniform float note_speed = 3.0;
uniform float spawn_distance = 15.0;

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

float get_alpha() {
    // Calculate note velocity based on note speed and song speed, matching your spawn speed
    float velocity = ((spawn_distance - 1.5) / ((60.0 / bpm) * pow(2.0, 6.0 - note_speed))) * song_speed;

    // Calculate the time interval between notes
    float time_between_notes = (60.0 * pow(2.0, 4.0 - beat_tempo)) / (bpm * song_speed);

    // Calculate the current time offset for each note based on the spacing interval
    float line_time = mod(TIME, time_between_notes * ceil(spawn_distance / velocity / time_between_notes));

    // Calculate how far each line has traveled based on velocity and time offset
    float z_position = spawn_distance - velocity * line_time;

    // For multiple lines: calculate relative position for each interval along z-axis
    float relative_position = mod(world_position.z + z_position, time_between_notes * velocity);

    // Visibility check: determine if relative_position is within the note width range
    if (relative_position >= 0.0 && relative_position < note_width) {
        return 1.0; // Fully visible within note width range
    } else {
        return 0.2;  // Less visible outside the note width range
    }
}

void fragment() {
	ALBEDO = color;
	EMISSION = color;
	ALPHA = get_alpha();
}
