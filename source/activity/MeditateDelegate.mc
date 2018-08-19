using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	private var mSummaryModels;
	
    function initialize(meditateModel, summaryModels) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mSummaryModels = summaryModels;
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
    
    function onFinishActivity() {  
    	showNextView();
    	
    	var confirmSaveActivity = GlobalSettings.loadConfirmSaveActivity();
    	if (confirmSaveActivity == ConfirmSaveActivity.AutoYes) { 
    		me.mMeditateActivity.finish();    		
        }
        else if (confirmSaveActivity == ConfirmSaveActivity.AutoNo) {
        	me.mMeditateActivity.discard(); 
        }   
        else { 	
	    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
	    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
	        Ui.pushView(confirmSaveDialog, new YesNoDelegate(me.mMeditateActivity.method(:finish), me.mMeditateActivity.method(:discard)), Ui.SLIDE_IMMEDIATE);
        }
    }   
       
    private function showSummaryView(summaryModel) { 
    	var summaryViewDelegate = new SummaryViewDelegate(summaryModel, me.mMeditateActivity.method(:discardDanglingActivity));
    	Ui.switchToView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT);  
    }
    
    private function showNextView() {    
    	var summaryModel = me.mMeditateActivity.calculateSummaryFields();
    	var continueAfterFinishingSession = GlobalSettings.loadMultiSession();
		if (continueAfterFinishingSession == MultiSession.Yes) {
			showSessionPickerView(summaryModel);
		}
		else {
			showSummaryView(summaryModel);
		}
    }
    
    private function showSessionPickerView(summaryModel) {
		var sessionStorage = new SessionStorage();	
		me.mSummaryModels.addSummary(summaryModel);
		var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage, me.mSummaryModels);
		Ui.switchToView(sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate, Ui.SLIDE_RIGHT);
    }
    
    function onBack() {
    	//making sure the app doesn't exit during an activity until the user stops it
    	return true;
    }
        
	private const MinMeditateActivityStopTime = 1;
	
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER && me.mMeditateModel.elapsedTime >= MinMeditateActivityStopTime) {
	    	me.stopActivity();
	    	return true;
	  	}
	  	return false;
    }
}