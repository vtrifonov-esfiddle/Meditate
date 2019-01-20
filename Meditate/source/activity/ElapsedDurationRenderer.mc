using Toybox.Graphics as Gfx;
using Toybox.Lang;

class ElapsedDuationRenderer {
	function initialize(color, radius, width) {
		me.mColor = color;
		me.mRadius = radius;
		me.mWidth = width;
	}
	
	private var mColor;
	private var mRadius;
	private var mWidth;
	private const StartDegree = 90;

    function drawOverallElapsedTime(dc, overallElapsedTime, alarmTime) {
    	var progressPercentage;
    	if (overallElapsedTime >= alarmTime) {
    		progressPercentage = 100;
    	}
    	else {
    		progressPercentage = 100 * (overallElapsedTime.toFloat() / alarmTime.toFloat());
    		if (progressPercentage == 0) {
    			progressPercentage = 0.05;
    		}
		}		
    	me.drawDuration(dc, progressPercentage);
    }
    private function drawDuration(dc, progressPercentage) {
        dc.setColor(me.mColor, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(me.mWidth);
        var endDegree = StartDegree + percentageToArcDegree(progressPercentage);
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2,  me.mRadius , Gfx.ARC_CLOCKWISE, me.StartDegree, endDegree);
    }
    
    private static function percentageToArcDegree(percentage) {
    	return - percentage * 3.6;
    }
}