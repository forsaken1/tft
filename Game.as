package {
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	
	public class Game {
		protected var unitsCount:int = 4, currentUnit:int;
		protected var unit, enemy:Array;
		protected var turnTimer:Timer;
		protected var currentTeam:Boolean;
		
		public function Game(unit_:Array, enemy_:Array) {
			unit = unit_;
			enemy = enemy_;
			Start();
		}
		
		public function Start() {
			turnTimer = new Timer(50);
			turnTimer.addEventListener(TimerEvent.TIMER, onTurn);
			turnTimer.start();
			
			currentUnit = 1;
			currentTeam = true;
			unit[currentUnit].SelectOn();
		}
		
		public function onTurn(event:TimerEvent) {
			if(currentTeam) {
				if(unit[currentUnit].GetInitiative() == 0)
					EnemyTurn();
			}
			else
				if(enemy[currentUnit].GetInitiative() == 0)
					PlayerTurn();
		}
		
		function EnemyTurn() {
			currentTeam = false;
			unit[currentUnit].SelectOff();
			unit[currentUnit].RefreshInitiative();
			//var count = unitsCount;
			//do {
				NextUnit();
			//	count--;
			//	if(count == 0) 
			//		Win();
			//} while(!enemy[currentUnit].IsDeath());
			trace("Enemy turn");
			enemy[currentUnit].SetInitiative(0);
		}
		
		function PlayerTurn() {
			currentTeam = true;
			//var count = unitsCount;
			//do {
				NextUnit();
			//	count--;
			//	if(count == 0) 
			//		Win();
			//} while(!unit[currentUnit].IsDeath());
			unit[currentUnit].SelectOn();
		}
		
		public function NextUnit() {
			if(!currentTeam) {
				currentUnit++;
				if(currentUnit > unitsCount)
					currentUnit = 1;
			}
		}
		
		public function Win() {
			Stop();
			trace("win!");
		}
		
		public function Stop() {
			turnTimer.stop();
		}
	}
}