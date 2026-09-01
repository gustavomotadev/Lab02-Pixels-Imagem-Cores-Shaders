vec2 rotate2d(vec2 v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    mat2 rot = mat2(c, -s, s, c);
    return rot * v;
}

float minkowski_length(in vec2 vector, in float order) {
    return pow(pow(abs(vector.x), order) + pow(abs(vector.y), order), 1.0 / order);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // -1 to 1 independent of aspect ratio
    vec2 uv = ((fragCoord.xy - (iResolution.xy / 2.0)) / min(iResolution.x, iResolution.y)) * 2.0;

    float line_width = 0.006;
    float radius = 0.5;
    float order = 0.25 + abs(fract(iTime*0.25) - 0.5) * 8.0;

	fragColor = vec4(1.0 - step(radius + line_width, minkowski_length(uv.xy, order)), 
        1.0 - step(line_width, abs(minkowski_length(uv.xy, order) - radius)), 
        step(radius - line_width, minkowski_length(uv.xy, order)),  
        1.0);

}