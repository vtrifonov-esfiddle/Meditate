using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ScreenPickerDetailsSinglePageView extends Ui.View {	
	private var mRenderer;
	
	function initialize(detailsModel) {	
		View.initialize();
		me.mRenderer = new DetailsViewRenderer(detailsModel);
	}
	
	function onUpdate(dc) {	
		View.onUpdate(dc);	
		me.mRenderer.renderBackgroundColor(dc);		
		me.mRenderer.renderDetailsView(dc);	  
    }      	
}