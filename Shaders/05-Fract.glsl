// Aplicando a função fract() da linguagem GLSL para obter a parte fracionária das coordenadas normalizadas, 
// o que permite criar o efeito de tiling ou "azulejamento" na imagem, 
// com as coordenadas se repetindo a cada intervalo unitário.

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 uv = fragCoord.xy / iResolution.xy;		// uv -> coordenadas normalizadas (0 a 1) 
														 
	uv = fract(uv);									// parte fracionária de x				
	
	fragColor = vec4(uv.xy, 0.0, 1.0);		

}
