using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;

class SummaryViewDelegate extends ScreenPickerDelegate {
	private var mSummaryModel;
	private var mDiscardDanglingActivity;

	function initialize(summaryModel, discardDanglingActivity) {		
		var hrvTracking = GlobalSettings.loadHrvTracking();		
		var stressTracking = GlobalSettings.loadStressTracking();
		me.mPagesCount = SummaryViewDelegate.getPagesCount(hrvTracking, stressTracking);
		setPageIndexes(hrvTracking, stressTracking);
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = summaryModel;
        me.mDiscardDanglingActivity = discardDanglingActivity;
        me.mSummaryLinesYOffset = App.getApp().getProperty("summaryLinesYOffset");
	}
		
	private var mSummaryLinesYOffset;
			
	private static function getPagesCount(hrvTracking, stressTracking) {		
		var pagesCount = 6;
		if (hrvTracking == HrvTracking.Off) {
			pagesCount -= 3;
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
			me.mHrvRmssdPageIndex = InvalidPageIndex;
			me.mHrvSdrrPageIndex = InvalidPageIndex;
			me.mHrvPnnxPageIndex = InvalidPageIndex;
		}
		else {
			if (stressTracking == StressTracking.Off) {
				me.mHrvRmssdPageIndex = 1;
			}
			else if (stressTracking == StressTracking.On) {				
				me.mHrvRmssdPageIndex = 2;
			}
			else {
				me.mHrvRmssdPageIndex = 3;
			}
			me.mHrvPnnxPageIndex = me.mHrvRmssdPageIndex + 1;			
			me.mHrvSdrrPageIndex = me.mHrvRmssdPageIndex + 2;
		}
	}
	
	private var mPagesCount;
	
	private var mHrvRmssdPageIndex;
	private var mHrvSdrrPageIndex;
	private var mHrvPnnxPageIndex;
	private var mStressPageIndex;
	private var mStressMedianPageIndex;
	
	private const InvalidPageIndex = -1;

	function onBack() {
		if (me.mDiscardDanglingActivity != null) {
			me.mDiscardDanglingActivity.invoke();
		}
		
		return false;
	}
	
