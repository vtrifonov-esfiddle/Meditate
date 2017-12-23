using Toybox.WatchUi as Ui;

class DiscardedView extends Ui.View {
	private var mSummaryModel;
	
	function initialize() {
		View.initialize();
	}		
	
	function onShow() {
		System.exit();
	}
}