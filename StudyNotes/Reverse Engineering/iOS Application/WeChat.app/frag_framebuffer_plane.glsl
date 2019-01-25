precision mediump float;
const int kernelSize = 5;
varying vec2 fragUV;
varying mat4 fragColorMatrix;
//varying vec2 vBlurTexCoords[15];
uniform sampler2D diffuseMap;
uniform int directionX;
uniform int needColorMatrix;
const bool blur = true;

vec4 sampleColor(vec2 sampleUV)
{
    vec4 originColor = texture2D(diffuseMap, sampleUV);
    return originColor;
}

void main(void)
{
    vec4 finalColor = vec4(0.0);
    
    float kernel[3];
    kernel[0] = 0.153388;
    kernel[1] = 0.221461;
    kernel[2] = 0.250301;
    int halfLength = 3;
    int value;
    float strength = 8.0;
    
    for (int i=0; i<kernelSize; i++) {
        value = i;
        if (i >= halfLength) {
            value = kernelSize - i - 1;
        }
        
        float sampleIndex = float(i) - (float(halfLength) - 1.0);
        
        if (directionX > 0) {
            vec2 sampleYUV = fragUV + vec2(0.0, (sampleIndex * float(strength)/896.0));
            finalColor += sampleColor(sampleYUV) * kernel[value];
        }
        else {
            vec2 sampleXUV = fragUV + vec2((sampleIndex * float(strength))/414.0, 0.0);
            finalColor += sampleColor(sampleXUV) * kernel[value];
        }
    }
    
    if (!blur) {
        finalColor = texture2D(diffuseMap, fragUV);
    }
    
    if (needColorMatrix > 0) {
        vec4 matrixedColor = finalColor * fragColorMatrix;
        matrixedColor.a -= 3.84;
        finalColor = matrixedColor;
    }
    
    gl_FragColor = finalColor;
}
