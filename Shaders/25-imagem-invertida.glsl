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

    vec4 inverted = vec4(1.0 - textureColor.r, 1.0 - textureColor.g, 1.0 - textureColor.b, 1.0);

    float time = iTime;
    float deg120 = 3.14159*0.66666;
    float deg240 = 3.14159*1.33333;

    vec4 timings = vec4(step(0.0, sin(iTime)), step(0.0, sin(iTime + deg120)), step(0.0, sin(iTime + deg240)), 1.0);
    vec4 invertedTimings = 1.0 - timings;

    fragColor = ((textureColor * timings) + (inverted * invertedTimings)) * letterbox;
}