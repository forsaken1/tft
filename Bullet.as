package {
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class Bullet extends bullet {
		private var unit, targetUnit:Unit;
		private var moveSpeed:int = 6;
		private var dx, dy:Number;
		
		public function Bullet(unit_:Unit) {
			unit = unit_;
			x = 23;
			y = - 47;
			
			switch(unit.GetClassName()) {
				case "Soldier":  break;
			}
		}
		
		public function MoveTo(targetLink:Gex) {
			targetUnit = targetLink.GetUnit();
			var s:Point = unit.localToGlobal(new Point(x, y));
			var len = (int)(Math.sqrt(Math.pow(Math.abs(s.x - targetLink.x), 2) + Math.pow(Math.abs(s.y - targetLink.y), 2)));
			var bulletMoveTimer:Timer = new Timer(2, (int)(len / moveSpeed + 0.6));
			var rot:Number = 90 - rotation;
			
			if(rot < 0) rot = 360 + rot;
			var rad:Number = rot * Math.PI / 180;
			dx = Math.cos(rad) * moveSpeed;
			dy = - Math.sin(rad) * moveSpeed;
				
			bulletMoveTimer.addEventListener(TimerEvent.TIMER, BulletMove);
			bulletMoveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, BulletMoveComplete);
			bulletMoveTimer.start();
		}
	
		function BulletMove(event:TimerEvent) {
			x += dx;
			y += dy;
		}
		
		function BulletMoveComplete(event:TimerEvent) {
			var distance = Algo.GetDistance(unit.GetGex(), targetUnit.GetGex());
			var firstDamage = unit.GetDamageFirst();
			var damage = (int)((firstDamage - Math.random() * (firstDamage / 10)) * Algo.GetDistanceFactor(distance));
			var health_ = targetUnit.GetCurrentHealth() - damage;
			
			Global.turnInfo = "Юнит " + unit.GetClassName() + " атаковал юнита " + targetUnit.GetClassName() + " с координатами: " + 
			(targetUnit.GetGex().j + 1) + " и " + (targetUnit.GetGex().i + 1) + " и нанес ему " + damage + " единиц урона. ";
			
			targetUnit.SetHealth(health_);
			unit.removeChild(this);
			unit.SetAttacking(false);
			unit.SetInitiative(unit.GetInitiative() - 1);
			if(unit.GetTeam() && unit.GetInitiative() > 0) {
				unit.wasShot = true;
				unit.RefreshInfoBar();
				unit.HighlightMove();
			}
			else
				unit.SetInitiative(0);
		}
	}
}