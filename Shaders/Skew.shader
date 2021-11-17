shader_type canvas_item;

uniform vec2 topleft;
uniform vec2 topright;
uniform vec2 bottomleft;
uniform vec2 bottomright;

void vertex(){
	
	if( UV.x <= 0.0 && UV.y <= 0.0) {
		VERTEX+=topleft
	}
	if( UV.x >= 1.0 && UV.y <= 0.0) {
		VERTEX+=topright
	}
	if( UV.x <= 0.0 && UV.y >= 1.0) {
		VERTEX+=bottomleft
	}
	if( UV.x >= 1.0 && UV.y >= 1.0) {
		VERTEX+=bottomright
	}
}