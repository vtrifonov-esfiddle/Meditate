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

		// If we have respiration rate and HRV on , we should push all text and icons one line below
		if (mMeditateModel.isRespirationRateOn() && me.mMeditateModel.isHrvOn()) {
			mRespirationRateYPosOffset = -1;
		} else {
			mRespirationRateYPosOffset = 0;
		}
    }
    
    private var mElapsedTime;
    private var mHrStatusText;    
	private var mHrStatus;
	private var mHrvIcon;
	private var mHrvText;	
	private var mBreathIcon;
	private var mBreathText;	
    private var mMeditateIcon;
    private var mRespirationRateYPosOffset;

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
    	var xPosText = dc.getWidth() / 2;
    	var yPosText = getYPosOffsetFromCenter(dc, 0 + mRespirationRateYPosOffset);
      	me.mHrStatusText = createMeditateText(Gfx.COLOR_WHITE, TextFont, xPosText, yPosText, Gfx.TEXT_JUSTIFY_CENTER); 
      	
  	    var hrStatusX = App.getApp().getProperty("meditateActivityIconsXPos");
		var iconsYOffset = App.getApp().getProperty("meditateActivityIconsYOffset");  
        var hrStatusY = getYPosOffsetFromCenter(dc, 0 + mRespirationRateYPosOffset) + iconsYOffset; 
  	    me.mHrStatus = new ScreenPicker.Icon({        
        	:font => StatusIconFonts.fontAwesomeFreeSolid,
        	:symbol => StatusIconFonts.Rez.Strings.faHeart,
        	:color=>Graphics.COLOR_RED,
        	:xPos => hrStatusX,
        	:yPos => hrStatusY
        });
    }
    
    private function renderHrvStatusLayout(dc) {
    	var hrvIconXPos = App.getApp().getProperty("meditateActivityIconsXPos");
    	var hrvTextYPos =  getYPosOffsetFromCenter(dc, 1 + mRespirationRateYPosOffset);
        var iconsYOffset = App.getApp().getProperty("meditateActivityIconsYOffset");
        var hrvIconYPos = hrvTextYPos + iconsYOffset;
        me.mHrvIcon =  new ScreenPicker.HrvIcon({
        	:xPos => hrvIconXPos,
        	:yPos => hrvIconYPos
        });
        
        var xHrvTextOffset = App.getApp().getProperty("meditateActivityXHrvTextOffset");
        var hrvTextXPos = hrvIconXPos + xHrvTextOffset;
        me.mHrvText = createMeditateText(Gfx.COLOR_WHITE, TextFont, hrvTextXPos, hrvTextYPos, Gfx.TEXT_JUSTIFY_LEFT); 
    }

	private function renderBreathStatusLayout(dc) {

		// Put HR and Respiration rate together when HRV is off
		var indexRespirationRateHrvOff = 0;
		if (!me.mMeditateModel.isHrvOn()) {
			indexRespirationRateHrvOff = -1;
		}

    	var breathIconXPos = App.getApp().getProperty("meditateActivityIconsXPos");
    	var breathTextYPos =  getYPosOffsetFromCenter(dc, 2 + mRespirationRateYPosOffset + indexRespirationRateHrvOff);
        var iconsYOffset = App.getApp().getProperty("meditateActivityIconsYOffset");
        var breathIconYPos = breathTextYPos + iconsYOffset;
        me.mBreathIcon =  new ScreenPicker.BreathIcon({
        	:xPos => breathIconXPos,
        	:yPos => breathIconYPos
        });
        
        var xbreathTextOffset = App.getApp().getProperty("meditateActivityXBreathTextOffset");
        var breathTextXPos = breathIconXPos + xbreathTextOffset;
        me.mBreathText = createMeditateText(Gfx.COLOR_WHITE, TextFont, breathTextXPos, breathTextYPos, Gfx.TEXT_JUSTIFY_LEFT); 
    }
    
    private function getYPosOffsetFromCenter(dc, lineOffset) {
    	return dc.getHeight() / 2 + lineOffset * dc.getFontHeight(TextFont);
    }
        
    function renderLayoutElapsedTime(dc) { 	
    	var xPosCenter = dc.getWidth() / 2;
    	var yPosCenter = getYPosOffsetFromCenter(dc, -1 + mRespirationRateYPosOffset);
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

        renderHrStatusLayout(dc);
        if (me.mMeditateModel.isHrvOn() == true) {
	        renderHrvStatusLayout(dc);
        }

		if (me.mMeditateModel.isRespirationRateOn()) {
			renderBreathStatusLayout(dc);
		}
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
	private function formatHr(hr) {
		if (hr == null || hr == 0) {
			return "--";
		}
		else {
			return hr.toString();
		}
	}
		
	private const InvalidHeartRate = "  --";
	
	private function formatHrv(hrv) {
		if (hrv == null) {
			return InvalidHeartRate;
		}
		else {
			return hrv.format("%3.0f");
		}
	}
	
    // Update the view
    function onUpdate(dc) {      
        View.onUpdate(dc);
        if (me.mMeditateIcon != null) {
        	mMeditateIcon.draw(dc);
        }
		
		var timeText = TimeFormatter.format(me.mMeditateModel.elapsedTime);
		var currentHr = me.mMeditateModel.currentHr;
		var hrvSuccessive = me.mMeditateModel.hrvSuccessive;

		// Check if activity is paused, render the [Paused] text
		// and hide HR/HRV metrics
		if (!me.mMeditateModel.isTimerRunning)  {
			timeText = Ui.loadResource(Rez.Strings.meditateActivityPaused);
			currentHr = null;
			hrvSuccessive = null;
		}

		me.mElapsedTime.setText(timeText);		
		me.mElapsedTime.draw(dc);
                    
        var alarmTime = me.mMeditateModel.getSessionTime();
		var elapsedTime = me.mMeditateModel.elapsedTime;

		// Enable backlight in the first 8 seconds then turn off to save battery
		if (elapsedTime <= 8) {
			Attention.backlight(true);
		}
		if (elapsedTime == 9) {
			Attention.backlight(false);
		}

		me.mMainDuationRenderer.drawOverallElapsedTime(dc, elapsedTime, alarmTime);
		if (me.mIntervalAlertsRenderer != null) {
			me.mIntervalAlertsRenderer.drawRepeatIntervalAlerts(dc);
			me.mIntervalAlertsRenderer.drawOneOffIntervalAlerts(dc);
		}
		
		me.mHrStatusText.setText(me.formatHr(currentHr));
		me.mHrStatusText.draw(dc);        
     	me.mHrStatus.draw(dc);	       	
     	
 	    if (me.mMeditateModel.isHrvOn() == true) {
	        me.mHrvIcon.draw(dc);
	        me.mHrvText.setText(me.formatHrv(hrvSuccessive));
	        me.mHrvText.draw(dc); 
        }

		if (me.mMeditateModel.isRespirationRateOn()) {
			var respirationRate = me.mMeditateModel.getRespirationRate();
			me.mBreathIcon.draw(dc);
			me.mBreathText.setText(me.formatHr(respirationRate));
			me.mBreathText.draw(dc); 
		}
    }
	
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
