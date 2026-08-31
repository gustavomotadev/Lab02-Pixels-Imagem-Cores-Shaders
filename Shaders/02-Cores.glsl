// Shader que define o valor dos 3 canais da cor de desenho, sendo uma funnção do tempo (iTime).
// o uso da função cos() faz com que o valor da cor varie suavemente entre 0.0 e 1.0.

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    
    float r = 0.5*cos(iTime)+0.5;
    float g = 1.0 - (0.5*cos(iTime)+0.5);
    float b = 0.0;

    fragColor = vec4(r, g, b, 1.0);
}