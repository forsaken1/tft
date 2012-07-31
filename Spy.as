package {
	import Unit;
	
	public class Spy extends Unit {
		public function Spy(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 9;
			health = 125;
			moveRadius = 3;
			attackRadius = 3;
			damageFirst = 100;
			className = "Spy";
			initiative = 3;
			
			super(gexLink_, area_, team_);
	
		}
	}
}