package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	public class Global {
		public static var selectedUnit:MovieClip;
		public static var playerTeam:Boolean;
		public static var playerUnitsCount, enemyUnitsCount:int;
		public static var GameLayer, EffectsLayer, UILayer:Sprite;
		public static var turnInfo:String;
	}
}