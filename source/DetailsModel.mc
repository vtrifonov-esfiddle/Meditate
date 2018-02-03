class ProgressBarLine {
	function initialize() {
		me.progressDictionary = {};
	}
	
	var progress;
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
		me.textOffset = 0;
		me.iconOffset = 0;
		me.value = new TextLine();
	}

	var icon;
	var textOffset;
	var iconOffset;
	var value;
}

class DetailsModel{
	function initialize() {
		me.title = "";
		me.color = null;
		
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
	
	function setAllTextsOffset(offset) {
		for (var i = 1; i <= LinesCount; i++) {
			me.detailLines[i].textOffset = offset;
		}
	}
	
	var title;
	var detailLines;
	var color;
	var backgroundColor;
}