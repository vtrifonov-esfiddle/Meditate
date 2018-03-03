using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;

class SummaryView extends Ui.View {
	private var mRenderer;
	
	function initialize() {
		View.initialize();
	}
	
	private function formatHr(hr) {
		return hr + " bpm";
	}
	
	function createDetailsRenderer(summaryModel) {
		var details = new DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary";
        details.titleColor = Gfx.COLOR_BLACK;
        details.setAllValuesOffset(5);
        
        details.detailLines[1].icon = Rez.Drawables.timeIcon;
        details.detailLines[1].value.text = TimeFormatter.format(summaryModel.elapsedTime);
                
        details.detailLines[2].icon = Rez.Drawables.heartRateMinIcon;
        details.detailLines[2].value.text = me.formatHr(summaryModel.minHr);
                
        details.detailLines[3].icon = Rez.Drawables.heartRateAvgIcon;
        details.detailLines[3].value.text = me.formatHr(summaryModel.avgHr);
        
        details.detailLines[4].icon = Rez.Drawables.heartRateMaxIcon;
        details.detailLines[4].value.text = me.formatHr(summaryModel.maxHr);
                
        details.detailLines[5].icon = Rez.Drawables.heartRateVariabilityIcon;
        details.detailLines[5].value.text = Lang.format("$1$ ms", [summaryModel.hrv]);
                
        var summaryLineXOffset = App.getApp().getProperty("summaryLineXOffset");
        for (var i = 1; i <= 5; i++) {
            details.detailLines[i].iconOffset = summaryLineXOffset;
        	details.detailLines[i].valueOffset = summaryLineXOffset;
        }
        
        me.mRenderer = new DetailsViewRenderer(details);
	}	
		
	function onUpdate(dc) {     
		if (me.mRenderer != null) {  
			me.mRenderer.renderBackgroundColor(dc);			
			me.mRenderer.renderDetailsView(dc);
		}	  
    }
}