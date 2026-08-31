// Uso da função periodica sin() da GLSL para criar um padrão de anéis concêntricos ao redor do centro da tela.
// a função paletta cria um padrão de cores, baseado na interpolação de 4 cores básicas 
// (veja referencia: https://iquilezles.org/articles/palettes/).

vec3 paletta( in float t ) {

	vec3 a = vec3(0.5, 0.5, 0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(1.0, 1.0, 1.0);
	vec3 d = vec3(0.263, 0.416, 0.557);
    return a + b*cos( 6.283185*(c*t+d) );
}


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	float 	raio = 0.5;											// raio do círculo

	vec2 	uv 	= (fragCoord / iResolution.xy) *2.0 - 1.0;		// uv -> coordenadas normalizadas (-1.0 a 1.0)

	uv *= iResolution.xy / min(iResolution.x, iResolution.y); 	// ajusta razão de aspecto

	float 	d = length(uv);									

	vec3 cor = paletta(d);										// cor da paleta baseada na distancia ao centro da tela

	d = abs(sin(d));											// criar o padrão periodico

	fragColor = vec4(cor, 1.0);		

}
