shader_type canvas_item;

uniform float percentage = 0.0;

void fragment() {
	float fade_width = 0.1;
	float transformed_percentage = (2.0 * fade_width + 1.0) * percentage - fade_width;
	
	vec2 uv = UV;
	
	float red = texture(TEXTURE, vec2(uv.x, uv.y)).r;
	float green = texture(TEXTURE, vec2(uv.x, uv.y)).g;
	float blue = texture(TEXTURE, vec2(uv.x, uv.y)).b;
	
	float start = transformed_percentage - fade_width;
	float end = transformed_percentage + fade_width;
	
	if (uv.x <= start) {
		COLOR = vec4(red, green, blue, 0.0);
	} else if (uv.x <= end) {
		float alpha = (uv.x - start)/(end - start);
		COLOR = vec4(red, green, blue, alpha);
	} else {
		COLOR = vec4(red, green, blue, 1.0);
	}
}