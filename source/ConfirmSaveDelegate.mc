using Toybox.WatchUi as Ui;

class ConfirmSaveDelegate extends Ui.ConfirmationDelegate {
	private var mMeditateActivity;

    function initialize(meditateActivity) {
        ConfirmationDelegate.initialize();
        me.mMeditateActivity = meditateActivity;
    }

    function onResponse(value) {
        if (value == Ui.CONFIRM_YES) {        	
        	var summaryModel = me.mMeditateActivity.finish();        	
	        Ui.pushView(new SummaryView(summaryModel), new SummaryViewDelegate(), Ui.SLIDE_IMMEDIATE);
        }
        else {
        	me.mMeditateActivity.discard();
        	var discardedView = new DiscardedView();
        	Ui.pushView(discardedView, new Ui.BehaviorDelegate(), Ui.SLIDE_IMMEDIATE);
        }
    }
}