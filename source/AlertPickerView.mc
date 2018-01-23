using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AlertPickerView extends ScreenPickerView {	
	private var mRenderer;
	
	function initialize(detailsModel) {	
		ScreenPickerView.initialize();
		me.mRenderer = new DetailsViewRenderer(detailsModel);
	}
	
	function onUpdate(dc) {		
		me.mRenderer.renderBackgroundColor(dc);		
		ScreenPickerView.onUpdate(dc);		
		me.mRenderer.renderDetailsView(dc);	  
    }      	
}