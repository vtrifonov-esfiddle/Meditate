using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;
using Toybox.Math;
using Toybox.Sensor;
using HrvAlgorithms.HrvTracking;

class MediteActivity extends HrvAlgorithms.HrvAndStressActivity {
	private var mMeditateModel;
	private var mVibeAlertsExecutor;	
		
	function initialize(meditateModel, heartbeatIntervalsSensor) {
		var fitSessionSpec;
		var sessionTime = meditateModel.getSessionTime();
		if (meditateModel.getActivityType() == ActivityType.Yoga) {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createYoga(createSessionName(sessionTime, Ui.loadResource(Rez.Strings.meditateYogaActivityName))); // Due to bug in Connect IQ API for breath activity to get respiration rate, we will use Yoga as default meditate activity
		}
		else {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createCardio(createSessionName(sessionTime, Ui.loadResource(Rez.Strings.meditateBreathActivityName)));
		}
		me.mMeditateModel = meditateModel;	
		HrvAlgorithms.HrvAndStressActivity.initialize(fitSessionSpec, meditateModel.getHrvTracking(), heartbeatIntervalsSensor);			
	}

	protected function createSessionName(sessionTime, activityName) {

		// Calculate session minutes and hours
		var sessionTimeMinutes = Math.round(sessionTime / 60);
		var sessionTimeHours = Math.round(sessionTimeMinutes / 60);
		var sessionName;

		// Create the Connect activity name showing the number of hours/minutes for the meditate session
		if (sessionTimeHours == 0) {
			sessionName = Lang.format("$1$ $2$min 🙏", [activityName, sessionTimeMinutes]);
		} else {
			sessionTimeMinutes = sessionTimeMinutes % 60;
			if (sessionTimeMinutes == 0){
				sessionName = Lang.format("$1$ $2$h 🙏", [activityName, sessionTimeHours]);
			} else {
				sessionName = Lang.format("$1$ $2$h $3$min 🙏", [activityName, sessionTimeHours, sessionTimeMinutes]);
			}
		}

		return sessionName;
	}
								
	protected function onBeforeStart(fitSession) {
		mMeditateModel.isTimerRunning = true;
		HrvAlgorithms.HrvAndStressActivity.onBeforeStart(fitSession);
		me.mVibeAlertsExecutor = new VibeAlertsExecutor(me.mMeditateModel);	
	}	
				
	protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {	
		if (activityInfo.elapsedTime != null) {
			me.mMeditateModel.elapsedTime = activityInfo.timerTime / 1000;
		}
		me.mMeditateModel.currentHr = activityInfo.currentHeartRate;
		me.mMeditateModel.minHr = minHr;
		me.mVibeAlertsExecutor.firePendingAlerts();	 
		me.mMeditateModel.hrvSuccessive = hrvSuccessive;
    	
	    Ui.requestUpdate();	    
	}	   	
	
	protected function onBeforeStop() {	
		HrvAlgorithms.HrvAndStressActivity.onBeforeStop();
		me.mVibeAlertsExecutor = null;
	}
		
	function calculateSummaryFields() {	
		var activitySummary = HrvAlgorithms.HrvAndStressActivity.calculateSummaryFields();	
		var summaryModel = new SummaryModel(activitySummary, me.mMeditateModel.getRespirationActivity(), me.mMeditateModel.getHrvTracking());
		return summaryModel;
	}
}