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
		me.mMeditateActivity.stop();		
		var calculatingResultsView = new CalculatingResultsView(method(:onFinishActivity));
		Ui.switchToView(calculatingResultsView, me, Ui.SLIDE_IMMEDIATE);	
	}
    
    private function onFinishActivity() {  
    	me.mMeditateActivity.calculateSummaryFields();
    	var summaryViewDelegate = me.showSummaryView();
    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
        Ui.pushView(confirmSaveDialog, new YesNoDelegate(summaryViewDelegate.method(:onConfirmedSave), summaryViewDelegate.method(:onDiscardedSave)), Ui.SLIDE_IMMEDIATE);
    }   
       
    private function showSummaryView() { 
    	var summaryViewDelegate = new SummaryViewDelegate(me.mMeditateActivity);
    	Ui.switchToView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT);  
    	return summaryViewDelegate;
    }
    
    function onBack() {
    	me.mMeditateActivity.stop();
    	me.mMeditateActivity.discard();
    	return false;
    }
        
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.stopActivity();
	    	return true;
	  	}
	  	return false;
    }
}