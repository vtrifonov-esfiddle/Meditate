using Toybox.WatchUi as Ui;

class SummaryViewDelegate extends Ui.BehaviorDelegate {
	function initialize() {
        BehaviorDelegate.initialize();
	}

	private function exitApplication() {		
		System.exit();
	}

	function onBack() {
		me.exitApplication();
	}
	
	function onNextPage() {
		me.exitApplication();
	}
	
	function onPreviousPage() {
		me.exitApplication();
	}
}