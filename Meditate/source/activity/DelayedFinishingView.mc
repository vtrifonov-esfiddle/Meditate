using Toybox.WatchUi as Ui;
using Toybox.Timer;

class DelayedFinishingView extends Ui.View {
	private var mOnShow;

	function initialize(onShow) {
		View.initialize();
		me.mOnShow = onShow;
	}
	
	function onViewDrawn() {
		me.mOnShow.invoke();
	}
	
	function onLayout(dc) {    
        setLayout(Rez.Layouts.delayedFinishing(dc));
    }     
	
	function onShow() {	
		var viewDrawnTimer = new Timer.Timer();
		viewDrawnTimer.start(method(:onViewDrawn), 1000, false);		
	}
		
	function onUpdate(dc) {     
		View.onUpdate(dc);
	}
	
	function onHide() {
	}
}