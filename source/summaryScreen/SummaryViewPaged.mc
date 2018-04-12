using Toybox.WatchUi as Ui;


class SummaryViewPaged extends Ui.View {
	var mRenderer;
	
	function initialize(renderer) {
		View.initialize();
		me.mRenderer = renderer;
	}	
	
	private function drawUpDownArrows(dc) {
		var up = new Rez.Drawables.upBlack();
        up.draw(dc);
        var down = new Rez.Drawables.downBlack();
        down.draw(dc); 
	}
		
	function onUpdate(dc) {     
		if (me.mRenderer != null) {
			me.mRenderer.renderBackgroundColor(dc);	
			me.drawUpDownArrows(dc); 	
			me.mRenderer.renderDetailsView(dc);
		}
    }
}