using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

class DigitsOutput {
	function initialize(initialHint, digits) {
		me.mHoursLow = me.createCharOutput();
		me.addOffset(me.mHoursLow);
		me.mSeparator = me.createSeparatorOutput(separator);
		me.addOffset(me.mSeparator);
		me.mMinutesHigh = me.createCharOutput();
		me.addOffset(me.mMinutesHigh);
		me.mMinutesLow = me.createCharOutput();
	}
		
	private var mHoursLow;
	private var mMinutesHigh;
	private var mMinutesLow;
	
	private var mInitialHint;
	private var mDigits;
	
	function getLayout() {
		var result = new [mDigits.size() + 1];
		result[0] = me.mInitialHint;
		for (var i = 0; i < mDigits.size(); i++) {
			result[i+1] = mDigits[i];
		}
		return result;
	}	
	
	function setInitialHintLayout() {
		me.mInitialHint.setColor(Gfx.COLOR_BLACK);
		me.mInitialHint.setBackgroundColor(Gfx.COLOR_LT_GRAY);
		
		me.mHoursLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mHoursLow.setColor(Gfx.COLOR_TRANSPARENT);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mMinutesHigh.setColor(Gfx.COLOR_TRANSPARENT);
		
		me.mMinutesLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mMinutesLow.setColor(Gfx.COLOR_TRANSPARENT);
		
		me.mSeparator.setColor(Gfx.COLOR_TRANSPARENT);
	}
	
	function setHoursSelected() {
		me.mInitialHint.setColor(Gfx.COLOR_TRANSPARENT);
		me.mInitialHint.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		
		me.mHoursLow.setBackgroundColor(Gfx.COLOR_DK_GRAY);
		me.mHoursLow.setColor(Gfx.COLOR_DK_GRAY);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_LT_GRAY);
		me.mMinutesHigh.setColor(Gfx.COLOR_LT_GRAY);
		
		me.mMinutesLow.setBackgroundColor(Gfx.COLOR_LT_GRAY);
		me.mMinutesLow.setColor(Gfx.COLOR_LT_GRAY);		
		
		me.mSeparator.setColor(Gfx.COLOR_BLACK);	
	}
		
	function setMinutesHighSelected() {	
		me.mHoursLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mHoursLow.setColor(Gfx.COLOR_BLACK);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_DK_GRAY);
		me.mMinutesHigh.setColor(Gfx.COLOR_DK_GRAY);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_LT_GRAY);
		me.mMinutesHigh.setColor(Gfx.COLOR_LT_GRAY);
	}
	
	function setMinutesLowSelected() {
		me.mHoursLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mHoursLow.setColor(Gfx.COLOR_BLACK);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mMinutesHigh.setColor(Gfx.COLOR_BLACK);
		
		me.mMinutesLow.setBackgroundColor(Gfx.COLOR_DK_GRAY);
		me.mMinutesLow.setColor(Gfx.COLOR_DK_GRAY);
	}
	
	function setFinish() {
		me.mHoursLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mHoursLow.setColor(Gfx.COLOR_BLACK);
		
		me.mMinutesHigh.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mMinutesHigh.setColor(Gfx.COLOR_BLACK);
		
		me.mMinutesLow.setBackgroundColor(Gfx.COLOR_TRANSPARENT);
		me.mMinutesLow.setColor(Gfx.COLOR_BLACK);
	}
	
	function setHoursLow(digit) {
		me.mHoursLow.setText(digit.toString());
	}
	
	function setMinutesHigh(digit) {
		me.mMinutesHigh.setText(digit.toString());
	}
	
	function setMinutesLow(digit) {
		me.mMinutesLow.setText(digit.toString());
	}
	
	function getOutputBuilder() {
		return new DigitsOutputBuilder(me);
	}
	
	class DigitsOutputBuilder {
		function initialize(font) {
			me.mFont = font;
			me.mDigits = {};
			me.mOutput = {};
		}
		
		private var mFont;
				
		private var mDigits;
		private var mOutput;		
		private var mInitialHint;
						
		function addDigit() {
			var digitIndex = me.mDigits.size();		
			me.mDigits[digitIndex] = me.createDigit();
						
			var outputIndex = me.mOutput.size();	
			me.mOutput[outputIndex] = me.mDigits[digitIndex];
		}
				
		private const DefaultDigit = "0";
		
		private function createDigit() {        
			var result = new Ui.Text({
	            :text=>DefaultDigit,
	            :color=>Gfx.COLOR_LT_GRAY,
	            :backgroundColor=>Gfx.COLOR_LT_GRAY,
	            :font=> me.mFont,
	            :locX => me.mX,
	            :locY=>Ui.LAYOUT_VALIGN_CENTER
	        });	
	        return result;
		}
		
		function addSeparator(separator) {
			var result = new Ui.Text({
	            :text=>separator,
	            :color=>Gfx.COLOR_BLACK,
	            :backgroundColor=>Gfx.COLOR_TRANSPARENT,
	            :font=> me.mFont,
	            :locX => me.mX,
	            :locY=>Ui.LAYOUT_VALIGN_CENTER
	        });	
	        
			var outputIndex = me.mOutput.size();	
			me.mOutput[outputIndex] = result;
		}
		
		private function getOffset(previousTextX, getTextWidthInPixels) {
			var textWidth = getTextWidthInPixels.Invoke(DefaultDigit, me.mFont);
			return previousTextX + textWidth + 3;
		}
		
		function addInitialHint(text) {
			me.mInitialHint = new Ui.Text({
	            :text=>text,
	            :color=>Gfx.COLOR_BLACK,
	            :backgroundColor=>Gfx.COLOR_LT_GRAY,
	            :font=>Gfx.FONT_TINY,
	            :locX =>Ui.LAYOUT_HALIGN_CENTER,
	            :locY=>Ui.LAYOUT_VALIGN_CENTER
        	});
		}  
		
		function build(getTextWidthInPixels) {
			var outputValues = me.mOutput.values();
			var x = 90;
			for (var i = 0; i < outputValues.size(); i++) {
				
				x = me.getOffset(x, getTextWidthInPixels);
			}
			return new DigitsLayout(me.mInitialHint, me.mDigits);
		}
	}
}