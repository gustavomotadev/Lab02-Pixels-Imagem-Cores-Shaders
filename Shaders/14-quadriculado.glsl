
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 uv = 2.0 * ((fragCoord / iResolution.xy) - 0.5);		// uv -> coordenadas normalizadas (-0.5 a 0.5)

	fragColor = vec4((1.0-step(0.0, uv.x))*(1.0-step(0.0, uv.y)) +
        (step(0.0, uv.x))*(step(0.0, uv.y)), 
        step(0.0, uv.y), 
        step(0.0, uv.x), 1.0);

}