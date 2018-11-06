using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;
using Toybox.Math;
using Toybox.Sensor;
using HrvAlgorithms.HrvTracking;

class MediteActivity extends HrvAlgorithms.HrvActivity {
	private var mMeditateModel;
	private var mVibeAlertsExecutor;	
		
	function initialize(meditateModel, heartbeatIntervalsSensor) {
		var fitSessionSpec;
		if (meditateModel.getActivityType() == ActivityType.Yoga) {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createYoga();
		}
		else {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createGeneric("Meditating");
		}
		me.mMeditateModel = meditateModel;	
		HrvAlgorithms.HrvActivity.initialize(fitSessionSpec, meditateModel.getHrvTracking(), true, heartbeatIntervalsSensor);			
	}
								
	protected function onBeforeStart(fitSession) {
		HrvAlgorithms.HrvActivity.onBeforeStart(fitSession);
		me.mVibeAlertsExecutor = new VibeAlertsExecutor(me.mMeditateModel);	
	}	
				
	protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {	
		if (activityInfo.elapsedTime != null) {
			me.mMeditateModel.elapsedTime = activityInfo.elapsedTime / 1000;
		}
		me.mMeditateModel.currentHr = activityInfo.currentHeartRate;
		me.mMeditateModel.minHr = minHr;
		me.mVibeAlertsExecutor.firePendingAlerts();	 
		me.mMeditateModel.hrvSuccessive = hrvSuccessive;
    	
	    Ui.requestUpdate();	    
	}	   	
	
	protected function onBeforeStop() {	
		HrvAlgorithms.HrvActivity.onBeforeStop();
		me.mVibeAlertsExecutor = null;
	}
		
	function calculateSummaryFields() {	
		var activitySummary = HrvAlgorithms.HrvActivity.calculateSummaryFields();	
		var summaryModel = new SummaryModel(activitySummary, me.mMeditateModel.getHrvTracking());
		return summaryModel;
	}
}