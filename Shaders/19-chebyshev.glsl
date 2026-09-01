vec2 rotate2d(vec2 v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    mat2 rot = mat2(c, -s, s, c);
    return rot * v;
}

float chebyshev_length(in vec2 vector) {
    return max(abs(vector.x), abs(vector.y));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // -1 to 1 independent of aspect ratio
    vec2 uv = ((fragCoord.xy - (iResolution.xy / 2.0)) / min(iResolution.x, iResolution.y)) * 2.0;

    float line_width = 0.006;
    float radius = 0.5;

	fragColor = vec4(1.0 - step(radius + line_width, chebyshev_length(uv.xy)), 
        1.0 - step(line_width, abs(chebyshev_length(uv.xy) - radius)), 
        step(radius - line_width, chebyshev_length(uv.xy)),  
        1.0);

}