	function createScreenPickerView() {
		var details;
		if (me.mSelectedPageIndex == 0) {
			details = me.createDetailsPageHr();
		} 
		else if (me.mSelectedPageIndex == me.mStressPageIndex) {
			details = me.createDetailsPageStress();
		}
		else if (me.mSelectedPageIndex == me.mStressMedianPageIndex) {
			details = me.createDetailsMinMaxHrMedian();
		}
		else if (me.mSelectedPageIndex == mHrvRmssdPageIndex){
			details = me.createDetailsPageHrvRmssd();
		}
		else if (me.mSelectedPageIndex == mHrvPnnxPageIndex){
			details = me.createDetailsPageHrvPnnx();
		} 
		else if (me.mSelectedPageIndex == mHrvSdrrPageIndex){
			details = me.createDetailsPageHrvSdrr();
		} 
		else {
			details = me.createDetailsPageHr();
		}
		if (me.mPagesCount > 1) {
			return new ScreenPickerDetailsView(details);
		}
		else {
			return new ScreenPickerDetailsSinglePageView(details);
		}
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

        
        var timeIcon = new Icon({       
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHourglassEnd,
        	:color=>Graphics.COLOR_BLACK  	
    	});
        details.detailLines[1].icon = timeIcon;
        details.detailLines[1].value.color = Gfx.COLOR_BLACK;
        details.detailLines[1].value.text = TimeFormatter.format(me.mSummaryModel.elapsedTime);
        
        var hrMinIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontHrMin,
        	:color=>Graphics.COLOR_RED   	
    	});     
        details.detailLines[2].icon = hrMinIcon;
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = me.formatHr(me.mSummaryModel.minHr);
                
        var hrAvgIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontHrAvg,
        	:color=>Graphics.COLOR_RED   	
    	});            
        details.detailLines[3].icon = hrAvgIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = me.formatHr(me.mSummaryModel.avgHr);
        
        var hrMaxIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontHrMax,
        	:color=>Graphics.COLOR_RED   	
    	});              
        details.detailLines[4].icon = hrMaxIcon;    
        details.detailLines[4].value.color = Gfx.COLOR_BLACK; 
        details.detailLines[4].value.text = me.formatHr(me.mSummaryModel.maxHr);
		
        var hrIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var hrValueXPos = App.getApp().getProperty("summaryHrValueXPos");                
        details.setAllIconsXPos(hrIconsXPos);
        details.setAllValuesXPos(hrValueXPos);   
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
		
	private function createDetailsPageStress() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
        
        var noStressIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontStress,
        	:color=>Graphics.COLOR_GREEN   	
    	});           
        details.detailLines[2].icon = noStressIcon;  
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;            
        details.detailLines[2].value.text = Lang.format("No: $1$ %", [me.mSummaryModel.noStress]);
        
        var lowStressIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontStress,
        	:color=>Graphics.COLOR_YELLOW   	
    	});      
        details.detailLines[3].icon = lowStressIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("Low: $1$ %", [me.mSummaryModel.lowStress]);  
        
        var highStressIcon = new Icon({       
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontStress,
        	:color=>Graphics.COLOR_RED   	
    	});        
        details.detailLines[4].icon = highStressIcon;
        details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = Lang.format("High: $1$ %", [me.mSummaryModel.highStress]);   
         
        var summaryStressIconsXPos = App.getApp().getProperty("summaryStressIconsXPos");
        var summaryStressValueXPos = App.getApp().getProperty("summaryStressValueXPos");
        details.setAllIconsXPos(summaryStressIconsXPos);
        details.setAllValuesXPos(summaryStressValueXPos);   
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}
	
	private function createDetailsMinMaxHrMedian() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;
                             
		var pieChartIcon = new Icon({       
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faPieChart,
        	:color=>Graphics.COLOR_BLACK  	
    	});      
        details.detailLines[3].icon = pieChartIcon;                
        details.detailLines[3].value.text = "Median";   
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = Lang.format("$1$ bpm", [me.mSummaryModel.stressMedian]);   
         
        var summaryStressMedianIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var summaryStressMeidanValueXPos = App.getApp().getProperty("summaryHrValueXPos");
        details.setAllIconsXPos(summaryStressMedianIconsXPos);
        details.setAllValuesXPos(summaryStressMeidanValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}
	
	private function createDetailsPageHrvRmssd() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV RMSSD";
        details.titleColor = Gfx.COLOR_BLACK;
                           
        var hrvIcon = new Icon({       
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHeartbeat,
        	:color=> Icon.HeartBeatPurpleColor  	
    	});            
        details.detailLines[3].icon = hrvIcon;              
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvRmssd]);
                 
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
	
	private function createDetailsPageHrvPnnx() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV pNNx";
        details.titleColor = Gfx.COLOR_BLACK;
                            
        var hrvIcon = new Icon({       
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHeartbeat,
        	:color=> Icon.HeartBeatPurpleColor  	
    	});            
        details.detailLines[2].icon = hrvIcon;      
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;        
        details.detailLines[2].value.text = "pNN20";
        
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ %", [me.mSummaryModel.hrvPnn20]);
        
    	details.detailLines[4].icon = hrvIcon;
    	details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = "pNN50";
        details.detailLines[5].value.color = Gfx.COLOR_BLACK;
        details.detailLines[5].value.text = Lang.format("$1$ %", [me.mSummaryModel.hrvPnn50]);  
         
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
	
	private function createDetailsPageHrvSdrr() {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV SDRR";
        details.titleColor = Gfx.COLOR_BLACK;
                        
        var hrvIcon = new Icon({       
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHeartbeat,
        	:color=> Icon.HeartBeatPurpleColor  	
    	});            
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
         
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
}