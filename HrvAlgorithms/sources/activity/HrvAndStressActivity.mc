module HrvAlgorithms {
	class HrvAndStressActivity extends HrActivity {
		function initialize(fitSession, hrvTracking, heartbeatIntervalsSensor) {
			me.mHrvTracking = hrvTracking;
			me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
			HrActivity.initialize(fitSession);
		}
		
		private var mHrvTracking;
		private var mHeartbeatIntervalsSensor;
		
		private var mHrvMonitor;
		private var mStressMonitor;
		
		private function isHrvOn() {
			return me.mHrvTracking != HrvTracking.Off;
		}
		
		protected function onBeforeStart(fitSession) {
			if (me.isHrvOn()) {					
				me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(method(:onOneSecBeatToBeatIntervals));
				me.mStressMonitor = new StressMonitor(fitSession, me.mHrvTracking);
				if (me.mHrvTracking == HrvTracking.OnDetailed) {
					me.mHrvMonitor = new HrvMonitorDetailed(fitSession, true);					
				}
				else {
					me.mHrvMonitor = new HrvMonitorDefault(fitSession);
				}
			}
		}
		
		function onOneSecBeatToBeatIntervals(heartBeatIntervals) {
			if (me.isHrvOn()) {	
				me.mHrvMonitor.addOneSecBeatToBeatIntervals(heartBeatIntervals);
				me.mStressMonitor.addOneSecBeatToBeatIntervals(heartBeatIntervals);	
			} 
		}
		
		protected function onBeforeStop() {
			if (me.isHrvOn()) {
		    	me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
	    	}
		}
		
		private var mHrvSuccessive;
		
		protected function onRefreshHrActivityStats(activityInfo, minHr) {	
			if (me.isHrvOn()) {
	    		me.mHrvSuccessive = me.mHrvMonitor.calculateHrvSuccessive();	
	    	}	    	
    		me.onRefreshHrvActivityStats(activityInfo, minHr, me.mHrvSuccessive);
		}
		
		protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {
		}
		
		function calculateSummaryFields() {	
			var hrSummary = HrActivity.calculateSummaryFields();	
			var activitySummary = new ActivitySummary();
			activitySummary.hrSummary = hrSummary;
			if (me.isHrvOn()) {
				activitySummary.hrvSummary = me.mHrvMonitor.calculateHrvSummary();
				activitySummary.stress = me.mStressMonitor.calculateStress(hrSummary.minHr);
			}
			return activitySummary;
		}
	}	
}