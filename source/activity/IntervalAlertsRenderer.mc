using Toybox.Graphics as Gfx;
using Toybox.Lang;

class IntervalAlertsRenderer {
	function initialize(sessionTime, oneOffIntervalAlerts, repeatIntervalAlerts, radius, width) {
		me.mSessionTime = sessionTime;
		me.mOneOffIntervalAlerts = oneOffIntervalAlerts;
		me.mRepeatIntervalAlerts = repeatIntervalAlerts;	
		me.mRadius = radius;
		me.mWidth = width;
	}
	
	private var mSessionTime;
	private var mOneOffIntervalAlerts;
	private var mRepeatIntervalAlerts;
	private var mRadius;
	private var mWidth;
	private const StartDegreeOffset = 90;

    function drawOneOffIntervalAlerts(dc) {
		me.drawIntervalAlerts(dc, me.mOneOffIntervalAlerts);
    }
    
    function drawRepeatIntervalAlerts(dc) {    
		me.drawIntervalAlerts(dc, me.mRepeatIntervalAlerts);
    }
    
    private function drawIntervalAlerts(dc, intervalAlerts) {
		for (var i = 0; i < intervalAlerts.size(); i++) {
    		var intervalAlert = intervalAlerts[i];	
    		var percentageTimes = intervalAlert.getAlertPercentageTimes(me.mSessionTime);
    		for (var pIndex = 0; pIndex < percentageTimes.size(); pIndex++) {
    			me.drawIntervalAlert(dc, percentageTimes[pIndex], intervalAlert.color);
    		}
    	}
    }    
    
    private function getAlertProgressPercentage(percentageTime) {
    	var progressPercentage = percentageTime * 100;
    	if (progressPercentage > 100) {
    		progressPercentage = 100;
    	}
    	else {
    		if (progressPercentage == 0) {
    			progressPercentage = 0.05;
    		}
		}
		return progressPercentage;	
    }
    
    private function drawIntervalAlert(dc, intervalAlertTime, color) {
    	var progressPercentage = me.getAlertProgressPercentage(intervalAlertTime);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(me.mWidth);
        var startDegree = percentageToArcDegree(progressPercentage);
        var endDegree = startDegree - 1.2;
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2,  me.mRadius , Gfx.ARC_CLOCKWISE, startDegree, endDegree);
    }
        
    private static function percentageToArcDegree(percentage) {
    	return StartDegreeOffset - percentage * 3.6;
    }
}