using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.ActivityRecording;
using Toybox.Sensor;

module HrvAlgorithms {
	class HrActivity {
		function initialize(fitSessionSpec) {
			me.mFitSession = ActivityRecording.createSession(fitSessionSpec);
			me.createMinHrDataField();	
			me.onBeforeStart(me.mFitSession);
			me.mFitSession.start(); 
			me.mRefreshActivityTimer = new Timer.Timer();		
			me.mRefreshActivityTimer.start(method(:refreshActivityStats), RefreshActivityInterval, true);
		}
			
		private var mFitSession;		
		private const RefreshActivityInterval = 1000;	
		private var mRefreshActivityTimer;
			
		protected function onBeforeStart(fitSession) {
		}
		
		function stop() {	
			if (me.mFitSession.isRecording() == false) {
				return;
		    }
		    me.onBeforeStop();
			me.mFitSession.stop();		
			me.mRefreshActivityTimer.stop();
			me.mRefreshActivityTimer = null;
		}
		
		protected function onBeforeStop() {
		}
					
		private function createMinHrDataField() {
			me.mMinHrField = me.mFitSession.createField(
	            "min_hr",
	            me.MinHrFieldId,
	            FitContributor.DATA_TYPE_UINT16,
	            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"bpm"}
	        );
			
	        me.mMinHrField.setData(0);
		}
		
		private const MinHrFieldId = 0;
		private var mMinHrField;
		private var mMinHr;
				
		function refreshActivityStats() {
			if (me.mFitSession.isRecording() == false) {
				return;
		    }	
		    
			var activityInfo = Activity.getActivityInfo();
			if (activityInfo == null) {
				return;
			}

			if (activityInfo.currentHeartRate != null && (me.mMinHr == null || me.mMinHr > activityInfo.currentHeartRate)) {
	    		me.mMinHr = activityInfo.currentHeartRate;
	    	}
	    	me.onRefreshHrActivityStats(activityInfo, me.mMinHr);
		}
		
		protected function onRefreshHrActivityStats(activityInfo, minHr) {
		}
		
		function calculateSummaryFields() {		
			var activityInfo = Activity.getActivityInfo();		
			if (me.mMinHr != null) {
				me.mMinHrField.setData(me.mMinHr);
			}
			
			var summary = new HrSummary();
			summary.maxHr = activityInfo.maxHeartRate;
			summary.averageHr = activityInfo.averageHeartRate;
			summary.minHr = me.mMinHr;
			summary.elapsedTimeSeconds = activityInfo.elapsedTime / 1000;
			return summary;
		}
								
		function finish() {		
			me.mFitSession.save();
			me.mFitSession = null;
		}
			
		function discard() {		
			me.mFitSession.discard();
			me.mFitSession = null;
		}
		
		function discardDanglingActivity() {
			var isDangling = me.mFitSession != null && !me.mFitSession.isRecording();
			if (isDangling) {
				me.discard();
			}
		}
	}	
}