package {
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import AI;
	
	public class Game {
		protected var unitsCount:int = 4, currentEnemyUnit, currentPlayerUnit:int;
		protected var unit, enemy:Array;
		protected var turnTimer:Timer;
		protected var currentTeam:Boolean;
		public var playerUnitsCount, enemyUnitsCount:int;
		
		public function Game(unit_:Array, enemy_:Array) {
			unit = unit_;
			enemy = enemy_;
			playerUnitsCount = 4;
			enemyUnitsCount = playerUnitsCount;
			Start();
		}
		
		public function Start() {
			turnTimer = new Timer(50);
			turnTimer.addEventListener(TimerEvent.TIMER, onTurn);
			turnTimer.start();
			
			currentPlayerUnit = 1;
			currentEnemyUnit = 1;
			currentTeam = true;
			unit[currentPlayerUnit].SelectOn();
		}
		
		public function onTurn(event:TimerEvent) {
			if(currentTeam) {
				if(unit[currentPlayerUnit].GetInitiative() == 0)
					EnemyTurn();
			}
			else
				if(enemy[currentEnemyUnit].GetInitiative() == 0)
					PlayerTurn();
		}
		
		function EnemyTurn() {
			currentTeam = false;
			unit[currentPlayerUnit].SelectOff();
			unit[currentPlayerUnit].RefreshInitiative();
			//var ai = new AI(enemy[currentUnit]);
			enemy[currentEnemyUnit].SetInitiative(0);
		}
		
		function PlayerTurn() {
			currentTeam = true;
			NextPlayerUnit();
			unit[currentPlayerUnit].SelectOn();
		}
		
		public function NextPlayerUnit() {
			currentPlayerUnit++;
			if(currentPlayerUnit > unitsCount)
				currentPlayerUnit = 1;
		}
		
		public function NextEnemyUnit() {
			currentEnemyUnit++;
			if(currentEnemyUnit > unitsCount)
				currentEnemyUnit = 1;
		}
		
		public function Win() {
			Stop();
			trace("win!");
		}
		
		public function Stop() {
			turnTimer.stop();
			
			unit[currentPlayerUnit].SelectOff();
				
			for(var i = 1; i <= unitsCount; i++) {
				if(!unit[i].IsDead()) {
					unit[i].RemoveUnit();
				}
				if(!enemy[i].IsDead()) {
					enemy[i].RemoveUnit();
				}
			}
		}
	}
}