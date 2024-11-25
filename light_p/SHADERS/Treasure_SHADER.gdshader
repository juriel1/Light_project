shader_type spatial;

uniform vec4 custom_color;

void fragment() {
    ALBEDO = custom_color.rgb;
    ALPHA = custom_color.a;
}
