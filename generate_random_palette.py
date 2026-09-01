import random
import re

glsl_code = """
// cosine based palettes, 4 vec3 params
// a = brightness [-1, 2]
// b = contrast [-1, 1]
// c = color_change_rate [0, 1.5]
// d = color_pick_locations [0, 1)
vec3 palette1(in float k)
{
    vec3 a = vec3(0.0,0.0,0.0);
    vec3 b = vec3(0.0,0.0,0.0);
    vec3 c = vec3(0.0,0.0,0.0);
    vec3 d = vec3(0.0,0.0,0.0);
    return a + b*cos( 6.283185*(c*k+d) );
}
"""

# Defined ranges for each vector (min, max)
RANGES = {
    "a": (-1.0, 2.0),
    "b": (-1.0, 1.0),
    "c": (0.0, 1.5),
    "d": (0.0, 1.0),
}


def generate_random_vec3(var_name: str) -> str:
    low, high = RANGES[var_name]
    vals = [round(random.uniform(low, high), 4) for _ in range(3)]
    return f"vec3 {var_name} = vec3({vals[0]}, {vals[1]}, {vals[2]});"


def randomize_glsl_palettes(code: str) -> str:
    pattern = r"vec3\s+([a-d])\s*=\s*vec3\([^)]+\);"
    return re.sub(pattern, lambda match: generate_random_vec3(match.group(1)), code)


if __name__ == "__main__":
    output_code = randomize_glsl_palettes(glsl_code)
    print(output_code)