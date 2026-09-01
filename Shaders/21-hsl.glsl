
vec3 hsl2rgb(vec3 hsl) {
    // Pure hue vector
    vec3 rgb = clamp(abs(mod(hsl.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    // Scale by saturation and adjust lightness
    return hsl.z + hsl.y * (rgb - 0.5) * (1.0 - abs(2.0 * hsl.z - 1.0));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // -1 to 1 independent of aspect ratio
    vec2 uv = ((fragCoord.xy - (iResolution.xy / 2.0)) / min(iResolution.x, iResolution.y)) * 2.0;

    float hue = mod(atan(uv.y, uv.x), 6.283185) / 6.283185;
    float saturation = length(uv.xy);
    float slowdown_factor = 0.125;
    float lightness = abs(fract(iTime*slowdown_factor*2.0) - 0.5) * 2.0;

	fragColor = vec4(hsl2rgb(vec3(hue, saturation, lightness)) *
    (1.0 - step(1.0 + (step(0.5, fract(iTime*slowdown_factor)) * 1000.0), length(uv.xy))), 
    1.0);

}