#iChannel0 "file://imagens/mandrill.png"

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // -1 to 1 independent of aspect ratio
    vec2 uv = ((fragCoord.xy - (iResolution.xy / 2.0)) / min(iResolution.x, iResolution.y)) * 2.0;

    vec4 textureColor = texture(iChannel0, uv);

    vec4 letterbox = vec4((1.0 - step(1.0, uv.x)) * 
        (1.0 - step(1.0, uv.y)) *
        step(-1.0, uv.x) *
        step(-1.0, uv.y));

	vec4 channels = vec4(
        ((1.0-step(0.0, uv.x))*(1.0-step(0.0, uv.y)) +
        (step(0.0, uv.x))*(step(0.0, uv.y))), 
        
        step(0.0, uv.y), 
        
        step(0.0, uv.x), 
        
        1.0);

    fragColor = textureColor * letterbox * channels;

}