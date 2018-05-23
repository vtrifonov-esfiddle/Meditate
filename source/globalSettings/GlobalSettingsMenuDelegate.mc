using Toybox.WatchUi as Ui;

class GlobalSettingsMenuDelegate extends Ui.MenuInputDelegate {
	function initialize(onGlobalSettingsChanged) {
		MenuInputDelegate.initialize();
		mOnGlobalSettingsChanged = onGlobalSettingsChanged;
	}
	
	private var mOnGlobalSettingsChanged;
	
	function onMenuItem(item) {
		if (item == :stressTracking) {
			var stressTrackingDelegate = new MenuOptionsDelegate(method(:onStressTrackingPicked));
        	Ui.pushView(new Rez.Menus.stressTrackingOptionsMenu(), stressTrackingDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:hrvTracking) {
			var hrvTrackingDelegate = new MenuOptionsDelegate(method(:onHrvTrackingPicked));
        	Ui.pushView(new Rez.Menus.hrvTrackingOptionsMenu(), hrvTrackingDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:newActivityType) {
			var newActivityTypeDelegate = new MenuOptionsDelegate(method(:onNewActivityTypePicked));
			Ui.pushView(new Rez.Menus.newActivityTypeOptionsMenu(), newActivityTypeDelegate, Ui.SLIDE_LEFT);
		}
	}
	
	private function onNewActivityTypePicked(item) {
		if (item == :meditating) {
			GlobalSettings.saveActivityType(ActivityType.Meditating);
		}
		else if (item == :yoga) {
			GlobalSettings.saveActivityType(ActivityType.Yoga);
		}
	}
	
	private function onStressTrackingPicked(item) {
		if (item == :on) {
			GlobalSettings.saveStressTracking(StressTracking.On);
		}
		else if (item == :onDetailed) {
			GlobalSettings.saveStressTracking(StressTracking.OnDetailed);
		}
		else if (item == :off) {
			GlobalSettings.saveStressTracking(StressTracking.Off);
		}
		mOnGlobalSettingsChanged.invoke();
	}
	
	private function onHrvTrackingPicked(item) {
		if (item == :on) {
			GlobalSettings.saveHrvTracking(HrvTracking.On);
		}
		else if (item == :off) {
			GlobalSettings.saveHrvTracking(HrvTracking.Off);
		}
		mOnGlobalSettingsChanged.invoke();
	}
}