using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

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
	}
	
	private const MaxHighlightsCount = 50;
	private var highlights;
	private var latestAddedIndex;
	
	var backgroundColor;	
	var startPosX;
	var yOffset;
					
	function addHighlight(color, progressPercentage) {
		if (latestAddedIndex + 1 < MaxHighlightsCount) {
			me.latestAddedIndex++;
			me.highlights[me.latestAddedIndex] = new LineHighlight(color, progressPercentage);
		}
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

class TextValue {
	function initialize() {
		me.text = "";
		me.font = Gfx.FONT_SYSTEM_SMALL;
		me.color = Gfx.COLOR_WHITE;
		me.xPos = 0;
	}

	var text;
	var font;
	var color;
	var xPos;
}

class Icon {
	function initialize() {
		me.symbol = "";
		me.font = null;
		me.color = Gfx.COLOR_WHITE;
		me.xPos = 0;
	}	

	function setSymbol(symbol) {
		me.symbol = Ui.loadResource(symbol);
	}
	var symbol;
	var color;
	var xPos;
	var font;
}

module IconFonts {
	var fontMeditateIcons = Ui.loadResource(Rez.Fonts.fontMeditateIcons);
	var fontAwesomeFreeSolid = Ui.loadResource(Rez.Fonts.fontAwesomeFreeSolid);
	var fontAwesomeFreeRegular = Ui.loadResource(Rez.Fonts.fontAwesomeFreeRegular);
}

class IconsLine extends DetailsLineBase {
	function initialize(lineNumber) {
		DetailsLineBase.initialize(lineNumber);
		me.mIcons = new [MaxIconsCount];
		me.mIconsCount = 0;
		me.xPos = 0;
	}
	
	private var mIcons;
	private const MaxIconsCount = 7;
	private var mIconsCount;
	
	var xPos;
	
	function addIcon(font, symbol, color) {
		me.mIcons[me.mIconsCount] = new IconsLineValue(font, symbol, color);
		me.mIconsCount++;
	}
	
	function getIcons() {
		return me.mIcons.slice(0, me.mIconsCount);
	}
}

class IconsLineValue {
	function initialize(font, symbol, color) {	
		me.font = font;
		me.symbol = Ui.loadResource(symbol);
		me.color = color;
	}
		
	var font;
	var symbol;
	var color;
}

class DetailsLine extends DetailsLineBase {
	function initialize(lineNumber) {
		DetailsLineBase.initialize(lineNumber);	
		me.icon = null;		
		me.value = new TextValue();
	}

	var icon;	
	var value;	
}

class DetailsLineBase {
	function initialize(lineNumber) {	
		me.mLineNumber = lineNumber;
		me.yLineOffset = 0;
	}

	var yLineOffset;
	
	private var mLineNumber;
		
	function getYPos() {
		return InitialPosY + me.mLineNumber * LineOffsetY + me.yLineOffset;
	}
	
	private const LineOffsetY = 32;
	private const InitialPosY = 30;
}

class DetailsModel{
	function initialize() {
		me.title = "";
		me.color = null;
		me.titleColor = null;
		me.detailLines = {
			1 => new DetailsLine(1),
			2 => new DetailsLine(2),
			3 => new DetailsLine(3),
			4 => new DetailsLine(4),
			5 => new DetailsLine(5)
		};
	}
	
	const LinesCount = 5;
	
	function setAllIconsXPos(xPos) {
		for (var i = 1; i <= LinesCount; i++) {
			if (me.detailLines[i] instanceof DetailsLine && detailLines[i].icon instanceof Icon) {
				me.detailLines[i].icon.xPos = xPos;
			}
		}
	}
	
	function setAllValuesXPos(xPos) {
		for (var i = 1; i <= LinesCount; i++) {
			if (me.detailLines[i] instanceof DetailsLine && me.detailLines[i].value instanceof TextValue) {
				me.detailLines[i].value.xPos = xPos;
			}
		}
	}
		
	var title;
	var titleColor;
	var detailLines;
	var color;
	var backgroundColor;
}