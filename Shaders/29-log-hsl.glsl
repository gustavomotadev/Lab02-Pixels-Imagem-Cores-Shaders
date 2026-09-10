#iChannel0 "file://imagens/mandrill.png"

vec3 hsl2rgb(vec3 hsl) {
    // Pure hue vector
    vec3 rgb = clamp(abs(mod(hsl.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    // Scale by saturation and adjust lightness
    return hsl.z + hsl.y * (rgb - 0.5) * (1.0 - abs(2.0 * hsl.z - 1.0));
}

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

float logBaseB( in float x, in float b) {

    return log(x) / log(b);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    float minRes = min(iResolution.x, iResolution.y);
    vec2 offset = ((iResolution.xy - minRes) / 2.0);
    vec2 uv = ((fragCoord.xy - offset) / minRes);

    vec4 textureColor = texture(iChannel0, uv);

    vec4 letterbox = vec4((1.0 - step(1.0, uv.x)) * 
        (1.0 - step(1.0, uv.y)) *
        step(0.0, uv.x) *
        step(0.0, uv.y));

    float base = (sin(iTime*1.5) + 1.0) * 5.0 + 1.1;

    vec3 hsl = rgb2hsl(textureColor.rgb);
    hsl.z = logBaseB(1.0 + hsl.z, base);

    fragColor = vec4(hsl2rgb(hsl), 1.0) * letterbox;

}