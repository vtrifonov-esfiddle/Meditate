using Toybox.WatchUi as Ui;
using Toybox.Lang;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Timer;

class MeditateView extends Ui.View {
	private var mMeditateModel;
	private var mMainDuationRenderer;
	private var mIntervalAlertsRenderer;
	
    function initialize(meditateModel) {
        View.initialize();
        me.mMeditateModel = meditateModel;
        me.mMainDuationRenderer = null;
        me.mIntervalAlertsRenderer = null;
        me.mElapsedTime = null; 
        me.mHrStatusText = null;
        me.mMeditateIcon = null; 
        
        me.mHrvSensorDataNullCount = null;
        me.mHrvBeatToBeatIntervalsNullCount = null;       
    }
    
    private var mElapsedTime;
    private var mHrStatusText;    
	private var mHrStatus;
	private var mHrvIcon;
	private var mHrvText;	
    private var mMeditateIcon;
    
    private var mHrvSensorDataNullCount;
    private var mHrvBeatToBeatIntervalsNullCount;
    
    private function createMeditateText(color, font, xPos, yPos, justification) {
    	return new Ui.Text({
        	:text => "",
        	:font => font,
        	:color => color,
        	:justification =>justification,
        	:locX => xPos,
        	:locY => yPos
    	});
    }
    
    private static const TextFont = Gfx.FONT_MEDIUM;
    
