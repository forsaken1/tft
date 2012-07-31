package {
	import Unit;
	
	public class Sniper extends Unit {
		public function Sniper(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 8;
			health = 125;
			moveRadius = 3;
			attackRadius = 4;
			damageFirst = 120;
			className = "Sniper";
			initiative = 3;
			
			super(gexLink_, area_, team_);
	
		}
	}
}