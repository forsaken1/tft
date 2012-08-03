package {	
	public class Popup extends popup {
		protected var link;
		
		public function Popup(link_) {
			stop();
			link = link_;
			x = link.x + 40;
			y = link.y - 30;
		}
		
		public function Show() {
			Global.UILayer.addChild(this);
		}
		
		public function Hide() {
			try { Global.UILayer.removeChild(this); } catch(error:Error) {}
		}
		
		public function Remove() {
			try { Global.UILayer.removeChild(this); } catch(error:Error) {}
		}
	}
}