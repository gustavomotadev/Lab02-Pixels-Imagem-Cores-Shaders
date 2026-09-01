
// cosine based palettes, 4 vec3 params
// a = brightness [-1, 2]
// b = contrast [-1, 1]
// c = color_change_rate [0, 1.5]
// d = color_pick_locations [0, 1)
vec3 palette1(in float k)
{
    vec3 a = vec3(0.3638, 0.8165, -0.6782);
    vec3 b = vec3(0.9492, 0.8565, 0.9582);
    vec3 c = vec3(0.5901, 1.2437, 1.2791);
    vec3 d = vec3(0.83, 0.1691, 0.3269);
    return a + b*cos( 6.283185*(c*k+d) );
}
vec3 palette2(in float k)
{
    vec3 a = vec3(0.2407, 0.8446, 1.7104);
    vec3 b = vec3(-0.6478, 0.5013, -0.8885);
    vec3 c = vec3(1.297, 1.0409, 1.4068);
    vec3 d = vec3(0.2891, 0.2766, 0.5262);
    return a + b*cos( 6.283185*(c*k+d) );
}

// Convert sRGB to Linear space
vec3 srgbToLinear(vec3 srgb) {
    return pow(max(srgb, vec3(0.0)), vec3(2.2));
}

// Convert Linear space back to sRGB
vec3 linearToSrgb(vec3 linear) {
    return pow(linear, vec3(1.0 / 2.2));
}

// Gamma-correct color blending
vec3 mixGammaCorrect(vec3 colorA, vec3 colorB, float k) {
    vec3 linearA = srgbToLinear(colorA);
    vec3 linearB = srgbToLinear(colorB);
    vec3 mixedLinear = mix(linearA, linearB, k);
    return linearToSrgb(mixedLinear);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // Scale and offset to remap time to range [0.0, 1.0]
    // multiplying time changes speed
    float time_fast = 0.5 + 0.5 * sin(iTime*0.5);
    float time_slow = 0.5 + 0.5 * sin(iTime*0.25);

    vec2 uv = fragCoord.xy / iResolution.xy;
    uv = uv + time_slow;

	fragColor = vec4(mixGammaCorrect(palette1(uv.x),
        palette2(uv.y), time_fast), 
        1.0);

}
