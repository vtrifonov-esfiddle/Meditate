using Toybox.WatchUi as Ui;

class GlobalSettingsMenuDelegate extends Ui.MenuInputDelegate {
	function initialize(onGlobalSettingsChanged) {
		MenuInputDelegate.initialize();
		mOnGlobalSettingsChanged = onGlobalSettingsChanged;
	}
	
	private var mOnGlobalSettingsChanged;
	
	function onMenuItem(item) {
		if (item == :stressTracking) {
			var stressTrackingDelegate = new GlobalSettingsOptionsDelegate(method(:onStressTrackingPicked));
        	Ui.pushView(new Rez.Menus.stressTrackingOptionsMenu(), stressTrackingDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:hrvTracking) {
			var hrvTrackingDelegate = new GlobalSettingsOptionsDelegate(method(:onHrvTrackingPicked));
        	Ui.pushView(new Rez.Menus.hrvTrackingOptionsMenu(), hrvTrackingDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:saveActivityType) {
			var saveActivityTypeDelegate = new GlobalSettingsOptionsDelegate(method(:onSaveActivityTypePicked));
			Ui.pushView(new Rez.Menus.saveActivityTypeOptionsMenu(), saveActivityTypeDelegate, Ui.SLIDE_LEFT);
		}
	}
	
	private function onSaveActivityTypePicked(item) {
		if (item == :meditating) {
			GlobalSettings.saveActivityType(SaveActivityType.Meditating);
		}
		else if (item == :yoga) {
			GlobalSettings.saveActivityType(SaveActivityType.Meditating);
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