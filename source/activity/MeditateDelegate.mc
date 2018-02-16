using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	
    function initialize(meditateModel) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mMeditateActivity = new MediateActivity(me.mMeditateModel);
        me.startActivity();
    }
		
	private function startActivity() {
		me.mMeditateActivity.start();
	}
	
	private function stopActivity() {
		Ui.requestUpdate();
		me.mMeditateActivity.stop();
		me.finishActivity();
	}
    
    private function finishActivity() {
    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
        Ui.pushView(confirmSaveDialog, new YesNoDelegate(method(:onConfirmedSave), method(:onDiscardedSave)), Ui.SLIDE_IMMEDIATE);
    }
    
    private function onConfirmedSave() {
    	var summaryModel = me.mMeditateActivity.finish();  
    	me.showSummaryView(summaryModel);
    }
    
    private function onDiscardedSave() {
    	var summaryModel = me.mMeditateActivity.discard();
    	me.showSummaryView(summaryModel);
    }
    
    private function showSummaryView(summaryModel) {    
        Ui.pushView(new SummaryView(summaryModel), new SummaryViewDelegate(), Ui.SLIDE_IMMEDIATE);
    }
    
    function onBack() {
    	me.mMeditateActivity.stop();
    	me.mMeditateActivity.discard();
    }
        
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.stopActivity();
	    	return true;
	  	}
	  	return false;
    }
}