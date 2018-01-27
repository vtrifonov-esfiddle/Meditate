using Toybox.WatchUi as Ui;
using Toybox.Lang;
using Toybox.Graphics as Gfx;

class MeditateView extends Ui.View {
	private var mMeditateModel;
	private var mHeartRateIcon;
	private var mIsHeartIconShowing;
	
    function initialize(meditateModel) {
        View.initialize();
        me.mMeditateModel = meditateModel;
        me.mHeartRateIcon = new Ui.Bitmap({
	         :rezId=>Rez.Drawables.heartRateIcon,
	         :locX=>Ui.LAYOUT_HALIGN_CENTER ,
	         :locY=>180
     	});
     	me.mIsHeartIconShowing = false;
    }
    


    // Load your resources here
    function onLayout(dc) {
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
	
    // Update the view
    function onUpdate(dc) {         
        dc.setColor(me.mMeditateModel.getColor(), me.mMeditateModel.getColor());   
        dc.clear();
        
    	var meditate = new Rez.Drawables.meditate();
        meditate.draw(dc);
		                        
        var output = View.findDrawableById("output");
        output.setText(Lang.format("Alarm: $1$", [TimeFormatter.format(me.mMeditateModel.getAlertTime())]));
        output.draw(dc);
        
        var hr = View.findDrawableById("HR");
       	hr.setText(me.formatHr(me.mMeditateModel.currentHr));		
		hr.draw(dc);
		
		var minHr = View.findDrawableById("MinHR");
		minHr.setText(me.formatHr(me.mMeditateModel.minHr));
		minHr.draw(dc);
		
		
		var time = View.findDrawableById("time");
		var elapsedTime = me.mMeditateModel.elapsedTime;
		time.setText(Lang.format("Time: $1$", [TimeFormatter.format(elapsedTime)]));		
		time.draw(dc);		
        
        if (!me.mIsHeartIconShowing) {
			me.mHeartRateIcon.draw(dc);
		}
		
		me.mIsHeartIconShowing = !me.mIsHeartIconShowing;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
