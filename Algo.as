package {
	public class Algo {
		public static var distance = [
	   [[ 0, 0, 4, 4, 4, 4, 4, 4, 0], 
		[ 0, 4, 4, 3, 3, 3, 3, 4, 4], 
		[ 0, 4, 3, 2, 2, 2, 3, 4, 4], 
		[ 0, 4, 3, 2, 1, 1, 2, 3, 4], 
		[ 4, 3, 2, 1, 0, 1, 2, 3, 4], 
		[ 0, 4, 3, 2, 1, 1, 2, 3, 4], 
		[ 0, 4, 3, 2, 2, 2, 3, 4, 4], 
		[ 0, 4, 4, 3, 3, 3, 3, 4, 4],
		[ 0, 0, 4, 4, 4, 4, 4, 4, 0]],
	   
	   [[ 0, 4, 4, 4, 4, 4, 4, 0, 0], 
		[ 4, 4, 3, 3, 3, 3, 4, 4, 0], 
		[ 4, 4, 3, 2, 2, 2, 3, 4, 0], 
		[ 4, 3, 2, 1, 1, 2, 3, 4, 0], 
		[ 4, 3, 2, 1, 0, 1, 2, 3, 4], 
		[ 4, 3, 2, 1, 1, 2, 3, 4, 0], 
		[ 4, 4, 3, 2, 2, 2, 3, 4, 0], 
		[ 4, 4, 3, 3, 3, 3, 4, 4, 0],
		[ 0, 4, 4, 4, 4, 4, 4, 0, 0]]];
		
		public static function GetDistance(gex1, gex2:Gex) {
			var i = gex2.i - gex1.i, j = gex2.j - gex1.j, side = 0;
			if(gex1.i % 2 == 0) side = 1;
			return distance[side][i + 4][j + 4];
		}		
		
		public static function GetDistanceFactor(dist) {
			switch(dist) {
				case 1: return 1;
				case 2: return 0.9;
				case 3: return 0.8;
				case 4: return 0.7;
			}
		}
	}
}