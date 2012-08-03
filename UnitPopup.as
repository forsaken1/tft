package {
	import flash.events.MouseEvent; 
    import flash.text.TextField;
    import flash.text.TextFormat;
	
	public class UnitPopup extends Popup {
		private var health, className, initiative:TextField;
		
		public function UnitPopup(unit_:Unit) {
			super(unit_);
			
			className = new TextField();
			className.x = 74;
			className.y = 4;
			
			health = new TextField();
			health.x = 95;
			health.y = 22;
			
			initiative = new TextField();
			initiative.x = 115;
			initiative.y = 39;
			
			addChild(className);
			addChild(health);
			addChild(initiative);
			
			AddListener();
		}
		
		public function AddListener() {
			link.addEventListener(MouseEvent.MOUSE_OVER, popupMouseOver);
			link.addEventListener(MouseEvent.MOUSE_OUT, popupMouseOut);
		}
		
		public function RemoveListener() {
			link.removeEventListener(MouseEvent.MOUSE_OVER, popupMouseOver);
			link.removeEventListener(MouseEvent.MOUSE_OUT, popupMouseOut);
		}
		
		function popupMouseOver(event:MouseEvent) {
			Show();
		}
		
		function popupMouseOut(event:MouseEvent) {
			Hide();
		}
		
		public override function Show() {
			x = link.GetGex().x + 40;
			y = link.GetGex().y - 30;
			
			var textFormat = new TextFormat();
			textFormat.font = "TF2 Secondary";
			textFormat.size = 14;
			
			className.text = link.GetClassName();
			className.setTextFormat(textFormat);
			
			health.text = link.GetCurrentHealth() + "/" + link.GetHealth();
			health.setTextFormat(textFormat);
			
			initiative.text = link.GetInitiative();
			initiative.setTextFormat(textFormat);
			
			super.Show();
		}
		
		public override function Remove() {
			RemoveListener();
			super.Remove();
		}
	}
}