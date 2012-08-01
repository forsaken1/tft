package {
	import Enemy;
	import Gex;
	
	public class AI {
		protected var unit:Unit;
		
		public function AI(unit_:Enemy) {
			unit = unit_;
			Turn();
		}
		
		function Turn() {
			var targetUnit = unit.FindTargetUnit();
			//trace(targetUnit);
			if(targetUnit != null) {
				unit.AttackTo(targetUnit.GetGex());
				return;
			}
			unit.SetInitiative(0);
			//var targetGex = unit.FindTargetGex();
			//unit.MoveTo(targetGex);
		}
	}
}