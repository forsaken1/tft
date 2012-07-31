package {
	import flash.text.TextField;
	import Unit;
	
	public class HealthBar extends healthBar {
		private var info:TextField;
		private var unit:Unit;
		
		public function HealthBar(unit_:Unit) {
			stop();
			unit = unit_;
			x = 0;
			y = 35;
			var health = unit.GetHealth();
			var currentHealth = unit.GetCurrentHealth();
			
			if(0 < currentHealth && currentHealth <= health / 6) {
				gotoAndStop(6);
			}
			if(health / 6 < currentHealth && currentHealth <= (health / 6) * 2) {
				gotoAndStop(5);
			}
			if((health / 6) * 2 < currentHealth && currentHealth <= (health / 6) * 3) {
				gotoAndStop(4);
			}
			if((health / 6) * 3 < currentHealth && currentHealth <= (health / 6) * 4) {
				gotoAndStop(3);
			}
			if((health / 6) * 4 < currentHealth && currentHealth <= (health / 6) * 5) {
				gotoAndStop(2);
			}
			if((health / 6) * 5 < currentHealth && currentHealth <= health) {
				gotoAndStop(1);
			}
		}
	}
}