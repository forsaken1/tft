package {
    import flash.text.TextField;
    import flash.text.TextFormat;
	
	public class GexPopup extends Popup {
		private var coords, distance:TextField;
		
		public function GexPopup(gex_:Gex) {
			super(gex_);
			gotoAndStop(2);
			
			coords = new TextField();
			coords.x = 110;
			coords.y = 7;
			
			distance = new TextField();
			distance.x = 110;
			distance.y = 25;
			
			addChild(coords);
			addChild(distance);
		}
		
		public override function Show() {					
			var textFormat = new TextFormat();
			textFormat.font = "TF2 Secondary";
			textFormat.size = 14;
			
			coords.text = (link.j + 1) + " и " + (link.i + 1);
			coords.setTextFormat(textFormat);
			
			if(Global.selectedUnit != null)
				distance.text = Algo.GetDistance(Global.selectedUnit.GetGex(), link);
			distance.setTextFormat(textFormat);
			
			super.Show();
		}
	}
}