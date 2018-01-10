using Toybox.WatchUi as Ui;

class ColorPickerDelegate extends ScreenPickerDelegate {
	protected var mColors;
	private var mOnColorSelected;
	
	function initialize(colors, onColorSelected) {
		ScreenPickerDelegate.initialize(colors.size());	
		
		me.mColors = colors;
		me.mOnColorSelected = onColorSelected;	
	}
	
	private function getSelectedColor() {
		return me.mColors[me.mSelectedPageIndex];
	}
	
	function createScreenPickerView() {
		return new ColorPickerView(me.getSelectedColor());
	}
	
	function onSelect() {
		me.mOnColorSelected.invoke(me.getSelectedColor());
		Ui.popView(Ui.SLIDE_RIGHT);
		return true;
	}	
}