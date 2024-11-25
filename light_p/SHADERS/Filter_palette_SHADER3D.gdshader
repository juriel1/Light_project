shader_type spatial;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;

uniform vec3 Palette_Red[4];
uniform vec3 Palette_Green[4];
uniform vec3 Palette_Blue[4];

uniform bool On_shader;
uniform int Color_palette; // 1 - R, 2 - G, 3 - B

void fragment() {
    vec3 Palette_target[4];
    if (Color_palette == 1) {
        Palette_target = Palette_Red;
    } else if (Color_palette == 2) {
        Palette_target = Palette_Green;
    } else if (Color_palette == 3) {
        Palette_target = Palette_Blue;
    } else {
        Palette_target = Palette_Red;
    }

    vec3 darknesColor_ = Palette_target[0];
    vec3 darkColor_ = Palette_target[1];
    vec3 ligthColor_ = Palette_target[2];
    vec3 ligthesColor_ = Palette_target[3];

    vec3 textureColor = texture(screen_texture, SCREEN_UV).xyz;

    if (On_shader) {
        if (textureColor.x < 0.3 && textureColor.y < 0.3) {
            ALBEDO = darknesColor_;
        } else if (textureColor.x < 0.5 && textureColor.y < 0.5) {
            ALBEDO = darkColor_;
        } else if (textureColor.x > 0.5 && textureColor.y > 0.5 && textureColor.z > 0.5) {
            ALBEDO = ligthesColor_;
        } else {
            ALBEDO = ligthColor_;
        }
    } else {
        ALBEDO = textureColor;
    }
}