using Toybox.WatchUi as Ui;


class SummaryView extends ScreenPickerView {
	var mRenderer;
	
	function initialize(renderer) {
		ScreenPickerView.initialize();
		me.mRenderer = renderer;
	}	
		
	function onUpdate(dc) {     
		if (me.mRenderer != null) {
			me.mRenderer.renderBackgroundColor(dc);	
			ScreenPickerView.onUpdate(dc);		
			me.mRenderer.renderDetailsView(dc);
		}
    }
}