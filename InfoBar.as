package {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Unit;
	
	public class InfoBar extends infoBar {
		private var unit:Unit;
		private var health, className, initiative, moveRadius, attackRadius:TextField;
		
		public function InfoBar(unit_:Unit) {
			stop();
			unit = unit_;
			
			x = 770;
			y = 5;
			
			var textFormat = new TextFormat();
			textFormat.font = "TF2 Secondary";
			textFormat.size = 16;
			
			className = new TextField();
			className.text = unit.GetClassName();
			addChild(className);
			className.x = 95;
			className.y = 10;
			className.setTextFormat(textFormat);
			
			health = new TextField();
			health.text = unit.GetCurrentHealth() + "/" + unit.GetHealth();
			addChild(health);
			health.x = 120;
			health.y = 38;
			health.setTextFormat(textFormat);
			
			initiative = new TextField();
			initiative.text = unit.GetInitiative();
			addChild(initiative);
			initiative.x = 145;
			initiative.y = 65;
			initiative.setTextFormat(textFormat);
			
			attackRadius = new TextField();
			attackRadius.text = unit.GetAttackRadius();
			addChild(attackRadius);
			attackRadius.x = 145;
			attackRadius.y = 92;
			attackRadius.setTextFormat(textFormat);
			
			moveRadius = new TextField();
			moveRadius.text = unit.GetMoveRadius();
			addChild(moveRadius);
			moveRadius.x = 145;
			moveRadius.y = 118;	
			moveRadius.setTextFormat(textFormat);
		}
	}
}