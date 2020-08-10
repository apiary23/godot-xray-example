shader_type spatial;
render_mode depth_test_disable;

void fragment() {
	
	vec4 world_v = CAMERA_MATRIX * vec4(VERTEX, 1.0); // vertex in world space
	vec3 cam_depth = VIEW;
	
	float depth = textureLod(DEPTH_TEXTURE, SCREEN_UV, 0.0).r;
	vec3 ndc = vec3(SCREEN_UV, depth) * 2.0 - 1.0;
	vec4 view_position = CAMERA_MATRIX * INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view_position.xyz /= view_position.w;
	ALBEDO = (view_position - world_v).xxx;
	ALBEDO = vec3(length(view_position - world_v));
	
	vec4 cam_dist = CAMERA_MATRIX[3];
	
	float dist_to_frag = length(cam_dist.xyz - view_position.xyz);
	float dist_to_vert = length(cam_dist.xyz - world_v.xyz);
	
	if (dist_to_frag > dist_to_vert) {
		ALBEDO = vec3(0.2, 0.9, 0.2);
	} else {
		ALBEDO = vec3(0.3, 0.3, 0.3);
		ALPHA = 0.5;
	}
}