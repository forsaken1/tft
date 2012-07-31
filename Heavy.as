package {
	import Unit;
	
	public class Heavy extends Unit {
		public function Heavy(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 5;
			health = 300;
			moveRadius = 1;
			attackRadius = 3;
			damageFirst = 100;
			className = "Heavy";
			initiative = 1;
			
			super(gexLink_, area_, team_);
			
		}
	}
}