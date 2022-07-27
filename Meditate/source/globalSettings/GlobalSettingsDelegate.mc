using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using HrvAlgorithms.HrvTracking;

class GlobalSettingsDelegate extends ScreenPicker.ScreenPickerDelegate {
	protected var mColors;
	private var mOnColorSelected;
	private var mSessionPickerDelegate;
	
	function initialize(sessionPickerDelegate) {
		ScreenPickerDelegate.initialize(0, 1);	
		
		me.mGlobalSettingsIconsXPos = App.getApp().getProperty("globalSettingsIconsXPos");
		me.mGlobalSettingsValueXPos = App.getApp().getProperty("globalSettingsValueXPos");
		me.mGlobalSettingsLinesYOffset = App.getApp().getProperty("globalSettingsLinesYOffset");
		me.mGlobalSettingsTitle = Ui.loadResource(Rez.Strings.menuGlobalSettings_title);
		me.mGlobalSettingsDetailsModel = new ScreenPicker.DetailsModel();
		me.mSessionPickerDelegate = sessionPickerDelegate;
		updateGlobalSettingsDetails();
	}
	
	private var mGlobalSettingsTitle;
	private var mGlobalSettingsIconsXPos;
	private var mGlobalSettingsValueXPos;
	private var mGlobalSettingsDetailsModel;
	private var mGlobalSettingsLinesYOffset;
	
	function createScreenPickerView() {
		return new ScreenPicker.ScreenPickerDetailsSinglePageView(me.mGlobalSettingsDetailsModel);
	}
	
	function onMenu() {        
    	return me.showGlobalSettingsMenu();
    }
    
	function onHold(param) {
		return me.showGlobalSettingsMenu();
	}

	function showGlobalSettingsMenu()
	{
		Ui.pushView(new Rez.Menus.globalSettingsMenu(), new GlobalSettingsMenuDelegate(method(:onGlobalSettingsChanged)), Ui.SLIDE_LEFT);  
	}

    function onBack() {    
    	Ui.switchToView(me.mSessionPickerDelegate.createScreenPickerView(), me.mSessionPickerDelegate, Ui.SLIDE_RIGHT);
    	return true;
    }
    
    function onGlobalSettingsChanged() {
    	me.updateGlobalSettingsDetails();
    	Ui.requestUpdate();
    }
    
    private function updateGlobalSettingsDetails() {
		var details = me.mGlobalSettingsDetailsModel;
		details.title = me.mGlobalSettingsTitle;
		details.titleFont = Gfx.FONT_SMALL;
        details.titleColor = Gfx.COLOR_WHITE;
        details.color = Gfx.COLOR_WHITE;
        details.backgroundColor = Gfx.COLOR_BLACK;
        		
		// HRV settings
	    details.detailLines[1].icon = new ScreenPicker.HrvIcon({});
	    var hrvTrackingSetting;
	    var hrvTracking = GlobalSettings.loadHrvTracking();
		if (hrvTracking == HrvTracking.On) {			
			hrvTrackingSetting = Ui.loadResource(Rez.Strings.menuNewHrvTrackingOptions_on);
		}          
		else if (hrvTracking == HrvTracking.OnDetailed) {
			hrvTrackingSetting = Ui.loadResource(Rez.Strings.menuNewHrvTrackingOptions_onDetailedSimple);
		}
		else {
			hrvTrackingSetting = Ui.loadResource(Rez.Strings.menuNewHrvTrackingOptions_off);
		}
		details.detailLines[1].value.text = "HRV: " +  hrvTrackingSetting; 	
		
		// Confirm save activity settings
		var confirmSaveSetting = "";		
        var saveActivityConfirmation = GlobalSettings.loadConfirmSaveActivity();
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoYes) {
			details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_GREEN
	        });	
	        confirmSaveSetting = Ui.loadResource(Rez.Strings.menuConfirmSaveActivityOptions_autoYes);
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoNo) {
        	details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_RED
	        });	
	        confirmSaveSetting = Ui.loadResource(Rez.Strings.menuConfirmSaveActivityOptions_autoNo);
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.Ask) {
        	details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession
	        });	
	        confirmSaveSetting = Ui.loadResource(Rez.Strings.menuConfirmSaveActivityOptions_askSimple);
        }
        details.detailLines[2].value.text = Ui.loadResource(Rez.Strings.menuGlobalSettings_save) + confirmSaveSetting;
        
		// Multi-session settings
        var multiSessionSetting = "";
        var multiSession = GlobalSettings.loadMultiSession();
    	details.detailLines[3].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faRepeatSession
	        });	
        if (multiSession == MultiSession.Yes) {
	        multiSessionSetting = Ui.loadResource(Rez.Strings.menuGlobalSettings_multiSession);
        }
        if (multiSession == MultiSession.No) {
	        multiSessionSetting = Ui.loadResource(Rez.Strings.menuGlobalSettings_singleSession);
        }
        details.detailLines[3].value.text = multiSessionSetting;
        
		// Activity type settings
        details.detailLines[4].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontMeditateIcons,
	        	:symbol => StatusIconFonts.Rez.Strings.meditateFontYoga
	        });	
        var newActivityType = GlobalSettings.loadActivityType();
        if (newActivityType == ActivityType.Meditating) {
        	details.detailLines[4].value.text = Ui.loadResource(Rez.Strings.menuNewActivityTypeOptions_meditating);
        }
        if (newActivityType == ActivityType.Yoga) {
        	details.detailLines[4].value.text = Ui.loadResource(Rez.Strings.menuNewActivityTypeOptions_yoga);
        }

		// Show Respiration rate settings if supported
		if (HrvAlgorithms.RrActivity.isRespirationRateSupported()) {
			
			var respirationRateSetting = "";
			var respirationRate = GlobalSettings.loadRespirationRate();
			details.detailLines[5].icon = new ScreenPicker.BreathIcon({});
			if (respirationRate == RespirationRate.On) {
				respirationRateSetting = Ui.loadResource(Rez.Strings.menuNewHrvTrackingOptions_on);
			}
			if (respirationRate == RespirationRate.Off) {
				respirationRateSetting = Ui.loadResource(Rez.Strings.menuNewHrvTrackingOptions_off);
			}
			details.detailLines[5].value.text = Ui.loadResource(Rez.Strings.menuGlobalSettings_respiration) + respirationRateSetting;
		}

        details.setAllLinesYOffset(me.mGlobalSettingsLinesYOffset);
        details.setAllIconsXPos(me.mGlobalSettingsIconsXPos);
        details.setAllValuesXPos(me.mGlobalSettingsValueXPos);  
	}
}