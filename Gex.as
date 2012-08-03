package {
	import flash.events.MouseEvent;

	public class Gex extends gex {
		public var i, j:int;
		private var unit:Unit;
		private var popUp:GexPopup;
		
		public function Gex(i_, j_:int) {
			stop();
			i = i_;
			j = j_;
			if(i % 2 == 0)
				x = 55 + j * 102; 
			else
				x = 105 + j * 102; 
			y = 55 + i * 78;
			
			AddListener();
			popUp = new GexPopup(this);
		}
		
		public function GetUnit() { return unit; }
		
		public function SetUnit(unit_:Unit) { unit = unit_; }
		
		public function RemoveListener() {
			removeEventListener(MouseEvent.MOUSE_OVER, GexMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, GexMouseOut);
			removeEventListener(MouseEvent.CLICK, GexMouseDown);
		}
		
		public function AddListener() {
			addEventListener(MouseEvent.MOUSE_OVER, GexMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, GexMouseOut);
			addEventListener(MouseEvent.CLICK, GexMouseDown);
		}
		
		public function RefreshListener() {
			gotoAndStop(1);
			RemoveListener();
			AddListener();
		}
		
		public function AddAttackListener() {
			if(unit != null) {
				if(unit.GetTeam() != Global.playerTeam) {
					unit.GetUnitPopup().RemoveListener(); 
					unit.addEventListener(MouseEvent.MOUSE_OVER, AttackEnemyMouseOver);
					unit.addEventListener(MouseEvent.MOUSE_OUT, AttackEnemyMouseOut);
					unit.addEventListener(MouseEvent.CLICK, AttackGex);
				}
			}
			else {
				gotoAndStop(3);
				addEventListener(MouseEvent.MOUSE_OVER, AttackGexMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, AttackGexMouseOut);
			}
		}
		
		public function RemoveAttackListener() {
			if(unit != null) {
				if(unit.GetTeam() != Global.playerTeam) {
					unit.GetUnitPopup().AddListener(); 
					unit.removeEventListener(MouseEvent.MOUSE_OVER, AttackEnemyMouseOver);
					unit.removeEventListener(MouseEvent.MOUSE_OUT, AttackEnemyMouseOut);
					unit.removeEventListener(MouseEvent.CLICK, AttackGex);
					gotoAndStop(3);
				}
			}
			else {
				gotoAndStop(1);
				removeEventListener(MouseEvent.MOUSE_OVER, AttackGexMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, AttackGexMouseOut);
			}
		}
		
		public function AddMoveListener() {
			if(unit == null) {
				gotoAndStop(2);
				RemoveListener();
				addEventListener(MouseEvent.MOUSE_OVER, MoveGexMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, MoveGexMouseOut);
				addEventListener(MouseEvent.CLICK, MoveToGex);
			}
			else {
				unit.RefreshHealthBar();
			}
		}
		
		public function RemoveMoveListener() {
			if(unit == null) {
				removeEventListener(MouseEvent.MOUSE_OVER, MoveGexMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, MoveGexMouseOut);
				removeEventListener(MouseEvent.CLICK, MoveToGex);
				gotoAndStop(1);
				AddListener();
			}
			else {
				unit.RefreshHealthBar();
			}
		}
		
		public function Remove() {
			Global.GameLayer.removeChild(this);
		}
		
		function AttackEnemyMouseOver(event:MouseEvent) { gotoAndStop(6); unit.GetAttackPopup().Show(); }
		function AttackEnemyMouseOut(event:MouseEvent) 	{ gotoAndStop(3); unit.GetAttackPopup().Hide(); }
		
		function AttackGexMouseOver(event:MouseEvent) 	{ gotoAndStop(6); }
		function AttackGexMouseOut(event:MouseEvent) 	{ gotoAndStop(3); }
		function AttackGex(event:MouseEvent) 			{ Global.selectedUnit.AttackTo(this); unit.GetAttackPopup().Hide(); }
		
		function MoveToGex(event:MouseEvent) 		{ Global.selectedUnit.MoveTo(this); popUp.Hide(); }
		function MoveGexMouseOver(event:MouseEvent) { gotoAndStop(4); popUp.Show();	}
		function MoveGexMouseOut(event:MouseEvent) 	{ gotoAndStop(2); popUp.Hide(); }
		
		function GexMouseDown(event:MouseEvent) { gotoAndStop(3); }
		function GexMouseOver(event:MouseEvent) { gotoAndStop(2); }
		function GexMouseOut(event:MouseEvent) 	{ gotoAndStop(1); }
	}
}