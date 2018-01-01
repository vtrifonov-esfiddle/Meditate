using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DigitsLayout {
	private var mFontDigits;
	
	const DigitsInputCount = 10;
		
	function initialize(viewDc) {
        me.mDigitsOutput = new DigitsOutput(viewDc, Gfx.FONT_TINY, ":");        
        var digitsOutputLayout = me.mDigitsOutput.getLayout();
		
		me.digitsLayout = new[DigitsInputCount + digitsOutputLayout.size() + 1];				
		me.mFontDigits = Ui.loadResource(Rez.Fonts.fontDigits);
								
		var digitSize = 40;
		var digitCirclePos = new DigitCirclePosition(viewDc.getWidth(), viewDc.getHeight(), digitSize);
		
		for (var digit = 0; digit < 10; digit++) {
			var posCoefficient = 0.1 * digit;
			
			var pos = digitCirclePos.getPos(posCoefficient);
			var layoutPos = digit+1;
			me.digitsLayout[layoutPos] = new DigitButton(pos["x"], pos["y"], digit, me.mFontDigits);			
		}		
		
		me.digitsLayout[0] = new Rez.Drawables.WhiteBackground();
		me.setDigitsOutputToLayout(me.digitsLayout, digitsOutputLayout);	
	}
	
	private function setDigitsOutputToLayout(digitsLayout, digitsOutputLayout) {	
		var digitOutputPos = DigitsInputCount + 1;
		
		for (var i = 0; i < digitsOutputLayout.size(); i++) {
			digitsLayout[digitOutputPos + i] = digitsOutputLayout[i];
		}
	}
	
	private var mDigitsOutput;
	
	function getDigitsOutput() {
		return me.mDigitsOutput;
	}	
	
	private function getDigitButton(digit) {
		var layoutPos = digit+1;
		return me.digitsLayout[layoutPos];
	}
		
	function enableDigitState(digit) {
		me.getDigitButton(digit).setState(:stateDefault);
	}
	
	function disableDigitState(digit) {
		me.getDigitButton(digit).setState(:stateDisabled);
	}	
	
	function enableAllDigits() {
		for (var digit = 0; digit < 10; digit++) {
			me.enableDigitState(digit);
		}
	}
	
	function disableAllDigits() {
		for (var digit = 0; digit < 10; digit++) {
			me.disableDigitState(digit);
		}
	}
	
	var digitsLayout;
}
