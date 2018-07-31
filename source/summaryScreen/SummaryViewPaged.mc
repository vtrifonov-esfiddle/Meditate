using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SummaryViewPaged extends Ui.View {
	var mRenderer;
	
	function initialize(renderer) {
		View.initialize();
		me.mRenderer = renderer;
	}	
	
	private function drawUpDownArrows(dc) {
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);			
 		var upYPos = 0;
		dc.drawText(dc.getWidth() / 2, upYPos, IconFonts.fontAwesomeFreeSolid, Ui.loadResource(Rez.Strings.faSortUp), Gfx.TEXT_JUSTIFY_CENTER);	
		var downYPos = dc.getHeight() - dc.getFontHeight(IconFonts.fontAwesomeFreeSolid);
		dc.drawText(dc.getWidth() / 2, downYPos, IconFonts.fontAwesomeFreeSolid, Ui.loadResource(Rez.Strings.faSortDown), Gfx.TEXT_JUSTIFY_CENTER);	
	}
		
	function onUpdate(dc) {     
		if (me.mRenderer != null) {
			me.mRenderer.renderBackgroundColor(dc);	
			me.drawUpDownArrows(dc); 	
			me.mRenderer.renderDetailsView(dc);
		}
    }
}