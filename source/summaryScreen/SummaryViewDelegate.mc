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

        
        var timeIcon = new Icon();
        timeIcon.font = IconFonts.fontAwesomeFreeSolid;
        timeIcon.setSymbol(Rez.Strings.faHourglassEnd);
        timeIcon.color = Gfx.COLOR_BLACK;
        details.detailLines[1].icon = timeIcon;
        details.detailLines[1].value.color = Gfx.COLOR_BLACK;
        details.detailLines[1].value.text = TimeFormatter.format(me.mSummaryModel.elapsedTime);
        
        var hrMinIcon = new Icon();
        hrMinIcon.font= IconFonts.fontMeditateIcons;
        hrMinIcon.setSymbol(Rez.Strings.meditateFontHrMin);                
        hrMinIcon.color = Gfx.COLOR_RED;        
        details.detailLines[2].icon = hrMinIcon;
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = me.formatHr(me.mSummaryModel.minHr);
                
        var hrAvgIcon = new Icon();
        hrAvgIcon.font = IconFonts.fontMeditateIcons;
        hrAvgIcon.setSymbol(Rez.Strings.meditateFontHrAvg);                
        hrAvgIcon.color = Gfx.COLOR_RED;                
        details.detailLines[3].icon = hrAvgIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = me.formatHr(me.mSummaryModel.avgHr);
        
        var hrMaxIcon = new Icon();
        hrMaxIcon.font = IconFonts.fontMeditateIcons;
        hrMaxIcon.setSymbol(Rez.Strings.meditateFontHrMax);                
        hrMaxIcon.color = Gfx.COLOR_RED;    
        details.detailLines[4].icon = hrMaxIcon;    
        details.detailLines[4].value.color = Gfx.COLOR_BLACK; 
        details.detailLines[4].value.text = me.formatHr(me.mSummaryModel.maxHr);
		
        var hrIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var hrValueXPos = App.getApp().getProperty("summaryHrValueXPos");                
        details.setAllIconsXPos(hrIconsXPos);
        details.setAllValuesXPos(hrValueXPos);   
        
        return new DetailsViewRenderer(details);
	}	
		
	private function createDetailsPageStress() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
        
        var noStressIcon = new Icon();
        noStressIcon.font = IconFonts.fontMeditateIcons;
        noStressIcon.setSymbol(Rez.Strings.meditateFontStress);                
        noStressIcon.color = Gfx.COLOR_GREEN;        
        details.detailLines[2].icon = noStressIcon;  
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;            
        details.detailLines[2].value.text = Lang.format("No: $1$ %", [me.mSummaryModel.noStress]);
        
        var lowStressIcon = new Icon();
        lowStressIcon.font = IconFonts.fontMeditateIcons;
        lowStressIcon.setSymbol(Rez.Strings.meditateFontStress);                
        lowStressIcon.color = Gfx.COLOR_YELLOW;        
        details.detailLines[3].icon = lowStressIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("Low: $1$ %", [me.mSummaryModel.lowStress]);  
        
        var highStressIcon = new Icon();
        highStressIcon.font = IconFonts.fontMeditateIcons;
        highStressIcon.setSymbol(Rez.Strings.meditateFontStress);                
        highStressIcon.color = Gfx.COLOR_RED;        
        details.detailLines[4].icon = highStressIcon;
        details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = Lang.format("High: $1$ %", [me.mSummaryModel.highStress]);   
         
        var summaryStressIconsXPos = App.getApp().getProperty("summaryStressIconsXPos");
        var summaryStressValueXPos = App.getApp().getProperty("summaryStressValueXPos");
        details.setAllIconsXPos(summaryStressIconsXPos);
        details.setAllValuesXPos(summaryStressValueXPos);   
        
        return new DetailsViewRenderer(details);
	}
	
	private function createDetailsMinMaxHrMedian() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
                             
		var pieChartIcon = new Icon();
		pieChartIcon.font = IconFonts.fontAwesomeFreeSolid;
        pieChartIcon.setSymbol(Rez.Strings.faPieChart);                
        pieChartIcon.color = Gfx.COLOR_BLACK;        
        details.detailLines[3].icon = pieChartIcon;                
        details.detailLines[3].value.text = "Median";   
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = Lang.format("$1$ bpm", [me.mSummaryModel.stressMedian]);   
         
        var summaryStressMedianIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var summaryStressMeidanValueXPos = App.getApp().getProperty("summaryHrValueXPos");
        details.setAllIconsXPos(summaryStressMedianIconsXPos);
        details.setAllValuesXPos(summaryStressMeidanValueXPos); 
        
        return new DetailsViewRenderer(details);
	}
	
	private function createDetailsPageHrv() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV SDRR";
        details.titleColor = Gfx.COLOR_BLACK;
        
        var hrvIcon = new Icon();        
        hrvIcon.font = IconFonts.fontAwesomeFreeSolid;
        hrvIcon.setSymbol(Rez.Strings.faHeartbeat);    
        var heartBeatPurpleColor = 0xFF00FF;            
        hrvIcon.color = heartBeatPurpleColor;        
        details.detailLines[2].icon = hrvIcon;      
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;        
        details.detailLines[2].value.text = "First 5 min";
        
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvFirst5Min]);
        
    	details.detailLines[4].icon = hrvIcon;
    	details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = "Last 5 min";
        details.detailLines[5].value.color = Gfx.COLOR_BLACK;
        details.detailLines[5].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvLast5Min]);  
         
        var summaryStressMedianIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var summaryStressMeidanValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(summaryStressMedianIconsXPos);
        details.setAllValuesXPos(summaryStressMeidanValueXPos); 
        //details.setAllLinesYOffset(-10);
        
        return new DetailsViewRenderer(details);
	}	
}