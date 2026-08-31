#iChannel0 "file://imagens/lena.png"

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 uv = fragCoord / iResolution.xy;
   
	vec4 cor = texture(iChannel0, uv);
    fragColor = cor;

}
