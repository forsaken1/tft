package {
	public class AI {
		protected var unit:Unit;
		
		public function AI(unit_:Unit) {
			unit = unit_;
			Turn();
		}
		
		function Turn() {
			var targetUnit = unit.FindTargetUnit();
			if(targetUnit != null) {
				unit.AttackTo(targetUnit.GetGex());
				return;
			}
			var targetGex = unit.FindTargetGex();
			unit.MoveTo(targetGex);
		}
	}
}