using Toybox.WatchUi as Ui;

class CalculatingResultsView extends Ui.View {
	private var mOnShow;
	
	function initialize(onShow) {
		View.initialize();
		me.mOnShow = onShow;
	}
	
	function onLayout(dc) {    
        setLayout(Rez.Layouts.calculatingResults(dc));
    }     
	
	function onShow() {
		me.mOnShow.invoke();
	}
		
	function onUpdate(dc) {     
		View.onUpdate(dc);
	}
	
	function onHide() {
	}
}