// Utilizando a função step() da linguagem GLSL para criar um efeito de borda nítida do círculo
// onde os fragmentos dentro do círculo (com raio definido) terão valor 0.0 
// e os fragmentos fora do círculo terão valor 1.0.

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 	uv 	= 2.0 * (fragCoord / iResolution.xy) - 1.0;		// uv -> coordenadas normalizadas (-1.0 a 1.0)

	uv *= iResolution.xy / min(iResolution.x, iResolution.y); 	// ajusta razão de aspecto

	float raio = 0.5;											// raio do círculo

	float d = abs(length(uv) - raio);							// abs iguala dentro e fora do círculo
	
	d = step(0.006, d);											// aplica função degrau com limiar estreito

	fragColor = vec4(vec3(d), 1.0);								// escala de cinza baseada na distância

}
