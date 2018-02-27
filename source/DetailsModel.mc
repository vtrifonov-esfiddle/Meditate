using Toybox.Graphics as Gfx;

class PercentageHighlightLine {
	function initialize() {
		me.highlights = {};
		me.latestAddedIndex = -1;
		me.backgroundColor = Gfx.COLOR_WHITE;
	}
	
	private var highlights;
	private var latestAddedIndex;
	var backgroundColor;	
	
	function addHighlight(color, progressPercentage) {
		me.latestAddedIndex++;
		me.highlights[latestAddedIndex] = new LineHighlight(color, progressPercentage);
	}
	
	function getHighlights() {
		return me.highlights;
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
	}

	var text;
}

class DetailsLine {
	function initialize() {
		me.icon = null;
		me.valueOffset = 0;
		me.iconOffset = 0;
		me.yLineOffset = 0;
		me.value = new TextLine();
	}

	var icon;
	var valueOffset;
	var yLineOffset;
	var iconOffset;
	var value;
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