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
        		
	    details.detailLines[1].icon = new ScreenPicker.HrvIcon({});
	    var hrvTrackingSetting;
	    var hrvTracking = GlobalSettings.loadHrvTracking();
		if (hrvTracking == HrvTracking.On) {			
			hrvTrackingSetting = "On";
		}          
		else if (hrvTracking == HrvTracking.OnDetailed) {
			hrvTrackingSetting = "On Detailed";
		}
		else {
			hrvTrackingSetting = "Off";
		}
		details.detailLines[1].value.text = "HRV: " +  hrvTrackingSetting; 	
		
		var confirmSaveSetting = "";		
        var saveActivityConfirmation = GlobalSettings.loadConfirmSaveActivity();
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoYes) {
			details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_GREEN
	        });	
	        confirmSaveSetting = "Auto Yes";
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoNo) {
        	details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_RED
	        });	
	        confirmSaveSetting = "Auto No";
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.Ask) {
        	details.detailLines[2].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSaveSession
	        });	
	        confirmSaveSetting = "Ask";
        }
        details.detailLines[2].value.text = "Save: " + confirmSaveSetting;
        
        var multiSessionSetting = "";
        var multiSession = GlobalSettings.loadMultiSession();
    	details.detailLines[3].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faRepeatSession
	        });	
        if (multiSession == MultiSession.Yes) {
	        multiSessionSetting = "Multi-session";
        }
        if (multiSession == MultiSession.No) {
	        multiSessionSetting = "Single session";
        }
        details.detailLines[3].value.text = multiSessionSetting;
        
        details.detailLines[4].icon = new ScreenPicker.Icon({        
	        	:font => StatusIconFonts.fontMeditateIcons,
	        	:symbol => StatusIconFonts.Rez.Strings.meditateFontYoga
	        });	
        var newActivityType = GlobalSettings.loadActivityType();
        if (newActivityType == ActivityType.Meditating) {
        	details.detailLines[4].value.text = "Meditate";
        }
        if (newActivityType == ActivityType.Yoga) {
        	details.detailLines[4].value.text = "Yoga";
        }
        details.setAllLinesYOffset(me.mGlobalSettingsLinesYOffset);
        details.setAllIconsXPos(me.mGlobalSettingsIconsXPos);
        details.setAllValuesXPos(me.mGlobalSettingsValueXPos);  
	}
}