// Shader GLSL mínimo, que apenas define uma cor constante para todos os fragmentos da imagem.

// Entrada	: fragCoord -> coordenadas do fragmento 
// Saída	: fragColor -> cor do fragmento

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	fragColor = vec4(1.0, 1.0, 1.0, 1.0);

}
