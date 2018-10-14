using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvTracking = GlobalSettings.loadHrvTracking();
		if (me.mHrvTracking == HrvTracking.OnDetailed) {
			me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);			
			me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
			me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
			me.mHrFromHeartbeatDataField = HrvMonitor.createHrFromHeartbeatDataField(activitySession);
		}
		if (me.mHrvTracking != HrvTracking.Off) {			
			me.mHrvDataField = HrvMonitor.createHrvDataField(activitySession);
			me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
			me.mHrvRmssd1MinDataField = HrvMonitor.createHrvRmssd1MinDataField(activitySession);
			me.mHrvRmssd30SecDataField = HrvMonitor.createHrvRmssd30SecDataField(activitySession);
			me.mHrvPnn50DataField = HrvMonitor.createHrvPnn50DataField(activitySession);
			me.mHrvPnn20DataField = HrvMonitor.createHrvPnn20DataField(activitySession);
		}
		me.mHrvSdrrFirst5Min = new HrvSdrrFirstNSec(Buffer5MinLength);
		me.mHrvSdrrLast5Min = new HrvSdrrLastNSec(Buffer5MinLength);	
		me.mHrvRmssd = new HrvRmssd();	
		me.mHrvRmssd1Min = new HrvRmssdRolling(HrvRmssd1Min);
		me.mHrvRmssd30Sec = new HrvRmssdRolling(HrvRmssd30Sec);
		me.mHrvPnn50 = new HrvPnnx(50);
		me.mHrvPnn20 = new HrvPnnx(20);
		me.mHrvConsecutive = new HrvConsecutive();
	}
	
	private var mHrvTracking;
	
	private const HrvRmssd30Sec = 30;
	private const HrvRmssd1Min = 60;
	private const Buffer5MinLength = 300;
	
	private var mHrvSdrrFirst5Min;
	private var mHrvSdrrLast5Min;	
	private var mHrvRmssd;
	private var mHrvRmssd1Min;
	private var mHrvRmssd30Sec;
	private var mHrvConsecutive;
	private var mHrvPnn50;
	private var mHrvPnn20;
		
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;	
	private var mHrvDataField;
	private var mHrvRmssd1MinDataField;
	private var mHrvRmssd30SecDataField;
	private var mHrvRmssdDataField;
	private var mHrvPnn50DataField;
	private var mHrvPnn20DataField;
	private var mHrFromHeartbeatDataField;
			
	private static const HrvFieldId = 6;
	private static const HrvRmssdFieldId = 7;	
	private static const HrvBeatToBeatIntervalsFieldId = 8;		
	private static const HrvSdrrFirst5MinFieldId = 9;
	private static const HrvSdrrLast5MinFieldId = 10;		
	private static const HrvPnn50FieldId = 11;
	private static const HrvPnn20FieldId = 12;
	private static const HrvRmssd30SecFieldId = 13;
	private static const HrvRmssd1MinFieldId = 14;
	private static const HrFromHeartbeatField = 16;
				
	private static function createHrvSdrrFirst5MinDataField(activitySession) {
		return activitySession.createField(
            "hrv_sdrr_f",
            HrvMonitor.HrvSdrrFirst5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
	}
	
	private static function createHrvSdrrLast5MinDataField(activitySession) {
		return activitySession.createField(
            "hrv_sdrr_l",
            HrvMonitor.HrvSdrrLast5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
	}
	
	private static function createHrvBeatToBeatIntervalsDataField(activitySession) {
		return activitySession.createField(
            "hrv_btb",
            HrvMonitor.HrvBeatToBeatIntervalsFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
	}
	
	private static function createHrvDataField(activitySession) {
		return activitySession.createField(
            "hrv_c",
            HrvMonitor.HrvFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
	}
	
	private static function createHrvRmssdDataField(activitySession) {
		return activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
	}
	
	private static function createHrvRmssd1MinDataField(activitySession) {
		return activitySession.createField(
            "hrv_rmssd1m",
            HrvMonitor.HrvRmssd1MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
	}
	
	private static function createHrvRmssd30SecDataField(activitySession) {
		return activitySession.createField(
            "hrv_rmssd30s",
            HrvMonitor.HrvRmssd30SecFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
	}
	
	private static function createHrFromHeartbeatDataField(activitySession) {
		return activitySession.createField(
            "hrv_hr",
            HrvMonitor.HrFromHeartbeatField,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"bpm"}
        );
	}
		
	private static function createHrvPnn50DataField(activitySession) {
		return activitySession.createField(
            "hrv_pnn50",
            HrvMonitor.HrvPnn50FieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createHrvPnn20DataField(activitySession) {
		return activitySession.createField(
            "hrv_pnn20",
            HrvMonitor.HrvPnn20FieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
		if (me.mHrvTracking != HrvTracking.Off) {
			for (var i = 0; i < beatToBeatIntervals.size(); i++) {
				var beatToBeatInterval = beatToBeatIntervals[i];				
				if (beatToBeatInterval != null) {		
	    			me.addValidBeatToBeatInterval(beatToBeatInterval);	
	    		}
	    	}
	    	var rmssd1Min = me.mHrvRmssd1Min.addOneSecBeatToBeatIntervals(beatToBeatIntervals); 	
	    	if (rmssd1Min != null) {
	    		me.mHrvRmssd1MinDataField.setData(rmssd1Min);
	    	}
	    	var rmssd30Sec = me.mHrvRmssd30Sec.addOneSecBeatToBeatIntervals(beatToBeatIntervals); 	
	    	if (rmssd30Sec != null) {
	    		me.mHrvRmssd30SecDataField.setData(rmssd30Sec);
	    	}	    	
    	}    	
	}
		
	private function addValidBeatToBeatInterval(beatToBeatInterval) {
		if (me.mHrvTracking == HrvTracking.OnDetailed) {			
			me.mHrvBeatToBeatIntervalsDataField.setData(beatToBeatInterval.toNumber());
			
			var hrFromHeartbeat = Math.round(60000 / beatToBeatInterval.toFloat()).toNumber();
			me.mHrFromHeartbeatDataField.setData(hrFromHeartbeat);
			
			me.mHrvSdrrFirst5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvSdrrLast5Min.addBeatToBeatInterval(beatToBeatInterval);
		}
		
		me.mHrvConsecutive.addBeatToBeatInterval(beatToBeatInterval);								
		me.mHrvRmssd.addBeatToBeatInterval(beatToBeatInterval);
		me.mHrvPnn50.addBeatToBeatInterval(beatToBeatInterval);
		me.mHrvPnn20.addBeatToBeatInterval(beatToBeatInterval);
	}			
				
	public function calculateHrvConsecutive() {
		if (me.mHrvTracking == HrvTracking.Off) {
			return null;
		}
		var hrv = me.mHrvConsecutive.calculate();
		if (hrv != null) {
			me.mHrvDataField.setData(hrv);
		}
		return hrv;
	}
	
	public function calculateHrvSummary() {
		if (me.mHrvTracking == HrvTracking.Off) {
			return null;
		}
		
		var hrvSummary = new HrvSummary();
		hrvSummary.rmssd = me.mHrvRmssd.calculate();
		if (hrvSummary.rmssd != null) {
			me.mHrvRmssdDataField.setData(hrvSummary.rmssd);
		}
		hrvSummary.pnn50 = me.mHrvPnn50.calculate();
		if (hrvSummary.pnn50 != null) {
			me.mHrvPnn50DataField.setData(hrvSummary.pnn50);
		}
		hrvSummary.pnn20 = me.mHrvPnn20.calculate();
		if (hrvSummary.pnn20 != null) {
			me.mHrvPnn20DataField.setData(hrvSummary.pnn20);
		}
		hrvSummary.rmssd = me.mHrvRmssd.calculate();
		if (hrvSummary.rmssd != null) {
			me.mHrvRmssdDataField.setData(hrvSummary.rmssd);
		}
		hrvSummary.first5MinSdrr = me.mHrvSdrrFirst5Min.calculate();
		if (hrvSummary.first5MinSdrr != null) {
			me.mHrvSdrrFirst5MinDataField.setData(hrvSummary.first5MinSdrr);
		}
		hrvSummary.last5MinSdrr = me.mHrvSdrrLast5Min.calculate();
		if (hrvSummary.last5MinSdrr != null) {
			me.mHrvSdrrLast5MinDataField.setData(hrvSummary.last5MinSdrr);
		}
		return hrvSummary;
	}
}

class HrvSummary {
	var rmssd;
	var pnn50;
	var pnn20;
	var first5MinSdrr;
	var last5MinSdrr;
}