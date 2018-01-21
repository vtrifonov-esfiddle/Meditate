using Toybox.WatchUi as Ui;

class SummaryView extends Ui.View {
	private var mSummaryModel;
	
	function initialize(summaryModel) {
		View.initialize();
		me.mSummaryModel = summaryModel;
	}
	
	function onLayout(dc) {
		setLayout(Rez.Layouts.summaryLayout(dc));
	}
	
	function onUpdate(dc) {       
        var elapsedTime = View.findDrawableById("elapsedTime");
        elapsedTime.setText(me.mSummaryModel.elapsedTime);
        
        var maxHr = View.findDrawableById("maxHr");
        maxHr.setText("Max HR: " + me.mSummaryModel.maxHr);
        
        var avgHr = View.findDrawableById("avgHr");
        avgHr.setText("Avg HR: " + me.mSummaryModel.avgHr);
                
        View.onUpdate(dc);
    }
}