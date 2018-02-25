using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DigitsLayout {
	private var mFontDigits;
	
	const DigitsInputCount = 10;
		
	function initialize(dcWidth, dcHeight, digitsOutput, digitsEnabledSpec) {
        me.mDigitsOutput = digitsOutput;      
        var digitsOutputLayout = me.mDigitsOutput.getLayout();
		
		me.digitsLayout = new[DigitsInputCount + digitsOutputLayout.size() + 1];				
		me.mFontDigits = Ui.loadResource(Rez.Fonts.fontDigits);
								
		var digitSize = 40;
		var digitCirclePos = new DigitCirclePosition(dcWidth, dcHeight, digitSize);
		
		for (var digit = 0; digit < DigitsInputCount; digit++) {
			var posCoefficient = 0.1 * digit;
			
			var pos = digitCirclePos.getPos(posCoefficient);
			var layoutPos = digit+1;
			me.digitsLayout[layoutPos] = new DigitButton(pos["x"], pos["y"], digit, me.mFontDigits);			
		}		
		
		me.digitsLayout[0] = new Rez.Drawables.whiteBackground();
		me.setDigitsOutputToLayout(me.digitsLayout, digitsOutputLayout);	
				
        me.mEnabledDigitsLayout = new EnabledDigitsLayout(digitsEnabledSpec, me.digitsLayout);  
	}
	
	private var mEnabledDigitsLayout;
	
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
		
	function setEnabledDigits(selectedDigitIndex) {
		me.mEnabledDigitsLayout.setEnabledDigits(selectedDigitIndex);
	}
			
	var digitsLayout;
}

class EnabledDigitsLayout {
	function initialize(digitsEnabledSpec, digitsLayout) {
		me.mDigitsEnabledSpec = digitsEnabledSpec;
		me.mDigitsLayout = digitsLayout;
	}
	
	private var mDigitsLayout;
	private const DigitsInputCount = 10;
	private var mDigitsEnabledSpec;
	
	private function getDigitButton(digit) {
		var layoutPos = digit+1;
		return me.mDigitsLayout[layoutPos];
	}
	
	private function enableDigitState(digit) {
		if (me.getDigitButton(digit).getState() == :stateDisabled) {
			me.getDigitButton(digit).setState(:stateDefault);
		}
		else if (me.getDigitButton(digit).getState() == :stateHighlightedSelected || me.getDigitButton(digit).getState() == :stateSelected) {
			me.getDigitButton(digit).setState(:stateHighlighted);
		}
	}
	
	private function disableDigitState(digit) {
		me.getDigitButton(digit).setState(:stateDisabled);
	}		
	
	function setEnabledDigits(selectedDigitIndex) {
		if (selectedDigitIndex < 0 || selectedDigitIndex >= me.mDigitsEnabledSpec.size()) {
			me.disableAllDigits();
			return;
		} 
		var minValue = me.mDigitsEnabledSpec[selectedDigitIndex][:minValue];
		var maxValue = me.mDigitsEnabledSpec[selectedDigitIndex][:maxValue];
		for (var digit = minValue; digit <= maxValue; digit++) {			
			me.enableDigitState(digit);
		}
		for (var digit = 0; digit < minValue; digit++) {			
			me.disableDigitState(digit);
		}
		for (var digit = maxValue + 1; digit < DigitsInputCount; digit++) {			
			me.disableDigitState(digit);
		}
	}	
	
	private function disableAllDigits() {
		for (var digit = 0; digit < DigitsInputCount; digit++) {			
			me.disableDigitState(digit);
		}
	}
}
