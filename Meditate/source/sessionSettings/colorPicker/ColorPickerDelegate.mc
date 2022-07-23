using Toybox.WatchUi as Ui;

class ColorPickerDelegate extends ScreenPicker.ScreenPickerDelegate {
	protected var mColors;
	private var mOnColorSelected;
	
	function initialize(colors, onColorSelected) {
		ScreenPickerDelegate.initialize(0, colors.size());	
		
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

	function onSwipe(swipeEvent) {
		
		// FIx back with left-to-right touch
		if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT) {
			Ui.popView(Ui.SLIDE_RIGHT);
			return true;
		}

		return false;
	}	
}