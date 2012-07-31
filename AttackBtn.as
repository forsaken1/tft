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
			addEventListener(MouseEvent.MOUSE_OVER, OnElement);
			addEventListener(MouseEvent.MOUSE_OUT, OutElement);
		}
		
		function OnElement(event:MouseEvent) {
			gotoAndStop(pressed ? 4 : 2);
		}
		
		function OutElement(event:MouseEvent) {
			gotoAndStop(pressed ? 3 : 1);
		}
		
		private function Press(event:MouseEvent):void {
			if(unit.GetInitiative() == 0) return;
			pressed = !pressed;
			if(pressed) 
				On();
			else 
				Off();
		}
		
		public function Off() {
			gotoAndStop(pressed ? 4 : 2);
			unit.RemoveHighlightAttack();
			unit.HighlightMove();
		}
		
		public function On() {
			gotoAndStop(pressed ? 4 : 2);
			unit.RemoveHighlightMove();
			unit.HighlightAttack();
		}
		
		public function GetPressed() { return pressed; }
	}
}