using Toybox.Application as App;
using HrvAlgorithms.HrvTracking;

class GlobalSettings {
	private static const HrvTrackingKey = "globalSettings_hrvTracking2";//version 2 due to change of behaviour
	
	static function loadHrvTracking() {
		var hrvTracking = App.Storage.getValue(HrvTrackingKey);
		if (hrvTracking == null) {
			hrvTracking = HrvTracking.On;
		}
		return hrvTracking;
	}
	
	static function saveHrvTracking(hrvTracking) {
		App.Storage.setValue(HrvTrackingKey, hrvTracking);
	}
	
	private static const ActivityTypeKey = "globalSettings_activityType";
	
	static function loadActivityType() {
		var activityType = App.Storage.getValue(ActivityTypeKey);
		if (activityType == null) {
			return ActivityType.Meditating;
		}
		else {
			return activityType;
		}
	}
	
	static function saveActivityType(activityType) {
		App.Storage.setValue(ActivityTypeKey, activityType);
	}
	
	private static const ConfirmSaveActivityKey = "globalSettings_confirmSaveActivity";
	
	static function loadConfirmSaveActivity() {
		var confirmSaveActivity = App.Storage.getValue(ConfirmSaveActivityKey);
		if (confirmSaveActivity == null) {
			return ConfirmSaveActivity.Ask;
		}
		else {
			return confirmSaveActivity;
		}		
	}
	
	static function saveConfirmSaveActivity(confirmSaveActivity) {
		App.Storage.setValue(ConfirmSaveActivityKey, confirmSaveActivity);
	}
	
	private static const MultiSessionKey = "globalSettings_multiSession";
	
	static function loadMultiSession() {
		var multiSession = App.Storage.getValue(MultiSessionKey);
		if (multiSession == null) {
			return MultiSession.No;
		}
		else {
			return multiSession;
		}
	}
	
	static function saveMultiSession(multiSession) {
		App.Storage.setValue(MultiSessionKey, multiSession);
	}
}

module ConfirmSaveActivity {
	enum {
		Ask = 0,
		AutoNo = 1,
		AutoYes = 2
	}
}

module MultiSession {
	enum {
		No = 0,
		Yes = 1
	}
}