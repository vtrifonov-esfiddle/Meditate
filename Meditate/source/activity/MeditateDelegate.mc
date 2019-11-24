using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	private var mSummaryModels;
	private var mSessionPickerDelegate;
	private var mHeartbeatIntervalsSensor;
	
    function initialize(meditateModel, summaryModels, heartbeatIntervalsSensor, sessionPickerDelegate) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mSummaryModels = summaryModels;
        me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
        me.mMeditateActivity = new MediteActivity(meditateModel, heartbeatIntervalsSensor);
        me.mSessionPickerDelegate = sessionPickerDelegate;
    }
    				
	private function stopActivity() {
		me.mMeditateActivity.stop();				
		var calculatingResultsView = new DelayedFinishingView(method(:onFinishActivity));
		Ui.switchToView(calculatingResultsView, me, Ui.SLIDE_IMMEDIATE);	
	}
	    
    function onFinishActivity() {  
		showNextView();
		    	
    	var confirmSaveActivity = GlobalSettings.loadConfirmSaveActivity();
    	if (confirmSaveActivity == ConfirmSaveActivity.AutoYes) { 
			//Made sure reading/writing session settings for the next session in multi-session mode happens before saving the FIT file.
			//If both happen at the same time FIT file gets corrupted
			var saveActivityView = new DelayedFinishingView(me.method(:onAutoSaveActivity));
			Ui.pushView(saveActivityView, me, Ui.SLIDE_IMMEDIATE);    		
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
    
    //this reads/writes session settings and needs to happen before saving session to avoid FIT file corruption          
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
			me.mHeartbeatIntervalsSensor.stop();
			me.mHeartbeatIntervalsSensor = null;
			
			showSummaryView(summaryModel);
		}
    }

	function onAutoSaveActivity() {
		me.mMeditateActivity.method(:finish);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
    
    private function showSessionPickerView(summaryModel) {		
		me.mSessionPickerDelegate.addSummary(summaryModel);
		Ui.switchToView(me.mSessionPickerDelegate.createScreenPickerView(), me.mSessionPickerDelegate, Ui.SLIDE_RIGHT);
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