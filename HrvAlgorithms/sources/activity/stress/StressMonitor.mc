using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;
module HrvAlgorithms {
	class StressMonitor {
		function initialize(activitySession, hrvTracking) {	
			me.mHrvTracking = hrvTracking;
			if (me.mHrvTracking == HrvTracking.OnDetailed) {		
				me.mHrPeaksWindow10DataField = StressMonitor.createHrPeaksWindow10DataField(activitySession);			
			}
			if (me.mHrvTracking != HrvTracking.Off) {		
				me.mHrPeaksAverageDataField = StressMonitor.createHrPeaksAverageDataField(activitySession);			
				me.mHrPeaksWindow10 = new HrPeaksWindow(10);	
			}						
		}
								
		private var mHrvTracking;
		
		private var mHrPeaksWindow10;	
		
		private var mHrPeaksWindow10DataField;
		private var mHrPeaksAverageDataField;
		
		private static const HrPeaksWindow10DataFieldId = 15;
		private static const HrPeaksAverageDataFieldId = 17;
		
		private static function createHrPeaksAverageDataField(activitySession) {
			return activitySession.createField(
	            "stress_hrpa",
	            HrPeaksAverageDataFieldId,
	            FitContributor.DATA_TYPE_FLOAT,
	            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
	        );
		}
	
		private static function createHrPeaksWindow10DataField(activitySession) {
			return activitySession.createField(
	            "stress_hrp",
	            HrPeaksWindow10DataFieldId,
	            FitContributor.DATA_TYPE_FLOAT,
	            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"bpm"}
	        );
		}
		
		function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
			if (me.mHrvTracking != HrvTracking.Off) {
				me.mHrPeaksWindow10.addOneSecBeatToBeatIntervals(beatToBeatIntervals);
				me.calculateHrPeaksWindow10();
			}
		}
		
		private function calculateHrPeaksWindow10() {
			if (me.mHrvTracking == HrvTracking.Off) {
				return;
			}
		
			var result = me.mHrPeaksWindow10.calculateCurrentPeak();
			if (result != null) {
				if (me.mHrPeaksWindow10DataField != null) {
					me.mHrPeaksWindow10DataField.setData(result);
				}
			}
		}
				
		public function calculateStress(minHr) {
			if (me.mHrvTracking == HrvTracking.Off) {
				return null;
			}
			var averageStress = me.mHrPeaksWindow10.calculateAverageStress(minHr);
			me.mHrPeaksAverageDataField.setData(averageStress);
			return averageStress;
		}
	}
}