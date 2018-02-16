using Toybox.WatchUi as Ui;

class ConfirmSaveDelegate extends Ui.ConfirmationDelegate {
	private var mMeditateActivity;

    function initialize(meditateActivity) {
        ConfirmationDelegate.initialize();
        me.mMeditateActivity = meditateActivity;
    }

    function onResponse(value) {
    	var summaryModel;
        if (value == Ui.CONFIRM_YES) {        	
        	summaryModel = me.mMeditateActivity.finish();  	        
        }
        else {
        	summaryModel = me.mMeditateActivity.discard();
        }
        Ui.pushView(new SummaryView(summaryModel), new SummaryViewDelegate(), Ui.SLIDE_IMMEDIATE);
    }
}