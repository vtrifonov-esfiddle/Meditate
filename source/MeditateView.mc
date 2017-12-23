using Toybox.WatchUi as Ui;
using Toybox.Lang;

class MeditateView extends Ui.View {
	private var mMeditateModel;
	private var mHeartRateIcon;
	private var mIsHeartIconShowing;
	
    function initialize(meditateModel) {
        View.initialize();
        me.mMeditateModel = meditateModel;
        me.mHeartRateIcon = new Ui.Bitmap({
	         :rezId=>Rez.Drawables.HeartRateIcon,
	         :locX=>Ui.LAYOUT_HALIGN_CENTER ,
	         :locY=>160
     	});
     	me.mIsHeartIconShowing = false;
    }
    

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
	
	
    // Update the view
    function onUpdate(dc) {       
        var output = View.findDrawableById("output");
        output.setText(me.mMeditateModel.output);
        
        var hr = View.findDrawableById("HR");
        if (me.mMeditateModel.heartRate) {
	       	hr.setText(me.mMeditateModel.heartRate.toString());		
		}
		
		var duration = View.findDrawableById("duration");
		var durationMins = me.mMeditateModel.getDurationMins();
		duration.setText(Lang.format("Duration: $1$ mins", [durationMins]));		
				
        View.onUpdate(dc);
        if (!me.mIsHeartIconShowing && me.mMeditateModel.isStarted) {
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
