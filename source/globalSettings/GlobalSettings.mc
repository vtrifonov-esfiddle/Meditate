using Toybox.Application as App;

class GlobalSettings {
	static function loadStressTracking() {
		var stressTracking = App.Storage.getValue(StressTrackingKey);
		if (stressTracking == null) {
			stressTracking = StressTracking.On;
		}
		return stressTracking;
	}
	
	private static const StressTrackingKey = "globalSettings_stressTracking";
	
	static function saveStressTracking(stressTracking) {
		App.Storage.setValue(StressTrackingKey, stressTracking);		
	}
	
	private static const HrvTrackingKey = "globalSettings_hrvTracking";
	
	static function loadHrvTracking() {
		var hrvTracking = App.Storage.getValue(HrvTrackingKey);
		if (hrvTracking == null) {
			hrvTracking = HrvTracking.Off;
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

module StressTracking {
	enum {
		Off = 0,
		On = 1,
		OnDetailed = 2
	}
}

module HrvTracking {
	enum {
		Off = 0,
		On = 1
	}
}