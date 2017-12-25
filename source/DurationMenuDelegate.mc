using Toybox.WatchUi as Ui;

class DurationMenuDelegate extends Ui.MenuInputDelegate {
	private var mMeditateModel;
	
    function initialize(meditateModel) {
        MenuInputDelegate.initialize();
        me.mMeditateModel = meditateModel;
    }
		
    function onMenuItem(item) {
        if (item == :duration10min) {
        	me.mMeditateModel.setDuration(10);
        }
        else if (item == :duration15min) {
   	        me.mMeditateModel.setDuration(15);
        }
        else if (item == :duration20min) {
   	        me.mMeditateModel.setDuration(20);
        }
        else if (item == :duration30min) {
   	        me.mMeditateModel.setDuration(30);
        }
        else if (item == :durationCustom) {
        	var durationPickerModel = new DurationPickerModel();
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, me.mMeditateModel), Ui.SLIDE_IMMEDIATE);
        }
    }

}