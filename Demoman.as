package {
	import Unit;
	
	public class Demoman extends Unit {
		public function Demoman(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 4;
			health = 175;
			moveRadius = 3;
			attackRadius = 3;
			damageFirst = 100;
			className = "Demoman";
			initiative = 3;
			
			super(gexLink_, area_, team_);
	
		}
	}
}