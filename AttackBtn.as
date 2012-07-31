package {
	import Unit;
	import flash.events.MouseEvent; 
	
	public class AttackBtn extends attackbtn {
		private var unit:Unit;
		private var pressed:Boolean;
		
		public function AttackBtn(unit_:Unit) {
			stop();
			unit = unit_;
			pressed = false;
			x = 770;
			y = 160;
			addEventListener(MouseEvent.CLICK, Press);
		}
		
		private function Press(event:MouseEvent):void {
			if(unit.GetInitiative() == 0) return;
			if(pressed) 
				Off();
			else 
				On();
		}
		
		public function Off() {
			gotoAndStop(1);
			unit.RemoveHighlightAttack();
			unit.HighlightMove();
			pressed = false;
		}
		
		public function On() {
			gotoAndStop(2);
			unit.RemoveHighlightMove();
			unit.HighlightAttack();
			pressed = true;
		}
		
		public function GetPressed() { return pressed; }
	}
}