using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;

class SummaryViewDelegate extends ScreenPickerDelegate {
	private var mSummaryModel;
	private var mMeditateActivity;

	function initialize(meditateActivity) {
        ScreenPickerDelegate.initialize(0, 3);
        me.mSummaryModel = null;
        me.mMeditateActivity = meditateActivity;
	}

	private function exitApplication() {		
		System.exit();
	}

	function onBack() {
		me.exitApplication();
	}
	
	function createScreenPickerView() {
		var renderer;
		if (me.mSummaryModel == null) {
			renderer = null; 
		}
		else if (me.mSelectedPageIndex == 0) {
			renderer = me.createDetailsPageHr();
		} 
		else if (me.mSelectedPageIndex == 1) {
			renderer = me.createDetailsPageStress();
		}
		else {
			renderer = me.createDetailsPageHrv();
		}
		me.mSummaryView = new SummaryView(renderer);
		return me.mSummaryView;
	}
	
	private var mSummaryView;
	
	private function refreshSummaryView() {
		me.mSummaryView.mRenderer = me.createDetailsPageHr();
		Ui.requestUpdate();
	}
	
 	function onConfirmedSave() {
    	me.mSummaryModel = me.mMeditateActivity.finish(); 
    	me.refreshSummaryView();
    }
    
    function onDiscardedSave() {
    	me.mSummaryModel = me.mMeditateActivity.discard();
    	me.refreshSummaryView();
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
                      
        details.detailLines[2].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[2].value.text = Lang.format("No: $1$ %", [me.mSummaryModel.noStress]);
        
    	details.detailLines[3].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[3].value.text = Lang.format("Some: $1$ %", [me.mSummaryModel.mediumStress]);  
        
    	details.detailLines[4].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[4].value.text = Lang.format("High: $1$ %", [me.mSummaryModel.highStress]);   
         
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXStressOffset");
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
        details.title = "Summary\n HRV";
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