using Toybox.WatchUi as Ui;

class ColorPickerDelegate extends ScreenPickerDelegate {
	protected var mSelectedColorIndex;
	protected var mColors;
	private var mOnColorSelected;
	
	function initialize(colors, onColorSelected) {
		ScreenPickerDelegate.initialize();	
		
		me.mSelectedColorIndex = 0;
		me.mColors = colors;
		me.mOnColorSelected = onColorSelected;	
	}
	
	function createScreenPickerView() {
		return new ColorPickerView(me.mColors[me.mSelectedColorIndex]);
	}
	
	function onSelect() {
		me.mOnColorSelected.invoke(me.mColors[me.mSelectedColorIndex]);
		Ui.popView(Ui.SLIDE_RIGHT);
		return true;
	}
	
	function onNextPage() {		
		me.mSelectedColorIndex = (me.mSelectedColorIndex + 1) % me.mColors.size();
		
		return ScreenPickerDelegate.onNextPage();
	}
	
	function onPreviousPage() {		
		if (me.mSelectedColorIndex == 0) {
			me.mSelectedColorIndex = me.mColors.size() - 1;
		}
		else {
			me.mSelectedColorIndex -= 1;
		}
		
		return ScreenPickerDelegate.onPreviousPage();
	}
}