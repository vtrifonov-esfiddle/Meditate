using Toybox.WatchUi as Ui;
using HrvAlgorithms.HrvTracking;

class GlobalSettingsMenuDelegate extends Ui.MenuInputDelegate {
	function initialize(onGlobalSettingsChanged) {
		MenuInputDelegate.initialize();
		mOnGlobalSettingsChanged = onGlobalSettingsChanged;
	}
	
	private var mOnGlobalSettingsChanged;
	
	function onMenuItem(item) {
		if (item ==:hrvTracking) {
			var hrvTrackingDelegate = new MenuOptionsDelegate(method(:onHrvTrackingPicked));
        	Ui.pushView(new Rez.Menus.newHrvTrackingOptionsMenu(), hrvTrackingDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:newActivityType) {
			var newActivityTypeDelegate = new MenuOptionsDelegate(method(:onNewActivityTypePicked));
			Ui.pushView(new Rez.Menus.newActivityTypeOptionsMenu(), newActivityTypeDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:confirmSaveActivity) {
			var confirmSaveActivityDelegate = new MenuOptionsDelegate(method(:onConfirmSaveActivityPicked));
			Ui.pushView(new Rez.Menus.confirmSaveActivityOptionsMenu(), confirmSaveActivityDelegate, Ui.SLIDE_LEFT);
		}
		else if (item ==:multiSession) {
			var multiSessionDelegate = new MenuOptionsDelegate(method(:onMultiSessionPicked));
			Ui.pushView(new Rez.Menus.multiSessionOptionsMenu(), multiSessionDelegate, Ui.SLIDE_LEFT);
		}
	}
	
	function onConfirmSaveActivityPicked(item) {
		if (item == :ask) {
			GlobalSettings.saveConfirmSaveActivity(ConfirmSaveActivity.Ask);
		}
		else if (item == :autoYes) {
			GlobalSettings.saveConfirmSaveActivity(ConfirmSaveActivity.AutoYes);
		}
		else if (item == :autoNo) {
			GlobalSettings.saveConfirmSaveActivity(ConfirmSaveActivity.AutoNo);
		}
		mOnGlobalSettingsChanged.invoke();
	}
	
	function onMultiSessionPicked(item) {
		if (item == :yes) {
			GlobalSettings.saveMultiSession(MultiSession.Yes);
		}
		else if (item == :no) {
			GlobalSettings.saveMultiSession(MultiSession.No);
		}
		mOnGlobalSettingsChanged.invoke();
	}
	
	function onNewActivityTypePicked(item) {
		if (item == :meditating) {
			GlobalSettings.saveActivityType(ActivityType.Meditating);
		}
		else if (item == :yoga) {
			GlobalSettings.saveActivityType(ActivityType.Yoga);
		}
		mOnGlobalSettingsChanged.invoke();
	}
			
	function onHrvTrackingPicked(item) {
		if (item == :on) {
			GlobalSettings.saveHrvTracking(HrvTracking.On);
		}
		else if (item == :onDetailed) {
			GlobalSettings.saveHrvTracking(HrvTracking.OnDetailed);
		}
		else if (item == :off) {
			GlobalSettings.saveHrvTracking(HrvTracking.Off);
		}
		mOnGlobalSettingsChanged.invoke();
	}
}