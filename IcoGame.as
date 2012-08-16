package {
	import flash.events.MouseEvent; 
	
	public class IcoGame extends icogame {
		protected var gameID;
		protected var selected:Boolean;
		
		public function Selected() { return selected; }
		public function GetGameID() { return gameID; }
		
		public function IcoGame(y_, gameID_) {
			stop();
			selected = false;
			x = 220;
			y = 100 + 50 * y_;
			gameID = gameID_;
			Global.GameLayer.addChild(this);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		function onClick(event:MouseEvent) {
			selected = !selected;
			if(selected)
				gotoAndStop(2);
			else
				gotoAndStop(1);
		}
		
		public function Remove() {
			Global.GameLayer.removeChild(this);
			removeEventListener(MouseEvent.CLICK, onClick);
		}
	}
}