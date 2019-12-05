using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	private var mSummaryModels;
	private var mSessionPickerDelegate;
	private var mHeartbeatIntervalsSensor;
	private var mSummaryModel;
	
    function initialize(meditateModel, summaryModels, heartbeatIntervalsSensor, sessionPickerDelegate) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mSummaryModels = summaryModels;
        me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
        me.mMeditateActivity = new MediteActivity(meditateModel, heartbeatIntervalsSensor);
        me.mSessionPickerDelegate = sessionPickerDelegate;
        me.mSummaryModel = null;
    }
    				
	private function stopActivity() {
		me.mMeditateActivity.stop();				
		var calculatingResultsView = new DelayedFinishingView(method(:onFinishActivity));
		Ui.switchToView(calculatingResultsView, me, Ui.SLIDE_IMMEDIATE);	
	}
	    
    function onFinishActivity() {  
    	me.mSummaryModel = me.mMeditateActivity.calculateSummaryFields();
		    	
    	var confirmSaveActivity = GlobalSettings.loadConfirmSaveActivity();
    	if (confirmSaveActivity == ConfirmSaveActivity.AutoYes) { 
			//Made sure reading/writing session settings for the next session in multi-session mode happens before saving the FIT file.
			//If both happen at the same time FIT file gets corrupted			
			me.mMeditateActivity.finish();
			var saveActivityView = new DelayedFinishingView(me.method(:onShowNextView));
			Ui.switchToView(saveActivityView, me, Ui.SLIDE_IMMEDIATE);    		
        }
        else if (confirmSaveActivity == ConfirmSaveActivity.AutoNo) {
        	me.mMeditateActivity.discard(); 
        	var nextView = new DelayedFinishingView(method(:onShowNextView));
			Ui.switchToView(nextView, me, Ui.SLIDE_IMMEDIATE);	
        }   
        else { 	
        	var nextView = new DelayedFinishingView(method(:onShowNextViewConfirmDialog));
			Ui.switchToView(nextView, me, Ui.SLIDE_IMMEDIATE);
        }
    }   
    
    //this reads/writes session settings and needs to happen before saving session to avoid FIT file corruption          
    private function showSummaryView(summaryModel) { 
    	var summaryViewDelegate = new SummaryViewDelegate(summaryModel, me.mMeditateActivity.method(:discardDanglingActivity));
    	Ui.switchToView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT);  
    }
    
    function onShowNextViewConfirmDialog() {      
    	onShowNextView();
     	
    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
        Ui.pushView(confirmSaveDialog, new YesNoDelegate(me.mMeditateActivity.method(:finish), me.mMeditateActivity.method(:discard)), Ui.SLIDE_IMMEDIATE);
    }
    
    function onShowNextView() {    
    	var continueAfterFinishingSession = GlobalSettings.loadMultiSession();
		if (continueAfterFinishingSession == MultiSession.Yes) {
			showSessionPickerView(me.mSummaryModel);
		}
		else {
			me.mHeartbeatIntervalsSensor.stop();
			me.mHeartbeatIntervalsSensor = null;
			
			showSummaryView(me.mSummaryModel);
		}
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