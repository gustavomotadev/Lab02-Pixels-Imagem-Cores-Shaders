#iChannel0 "file://imagens/mandrill.png"

vec3 rgb2hsl(vec3 c) {
    float maxC = max(max(c.r, c.g), c.b);
    float minC = min(min(c.r, c.g), c.b);
    float delta = maxC - minC;

    float l = (maxC + minC) * 0.5;
    float h = 0.0;
    float s = 0.0;

    if (delta > 0.00001) {
        s = l < 0.5 ? delta / (maxC + minC) : delta / (2.0 - (maxC + minC));

        if (c.r >= maxC) {
            h = (c.g - c.b) / delta + (c.g < c.b ? 6.0 : 0.0);
        } else if (c.g >= maxC) {
            h = (c.b - c.r) / delta + 2.0;
        } else {
            h = (c.r - c.g) / delta + 4.0;
        }
        h /= 6.0;
    }

    return vec3(h, s, l);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // -1 to 1 independent of aspect ratio
    vec2 uv = ((fragCoord.xy - (iResolution.xy / 2.0)) / min(iResolution.x, iResolution.y)) * 2.0;

    vec4 textureColor = texture(iChannel0, uv);

    vec4 hslColor = vec4(rgb2hsl(vec3(textureColor.r, textureColor.g, textureColor.b)), 1.0);

    vec4 letterbox = vec4((1.0 - step(1.0, uv.x)) * 
        (1.0 - step(1.0, uv.y)) *
        step(-1.0, uv.x) *
        step(-1.0, uv.y));

	vec4 firstQuadrant = vec4(step(0.0, uv.x)*step(0.0, uv.y)) * textureColor;
	vec4 secondQuadrant = vec4(step(0.0, -uv.x)*step(0.0, uv.y)) * hslColor.x;
	vec4 thirdQuadrant = vec4(step(0.0, -uv.x)*step(0.0, -uv.y)) * hslColor.y;
	vec4 fourthQuadrant = vec4(step(0.0, uv.x)*step(0.0, -uv.y)) * hslColor.z;

    fragColor = (firstQuadrant + secondQuadrant + thirdQuadrant + fourthQuadrant) * letterbox;

}