using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ScreenPickerView extends Ui.View {	
	function initialize() {
		View.initialize();
	}
	
	function onUpdate(dc) {		                
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);			
 		var upYPos = 0;
		dc.drawText(dc.getWidth() / 2, upYPos, IconFonts.fontAwesomeFreeSolid, Ui.loadResource(Rez.Strings.faSortUp), Gfx.TEXT_JUSTIFY_CENTER);	
		var downYPos = dc.getHeight() - dc.getFontHeight(IconFonts.fontAwesomeFreeSolid);
		dc.drawText(dc.getWidth() / 2, downYPos, IconFonts.fontAwesomeFreeSolid, Ui.loadResource(Rez.Strings.faSortDown), Gfx.TEXT_JUSTIFY_CENTER);	       
    }
}