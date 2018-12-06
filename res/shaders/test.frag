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
    vec4 color = texture2D(CC_Texture0, v_texCoord);
	// 用min函数是避免alpha值不起作用
	color.r = min(1.0 - color.r, color.a);
	color.g = min(1.0 - color.g, color.a);
	color.b = min(1.0 - color.b, color.a);
	gl_FragColor = color;
}