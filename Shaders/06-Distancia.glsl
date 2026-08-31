// Uilizando a função length() da linguagem GLSL para calcular a distância da origem (centro da tela) 
// até as coordenadas normalizadas dos fragmentos (uv),

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 uv = 2.0 * (fragCoord / iResolution.xy) - 1.0;		// uv -> coordenadas normalizadas (-1.0 a 1.0)

	float d = length(uv);									// calcula distância da origem (0,0)
	
	fragColor = vec4(d, 0.0, 0.0, 1.0);						// mapeando a distância para o canal R do fragmento

}
