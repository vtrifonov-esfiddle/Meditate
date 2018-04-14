using Toybox.WatchUi as Ui;


class SummaryView extends Ui.View {
	var mRenderer;
	
	function initialize(renderer) {
		View.initialize();
		me.mRenderer = renderer;
	}	
			
	function onUpdate(dc) {     
		if (me.mRenderer != null) {
			me.mRenderer.renderBackgroundColor(dc);	
			me.mRenderer.renderDetailsView(dc);
		}
    }
}