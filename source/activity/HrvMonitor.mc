using Toybox.FitContributor;
using Toybox.Math;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
		me.previousRrInterval = null;
		me.squareOfSuccessiveRrDifferences = 0.0;
		me.successiveDifferencesCount = 0;
	}
	
	private var mHrvRmssdDataField;
	private var previousRrInterval;
	private var squareOfSuccessiveRrDifferences;	
	private var successiveDifferencesCount;
	private static const HrvRmssdFieldId = 1;
	
	private static function createHrvRmssdDataField(activitySession) {
		var hrvRmssdDataField = activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
        return hrvRmssdDataField;
	}
		
	function addHrSample(hr) {
		if (hr != null) {
			var hrvRr = 60000.toFloat() / hr.toFloat();		
			me.addRrInterval(hrvRr);
			
			var currentHrv = me.calculateHrvUsingRmssd();
			if (currentHrv != null) {
				me.mHrvRmssdDataField.setData(currentHrv);
			}
		}
	}
		
	private function addRrInterval(hrvRr) {
		if (me.previousRrInterval != null) {
			me.successiveDifferencesCount++;		
			me.squareOfSuccessiveRrDifferences += Math.pow(hrvRr - me.previousRrInterval, 2);
		}		
		me.previousRrInterval = hrvRr;
	}
	
	public function calculateHrvUsingRmssd() {
		if (me.successiveDifferencesCount < 1) {
			return null;
		}
		
		var rootMeanSquareOfSuccessiveRrDifferences = Math.sqrt(me.squareOfSuccessiveRrDifferences / me.successiveDifferencesCount);
		return rootMeanSquareOfSuccessiveRrDifferences;
	}
}