using Toybox.Math;

class DigitCirclePosition {
	function initialize(regionWidth, regionHeigh, digitSize) {		
		me.radius = (regionWidth - digitSize) / 2 - 10;
		
		me.centerX = (regionWidth - digitSize) / 2;
		me.centerY = (regionHeigh - digitSize) / 2;
	}
	
	private var radius;
	private var centerX;
	private var centerY;
	
	function getPos(posCoefficient) {		
		var twelveOclockOffset = -0.25;
		var angleRad =  Math.PI * 2 * (posCoefficient + twelveOclockOffset);
		
		var result = {};
		result["x"] = me.getXPos(me.radius, angleRad, me.centerX);
		result["y"] = me.getYPos(me.radius, angleRad, me.centerY);
		
		return result;
	}
			
	private function getXPos(radius, angleRad, centerX) {
		return radius * Math.cos(angleRad) + centerX;
	}
	
	private function getYPos(radius, angleRad, centerY) {
		return radius * Math.sin(angleRad) + centerY;
	}
}