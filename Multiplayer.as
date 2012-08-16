package {
	import flash.net.*;
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.events.Event;
	import com.adobe.serialization.json.*;
	
	public class Multiplayer {
		protected var unitsCount:int = 4, currentEnemyUnit, currentPlayerUnit:int;
		protected var unit, enemy:Array;
		protected var turnTimer, waitTimer:Timer;
		protected var currentTeam:Boolean;
		protected var turnInfoBar:TurnInfoBar;
		private var pass = "any_pass", sec = 0, gameID, gx, URL = 'http://localhost/tft/';
		
		public function Multiplayer(unit_:Array) {
			unit = unit_;
			enemy = [unitsCount + 1];
			gx = unit[1].GetArea(); 
			
			Global.playerUnitsCount = unitsCount;
			Global.enemyUnitsCount = unitsCount;
			Global.turnInfo = "";
			
			turnInfoBar = new TurnInfoBar(this);
		}
		//////////////////////////////////////////////////////second player
		public function ConnectTo(gameID_) {
			gameID = gameID_;
			
			var vars = new URLVariables();
			for(var i = 1; i <= 4; i++)
				vars['secondPlayerUnit' + i] = unit[i].GetClassNumber();
				
			SendTo(URL + 'connectTo.php', vars, onConnectComplete);
		}
		
		function onConnectComplete(event:Event) {
			var answer = event.target.data.substr(1);
			var jdata = JSON.decode(answer);
			turnInfoBar.Text(jdata.msg);
			
			var un = [, (int)(jdata.firstPlayerUnit1), (int)(jdata.firstPlayerUnit2), (int)(jdata.firstPlayerUnit3), (int)(jdata.firstPlayerUnit4)];
			for(var i = 1; i <= 4; i++) {
				enemy[i] = Algo.CreateUnit(gx, un[i], i * 2 - 2, true);
				Global.GameLayer.addChild(enemy[i]);
			}
			currentTeam = false;
			//Start();
		}
		////////////////////////////////////////////////first player
		public function CreateGame() {
			gameID = (int)(Math.random() * 1000000) + (int)(Math.random() * 1000000) + (int)(Math.random() * 1000000);
			
			var vars = new URLVariables();
			for(var i = 1; i <= 4; i++)
				vars['firstPlayerUnit' + i] = unit[i].GetClassNumber();
				
			SendTo(URL + 'createGame.php', vars, onCreateGameComplete);
		}
		
		function onCreateGameComplete(event:Event) {
			turnInfoBar.Text(event.target.data);
			
			waitTimer = new Timer(3000);
			waitTimer.addEventListener(TimerEvent.TIMER, onWaiting);
			waitTimer.start();
		}
		
		function onWaiting(event:TimerEvent) {
			SendTo(URL + 'onWaiting.php', new URLVariables(), onWaitingRequestComplete);
		}
		
		function onWaitingRequestComplete(event:Event) {
			var answer = event.target.data.substr(1);
			var jdata = JSON.decode(answer);
			
			if(jdata.ready == null || jdata.ready == 'no')
				return;
			
			if(jdata.ready == 'yes') {
				waitTimer.stop();
				turnInfoBar.Text(jdata.msg);
				
				var en = [, (int)(jdata.secondPlayerUnit1), (int)(jdata.secondPlayerUnit2), (int)(jdata.secondPlayerUnit3), (int)(jdata.secondPlayerUnit4)];
				for(var i = 1; i <= 4; i++) {
					enemy[i] = Algo.CreateUnit(gx, en[i], i * 2 - 2, false);
					Global.GameLayer.addChild(enemy[i]);
				}
				currentTeam = true;
				Start();
			}
		}
		////////////////////////////////////////////////////////////
		function Start() {
			currentPlayerUnit = 1;
			currentEnemyUnit = 1;
			
			turnTimer = new Timer(1000);
			turnTimer.addEventListener(TimerEvent.TIMER, onTurn);
			turnTimer.start();
			
			unit[currentPlayerUnit].SelectOn();
		}
		
		function onTurn() {
			turnInfoBar.Text(Global.turnInfo + ++sec);
			//if(currentTeam) {
			if(unit[currentPlayerUnit].GetInitiative() == 0)
				SendTurn();
			else	
				SendTo(URL + 'checkRotation.php', new URLVariables(), onCheckRotationComplete);
			//}
			//else
				//if(enemy[currentEnemyUnit].GetInitiative() == 0)
					//PlayerTurn();
					
			if(Global.enemyUnitsCount == 0)
				Win();
				
			if(Global.playerUnitsCount == 0)
				Lose();
		}
		
		function SendTurn() {
			unit[currentPlayerUnit].RefreshInitiative();
			SendTo();
		}
		
		function onCheckRotationComplete(event:Event) {
			var answer = event.target.data.substr(1);
			var jdata = JSON.decode(answer);
			
			if(jdata.teamRotation != currentTeam) {
				//MakeTurn();
				currentTeam = !currentTeam;
			}
		}
		
		function PlayerTurn() {
			//if(!enemy[currentEnemyUnit].IsDead())
			//	enemy[currentEnemyUnit].RefreshInitiative();
				
			if(Global.playerUnitsCount > 0) {
				NextPlayerUnit();
				unit[currentPlayerUnit].SelectOn();
			}
		}
		
		public function NextPlayerUnit() {
			currentPlayerUnit++;
			if(currentPlayerUnit > unitsCount)
				currentPlayerUnit = 1;
			if(unit[currentPlayerUnit].IsDead())
				NextPlayerUnit();
		}
		
		public function Win() {
			Global.turnInfo = "Вы победили :)";
		}
		
		public function Lose() {
			Global.turnInfo = "Вы проиграли :(";
		}
		
		public function SendTo(url_, data_, onComplete) {
			data_['pass'] = pass;
			data_['gameID'] = gameID;
			
			var loader = new URLLoader();
			var request = new URLRequest(url_);
			
			request.method = URLRequestMethod.POST;
			request.data = data_;
			loader.load(request);
			
			if(onComplete != null)
				loader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		function RemoveConnection() {
			SendTo(URL + 'removeConnection.php', new URLVariables(), null);
		}
		
		public function Stop() {
			turnInfoBar.Remove();		
			RemoveConnection();
			
			try { 
				turnTimer.stop();
				waitTimer.stop();
				unit[currentPlayerUnit].SelectOff(); 
			} catch(error:Error) {}
				
			for(var i = 1; i <= unitsCount; i++) {
				if(!unit[i].IsDead()) 
					unit[i].Remove();
				
				if(enemy[i] != null)
					if(!enemy[i].IsDead()) 
						enemy[i].Remove();
			}
		}
	}
}