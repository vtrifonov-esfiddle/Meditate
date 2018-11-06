module HrvAlgorithms {
	class HrvActivity extends HrActivity {
		function initialize(fitSession, hrvTracking, isStressTracked, heartbeatIntervalsSensor) {
			me.mHrvTracking = hrvTracking;
			me.mIsStressTracked = isStressTracked;
			me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
			HrActivity.initialize(fitSession);
		}
		
		private var mHrvTracking;
		private var mIsStressTracked;
		private var mHeartbeatIntervalsSensor;
		
		private var mHrvMonitor;
		private var mStressMonitor;
		
		private function isHrvOn() {
			return me.mHrvTracking != HrvTracking.Off;
		}
		
		protected function onBeforeStart(fitSession) {
			if (me.isHrvOn()) {					
				me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(method(:onOneSecBeatToBeatIntervals));
				me.mHrvMonitor = new HrvMonitor(fitSession, me.mHrvTracking);
				me.mStressMonitor = new StressMonitor(fitSession, me.mHrvTracking);
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