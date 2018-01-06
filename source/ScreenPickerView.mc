using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ScreenPickerView extends Ui.View {
	private var mColor;
	
	function initialize(color) {
		View.initialize();
		me.mColor = color;
	}
	
	function onUpdate(dc) {				        
        dc.setColor(Gfx.COLOR_TRANSPARENT, me.mColor);        
        dc.clear();
                
        var up = new Rez.Drawables.up();
        up.draw(dc);
        var down = new Rez.Drawables.down();
        down.draw(dc);        
    }
}