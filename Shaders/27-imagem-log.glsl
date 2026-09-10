#iChannel0 "file://imagens/mandrill.png"

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

    float time = iTime * 1.5;
    float deg120 = 3.14159*0.66666;
    float deg240 = 3.14159*1.33333;

    vec3 bases = ((vec3(sin(time), sin(time + deg120), sin(time + deg240)) + 1.0) * 5.0) + 1.1;

    fragColor = vec4(vec3(logBaseB(1.0 + textureColor.r, bases.x), 
        logBaseB(1.0 + textureColor.g, bases.y), 
        logBaseB(1.0 + textureColor.b, bases.z)), 
        1.0) * 
        letterbox;

}