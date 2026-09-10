#iChannel0 "file://imagens/mandrill.png"

float rgb2luma(in vec3 c) {

    return 0.299*c.r + 0.587*c.g + 0.114*c.b;
}

float gx(in vec2 uv) {

    vec2 inc = 1.0 / iChannelResolution[0].xy;

    return (rgb2luma(texture(iChannel0, uv + vec2(-inc.x, inc.y)).rgb) * -1.0) +
        (rgb2luma(texture(iChannel0, uv + vec2(-inc.x, 0.0)).rgb) * -2.0) +
        (rgb2luma(texture(iChannel0, uv - inc).rgb) * -1.0) +
        (rgb2luma(texture(iChannel0, uv + inc).rgb) * 1.0) + 
        (rgb2luma(texture(iChannel0, uv + vec2(inc.x, 0.0)).rgb) * 2.0) +
        (rgb2luma(texture(iChannel0, uv + vec2(inc.x, -inc.y)).rgb) * 1.0);
}

float gy(in vec2 uv) {

    vec2 inc = 1.0 / iChannelResolution[0].xy;

    return (rgb2luma(texture(iChannel0, uv + vec2(-inc.x, inc.y)).rgb) * -1.0) +
        (rgb2luma(texture(iChannel0, uv + vec2(0.0, inc.y)).rgb) * -2.0) +
        (rgb2luma(texture(iChannel0, uv + inc).rgb) * -1.0) +
        (rgb2luma(texture(iChannel0, uv - inc).rgb) * 1.0) + 
        (rgb2luma(texture(iChannel0, uv + vec2(0.0, -inc.y)).rgb) * 2.0) +
        (rgb2luma(texture(iChannel0, uv + vec2(inc.x, -inc.y)).rgb) * 1.0);
}

float sobel(in vec2 uv) {
    float gx_temp = gx(uv);
    float gy_temp = gy(uv);
    return sqrt(gx_temp*gx_temp + gy_temp*gy_temp);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    float minRes = min(iResolution.x, iResolution.y);
    vec2 offset = ((iResolution.xy - minRes) / 2.0);
    vec2 uv = ((fragCoord.xy - offset) / minRes);

    // vec4 textureColor = texture(iChannel0, uv);

    vec4 letterbox = vec4((1.0 - step(1.0, uv.x)) * 
        (1.0 - step(1.0, uv.y)) *
        step(0.0, uv.x) *
        step(0.0, uv.y));

    fragColor = vec4(gx(uv), sobel(uv), gy(uv), 1.0) * letterbox;

}