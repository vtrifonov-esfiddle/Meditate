using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SummaryView extends Ui.View {
	private var mRenderer;
	
	function initialize(summaryModel) {
		View.initialize();
		me.createDetailsRenderer(summaryModel);
	}
	
	private function createDetailsRenderer(summaryModel) {
		var details = new DetailsModel();
        details.color = Gfx.COLOR_WHITE;
        details.title = "Summary";
        
        details.detailLines[1].icon = Rez.Drawables.timeIcon;
        details.detailLines[1].text = TimeFormatter.format(summaryModel.elapsedTime);
        details.detailLines[1].textOffset = 5;
                
        details.detailLines[2].icon = Rez.Drawables.heartRateAvgIcon;
        details.detailLines[2].text = summaryModel.avgHr;
        details.detailLines[2].textOffset = 5;
        
        details.detailLines[3].icon = Rez.Drawables.heartRateMaxIcon;
        details.detailLines[3].text = summaryModel.maxHr;
        details.detailLines[3].textOffset = 5;
        
        me.mRenderer = new DetailsViewRenderer(details);
	}	
		
	function onUpdate(dc) {       
		me.mRenderer.renderBackgroundColor(dc);			
		me.mRenderer.renderDetailsView(dc);	  
    }
}