using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

module DigitOutputType {
	enum {
		Digit = 1,
		Separator = 2
	}
}

class DigitsOutput {
	function initialize(initialHint, digits, separators, layout) {
		me.mInitialHint = initialHint;
		me.mDigits = digits;
		me.mSeparators = separators;
		me.mLayout = layout;
	}
			
	private var mInitialHint;
	private var mDigits;
	private var mSeparators;
	private var mLayout;
	
	function getLayout() {
		return mLayout;
	}	
	
	function setInitialHintLayout() {
		me.mInitialHint.setColor(Gfx.COLOR_BLACK);
		me.mInitialHint.setBackgroundColor(Gfx.COLOR_LT_GRAY);
		
		for (var i = 0; i < me.mDigits.size(); i++) {
			me.mDigits[i].setBackgroundColor(Gfx.COLOR_TRANSPARENT);
			me.mDigits[i].setColor(Gfx.COLOR_TRANSPARENT);
		}
		for (var i = 0; i < me.mSeparators.size(); i++) {
			me.mSeparators[i].setBackgroundColor(Gfx.COLOR_TRANSPARENT);
			me.mSeparators[i].setColor(Gfx.COLOR_TRANSPARENT);
		}
	}
	
	function setSelectedDigit(selectedIndex, digits) {
		me.mInitialHint.setColor(Gfx.COLOR_TRANSPARENT);
		me.mInitialHint.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		
		for (var i = 0; i <= selectedIndex; i++) {
			me.mDigits[i].setBackgroundColor(Gfx.COLOR_TRANSPARENT);
			me.mDigits[i].setColor(Gfx.COLOR_BLACK);
			me.mDigits[i].setText(digits[i].toString());
		}		
		var nextIndex = selectedIndex + 1;
		if (nextIndex < me.mDigits.size()) {
			me.mDigits[nextIndex].setBackgroundColor(Gfx.COLOR_DK_GRAY);
			me.mDigits[nextIndex].setColor(Gfx.COLOR_DK_GRAY);
		}
		
		for (var i = nextIndex + 1; i < me.mDigits.size(); i++) {
			me.mDigits[i].setBackgroundColor(Gfx.COLOR_LT_GRAY);
			me.mDigits[i].setColor(Gfx.COLOR_LT_GRAY);
		}
		for (var i = 0; i < me.mSeparators.size(); i++) {
			me.mSeparators[i].setColor(Gfx.COLOR_BLACK);
		}	
	}	
}