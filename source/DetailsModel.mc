using Toybox.Graphics as Gfx;

class PercentageHighlightLine {
	function initialize(highlightsCount) {
		if (highlightsCount > 0) {
			me.highlights = new [MaxHighlightsCount];
		}
		else {
			me.highlights = [];
		}
		me.latestAddedIndex = -1;
		me.backgroundColor = Gfx.COLOR_WHITE;
		me.isHighlightFilterReset = true;
	}
	
	private const MaxHighlightsCount = 50;
	private var highlights;
	private var latestAddedIndex;
	var backgroundColor;	
	
	function addHighlight(color, progressPercentage) {
		if (latestAddedIndex + 1 < MaxHighlightsCount && me.isHighglightFiltered(progressPercentage) == false) {
			me.latestAddedIndex++;
			me.highlights[me.latestAddedIndex] = new LineHighlight(color, progressPercentage);
		}
	}
	
	private function isHighglightFiltered(currentPercentageTime) {
		if (me.latestAddedIndex == -1) {
			return false;
		}
		if (me.isHighlightFilterReset == true) {
			me.isHighlightFilterReset = false;
			return false;
		}
		var lastPercentageTime = me.highlights[me.latestAddedIndex].progressPercentage;
		return (currentPercentageTime - lastPercentageTime) < MinPercentageOffset;
	}
		
	private const MinPercentageOffset = 0.05;
	
	private var isHighlightFilterReset;
	
	function resetHighlightsFilter() {
		me.isHighlightFilterReset = true;
	}
	
	function getHighlights() {
		if (me.highlights.size() == 0) {
			return [];
		}
		else {
			return me.highlights.slice(0, me.latestAddedIndex + 1);
		}
	}
}

class LineHighlight {
	function initialize(color, progressPercentage) {
		me.color = color;
		me.progressPercentage = progressPercentage;
	}
	var color;
	var progressPercentage;
}

class TextLine {
	function initialize() {
		me.text = "";
		me.font = Gfx.FONT_SYSTEM_SMALL;
		me.color = Gfx.COLOR_WHITE;
		me.xOffset = 0;
	}

	var text;
	var font;
	var color;
	var xOffset;
}

class Icon {
	function initialize(rezFont) {
		me.symbols = "";
		me.font = Ui.loadResource(rezFont);
		me.color = Gfx.COLOR_WHITE;
		me.xOffset = 0;
	}

	function addSymbol(symbol) {
		me.symbols += Ui.loadResource(symbol);
	}
	var symbols;
	var font;
	var color;
	var xOffset;
}

class IconMeditate extends Icon {
	function initialize() {
		Icon.initialize(Rez.font.fontMeditateIcons);
	}
}

class IconFontAwesomeSolid extends Icon {
	function initialize() {
		Icon.initialize(Rez.font.fontAwesomeFreeSolid);
	}
}

class IconFontAwesomeRegular extends Icon {
	function initialize() {
		Icon.initialize(Rez.font.fontAwesomeFreeRegular);
	}
}

class DetailsLine {
	function initialize() {
		me.icon = null;
		me.iconsColor = Gfx.COLOR_WHITE;
		me.yLineOffset = 0;
		me.value = new TextLine();
	}

	var icon;	
	var value;
	var yLineOffset;
}

class DetailsModel{
	function initialize() {
		me.title = "";
		me.color = null;
		me.titleColor = null;
		me.detailLines = {
			1 => new DetailsLine(),
			2 => new DetailsLine(),
			3 => new DetailsLine(),
			4 => new DetailsLine(),
			5 => new DetailsLine()
		};
	}
	
	const LinesCount = 5;
	
	function setAllIconsOffset(offset) {
		for (var i = 1; i <= LinesCount; i++) {
			me.detailLines[i].iconOffset = offset;
		}
	}
	
	function setAllValuesOffset(offset) {
		for (var i = 1; i <= LinesCount; i++) {
			me.detailLines[i].valueOffset = offset;
		}
	}
	
	var title;
	var titleColor;
	var detailLines;
	var color;
	var backgroundColor;
}