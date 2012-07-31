package {
	import Unit;
	
	public class Medic extends Unit {
		public function Medic(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 7;
			health = 150;
			moveRadius = 4;
			attackRadius = 3;
			damageFirst = 0;
			className = "Medic";
			initiative = 4;
			
			super(gexLink_, area_, team_);
	
		}
	}
}