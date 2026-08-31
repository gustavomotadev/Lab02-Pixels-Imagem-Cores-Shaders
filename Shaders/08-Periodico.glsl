// Uso da função periodica sin() da GLSL para criar um padrão de anéis concêntricos ao redor do centro da tela,


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 	uv 	= (fragCoord / iResolution.xy) *2.0 - 1.0;		// uv -> coordenadas normalizadas (-1.0 a 1.0)

	uv *= iResolution.xy / min(iResolution.x, iResolution.y); 	// ajusta razão de aspecto

	float 	d = length(uv);									

	d = (sin(d));												// criar o padrão periodico

	fragColor = vec4(vec3(d), 1.0);		

}
