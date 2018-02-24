using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DigitsLayoutBuilder {
	function initialize(font) {
		me.mFont = font;
		me.mOutput = {};
		me.mDigitsEnabledSpec = {};
		me.mInitialHint = null;
	}
	
	private var mFont;			
	private var mOutput;		
	private var mInitialHint;
	private var mDigitsEnabledSpec;
					
	function addDigit(enabledDigitsSpec) {				
		var outputIndex = me.mOutput.size();	
		me.mOutput[outputIndex] = me.createDigit();
		var digitsEnabledSpecIndex = me.mDigitsEnabledSpec.size();
		me.mDigitsEnabledSpec[digitsEnabledSpecIndex] = enabledDigitsSpec;
	}
			
	private const DefaultDigit = "0";
	private const UninitializesX = 0;
	
	private function createDigit() {        
		var result = {
            :text=>DefaultDigit,
            :color=>Gfx.COLOR_LT_GRAY,
            :backgroundColor=>Gfx.COLOR_LT_GRAY,
            :font=> me.mFont,
            :locX => UninitializesX,
            :locY=>Ui.LAYOUT_VALIGN_CENTER,
            :type=> DigitOutputType.Digit
        };	
        return result;
	}
	
	function addSeparator(separator) {
		var result = {
            :text=>separator,
            :color=>Gfx.COLOR_BLACK,
            :backgroundColor=>Gfx.COLOR_TRANSPARENT,
            :font=> me.mFont,
            :locX => UninitializesX,
            :locY=>Ui.LAYOUT_VALIGN_CENTER,
            :type=> DigitOutputType.Separator
        };	
        
		var outputIndex = me.mOutput.size();	
		me.mOutput[outputIndex] = result;
	}
	
	private function getDigitOffset(previousTextX, viewDc) {
		var textWidth = viewDc.getTextWidthInPixels(DefaultDigit, me.mFont);
		return previousTextX + textWidth + 3;
	}
	
	private function getSeparatorOffset(previousTextX, separatorText, viewDc) {
		var textWidth = viewDc.getTextWidthInPixels(separatorText, me.mFont);
		return previousTextX + textWidth + 3;
	}
	
	function addInitialHint(text) {
		me.mInitialHint = new Ui.Text({
            :text=>text,
            :color=>Gfx.COLOR_BLACK,
            :backgroundColor=>Gfx.COLOR_LT_GRAY,
            :font=>me.mFont,
            :locX =>Ui.LAYOUT_HALIGN_CENTER,
            :locY=>Ui.LAYOUT_VALIGN_CENTER
    	});
	}  
	
	function setOutputXOffset(x) {
		me.mOutputXOffset = x;
	}
	
	private var mOutputXOffset;
	
	function build(viewDc) {
		var outputSpecs = me.mOutput.values();
		var layout = new [outputSpecs.size() + 1];
		layout[0] = me.mInitialHint;
			
		var digits = {};
		var separators = {};
		var x = me.mOutputXOffset;
		for (var i = 0; i < outputSpecs.size(); i++) {
			outputSpecs[i][:locX] = x;
			var outputSpecType = outputSpecs[i][:type];
			outputSpecs[i][:type] = null;				
			layout[i+1] = new Ui.Text(outputSpecs[i]);
			me.filterOutputType(digits, DigitOutputType.Digit, outputSpecType, layout[i+1]);
			me.filterOutputType(separators, DigitOutputType.Separator, outputSpecType, layout[i+1]);
			if (outputSpecType == DigitOutputType.Separator) {
				x = me.getSeparatorOffset(x, outputSpecs[i][:text],  viewDc);
			}
			else {
				x = me.getDigitOffset(x, viewDc);
			}
		}
		var digitsOutput = new DigitsOutput(me.mInitialHint, digits.values(), separators.values(), layout);
		var digitsLayout = new DigitsLayout(viewDc.getWidth(), viewDc.getHeight(), digitsOutput, me.mDigitsEnabledSpec);
		return digitsLayout;
	}
	
	private function filterOutputType(filteringCollection, filteringType, outputSpecType, output) {
		if (outputSpecType == filteringType) {					
			var digitIndex = filteringCollection.size();	
			filteringCollection[digitIndex] = output;
		}
	}
}