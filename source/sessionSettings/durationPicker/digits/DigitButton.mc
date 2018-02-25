using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System;

class DigitButton extends Ui.Button {
		
	function initialize(x, y, value, fontDigits) {
		me.mX = x;
		me.mY = y;		
		me.mFontDigits = fontDigits;				
        me.mSize = 40;
			
        var options = {
            :stateDefault => Gfx.COLOR_TRANSPARENT,
            :locX=>x,
            :locY=>y,
            :width=>me.mSize,
            :height=>me.mSize
            };
            
		Ui.Button.initialize(options);
		
		me.mValue = value;
	}
	
	private var mFontDigits;
	private var mValue;
	private var mX;
	private var mY;
	private var mSize;
	
	function draw(dc) {	
		Ui.Button.draw(dc);
		if (me.getState() == :stateDisabled) {
			dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);	
		}
		else if (me.getState() == :stateSelected || me.getState() == :stateHighlighted || me.getState() == :stateHighlightedSelected) {
			dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);	
		}
		else {
			dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);	
		}	
					
		dc.drawText(me.mX + me.mSize / 4, me.mY - 4, me.mFontDigits, me.mValue, Gfx.TEXT_JUSTIFY_LEFT);				
	}
	
	function getDigitValue() {
		return me.mValue;
	}
}
