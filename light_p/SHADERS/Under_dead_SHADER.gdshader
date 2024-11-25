shader_type spatial;

uniform vec4 custom_color; // Color base de fondo
uniform vec4 dot_color; // Color de los puntos
uniform float speed : hint_range(0.0, 10.0); // Velocidad de movimiento
uniform float min_dot_size : hint_range(0.001, 0.01); // Tamaño mínimo de los puntos
uniform float max_dot_size : hint_range(0.1, 0.2); // Tamaño máximo de los puntos
uniform float grid_spacing : hint_range(0.1, 1.0); // Espaciado entre puntos, afecta la cantidad de puntos

// Función para generar números aleatorios a partir de coordenadas UV
float random(vec2 p) {
    return fract(sin(dot(p ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    // Color base para el fondo
    vec3 base_color = custom_color.rgb;

    // Generar coordenadas para los puntos
    vec2 uv = UV;
    uv.x += TIME * speed; // Movimiento horizontal animado

    // Crear patrón de puntos, ajustando el espaciado
    float grid_x = floor(uv.x / grid_spacing) * grid_spacing;
    float grid_y = floor(uv.y / grid_spacing) * grid_spacing;

    // Posición central de cada celda
    vec2 dot_center = vec2(grid_x + grid_spacing * 0.5, grid_y + grid_spacing * 0.5);

    // Distancia al centro del punto
    float dist = length(uv - dot_center);

    // Generar un tamaño aleatorio para cada punto en el rango [min_dot_size, max_dot_size]
    float random_size = mix(min_dot_size, max_dot_size, random(dot_center));

    // Crear puntos circulares con bordes suaves
    float dot = smoothstep(random_size * 0.5, random_size * 0.45, dist);

    // Mezclar el color base con el color de los puntos
    vec3 final_color = mix(base_color, dot_color.rgb, dot);

    // Asignar color final
    ALBEDO = final_color;
    ALPHA = custom_color.a;
}