    private function renderBackground(dc) {				        
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);        
        dc.clear();        
    }
    
    private function renderHrStatusLayout(dc) {
    	var xPosCenter = dc.getWidth() / 2;
    	var yPosCenterNextLine = dc.getHeight() / 2 + dc.getFontHeight(TextFont);
      	me.mHrStatusText = createMeditateText(Gfx.COLOR_WHITE, TextFont, xPosCenter, yPosCenterNextLine, Gfx.TEXT_JUSTIFY_CENTER); 
      	
  	    var hrStatusX = App.getApp().getProperty("meditateActivityHrXPos");
        var hrStatusY = App.getApp().getProperty("meditateActivityHrYPos"); 
  	    me.mHrStatus = new Icon({        
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHeart,
        	:color=>Graphics.COLOR_RED,
        	:xPos => hrStatusX,
        	:yPos => hrStatusY
        });
    }
    
    private function renderHrvStatusLayout(dc) {
    	var hrStatusX = App.getApp().getProperty("meditateActivityHrXPos");
        var hrStatusY = App.getApp().getProperty("meditateActivityHrYPos");
    	var hrvTextYPos =  hrStatusY - 2 * dc.getFontHeight(TextFont);
        var hrvIconYPos = hrvTextYPos + 3;
        me.mHrvIcon = new Icon({        
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHeartbeat,
        	:color=>Graphics.COLOR_BLUE,
        	:xPos => hrStatusX,
        	:yPos => hrvIconYPos
        });
        var hrvTextXPos = hrStatusX + 20;
        me.mHrvText = createMeditateText(Gfx.COLOR_WHITE, TextFont, hrvTextXPos, hrvTextYPos, Gfx.TEXT_JUSTIFY_LEFT); 
        
        var hrvNullCountYPos = hrStatusY - 3 * dc.getFontHeight(TextFont);
        me.mHrvSensorDataNullCount = createMeditateText(Gfx.COLOR_WHITE, TextFont, 60, hrvNullCountYPos, Gfx.TEXT_JUSTIFY_LEFT);
        me.mHrvBeatToBeatIntervalsNullCount = createMeditateText(Gfx.COLOR_WHITE, TextFont, 110, hrvNullCountYPos, Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    function renderLayoutElapsedTime(dc) { 	
    	var xPosCenter = dc.getWidth() / 2;
    	var yPosCenter = dc.getHeight() / 2;
    	me.mElapsedTime = createMeditateText(me.mMeditateModel.getColor(), TextFont, xPosCenter, yPosCenter, Gfx.TEXT_JUSTIFY_CENTER);
    }
                
    // Load your resources here
    function onLayout(dc) {   
        renderBackground(dc);   
        renderLayoutElapsedTime(dc);  
		        
        var durationArcRadius = dc.getWidth() / 2;
        var mainDurationArcWidth = dc.getWidth() / 4;
        me.mMainDuationRenderer = new ElapsedDuationRenderer(me.mMeditateModel.getColor(), durationArcRadius, mainDurationArcWidth);
        
        if (me.mMeditateModel.hasIntervalAlerts()) {
	        var intervalAlertsArcRadius = dc.getWidth() / 2;
	        var intervalAlertsArcWidth = dc.getWidth() / 16;
	        me.mIntervalAlertsRenderer = new IntervalAlertsRenderer(me.mMeditateModel.getSessionTime(), me.mMeditateModel.getOneOffIntervalAlerts(), 
	        	me.mMeditateModel.getRepeatIntervalAlerts(), intervalAlertsArcRadius, intervalAlertsArcWidth);    
    	}
    	else {
    		me.mIntervalAlertsRenderer = null;
    	}    
        renderHrStatusLayout(dc);
        if (me.mMeditateModel.isHrvOn() == true) {
	        renderHrvStatusLayout(dc);	        
	        
        }
        delayedShowMeditateIcon();
    }
    
    private function delayedShowMeditateIcon() {
    	var mMeditateIconLoaderTimer = new Timer.Timer();
        mMeditateIconLoaderTimer.start(method(:onLoadMeditateIcon), 500, false);
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
	private function formatHr(hr) {
		if (hr == null) {
			return "--";
		}
		else {
			return hr.toString();
		}
	}
		
	private const InvalidHeartRate = "--";
	
	private function formatHrv(hrv) {
		if (hrv == null) {
			return InvalidHeartRate;
		}
		else {
			return hrv.format("%3.2f");
		}
	}
	
    private static const MinMeditateIconFreeMemory = 21000;
    
	function onLoadMeditateIcon() {
    	var stats = System.getSystemStats();    	
        var meditateIconX = App.getApp().getProperty("meditateActivityMeditateIconX");
        var meditateIconY = App.getApp().getProperty("meditateActivityMeditateIconY");
        
		if (stats.freeMemory > MinMeditateIconFreeMemory) {		
	        me.mMeditateIcon = new Ui.Bitmap({
	        	:rezId => Rez.Drawables.meditateIcon,
	        	:locX => meditateIconX,
	        	:locY => meditateIconY
        	});
		}
	}
	
    // Update the view
    function onUpdate(dc) {      
        View.onUpdate(dc);
        if (me.mMeditateIcon != null) {
        	mMeditateIcon.draw(dc);
        }
		me.mElapsedTime.setText(TimeFormatter.format(me.mMeditateModel.elapsedTime));		
		me.mElapsedTime.draw(dc);
                    
        var alarmTime = me.mMeditateModel.getSessionTime();
		me.mMainDuationRenderer.drawOverallElapsedTime(dc, me.mMeditateModel.elapsedTime, alarmTime);
		if (me.mIntervalAlertsRenderer != null) {
			me.mIntervalAlertsRenderer.drawRepeatIntervalAlerts(dc);
			me.mIntervalAlertsRenderer.drawOneOffIntervalAlerts(dc);
		}	
		
		me.mHrStatusText.setText(me.formatHr(me.mMeditateModel.currentHr));
		me.mHrStatusText.draw(dc);        
     	me.mHrStatus.draw(dc);	       	
     	
 	    if (me.mMeditateModel.isHrvOn() == true) {
	        me.mHrvIcon.draw(dc);
	        me.mHrvText.setText(me.formatHrv(me.mMeditateModel.hrv));
	        me.mHrvText.draw(dc); 
	        
	        me.mHrvSensorDataNullCount.setText("S: " + me.mMeditateModel.hrvSensorDataNullCount.toString());
	        me.mHrvSensorDataNullCount.draw(dc);
	        me.mHrvBeatToBeatIntervalsNullCount.setText("B: " + me.mMeditateModel.hrvBeatToBeatIntervalsNullCount.toString());
	        me.mHrvBeatToBeatIntervalsNullCount.draw(dc);
        }
    }
    

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
