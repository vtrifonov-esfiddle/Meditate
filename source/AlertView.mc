using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AlertView extends ScreenPickerView {	
	private var mRenderer;
	
	function initialize(alertModel) {	
		ScreenPickerView.initialize();
		me.mRenderer = new DetailsViewRenderer(alertModel);
	}
	
	function onUpdate(dc) {		
		me.mRenderer.renderBackgroundColor(dc);		
		ScreenPickerView.onUpdate(dc);		
		me.mRenderer.renderDetailsView(dc);	  
    }      	
}