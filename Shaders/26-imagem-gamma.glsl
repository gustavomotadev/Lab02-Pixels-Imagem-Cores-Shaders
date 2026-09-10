#iChannel0 "file://imagens/mandrill.png"

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

    float time = iTime;
    float deg120 = 3.14159*0.66666;
    float deg240 = 3.14159*1.33333;

    vec3 gammas = (vec3(sin(time), sin(time + deg120), sin(time + deg240)) + 1.0) * 1.5;

    fragColor = vec4(pow(textureColor.rgb, vec3(gamma)), 1.0) * letterbox;

}