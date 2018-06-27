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
    	
    	var activityConfirmation = GlobalSettings.loadSaveActivityConfirmation();
    	if (activityConfirmation == SaveActivityConfirmation.AutoYes) { 
    		summaryViewDelegate.onConfirmedSave();    		
        }
        else if (activityConfirmation == SaveActivityConfirmation.AutoNo) {
        	summaryViewDelegate.onDiscardedSave(); 
        }   
        else { 	
	    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
	    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
	        Ui.pushView(confirmSaveDialog, new YesNoDelegate(summaryViewDelegate.method(:onConfirmedSave), summaryViewDelegate.method(:onDiscardedSave)), Ui.SLIDE_IMMEDIATE);
        }
    }   
       
    private function showSummaryView() { 
    	var summaryViewDelegate = new SummaryViewDelegate(me.mMeditateActivity);
    	Ui.switchToView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT);  
    	return summaryViewDelegate;
    }
    
    function onBack() {
    	//making sure the app doesn't exit during an activity until the user stops it
    	return true;
    }
        
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.stopActivity();
	    	return true;
	  	}
	  	return false;
    }
}