using Toybox.WatchUi as Ui;

class ScreenPickerDelegate extends Ui.BehaviorDelegate {
	protected var mSelectedColorIndex;
	protected var mColors;
	private var mOnColorSelected;
	
	function initialize(colors, onColorSelected) {
		BehaviorDelegate.initialize();
		
		me.mSelectedColorIndex = 0;
		me.mColors = colors;
		me.mOnColorSelected = onColorSelected;
	}

	function onSelect() {
		me.mOnColorSelected.invoke(me.mColors[me.mSelectedColorIndex]);
		Ui.popView(Ui.SLIDE_LEFT);
		return true;
	}
		
	function onNextPage() {
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		
		me.mSelectedColorIndex = (me.mSelectedColorIndex + 1) % me.mColors.size();
		Ui.pushView(me.createScreenPickerView(), me, Ui.SLIDE_DOWN);
		
		return true;
	}
	
	function createScreenPickerView() {
	}
	
	function onPreviousPage() {
		Ui.popView(Ui.SLIDE_IMMEDIATE);
		
		if (me.mSelectedColorIndex == 0) {
			me.mSelectedColorIndex = me.mColors.size() - 1;
		}
		else {
			me.mSelectedColorIndex -= 1;
		}
		Ui.pushView(me.createScreenPickerView(), me, Ui.SLIDE_UP);
		
		return true;
	}
}