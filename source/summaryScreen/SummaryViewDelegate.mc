using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;

class SummaryViewDelegate extends ScreenPickerDelegate {
	private var mSummaryModel;
	private var mMeditateActivity;

	function initialize(meditateActivity) {		
		var hrvTracking = GlobalSettings.loadHrvTracking();		
		var stressTracking = GlobalSettings.loadStressTracking();
		me.mPagesCount = SummaryViewDelegate.getPagesCount(hrvTracking, stressTracking);
		setPageIndexes(hrvTracking, stressTracking);
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = meditateActivity.getSummary();
        me.mMeditateActivity = meditateActivity;
	}
		
	private static function getPagesCount(hrvTracking, stressTracking) {		
		var pagesCount = 4;
		if (hrvTracking == HrvTracking.Off) {
			pagesCount--;
		}
		if (stressTracking == StressTracking.Off) {
			pagesCount -= 2;
		}
		else if (stressTracking == StressTracking.On) {
			pagesCount--;
		}
		return pagesCount;
	}
	
	private function setPageIndexes(hrvTracking, stressTracking) {
		if (stressTracking == StressTracking.Off) {
			me.mStressPageIndex = InvalidPageIndex;
		}
		else {
			me.mStressPageIndex = 1;
		}
		
		if (stressTracking == StressTracking.OnDetailed) {
			me.mStressMedianPageIndex = 2;
		}
		else {
			me.mStressMedianPageIndex = InvalidPageIndex;
		}
		
		if (hrvTracking == HrvTracking.Off) {
			me.mHrvPageIndex = InvalidPageIndex;
		}
		else {
			if (stressTracking == StressTracking.Off) {
				me.mHrvPageIndex = 1;
			}
			else if (stressTracking == StressTracking.On) {
				me.mHrvPageIndex = 2;
			}
			else {
				me.mHrvPageIndex = 3;
			}
		}
	}
	
	private var mPagesCount;
	
	private var mHrvPageIndex;
	private var mStressPageIndex;
	private var mStressMedianPageIndex;
	
	private const InvalidPageIndex = -1;

	function onBack() {
		me.mMeditateActivity.discardDanglingActivity();
		var continueAfterFinishingSession = GlobalSettings.loadContinueAfterFinishingSession();
		if (continueAfterFinishingSession == ContinueAfterFinishingSession.Yes) {
			var sessionStorage = new SessionStorage();	
			var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage);
			Ui.switchToView(sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate, Ui.SLIDE_LEFT);
			return true;
		}
		else {
			return false; //exit app
		}
	}
	
	function createScreenPickerView() {
		var renderer;
		if (me.mSelectedPageIndex == 0) {
			renderer = me.createDetailsPageHr();
		} 
		else if (me.mSelectedPageIndex == me.mStressPageIndex) {
			renderer = me.createDetailsPageStress();
		}
		else if (me.mSelectedPageIndex == me.mStressMedianPageIndex) {
			renderer = me.createDetailsMinMaxHrMedian();
		}
		else if (me.mSelectedPageIndex == mHrvPageIndex){
			renderer = me.createDetailsPageHrv();
		}
		else {
			renderer = me.createDetailsPageHr();
		}
		if (me.mPagesCount > 1) {
			me.mSummaryView = new SummaryViewPaged(renderer);
		}
		else {
			me.mSummaryView = new SummaryView(renderer);
		}
		return me.mSummaryView;
	}	
		
	private var mSummaryView;
	
 	function onConfirmedSave() {
    	me.mMeditateActivity.finish(); 
    }
    
    function onDiscardedSave() {
    	me.mMeditateActivity.discard();
    }
	
	private function formatHr(hr) {
		return hr + " bpm";
	}
	
	private function createDetailsPageHr() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary HR";
        details.titleColor = Gfx.COLOR_BLACK;
        details.setAllValuesOffset(5);
        
        details.detailLines[1].icon = Rez.Drawables.timeIcon;
        details.detailLines[1].value.text = TimeFormatter.format(me.mSummaryModel.elapsedTime);
                
        details.detailLines[2].icon = Rez.Drawables.heartRateMinIcon;
        details.detailLines[2].value.text = me.formatHr(me.mSummaryModel.minHr);
                
        details.detailLines[3].icon = Rez.Drawables.heartRateAvgIcon;
        details.detailLines[3].value.text = me.formatHr(me.mSummaryModel.avgHr);
        
        details.detailLines[4].icon = Rez.Drawables.heartRateMaxIcon;
        details.detailLines[4].value.text = me.formatHr(me.mSummaryModel.maxHr);
                
                
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXOffset");
        for (var i = 1; i <= 5; i++) {
            details.detailLines[i].iconOffset = summaryLineXOffset;
        	details.detailLines[i].valueOffset = summaryLineXOffset;
        }
        
        return new DetailsViewRenderer(details);
	}	
		
	private function createDetailsPageStress() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
        details.setAllValuesOffset(5);
                      
        details.detailLines[2].icon = Rez.Drawables.noStressIcon;
        details.detailLines[2].value.text = Lang.format("No: $1$ %", [me.mSummaryModel.noStress]);
        
    	details.detailLines[3].icon = Rez.Drawables.lowStressIcon;
        details.detailLines[3].value.text = Lang.format("Low: $1$ %", [me.mSummaryModel.lowStress]);  
        
    	details.detailLines[4].icon = Rez.Drawables.highStressIcon;
        details.detailLines[4].value.text = Lang.format("High: $1$ %", [me.mSummaryModel.highStress]);   
         
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXStressOffset");
        for (var i = 1; i <= 5; i++) {
            details.detailLines[i].iconOffset = summaryLineXOffset;
        	details.detailLines[i].valueOffset = summaryLineXOffset;
        }
        
        return new DetailsViewRenderer(details);
	}
	
	private function createDetailsMinMaxHrMedian() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
        details.setAllValuesOffset(5);
                              
        details.detailLines[3].icon = Rez.Drawables.pieChartIcon;
        details.detailLines[3].value.text = "Median";   
        details.detailLines[4].value.text = Lang.format("$1$ bpm", [me.mSummaryModel.stressMedian]);   
         
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXOffset");
        for (var i = 1; i <= 5; i++) {
            details.detailLines[i].iconOffset = summaryLineXOffset;
        	details.detailLines[i].valueOffset = summaryLineXOffset;
        }
        
        return new DetailsViewRenderer(details);
	}
	
	private function createDetailsPageHrv() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV SDRR";
        details.titleColor = Gfx.COLOR_BLACK;
        details.setAllValuesOffset(5);
                      
        details.detailLines[2].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[2].value.text = "First 5 min";
        details.detailLines[3].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvFirst5Min]);
        
    	details.detailLines[4].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[4].value.text = "Last 5 min";
        details.detailLines[5].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvLast5Min]);  
         
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXHrvOffset");
        for (var i = 1; i <= 5; i++) {
            details.detailLines[i].iconOffset = summaryLineXOffset;
        	details.detailLines[i].valueOffset = summaryLineXOffset;
        }
        
        return new DetailsViewRenderer(details);
	}	
}