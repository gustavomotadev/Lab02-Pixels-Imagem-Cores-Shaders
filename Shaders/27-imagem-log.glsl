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

    float base = (sin(iTime*1.5) + 1.0) * 15.0 + 1.1;

    fragColor = vec4(vec3(logBaseB(1.0 + textureColor.r, base), 
        logBaseB(1.0 + textureColor.g, base), 
        logBaseB(1.0 + textureColor.b, base)), 
        1.0) * 
        letterbox;

}