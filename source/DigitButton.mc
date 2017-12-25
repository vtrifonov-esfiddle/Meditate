using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DigitButton extends Ui.Button {

	private function getDigitBitmapRezId(digit) {
		switch (digit) {
			case 0: 
				return Rez.Drawables.digit0;
			case 1:
				return Rez.Drawables.digit1;
			case 2:
				return Rez.Drawables.digit2;
			case 3:
				return Rez.Drawables.digit3;
			case 4:
				return Rez.Drawables.digit4;
			case 5:
				return Rez.Drawables.digit5;
			case 6:
				return Rez.Drawables.digit6;
			case 7:
				return Rez.Drawables.digit7;
			case 8:
				return Rez.Drawables.digit8;
			case 9:
				return Rez.Drawables.digit9;
		}
	}
	
	private function getDigitDisabledBitmapRezId(digit) {
		switch (digit) {
			case 0: 
				return Rez.Drawables.digit0Disabled;
			case 1:
				return Rez.Drawables.digit1Disabled;
			case 2:
				return Rez.Drawables.digit2Disabled;
			case 3:
				return Rez.Drawables.digit3Disabled;
			case 4:
				return Rez.Drawables.digit4Disabled;
			case 5:
				return Rez.Drawables.digit5Disabled;
			case 6:
				return Rez.Drawables.digit6Disabled;
			case 7:
				return Rez.Drawables.digit7Disabled;
			case 8:
				return Rez.Drawables.digit8Disabled;
			case 9:
				return Rez.Drawables.digit9Disabled;
		}
	}
	
	private function getDigitDefaultBitmap(value) {
		return new Ui.Bitmap({:rezId=>getDigitBitmapRezId(value)});
	}
	
	private function getDigitDisabledBitmap(value) {
		return new Ui.Bitmap({:rezId=>getDigitDisabledBitmapRezId(value)});
	}
	
	function initialize(x, y, value) {
		var buttonDefault = me.getDigitDefaultBitmap(value);
        //var buttonDisabled = me.getDigitDisabledBitmap(value);

        var width = buttonDefault.getDimensions()[0];
        var height = buttonDefault.getDimensions()[1];
			
		//:stateDisabled=>buttonDisabled,
        var options = {
            :stateDefault=>buttonDefault,
            
            :stateSelected=>Gfx.COLOR_GREEN,
            :locX=>x,
            :locY=>y,
            :width=>width,
            :height=>height
            };
            
		Ui.Button.initialize(options);
		
		me.mValue = value;
	}
	
	private var mValue;
	
	function getDigitValue() {
		return me.mValue;
	}
}
