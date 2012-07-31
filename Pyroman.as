package {
	import Unit;
	
	public class Pyroman extends Unit {
		public function Pyroman(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 3;
			health = 175;
			moveRadius = 3;
			attackRadius = 2;
			damageFirst = 150;
			className = "Pyroman";
			initiative = 3;
			
			super(gexLink_, area_, team_);
	
		}
	}
}