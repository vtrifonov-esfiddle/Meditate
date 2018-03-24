using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
		me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
		me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
		me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
		
		me.mHrvRmssd = new HrvRmssd();
		me.mHrvSdrrFirst5Min = new HrvSdrrFirstNSec(Buffer5MinLength);
		me.mHrvSdrrLast5Min = new HrvSdrrLastNSec(Buffer5MinLength);
	}
	
	private const Buffer5MinLength = 300;
	
	private var mHrvSdrrFirst5Min;
	private var mHrvSdrrLast5Min;
	private var mHrvRmssd;
	
	private var mHrvRmssdDataField;
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;
			
	private static const HrvBeatToBeatIntervalsFieldId = 1;		
	private static const HrvSdrrFirst5MinFieldId = 2;
	private static const HrvSdrrLast5MinFieldId = 3;	
	private static const HrvRmssdFieldId = 4;
	
	
	private static function createHrvRmssdDataField(activitySession) {
		var hrvRmssdDataField = activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvRmssdDataField;
	}
		
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
		
	function addHrSample(hr) {
		if (hr != null) {
			var beatToBeatInterval = 60000.toFloat() / hr.toFloat();		
			me.mHrvBeatToBeatIntervalsDataField.setData(beatToBeatInterval.toNumber());
			
			me.mHrvSdrrFirst5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvSdrrLast5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvRmssd.addBeatToBeatInterval(beatToBeatInterval);
		}
	}
	
	public function calculateHrvFirst5MinSdrr() {		
		var sdrr = me.mHrvSdrrFirst5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrFirst5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
	
	public function calculateHrvLast5MinSdrr() {
		var sdrr = me.mHrvSdrrLast5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrLast5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
		
	public function calculateHrvUsingRmssd() {
		var hrv = me.mHrvRmssd.calculate();
		if (hrv != null) {
			me.mHrvRmssdDataField.setData(hrv);
		}
		return hrv;
	}
}