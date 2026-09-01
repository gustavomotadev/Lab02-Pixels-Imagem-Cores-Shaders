vec2 rotate2d(vec2 v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    mat2 rot = mat2(c, -s, s, c);
    return rot * v;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 uv = (fragCoord / iResolution.xy)*2.0 - vec2(1.0,1.0);

    // time goes from 0 to 2pi and rotates unit vector
    vec2 line_direction = rotate2d(vec2(1.0, 0.0), 
        6.283185*fract(iTime*0.125));

    // assumes x0 = 0 and y0 = 0
    float edge_function = (uv.x*line_direction.y) - (uv.y*line_direction.x);

    float line_width = 0.006;

	fragColor = vec4(step(line_width, edge_function), 
        1.0 - step(line_width, abs(edge_function)), 
        step(line_width, -edge_function), 1.0);

}