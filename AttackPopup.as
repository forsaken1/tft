package {
    import flash.text.TextField;
    import flash.text.TextFormat;
	
	public class AttackPopup extends Popup {
		private var className, health, damage:TextField;
		
		public function AttackPopup(unit_:Unit) {
			super(unit_);
			gotoAndStop(3);
			
			className = new TextField();
			className.x = 74;
			className.y = 4;
			
			health = new TextField();
			health.x = 74;
			health.y = 22;
			
			damage = new TextField();
			damage.x = 74;
			damage.y = 39;
			
			addChild(className);
			addChild(health);
			addChild(damage);
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
			
			var firstDamage = Global.selectedUnit.GetDamageFirst();
			var factor = Algo.GetDistanceFactor(Algo.GetDistance(Global.selectedUnit.GetGex(), link.GetGex()));
			damage.text = (int)(firstDamage * factor * 0.9) + " ~ " + (int)(firstDamage * factor);
			damage.setTextFormat(textFormat);
			
			super.Show();
		}
	}
}