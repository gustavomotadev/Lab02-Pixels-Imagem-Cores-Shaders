
#iChannel0 "file://imagens/lena.png"

const int k_size = 3;  

const float kernelBlur[k_size*k_size] = float[k_size*k_size](   1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0,
                                                                1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0,
                                                                1.0 / 9.0, 1.0 / 9.0, 1.0 / 9.0
                                                            );

vec2 calcula_uv(vec2 f_coord) {
     // Obtém as dimensões da imagem e da janela
    vec2 imgSize 		= iChannelResolution[0].xy;
    vec2 viewPort 		= iResolution.xy;

    // Calcula as proporções (largura / altura)
    float imgRatio 		= imgSize.x / imgSize.y;
    float screenRatio 	= viewPort.x / viewPort.y;

    // Define a área onde a imagem será desenhada, mantendo a proporção
    vec2 resizeTarget 	= viewPort;
    vec2 startPos 		= vec2(0.0);

    if (imgRatio > screenRatio) { 
        // Imagem é mais larga que a tela: preenche a largura
        resizeTarget.x 	= viewPort.x;
        resizeTarget.y 	= viewPort.x / imgRatio;
        startPos.y 		= (viewPort.y - resizeTarget.y) * 0.5; // centraliza verticalmente
        } 
    else { 
        // Imagem é mais alta que a tela: preenche a altura
        resizeTarget.y 	= viewPort.y;
        resizeTarget.x 	= viewPort.y * imgRatio;
        startPos.x 		= (viewPort.x - resizeTarget.x) * 0.5; // centraliza horizontalmente
        }

    return (f_coord - startPos) / resizeTarget;
}

vec4 converteEscalaDeCinzas(vec2 uv) {
    vec4 cor = texture(iChannel0, uv);
    
    // Calcula a intensidade da cor (média dos canais RGB)
    float intensidade = (cor.r + cor.g + cor.b) / 3.0;
    
    // Aplica o filtro de intensidade
    return vec4(intensidade, intensidade, intensidade, cor.a);
}

vec4 aplicaKernel(vec2 uv, int k_size, float kernel[k_size*k_size]) {
    vec2 texelSize = 1.0 / iChannelResolution[0].xy; // Tamanho de um texel
    vec4 resultado = vec4(0.0);
    
    int half_k = k_size / 2;
    
    for (int i = -half_k; i <= half_k; i++) {
        for (int j = -half_k; j <= half_k; j++) {
            vec2 offset = vec2(float(i), float(j)) * texelSize;
            vec4 cor = texture(iChannel0, uv + offset);
            resultado += cor * kernel[(i + half_k) * k_size + (j + half_k)];
        }
    }
    
    return resultado;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    // Calcula a coordenada UV para o pixel atual
    vec2 uv = calcula_uv(fragCoord);

    // Verifica se o pixel está dentro da área da imagem
    if (uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0) {
        fragColor = aplicaKernel(uv, k_size, kernelBlur);
        }
    else 
        fragColor = vec4(0.0); 
}