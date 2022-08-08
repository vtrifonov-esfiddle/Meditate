using Toybox.Math;
using Toybox.System;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Activity as Activity;
using Toybox.SensorHistory as SensorHistory;
using Toybox.ActivityMonitor as ActivityMonitor;

class HeartRateGraphView extends ScreenPicker.ScreenPickerView  {

    hidden var position_x, position_y;
    hidden var graph_width, graph_height;
	var centerX;
	var centerY;
	var summaryModel;

    function initialize(summaryModel) {
    	ScreenPickerView.initialize(Gfx.COLOR_BLACK);
		me.summaryModel = summaryModel;
    }
	
    // Update the view
    function onUpdate(dc) {    

		// Clear the screen
		dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_WHITE);  
        dc.clear();
    	ScreenPickerView.onUpdate(dc);

		// Calculate center of the screen
		centerX = dc.getWidth()/2;
		centerY = dc.getHeight()/2;

		// Calculate position of the chart
		position_x = centerX - (centerX / 1.5) - App.getApp().getProperty("heartRateChartXPosrelocation");
		position_y = centerY + (centerY / 2);
	
		graph_height = dc.getHeight() / 3;
		graph_width =  App.getApp().getProperty("heartRateChartWidth");

		if (me.summaryModel.minHr instanceof String) {
			me.summaryModel.minHr = "--";
		}

		if (me.summaryModel.maxHr instanceof String) {
			me.summaryModel.maxHr = "--";
		}

		if (me.summaryModel.avgHr instanceof String) {
			me.summaryModel.avgHr = "--";
		}
		
		dc.setColor(Gfx.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

		// Draw title text
		dc.drawText(centerX, 
					25, 
					Gfx.FONT_SYSTEM_MEDIUM, 
					Ui.loadResource(Rez.Strings.SummaryHR), 
					Graphics.TEXT_JUSTIFY_CENTER);

		// Draw MIN HR text
		dc.drawText(centerX - centerX / 2 + 20, 
					centerY - centerY / 2 + 10, 
					Gfx.FONT_SYSTEM_TINY, 
					Ui.loadResource(Rez.Strings.SummaryRespirationMin) + me.summaryModel.minHr.toString(), 
					Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

		// Draw AVG HR text
		dc.drawText(centerX, 
					centerY + centerY / 2 + 20, 
					Gfx.FONT_SYSTEM_TINY, 
					Ui.loadResource(Rez.Strings.SummaryRespirationAvg) + me.summaryModel.avgHr.toString(), 
					Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

		// Draw MAX HR text
		dc.drawText(centerX + centerX / 2 - 20, 
					centerY - centerY / 2 + 10, 
					Gfx.FONT_SYSTEM_TINY, 
					Ui.loadResource(Rez.Strings.SummaryRespirationMax) + me.summaryModel.maxHr.toString(), 
					Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

		// Retrieve saved HR history for this activity
		var heartRateHistory = me.summaryModel.hrHistory;
		
		// Validate if we have heart rate history
		if (heartRateHistory == null || heartRateHistory.size() <=0) {
			return;
		}
		
		//DEBUG
		//me.summaryModel.minHr = 55;
		//me.summaryModel.maxHr = 80;

		// Get min and max HR and check if they are valid
		var HistoryMin = me.summaryModel.minHr;
		var HistoryMax = me.summaryModel.maxHr;

		if(HistoryMin instanceof String) {
			return;
		}

		if(HistoryMax instanceof String) {
			return;
		}

		// Reduce a bit the min heart rate so it will show in the chart
		HistoryMin-=6;

		// Calculate different between min and max HR
		var minMaxDiff = (HistoryMax - HistoryMin).toFloat();
		
		// Chart as light blue
		dc.setPenWidth(1);
		dc.setColor(0x27a0c4, Graphics.COLOR_TRANSPARENT);
		
		// Try adapting the chart for the graph width
		var skipSize = 1;
		var skipSizeFloatPart = 0;

		// If chart would be larger than expected graph width
		if (heartRateHistory.size() > graph_width) {

			// Calculate with maximum precision the skip
			skipSizeFloatPart = heartRateHistory.size().toFloat() / graph_width.toFloat();
			skipSizeFloatPart = skipSizeFloatPart - Math.floor(skipSizeFloatPart);
			skipSizeFloatPart = skipSizeFloatPart * 10000000;

			// Calculate the basic skip for the for loop
			skipSize = Math.floor(heartRateHistory.size().toFloat() / graph_width.toFloat()).toNumber();
		} 
		
		// Draw HR chart
		var xStep = 1;
		for (var i = 0; i < heartRateHistory.size(); i+=skipSize){
			
			var heartRate = heartRateHistory[i];
			
			if (heartRate!=null) {

				var lineHeight = (heartRate-HistoryMin) * (graph_height.toFloat() / minMaxDiff.toFloat());

				dc.drawLine(position_x + xStep, 
							position_y - lineHeight.toNumber(), 
							position_x + xStep, 
							position_y);
			}

			// Skip to fit the chart in the screen
			if (skipSizeFloatPart > 0) {
				if ((xStep * 1000000) % (skipSizeFloatPart).toNumber() > 1000000) {
					i++;			
				}
			}

			xStep++;
		}

		// Draw lines and labels 
		dc.setPenWidth(1);
		dc.setColor(Gfx.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

		var lineSpacing = graph_height / 4;

		for(var i = 0; i <= 4; i++){

			// Draw lines over chart
			dc.drawLine(position_x + 3, 
						position_y - (lineSpacing * i), 
						position_x + graph_width, 
						position_y - (lineSpacing * i));

			if (i!=0) {

				// Draw labels for the lines except last one
				dc.drawText(position_x + App.getApp().getProperty("heartRateChartXPosLabelrelocation"), 
							position_y - (lineSpacing * i), 
							Gfx.FONT_SYSTEM_XTINY, 
							Math.round(HistoryMin + (minMaxDiff / 4) * i).toNumber(), 
							Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			}
		}
    }
}