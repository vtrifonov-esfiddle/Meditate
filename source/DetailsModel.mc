class DetailsLine {
	function initialize() {
		me.icon = null;
		me.text = "";
	}

	var icon;
	var text;
}

class DetailsModel{
	function initialize() {
		me.title = "";
		me.color = null;
		
		me.detailLines = {
			1 => new DetailsLine(),
			2 => new DetailsLine(),
			3 => new DetailsLine(),
			4 => new DetailsLine(),
			5 => new DetailsLine()
		};
	}
	
	var title;
	var detailLines;
	var color;
}