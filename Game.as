package {
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.display.Stage;
	
	public class Game {
		protected var unitsCount:int = 4, currentEnemyUnit, currentPlayerUnit:int;
		protected var unit, enemy:Array;
		protected var turnTimer:Timer;
		protected var currentTeam:Boolean;
		protected var turnInfoBar:TurnInfoBar;
		
		public function Game(unit_:Array, enemy_:Array) {
			unit = unit_;
			enemy = enemy_;
			Global.playerUnitsCount = 4;
			Global.enemyUnitsCount = Global.playerUnitsCount;
			Global.turnInfo = "Игра началась!";
			
			turnTimer = new Timer(100);
			turnTimer.addEventListener(TimerEvent.TIMER, onTurn);
			turnTimer.start();
			
			currentPlayerUnit = 1;
			currentEnemyUnit = 0;
			currentTeam = true;
			unit[currentPlayerUnit].SelectOn();
			
			AddTurnInfoBar();
		}
		
		public function AddTurnInfoBar() {
			turnInfoBar = new TurnInfoBar(this);
			Global.GameLayer.addChild(turnInfoBar);
		}
		
		public function RemoveTurnInfoBar() {
			Global.GameLayer.removeChild(turnInfoBar);
		}
		
		public function onTurn(event:TimerEvent) {
			turnInfoBar.Text(Global.turnInfo);
			if(currentTeam) {
				if(unit[currentPlayerUnit].GetInitiative() == 0)
					EnemyTurn();
			}
			else
				if(enemy[currentEnemyUnit].GetInitiative() == 0)
					PlayerTurn();
					
			if(Global.enemyUnitsCount == 0)
				Win();
				
			if(Global.playerUnitsCount == 0)
				Lose();
		}
		
		function EnemyTurn() {
			currentTeam = false;
			if(!unit[currentPlayerUnit].IsDead()) {
				unit[currentPlayerUnit].SelectOff();
				unit[currentPlayerUnit].RefreshInitiative();
			}
			if(Global.enemyUnitsCount > 0) {
				NextEnemyUnit();
				new AI(enemy[currentEnemyUnit]);
				//enemy[currentEnemyUnit].SetInitiative(0);
			}
		}
		
		function PlayerTurn() {
			currentTeam = true;
			if(!enemy[currentEnemyUnit].IsDead())
				enemy[currentEnemyUnit].RefreshInitiative();
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
		
		public function NextEnemyUnit() {
			currentEnemyUnit++;
			if(currentEnemyUnit > unitsCount)
				currentEnemyUnit = 1;
			if(enemy[currentEnemyUnit].IsDead())
				NextEnemyUnit();
		}
		
		public function Win() {
			Global.turnInfo = "Вы победили :)";
		}
		
		public function Lose() {
			Global.turnInfo = "Вы проиграли :(";
		}
		
		public function Stop() {
			turnTimer.stop();
			
			RemoveTurnInfoBar();			
			try { unit[currentPlayerUnit].SelectOff(); } catch(error:Error) {}
				
			for(var i = 1; i <= unitsCount; i++) {
				if(!unit[i].IsDead()) {
					unit[i].Remove();
				}
				if(!enemy[i].IsDead()) {
					enemy[i].Remove();
				}
			}
		}
	}
}