package {
	import Unit;
	import Gex;
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
			unit.removeChild(this);
			unit.SetAttacking(false);
			targetUnit.SetHealth(targetUnit.GetCurrentHealth() - unit.GetDamageFirst());
			unit.SetInitiative(0);
			//unit.RefreshInfoBar();
		}
	}
}