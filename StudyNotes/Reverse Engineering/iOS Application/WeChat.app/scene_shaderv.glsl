attribute vec4 position;
attribute vec4 positionColor;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 colorMatrix;

varying vec2 fragUV;
varying mat4 fragColorMatrix;

void main()
{
    fragColorMatrix = colorMatrix;
    vec4 vPos;
    vPos = projectionMatrix * modelViewMatrix * position;
    
    gl_Position = vPos;
}
