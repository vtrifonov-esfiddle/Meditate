using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

module HrvAlgorithms {
	class HrvMonitorDefault {
		function initialize(activitySession) {					
			me.mHrvSuccessiveDataField = HrvMonitorDefault.createHrvSuccessiveDataField(activitySession);
			me.mHrvRmssdDataField = HrvMonitorDefault.createHrvRmssdDataField(activitySession);
						
			me.mHrvRmssd = new HrvRmssd();	
			me.mHrvSuccessive = new HrvSuccessive();
		}
				
		private const HrvRmssd30Sec = 30;
		
		private var mHrvRmssd;
		private var mHrvSuccessive;
			
		private var mHrvSuccessiveDataField;
		private var mHrvRmssdDataField;
				
		private static const HrvSuccessiveFieldId = 6;
		private static const HrvRmssdFieldId = 7;	
				
		private static function createHrvSuccessiveDataField(activitySession) {
			return activitySession.createField(
	            "hrv_s",
	            HrvMonitorDefault.HrvSuccessiveFieldId,
	            FitContributor.DATA_TYPE_FLOAT,
	            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
	        );
		}
		
		private static function createHrvRmssdDataField(activitySession) {
			return activitySession.createField(
	            "hrv_rmssd",
	            HrvMonitorDefault.HrvRmssdFieldId,
	            FitContributor.DATA_TYPE_FLOAT,
	            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
	        );
		}
					
		function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
			for (var i = 0; i < beatToBeatIntervals.size(); i++) {
				var beatToBeatInterval = beatToBeatIntervals[i];				
				if (beatToBeatInterval != null) {		
	    			me.addValidBeatToBeatInterval(beatToBeatInterval);	
	    		}
	    	}		    	
		}
			
		protected function addValidBeatToBeatInterval(beatToBeatInterval) {
			me.mHrvSuccessive.addBeatToBeatInterval(beatToBeatInterval);	
			me.mHrvRmssd.addBeatToBeatInterval(beatToBeatInterval);
		}			
					
		public function calculateHrvSuccessive() {
			var hrvSuccessive = me.mHrvSuccessive.calculate();
			if (hrvSuccessive != null) {
				me.mHrvSuccessiveDataField.setData(hrvSuccessive);
			}
			return hrvSuccessive;
		}
		
		public function calculateHrvSummary() {			
			var hrvSummary = new HrvSummary();
			hrvSummary.rmssd = me.mHrvRmssd.calculate();
			if (hrvSummary.rmssd != null) {
				me.mHrvRmssdDataField.setData(hrvSummary.rmssd);
			}
			return hrvSummary;
		}
	}
}