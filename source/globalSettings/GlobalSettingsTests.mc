using Toybox.Application as App;

class GlobalSettingsFixture {
	static function resetStressTracking() {
		App.Storage.setValue("globalSettings_stressTracking", null);
	}
	static function resetHrvTracking() {
		App.Storage.setValue("globalSettings_hrvTracking", null);
	}
	static function resetActivityType() {
		App.Storage.setValue("globalSettings_activityType", null);
	}
}

class GlobalSettingsTests {	
	(:test)
	static function loadStressTrackingNoInitialValue(logger) {
		GlobalSettingsFixture.resetStressTracking();
		var actualStressTracking = GlobalSettings.loadStressTracking();
		return actualStressTracking == StressTracking.On;
	}
	
	(:test)
	static function loadHrvTrackingNoInitialValue(logger) {
		GlobalSettingsFixture.resetHrvTracking();
		var actualHrvTracking = GlobalSettings.loadHrvTracking();
		return actualHrvTracking == HrvTracking.Off;
	}
	
	(:test)
	static function saveStressTrackingOn(logger) {
		GlobalSettingsFixture.resetStressTracking();
		GlobalSettings.saveStressTracking(StressTracking.On);		
		var actualStressTracking = GlobalSettings.loadStressTracking();
		return actualStressTracking == StressTracking.On;
	}
	
	(:test)
	static function saveStressTrackingOff(logger) {
		GlobalSettingsFixture.resetStressTracking();
		GlobalSettings.saveStressTracking(StressTracking.Off);		
		var actualStressTracking = GlobalSettings.loadStressTracking();
		return actualStressTracking == StressTracking.Off;
	}
	
	(:test)
	static function saveStressTrackingOnDetailed(logger) {
		GlobalSettingsFixture.resetStressTracking();
		GlobalSettings.saveStressTracking(StressTracking.OnDetailed);		
		var actualStressTracking = GlobalSettings.loadStressTracking();
		return actualStressTracking == StressTracking.OnDetailed;
	}
	
	(:test)
	static function loadHrvTrackingOff(logger) {
		GlobalSettingsFixture.resetHrvTracking();
		GlobalSettings.saveHrvTracking(StressTracking.Off);	
		var actualHrvTracking = GlobalSettings.loadHrvTracking();
		return actualHrvTracking == HrvTracking.Off;
	}
	
	(:test)
	static function loadHrvTrackingOn(logger) {
		GlobalSettingsFixture.resetHrvTracking();
		GlobalSettings.saveHrvTracking(StressTracking.On);	
		var actualHrvTracking = GlobalSettings.loadHrvTracking();
		return actualHrvTracking == HrvTracking.On;
	}
	
	(:test)
	static function loadActivityTypeNoInitialValue(logger) {
		GlobalSettingsFixture.resetActivityType();
		var actualActivityType = GlobalSettings.loadActivityType();
		return actualActivityType == ActivityType.Meditating;
	}
	
	(:test)
	static function loadActivityTypeMeditating(logger) {
		GlobalSettingsFixture.resetActivityType();
		GlobalSettings.saveActivityType(ActivityType.Meditating);
		var actualActivityType = GlobalSettings.loadActivityType();
		return actualActivityType == ActivityType.Meditating;
	}
	
	(:test)
	static function loadActivityTypeYoga(logger) {
		GlobalSettingsFixture.resetActivityType();
		GlobalSettings.saveActivityType(ActivityType.Yoga);
		var actualActivityType = GlobalSettings.loadActivityType();
		return actualActivityType == ActivityType.Yoga;
	}
}