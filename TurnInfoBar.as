﻿package {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TurnInfoBar extends turninfobar {
		protected var game:Game;
		private var turnInfo:TextField;		
		
		public function TurnInfoBar(game_:Game) {
			game = game_;
			x = 5;
			y = 587;
			
			turnInfo = new TextField();
			turnInfo.x = 8;
			turnInfo.y = 8;
			turnInfo.width = 730;
			turnInfo.height = 24;
			
			addChild(turnInfo);
		}
		
		public function Text(text_:String) {
			var textFormat = new TextFormat();
			textFormat.size = 13;
			
			turnInfo.text = text_;
			turnInfo.setTextFormat(textFormat);
		}
	}
}