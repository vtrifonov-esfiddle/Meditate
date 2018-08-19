using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvTracking = GlobalSettings.loadHrvTracking();
		if (me.mHrvTracking != HrvTracking.Off) {
			me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
			me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
			me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
		}
		else {
			me.mHrvBeatToBeatIntervalsDataField = null;
			me.mHrvSdrrFirst5MinDataField = null;
			me.mHrvSdrrLast5MinDataField = null;
		}
		me.mHrvSdrrFirst5Min = new HrvSdrrFirstNSec(Buffer5MinLength);
		me.mHrvSdrrLast5Min = new HrvSdrrLastNSec(Buffer5MinLength);		
	}
	
	private var mHrvTracking;
	
	private const Buffer5MinLength = 300;
	
	private var mHrvSdrrFirst5Min;
	private var mHrvSdrrLast5Min;	
		
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;	
			
	private static const HrvBeatToBeatIntervalsFieldId = 6;		
	private static const HrvSdrrFirst5MinFieldId = 7;
	private static const HrvSdrrLast5MinFieldId = 8;	
				
	private static function createHrvSdrrFirst5MinDataField(activitySession) {
		var hrvSdrrFirst5MinDataField = activitySession.createField(
            "hrv_sdrr_f",
            HrvMonitor.HrvSdrrFirst5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdrrFirst5MinDataField;
	}
	
	private static function createHrvSdrrLast5MinDataField(activitySession) {
		var hrvSdrrLast5MinDataField = activitySession.createField(
            "hrv_sdrr_l",
            HrvMonitor.HrvSdrrLast5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdrrLast5MinDataField;
	}
	
	private static function createHrvBeatToBeatIntervalsDataField(activitySession) {
		var beatToBeatfield = activitySession.createField(
            "hrv_btb",
            HrvMonitor.HrvBeatToBeatIntervalsFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
        return beatToBeatfield;
	}
		
	function addBeatToBeatInterval(beatToBeatInterval) {
		if (me.mHrvTracking == HrvTracking.On) {	
			me.mHrvBeatToBeatIntervalsDataField.setData(beatToBeatInterval.toNumber());
			
			me.mHrvSdrrFirst5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvSdrrLast5Min.addBeatToBeatInterval(beatToBeatInterval);
		}
	}
		
	public function calculateHrvFirst5MinSdrr() {		
		if (me.mHrvTracking == HrvTracking.Off) {
			return null;
		}
		var sdrr = me.mHrvSdrrFirst5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrFirst5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
	
	public function calculateHrvLast5MinSdrr() {
		if (me.mHrvTracking == HrvTracking.Off) {
			return null;
		}
		var sdrr = me.mHrvSdrrLast5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrLast5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
}