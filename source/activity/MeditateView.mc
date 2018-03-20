using Toybox.WatchUi as Ui;
using Toybox.Lang;
using Toybox.Graphics as Gfx;

class MeditateView extends Ui.View {
	private var mMeditateModel;
	private var mMainDuationRenderer;
	private var mIntervalAlertsRenderer;
	
    function initialize(meditateModel) {
        View.initialize();
        me.mMeditateModel = meditateModel;
        me.mMainDuationRenderer = null;
        me.mIntervalAlertsRenderer = null;
    }
    


    // Load your resources here
    function onLayout(dc) {    
        var durationArcRadius = dc.getWidth() / 2;
        var mainDurationArcWidth = dc.getWidth() / 4;
        me.mMainDuationRenderer = new ElapsedDuationRenderer(me.mMeditateModel.getColor(), durationArcRadius, mainDurationArcWidth);
        
        var intervalAlertsArcRadius = dc.getWidth() / 2;
        var intervalAlertsArcWidth = dc.getWidth() / 16;
        me.mIntervalAlertsRenderer = new IntervalAlertsRenderer(me.mMeditateModel.getSessionTime(), me.mMeditateModel.getOneOffIntervalAlerts(), 
        	me.mMeditateModel.getRepeatIntervalAlerts(), intervalAlertsArcRadius, intervalAlertsArcWidth);
        setLayout(Rez.Layouts.mainLayout(dc));
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
	
	private function formatHrv(hr) {
		if (hr == null) {
			return "--";
		}
		else {
			return hr.format("%3.2f");
		}
	}
	
    // Update the view
    function onUpdate(dc) {  
    	if (me.mMeditateModel.isSessionFinished) {
    		var calculatingResultsText = Ui.loadResource(Rez.Strings.activityCalculatingResultsText);
    		dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        	dc.clear();  
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 20, Gfx.FONT_SYSTEM_MEDIUM, calculatingResultsText, Gfx.TEXT_JUSTIFY_CENTER);
    	}
    	else { 
			var elapsedTime = View.findDrawableById("elapsedTime");
			elapsedTime.setColor(me.mMeditateModel.getColor());
			elapsedTime.setText(TimeFormatter.format(me.mMeditateModel.elapsedTime));		
			
			var hrStatusText = View.findDrawableById("hrStatusText");
			hrStatusText.setText(me.formatHr(me.mMeditateModel.currentHr));
					
	        View.onUpdate(dc);
	        		                        
	        var alarmTime = me.mMeditateModel.getSessionTime();
			me.mMainDuationRenderer.drawOverallElapsedTime(dc, me.mMeditateModel.elapsedTime, alarmTime);
			if (me.mIntervalAlertsRenderer != null) {
				me.mIntervalAlertsRenderer.drawRepeatIntervalAlerts(dc);
				me.mIntervalAlertsRenderer.drawOneOffIntervalAlerts(dc);
			}	
		}
    }
    

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
