#iChannel0 "file://imagens/mandrill.png"

float rgb2luma(in vec3 c) {

    return 0.299*c.r + 0.587*c.g + 0.114*c.b;
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

    float gamma = (sin(iTime) + 1.0) * 1.5;

    fragColor = vec4(pow(textureColor.rgb, vec3(gamma)), 1.0) * letterbox;

}