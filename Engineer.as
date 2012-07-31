package {
	import Unit;
	
	public class Engineer extends Unit {
		public function Engineer(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 6;
			health = 125;
			moveRadius = 3;
			attackRadius = 2;
			damageFirst = 50;
			className = "Engineer";
			initiative = 3;
			
			super(gexLink_, area_, team_);
	
		}
	}
}