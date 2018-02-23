class DigitsOutputBuilder {
	function initialize(font) {
		me.mFont = font;
		me.mOutput = {};
		me.mInitialHint = null;
	}
	
	private var mFont;
			
	private var mOutput;		
	private var mInitialHint;
					
	function addDigit() {				
		var outputIndex = me.mOutput.size();	
		me.mOutput[outputIndex] = me.createDigit();
	}
			
	private const DefaultDigit = "0";
	
	private function createDigit() {        
		var result = {
            :text=>DefaultDigit,
            :color=>Gfx.COLOR_LT_GRAY,
            :backgroundColor=>Gfx.COLOR_LT_GRAY,
            :font=> me.mFont,
            :locX => me.mX,
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
            :locX => me.mX,
            :locY=>Ui.LAYOUT_VALIGN_CENTER,
            :type=> DigitOutputType.Separator
        };	
        
		var outputIndex = me.mOutput.size();	
		me.mOutput[outputIndex] = result;
	}
	
	private function getOffset(previousTextX, viewDc) {
		var textWidth = viewDc.getTextWidthInPixels(DefaultDigit, me.mFont);
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
	
	function build(viewDc) {
		var outputSpecs = me.mOutput.values();
		var layout = new [outputValues.size() + 1];
		layout[0] = me.mInitialHint;
			
		var digits = {};
		var separators = {};
		var x = 90;
		for (var i = 0; i < outputSpecs.size(); i++) {
			outputSpecs[i][:locX] = x;
			var outputSpecType = outputSpecs[i][:type];
			outputSpecs[i][:type] = null;				
			layout[i+1] = new Ui.Text(outputSpecs[i]);
			me.filterOutputType(digits, DigitOutputType.Digit, outputSpecType, layout[i+1]);
			me.filterOutputType(separators, DigitOutputType.Separator, outputSpecType, layout[i+1]);
			x = me.getOffset(x, viewDc);
		}
		return new DigitsLayout(me.mInitialHint, digits.values(), separators.values(), layout);
	}
	
	private function filterOutputType(filteringCollection, filteringType, outputSpecType, output) {
		if (outputSpecType == filteringType) {					
			var digitIndex = filteringCollection.size();	
			filteringCollection = output;
		}
	}
}