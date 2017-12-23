using Toybox.WatchUi as Ui;

class DurationMenuDelegate extends Ui.MenuInputDelegate {
	private var mMeditateModel;
	
    function initialize(meditateModel) {
        MenuInputDelegate.initialize();
        me.mMeditateModel = meditateModel;
    }
		
    function onMenuItem(item) {
        if (item == :duration1min) {
        	me.mMeditateModel.setDuration(1);
        } 
        else if (item == :duration10min) {
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
        else if (item == :duration60min) {
   	        me.mMeditateModel.setDuration(60);
        }
    }

}