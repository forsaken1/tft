package {
	import Unit;
	
	public class Soldier extends Unit {
		public function Soldier(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 2;
			health = 200;
			moveRadius = 2;
			attackRadius = 4;
			damageFirst = 120;
			className = "Soldier";
			initiative = 2;
			
			super(gexLink_, area_, team_);
			
		}
	}
}