class ProgressBarLine {
	function initialize() {
		me.progressSections = {};
		me.sectionsLatestAddedIndex = -1;
	}
	
	private var progressSections;
	private var sectionsLatestAddedIndex;
	
	function addSection(color, progressPercentage) {
		sectionsLatestAddedIndex++;
		me.progressSections[sectionsLatestAddedIndex] = new ProgressBarSection(color, progressPercentage);
	}
	
	function getSections() {
		return me.progressSections;
	}
}

class ProgressBarSection {
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
		me.value = new TextLine();
	}

	var icon;
	var valueOffset;
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