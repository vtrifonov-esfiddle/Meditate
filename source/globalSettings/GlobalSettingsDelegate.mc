using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class GlobalSettingsDelegate extends ScreenPickerDelegate {
	protected var mColors;
	private var mOnColorSelected;
	
	function initialize() {
		ScreenPickerDelegate.initialize(0, 1);	
		
		me.mGlobalSettingsIconsXPos = App.getApp().getProperty("globalSettingsIconsXPos");
		me.mGlobalSettingsValueXPos = App.getApp().getProperty("globalSettingsValueXPos");
		me.mGlobalSettingsLinesYOffset = App.getApp().getProperty("globalSettingsLinesYOffset");
		me.mGlobalSettingsTitle = Ui.loadResource(Rez.Strings.menuGlobalSettings_title);
		me.mGlobalSettingsDetailsModel = new DetailsModel();
		updateGlobalSettingsDetails();
	}
	
	private var mGlobalSettingsTitle;
	private var mGlobalSettingsIconsXPos;
	private var mGlobalSettingsValueXPos;
	private var mGlobalSettingsDetailsModel;
	private var mGlobalSettingsLinesYOffset;
	
	function createScreenPickerView() {
		return new ScreenPickerDetailsSinglePageView(me.mGlobalSettingsDetailsModel);
	}
	
	function onMenu() {        
    	Ui.pushView(new Rez.Menus.globalSettingsMenu(), new GlobalSettingsMenuDelegate(method(:onGlobalSettingsChanged)), Ui.SLIDE_LEFT);  
    }
    
    function onBack() {
    	var sessionStorage = new SessionStorage();	 
    	var summaryRollupModel = new SummaryRollupModel();	   	    	
    	var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage, summaryRollupModel);
    	Ui.switchToView(sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate, Ui.SLIDE_RIGHT);
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
        
        var stressIcon = new Icon({        
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontStress
        });
        
        details.detailLines[1].icon = stressIcon;    
        var stressTrackingSetting = "";     
		var stressTracking = GlobalSettings.loadStressTracking();
		if (stressTracking == StressTracking.On) {
			stressTrackingSetting = "On";	
		}
		if (stressTracking == StressTracking.OnDetailed) {		
			stressTrackingSetting = "On Detailed";		
		}  
		if (stressTracking == StressTracking.Off) {
			stressTrackingSetting = "Off";	
		}		
		details.detailLines[1].value.text = "Stress: " +  stressTrackingSetting; 
		
		var hrvIcon = new Icon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faHeartbeat,
	        	:color => Icon.HeartBeatPurpleColor
	        });	
	    details.detailLines[2].icon = hrvIcon;
	    var hrvTrackingSetting;
		if (GlobalSettings.loadHrvTracking() == HrvTracking.On) {			
			hrvTrackingSetting = "On";
		}          
		else {
			hrvTrackingSetting = "Off";
		}
		details.detailLines[2].value.text = "HRV: " +  hrvTrackingSetting; 	
		
		var confirmSaveSetting = "";		
        var saveActivityConfirmation = GlobalSettings.loadConfirmSaveActivity();
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoYes) {
			details.detailLines[3].icon = new Icon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_GREEN
	        });	
	        confirmSaveSetting = "Auto Yes";
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoNo) {
        	details.detailLines[3].icon = new Icon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_RED
	        });	
	        confirmSaveSetting = "Auto No";
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.Ask) {
        	details.detailLines[3].icon = new Icon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faSaveSession
	        });	
	        confirmSaveSetting = "Ask";
        }
        details.detailLines[3].value.text = "Save: " + confirmSaveSetting;
        
        var multiSessionSetting = "";
        var multiSession = GlobalSettings.loadMultiSession();
    	details.detailLines[4].icon = new Icon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faRepeatSession
	        });	
        if (multiSession == MultiSession.Yes) {
	        multiSessionSetting = "Multi-session";
        }
        if (multiSession == MultiSession.No) {
	        multiSessionSetting = "Single session";
        }
        details.detailLines[4].value.text = multiSessionSetting;
        
        details.detailLines[5].icon = new Icon({        
	        	:font => IconFonts.fontMeditateIcons,
	        	:symbol => Rez.Strings.meditateFontYoga
	        });	
        var newActivityType = GlobalSettings.loadActivityType();
        if (newActivityType == ActivityType.Meditating) {
        	details.detailLines[5].value.text = "Meditate";
        }
        if (newActivityType == ActivityType.Yoga) {
        	details.detailLines[5].value.text = "Yoga";
        }
        details.setAllLinesYOffset(me.mGlobalSettingsLinesYOffset);
        details.setAllIconsXPos(me.mGlobalSettingsIconsXPos);
        details.setAllValuesXPos(me.mGlobalSettingsValueXPos);  
	}
}