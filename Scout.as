package {
	import Unit;
	
	public class Scout extends Unit {
		public function Scout(gexLink_:Gex, area_:Object, team_:Boolean) {
			NClass = 1;
			health = 125;
			moveRadius = 4;
			attackRadius = 3;
			damageFirst = 50;
			className = "Scout";
			initiative = 4;
			
			super(gexLink_, area_, team_);
	
		}
	}
}