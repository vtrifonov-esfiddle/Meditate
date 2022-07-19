using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;
using HrvAlgorithms.HrvTracking;

class SummaryViewDelegate extends ScreenPicker.ScreenPickerDelegate {
	private var mSummaryModel;
	private var mDiscardDanglingActivity;

	function initialize(summaryModel, discardDanglingActivity) {		
		me.mPagesCount = SummaryViewDelegate.getPagesCount(summaryModel.hrvTracking);
		setPageIndexes(summaryModel.hrvTracking);
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = summaryModel;
        me.mDiscardDanglingActivity = discardDanglingActivity;
        me.mSummaryLinesYOffset = App.getApp().getProperty("summaryLinesYOffset");
	}
		
	private var mSummaryLinesYOffset;
			
	private static function getPagesCount(hrvTracking) {		
		var pagesCount = 5;
		if (hrvTracking == HrvTracking.Off) {
			pagesCount -= 4;
		}
		else if (hrvTracking == HrvTracking.On) {
			pagesCount -= 2;
		}
		return pagesCount;
	}
	
	private function setPageIndexes(hrvTracking) {		
		if (hrvTracking == HrvTracking.Off) {
			me.mStressPageIndex = InvalidPageIndex;
			me.mHrvRmssdPageIndex = InvalidPageIndex;
			me.mHrvSdrrPageIndex = InvalidPageIndex;
			me.mHrvPnnxPageIndex = InvalidPageIndex;
		}
		else {
			me.mStressPageIndex = 1;
			me.mHrvRmssdPageIndex = 2;
				
			if (hrvTracking == HrvTracking.OnDetailed) {	
				me.mHrvPnnxPageIndex = me.mHrvRmssdPageIndex + 1;	
				me.mHrvSdrrPageIndex = me.mHrvRmssdPageIndex + 2;
			}
			else {
				me.mHrvPnnxPageIndex = InvalidPageIndex;
				me.mHrvSdrrPageIndex = InvalidPageIndex;
			}
		}
	}
	
	private var mPagesCount;
	
	private var mHrvRmssdPageIndex;
	private var mHrvSdrrPageIndex;
	private var mHrvPnnxPageIndex;
	private var mStressPageIndex;
	
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
			return new ScreenPicker.ScreenPickerDetailsView(details);
		}
		else {
			return new ScreenPicker.ScreenPickerDetailsSinglePageView(details);
		}
	}	
				
	private function formatHr(hr) {
		return hr + " bpm";
	}
	
	private function createDetailsPageHr() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary HR";
        details.titleColor = Gfx.COLOR_BLACK;

        
        var timeIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontAwesomeFreeSolid,
        	:symbol => StatusIconFonts.Rez.Strings.faHourglassEnd,
        	:color=>Graphics.COLOR_BLACK  	
    	});
        details.detailLines[1].icon = timeIcon;
        details.detailLines[1].value.color = Gfx.COLOR_BLACK;
        details.detailLines[1].value.text = TimeFormatter.format(me.mSummaryModel.elapsedTime);
        
        var hrMinIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrMin,
        	:color=>Graphics.COLOR_RED   	
    	});     
        details.detailLines[2].icon = hrMinIcon;
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = me.formatHr(me.mSummaryModel.minHr);
                
        var hrAvgIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrAvg,
        	:color=>Graphics.COLOR_RED   	
    	});            
        details.detailLines[3].icon = hrAvgIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = me.formatHr(me.mSummaryModel.avgHr);
        
        var hrMaxIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrMax,
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
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n Stress";
        details.titleColor = Gfx.COLOR_BLACK;

		//DEBUG logging
		//var now = Time.now();
		//var time = Calendar.info(now, Time.FORMAT_SHORT);
		//System.println(time.hour.format("%d")+":"+time.min.format("%02d")+":"+time.sec.format("%02d"));

		//System.println("stressStart:" + me.mSummaryModel.stressStart);
		//System.println("stressEnd:" + me.mSummaryModel.stressEnd);
		//System.println("--------------------------------------");

 		if (me.mSummaryModel.stressStart!=null && me.mSummaryModel.stressEnd!=null) {

				var lowStressIcon = new ScreenPicker.StressIcon({});
    			lowStressIcon.setLowStress();	      
        		details.detailLines[3].icon = lowStressIcon;  
				details.detailLines[3].value.color = Gfx.COLOR_BLACK;            
				details.detailLines[3].value.text = Lang.format("Stress Start: $1$", [me.mSummaryModel.stressStart.format("%d")]);

				lowStressIcon = new ScreenPicker.StressIcon({});
    			lowStressIcon.setLowStress();	      
        		details.detailLines[4].icon = lowStressIcon;  
				details.detailLines[4].value.color = Gfx.COLOR_BLACK;            
				details.detailLines[4].value.text = Lang.format("Stress End: $1$", [me.mSummaryModel.stressEnd.format("%d")]);
		}

    	var lowStressIcon = new ScreenPicker.StressIcon({});
    	lowStressIcon.setLowStress();	      
        details.detailLines[2].icon = lowStressIcon;  
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;            
        details.detailLines[2].value.text = Lang.format("$1$ %", [me.mSummaryModel.stress]);
                 
        var summaryStressIconsXPos = App.getApp().getProperty("summaryStressIconsXPos");
        var summaryStressValueXPos = App.getApp().getProperty("summaryStressValueXPos");
        details.setAllIconsXPos(summaryStressIconsXPos);
        details.setAllValuesXPos(summaryStressValueXPos);   
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}
	
	private function createDetailsPageHrvRmssd() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV RMSSD";
        details.titleColor = Gfx.COLOR_BLACK;
                             
        details.detailLines[3].icon = new ScreenPicker.HrvIcon({});              
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
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV pNNx";
        details.titleColor = Gfx.COLOR_BLACK;
                            
        var hrvIcon = new ScreenPicker.HrvIcon({});            
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
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV SDRR";
        details.titleColor = Gfx.COLOR_BLACK;
                        
        var hrvIcon = new ScreenPicker.HrvIcon({});            
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