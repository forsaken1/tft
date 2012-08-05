package {
	import flash.net.*;
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.events.Event;
	
	public class Multiplayer {
		protected var unitsCount:int = 4, currentEnemyUnit, currentPlayerUnit:int;
		protected var unit, enemy:Array;
		protected var turnTimer:Timer;
		protected var currentTeam:Boolean;
		protected var turnInfoBar:TurnInfoBar;
		private var pass = "any_pass", gameID, loader;
		
		public function Multiplayer(unit_:Array) {
			unit = unit_;
			gameID = Math.random() * 1000000 + "" + Math.random() * 1000000 + "" + Math.random() * 1000000;
			Global.playerUnitsCount = 4;
			Global.enemyUnitsCount = Global.playerUnitsCount;
			Global.turnInfo = "";
			
			AddTurnInfoBar();
			CreateGame();
		}
		
		public function CreateGame() {
			var vars = new URLVariables();
			vars['pass'] = pass;	
			vars['gameID'] = gameID;
			vars['firstPlayerUnit1'] = unit[1].GetClassNumber();
			vars['firstPlayerUnit2'] = unit[2].GetClassNumber();
			vars['firstPlayerUnit3'] = unit[3].GetClassNumber();
			vars['firstPlayerUnit4'] = unit[4].GetClassNumber();
			SendTo('http://tft.16mb.com/createGame.php', vars);
		}
		
		public function SendTo(url_, data_) {
			loader = new URLLoader();
			var request = new URLRequest(url_);
			request.method = URLRequestMethod.POST;

			request.data = data_;
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, onSendComplete);
		}
		
		function onSendComplete(event:Event) {
			turnInfoBar.Text(loader.data);
		}
		
		public function AddTurnInfoBar() {
			turnInfoBar = new TurnInfoBar(this);
			Global.GameLayer.addChild(turnInfoBar);
			turnInfoBar.Text(Global.turnInfo);
		}
		
		public function RemoveTurnInfoBar() {
			Global.GameLayer.removeChild(turnInfoBar);
		}
		
		public function Stop() {
			RemoveTurnInfoBar();			
			try { unit[currentPlayerUnit].SelectOff(); } catch(error:Error) {}
				
			for(var i = 1; i <= unitsCount; i++) {
				if(!unit[i].IsDead()) {
					unit[i].Remove();
				}
			}
		}
	}
}