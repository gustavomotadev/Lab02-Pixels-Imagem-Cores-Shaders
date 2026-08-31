// Normalizando as coordenadas dos fragmentos (dada por fragCoord) para o intervalo [0, 1], 
// onde (0, 0) é o canto inferior esquerdo da tela e (1, 1) é o canto superior direito.
// para isso utilizamos a variável uniformiResolution, que contém a resolução da tela em pixels.

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 uv = fragCoord / iResolution.xy;		// uv -> coordenadas normalizadas (0 a 1)
	
	fragColor = vec4(uv.x, uv.y, 0.0, 1.0);		

}
