// Levando a coordenada da origem do sistema de referencia para o centro da tela.
// e normalizando as coordenadas dos fragmentos para o intervalo [-0.5, 0.5],

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 uv = 2.0 * ((fragCoord / iResolution.xy) - 0.5);		// uv -> coordenadas normalizadas (-0.5 a 0.5)
	
	fragColor = vec4(uv.x, uv.y, 0.0, 1.0);		
}