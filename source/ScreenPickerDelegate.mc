using Toybox.WatchUi as Ui;

class ScreenPickerDelegate extends Ui.BehaviorDelegate {
	protected var mSelectedPageIndex;
	protected var mPagesCount;
	
	function initialize(selectedPageIndex, pagesCount) {
		BehaviorDelegate.initialize();
		me.mSelectedPageIndex = selectedPageIndex;
		me.mPagesCount = pagesCount;
	}
			
	function createScreenPickerView() {
	}
	
	function setPagesCount(pagesCount) {
		me.mPagesCount = pagesCount;
	}
	
	function select(pageIndex) {
		me.mSelectedPageIndex = pageIndex;
		Ui.switchToView(me.createScreenPickerView(), me, Ui.SLIDE_IMMEDIATE);
	}
	
	function onNextPage() {					
		me.mSelectedPageIndex = (me.mSelectedPageIndex + 1) % me.mPagesCount;
		
		Ui.switchToView(me.createScreenPickerView(), me, Ui.SLIDE_UP);		
		return true;
	}
	
	function onPreviousPage() {		
		if (me.mSelectedPageIndex == 0) {
			me.mSelectedPageIndex = me.mPagesCount - 1;
		}
		else {
			me.mSelectedPageIndex -= 1;
		}		
		Ui.switchToView(me.createScreenPickerView(), me, Ui.SLIDE_DOWN);		
		return true;
	}
}