package {	
	import flash.events.MouseEvent; 
	
	public class Ico extends ico {
		private var N, NClass:int;
		
		public function Ico(class_:int) {
			stop();
			N = class_;
			NClass = N;
			x = NClass * 170 - 25;
			y = 100;
			gotoAndStop(NClass);
			addEventListener(MouseEvent.CLICK, onClick);
		}	
		
		function onClick(event:MouseEvent) {
			IncClassNumber();
		}
		
		public function GetClassNumber():int {
			return NClass;
		}
		
		public function GetN():int {
			return N;
		}
		
		public function IncClassNumber() {
			NClass++;
			if(NClass > 9) NClass = 1;
			gotoAndStop(NClass);
		}
	}
}