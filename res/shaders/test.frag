varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform vec2 v_mousePosition;

void main()
{
	// if (v_texCoord.x>v_mousePosition.x-0.1 &&
	// 		v_texCoord.x<v_mousePosition.x+0.1 &&
	// 		v_texCoord.y>v_mousePosition.y-0.1 &&
	// 		v_texCoord.y<v_mousePosition.y+0.1) {
	// 	gl_FragColor = texture2D(CC_Texture0, v_texCoord);
	// } else {
	// 	gl_FragColor = vec4(1.0,0.0,0.0,.8);
	// }

    // 反相
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0) - texture2D(CC_Texture0, v_texCoord);
    gl_FragColor *= 0.5;
    
    // gl_FragColor = texture2D(CC_Texture0, v_texCoord) * 0.4;
}