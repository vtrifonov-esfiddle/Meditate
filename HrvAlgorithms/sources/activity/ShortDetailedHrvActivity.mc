module HrvAlgorithms {
	class ShortDetailedHrvActivity extends HrActivity {
		function initialize(fitSession, heartbeatIntervalsSensor) {
			me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
			HrActivity.initialize(fitSession);
		}
		
		private var mHeartbeatIntervalsSensor;		
		private var mHrvMonitor;
		
		
		protected function onBeforeStart(fitSession) {		
			me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(method(:onOneSecBeatToBeatIntervals));
			me.mHrvMonitor = new HrvMonitorDetailed(fitSession, false);
		}
		
		function onOneSecBeatToBeatIntervals(heartBeatIntervals) {
			me.mHrvMonitor.addOneSecBeatToBeatIntervals(heartBeatIntervals);
		}
		
		protected function onBeforeStop() {
	    	me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
		}
		
		private var mHrvSuccessive;
		
		protected function onRefreshHrActivityStats(activityInfo, minHr) {	
    		me.mHrvSuccessive = me.mHrvMonitor.calculateHrvSuccessive();		
    		me.onRefreshHrvActivityStats(activityInfo, minHr, me.mHrvSuccessive);
		}
		
		protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {
		}
		
		function calculateSummaryFields() {	
			var hrSummary = HrActivity.calculateSummaryFields();	
			var activitySummary = new ActivitySummary();
			activitySummary.hrSummary = hrSummary;
			activitySummary.hrvSummary = me.mHrvMonitor.calculateHrvSummary();
			return activitySummary;
		}
	}	
}