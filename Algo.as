package {
	public class Algo {
		public static function GetDistance(gex1, gex2:Gex) {
			return Math.max(Math.abs(gex1.i - gex2.i), Math.abs(gex1.j - gex2.j));
		}		
	}
}