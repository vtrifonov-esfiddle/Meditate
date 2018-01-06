using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ColorPickerView extends Ui.View {
	private var mColor;
	function initialize(color) {
		View.initialize();
		me.mColor = color;
	}
	
	function onLayout(dc) {
		setLayout(Rez.Layouts.ColorPicker(dc));
	}
	
	function onUpdate(dc) {		
        View.onUpdate(dc);   
        
        dc.setColor(me.mColor, Gfx.COLOR_TRANSPARENT); 
        dc.fillCircle(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2);        
        
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_TRANSPARENT); 
        var up = new Rez.Drawables.up();
        up.draw(dc);
        var down = new Rez.Drawables.down();
        down.draw(dc);        
    }
}