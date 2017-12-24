using Toybox.WatchUi as Ui;

class DurationPickerDelegate extends Ui.PickerDelegate {
	private var mMeditateModel;
	
    function initialize(meditateModel) {
        PickerDelegate.initialize();
        me.mMeditateModel = meditateModel;
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	var durationMins = values[0] * 60 + values[1];    	
    	me.mMeditateModel.setDuration(durationMins);
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

}