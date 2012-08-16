package {
	public class Algo {		
		public static function GetDistance(gex1, gex2:Gex) {
			var i = gex2.i - gex1.i, j = gex2.j - gex1.j, side = 0;
			if(gex1.i % 2 == 0) side = 1;
			return Global.distance[side][i + 4][j + 4];
		}		
		
		public static function GetDistanceFactor(dist) {
			switch(dist) {
				case 1: return 1;
				case 2: return 0.9;
				case 3: return 0.8;
				case 4: return 0.7;
			}
		}
		
		public static function CreateUnit(gx, class_, posJ, team_:Boolean):Unit {
			var posI:int = team_ ? 5 : 1;
			var gexLink = gx[posI][posJ];
			
			switch(class_) {
				case 1: return new Scout(gexLink, gx, team_); 
				case 2: return new Soldier(gexLink, gx, team_); 
				case 3: return new Pyroman(gexLink, gx, team_); 
				case 4: return new Demoman(gexLink, gx, team_); 
				case 5: return new Heavy(gexLink, gx, team_); 
				case 6: return new Engineer(gexLink, gx, team_); 
				case 7: return new Medic(gexLink, gx, team_); 
				case 8: return new Sniper(gexLink, gx, team_); 
				case 9: return new Spy(gexLink, gx, team_); 
			}
			return null;
		}
	}
}