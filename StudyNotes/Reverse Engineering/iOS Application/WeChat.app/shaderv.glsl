attribute vec4 position;
attribute vec4 positionColor;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 colorMatrix;

varying lowp vec4 varyColor;


void main()
{
        varyColor = colorMatrix * positionColor;
//        varyColor = positionColor;
    
    vec4 vPos;
    vPos = projectionMatrix * modelViewMatrix * position;
    
//    vPos = position;

    gl_Position = vPos;
}
