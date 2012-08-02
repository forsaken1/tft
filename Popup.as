package {
    import flash.text.TextField;
    import flash.text.TextFormat;
	import flash.events.MouseEvent; 
	
	public class Popup extends popup {
		protected var unit:Unit;
		private var health, className, initiative:TextField;
		
		public function Popup(unit_:Unit) {
			unit = unit_;
			
			className = new TextField();
			health = new TextField();
			initiative = new TextField();
			
			addChild(className);
			addChild(health);
			addChild(initiative);
		}
		
		public function Show() {
			x = unit.GetGex().x + 40;
			y = unit.GetGex().y - 30;
			Global.UILayer.addChild(this);
			
			var textFormat = new TextFormat();
			textFormat.font = "TF2 Secondary";
			textFormat.size = 14;
			
			className.text = unit.GetClassName();
			className.x = 74;
			className.y = 4;
			className.setTextFormat(textFormat);
			
			health.text = unit.GetCurrentHealth() + "/" + unit.GetHealth();
			health.x = 95;
			health.y = 22;
			health.setTextFormat(textFormat);
			
			initiative.text = unit.GetInitiative();
			initiative.x = 115;
			initiative.y = 39;
			initiative.setTextFormat(textFormat);
		}
		
		public function Hide() {
			Global.UILayer.removeChild(this);
		}
	}
}