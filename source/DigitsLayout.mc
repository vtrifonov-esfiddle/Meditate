using Toybox.WatchUi as Ui;

class DigitsLayout {
	private var durationText;
	private var doneIcon;
	
	function initialize(viewDc) {
		me.digitsLayout = new[12];
				
		me.digitsLayout[0] = new Rez.Drawables.WhiteBackground();
		me.durationText = new Ui.Text({
            :text=>"Pick duration",
            :color=>Graphics.COLOR_BLACK,
            :backgroundColor=>Graphics.COLOR_LT_GRAY,
            :font=>Graphics.FONT_TINY,
            :locX =>Ui.LAYOUT_HALIGN_CENTER,
            :locY=>Ui.LAYOUT_VALIGN_CENTER
        });		
        me.digitsLayout[1] = me.durationText;		
				
		var digitSize = 40;
		var digitCirclePos = new DigitCirclePosition(viewDc.getWidth(), viewDc.getHeight(), digitSize);
		
		for (var digit = 0; digit < 10; digit++) {
			var posCoefficient = 0.1 * digit;
			
			var pos = digitCirclePos.getPos(posCoefficient);
			var layoutPos = digit+2;
			me.digitsLayout[layoutPos] = new DigitButton(pos["x"], pos["y"], digit);	
		}	
	}
	
	
	function updateDurationText(text) {
		me.durationText.setText(text);
	}
	
	var digitsLayout;
}
