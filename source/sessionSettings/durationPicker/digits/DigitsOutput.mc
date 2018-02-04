using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

class DigitsOutput {
	function initialize(viewDc, font, separator) {
		me.mViewDc = viewDc;
		me.mFont = font;
		
		me.mX = 90;
		me.mHoursLow = me.createCharOutput();
		me.addOffset(me.mHoursLow);
		me.mSeparator = me.createSeparatorOutput(separator);
		me.addOffset(me.mSeparator);
		me.mMinutesHigh = me.createCharOutput();
		me.addOffset(me.mMinutesHigh);
		me.mMinutesLow = me.createCharOutput();
		
		me.mInitialHint = new Ui.Text({
            :text=>"Pick H:MM",
            :color=>Gfx.COLOR_BLACK,
            :backgroundColor=>Gfx.COLOR_LT_GRAY,
            :font=>Gfx.FONT_TINY,
            :locX =>Ui.LAYOUT_HALIGN_CENTER,
            :locY=>Ui.LAYOUT_VALIGN_CENTER
        });
	}
	
	private var mViewDc;
	private var mFont;
	private var mX;
	
	private var mHoursLow;
	private var mMinutesHigh;
	private var mMinutesLow;
	private var mSeparator;
	
	private var mInitialHint;
	
	private const DefaultDigit = "0";
	
	private function addOffset(previousText) {
		var textWidth = me.mViewDc.getTextWidthInPixels(DefaultDigit, me.mFont);
		me.mX = previousText.locX + textWidth + 3;
	}
	
	private function createSeparatorOutput(separator) {
		return new Ui.Text({
            :text=>separator,
            :color=>Gfx.COLOR_BLACK,
            :backgroundColor=>Gfx.COLOR_TRANSPARENT,
            :font=> me.mFont,
            :locX => me.mX,
            :locY=>Ui.LAYOUT_VALIGN_CENTER
        });	
	}
		
	private function createCharOutput() {        
		return new Ui.Text({
            :text=>DefaultDigit,
            :color=>Gfx.COLOR_LT_GRAY,
            :backgroundColor=>Gfx.COLOR_LT_GRAY,
            :font=> me.mFont,
            :locX => me.mX,
            :locY=>Ui.LAYOUT_VALIGN_CENTER
        });	
	}
	
	function getLayout() {
		return [me.mInitialHint, me.mHoursLow, me.mSeparator, me.mMinutesHigh, me.mMinutesLow ];
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
}