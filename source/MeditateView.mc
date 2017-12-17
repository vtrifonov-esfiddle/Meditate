using Toybox.WatchUi as Ui;

class MeditateView extends Ui.View {
	private var mMeditateModel;
	
    function initialize(meditateModel) {
        View.initialize();
        me.mMeditateModel = meditateModel;
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
        hr.setText("HR: " + me.mMeditateModel.heartRate);
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
