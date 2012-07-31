package {
	import HealthBar;
	import AttackBtn;
	import flash.events.MouseEvent; 
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.display.Stage;
	import Bullet;
	import InfoBar;
	
	public class Unit extends unit {
		protected var area:Object;
		protected var targetLink, gexLink:Gex;
		protected var health:int, currentHealth:int, moveRadius:int, attackRadius:int, 
		rotateSpeed:int = 4, moveSpeed:int = 4, NClass:int, damageFirst:int,
		initiative:int;
		protected var className:String;
		protected var dx, dy:Number;
		protected var hbar:HealthBar;
		protected var attackButton:AttackBtn;
		protected var info:InfoBar;
		protected var selected, moving, attacking, team:Boolean;
		protected var radius = [
				 [[[-1,-1],[-1, 0],[99,99]], 
				  [[ 0,-1],[99,99],[ 0, 1]], 
				  [[ 1,-1],[ 1, 0],[99,99]]],
				  
				 [[[99,99],[-2,-1],[-2, 0],[-2, 1],[99,99]],
				  [[-1,-2],[-1,-1],[-1, 0],[-1, 1],[99,99]], 
				  [[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2]], 
				  [[ 1,-2],[ 1,-1],[ 1, 0],[ 1, 1],[99,99]],
				  [[99,99],[ 2,-1],[ 2, 0],[ 2, 1],[99,99]]],
				  
				 [[[99,99],[-3,-2],[-3,-1],[-3, 0],[-3, 1],[99,99],[99,99]],
				  [[99,99],[-2,-2],[-2,-1],[-2, 0],[-2, 1],[-2, 2],[99,99]],
				  [[-1,-3],[-1,-2],[-1,-1],[-1, 0],[-1, 1],[-1, 2],[99,99]], 
				  [[ 0,-3],[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2],[ 0, 3]], 
				  [[ 1,-3],[ 1,-2],[ 1,-1],[ 1, 0],[ 1, 1],[ 1, 2],[99,99]],
				  [[99,99],[ 2,-2],[ 2,-1],[ 2, 0],[ 2, 1],[ 2, 2],[99,99]],
				  [[99,99],[ 3,-2],[ 3,-1],[ 3, 0],[ 3, 1],[99,99],[99,99]]], 
				  
				 [[[99,99],[99,99],[-4,-2],[-4,-1],[-4, 0],[-4, 1],[-4, 2],[99,99],[99,99]],
				  [[99,99],[-3,-3],[-3,-2],[-3,-1],[-3, 0],[-3, 1],[-3, 2],[99,99],[99,99]],
				  [[99,99],[-2,-3],[-2,-2],[-2,-1],[-2, 0],[-2, 1],[-2, 2],[-2, 3],[99,99]],
				  [[-1,-4],[-1,-3],[-1,-2],[-1,-1],[-1, 0],[-1, 1],[-1, 2],[-1, 3],[99,99]], 
				  [[ 0,-4],[ 0,-3],[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2],[ 0, 3],[ 0, 4]], 
				  [[ 1,-4],[ 1,-3],[ 1,-2],[ 1,-1],[ 1, 0],[ 1, 1],[ 1, 2],[ 1, 3],[99,99]],
				  [[99,99],[ 2,-3],[ 2,-2],[ 2,-1],[ 2, 0],[ 2, 1],[ 2, 2],[ 2, 3],[99,99]],
				  [[99,99],[ 3,-3],[ 3,-2],[ 3,-1],[ 3, 0],[ 3, 1],[ 3, 2],[99,99],[99,99]],
				  [[99,99],[99,99],[ 4,-2],[ 4,-1],[ 4, 0],[ 4, 1],[ 4, 2],[99,99],[99,99]]],
				  
				 [[[99,99],[-1, 0],[-1, 1]], 
				  [[ 0,-1],[99,99],[ 0, 1]], 
				  [[99,99],[ 1, 0],[ 1, 1]]],
				  
				 [[[99,99],[-2,-1],[-2, 0],[-2, 1],[99,99]],
				  [[99,99],[-1,-1],[-1, 0],[-1, 1],[-1, 2]], 
				  [[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2]], 
				  [[99,99],[ 1,-1],[ 1, 0],[ 1, 1],[ 1, 2]],
				  [[99,99],[ 2,-1],[ 2, 0],[ 2, 1],[99,99]]],
				  
				 [[[99,99],[99,99],[-3,-1],[-3, 0],[-3, 1],[-3, 2],[99,99]],
				  [[99,99],[-2,-2],[-2,-1],[-2, 0],[-2, 1],[-2, 2],[99,99]],
				  [[99,99],[-1,-2],[-1,-1],[-1, 0],[-1, 1],[-1, 2],[-1, 3]], 
				  [[ 0,-3],[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2],[ 0, 3]], 
				  [[99,99],[ 1,-2],[ 1,-1],[ 1, 0],[ 1, 1],[ 1, 2],[ 1, 3]],
				  [[99,99],[ 2,-2],[ 2,-1],[ 2, 0],[ 2, 1],[ 2, 2],[99,99]],
				  [[99,99],[99,99],[ 3,-1],[ 3, 0],[ 3, 1],[ 3, 2],[99,99]]], 
				  
				 [[[99,99],[99,99],[-4,-2],[-4,-1],[-4, 0],[-4, 1],[-4, 2],[99,99],[99,99]],
				  [[99,99],[99,99],[-3,-2],[-3,-1],[-3, 0],[-3, 1],[-3, 2],[-3, 3],[99,99]],
				  [[99,99],[-2,-3],[-2,-2],[-2,-1],[-2, 0],[-2, 1],[-2, 2],[-2, 3],[99,99]],
				  [[99,99],[-1,-3],[-1,-2],[-1,-1],[-1, 0],[-1, 1],[-1, 2],[-1, 3],[-1, 4]], 
				  [[ 0,-4],[ 0,-3],[ 0,-2],[ 0,-1],[99,99],[ 0, 1],[ 0, 2],[ 0, 3],[ 0, 4]], 
				  [[99,99],[ 1,-3],[ 1,-2],[ 1,-1],[ 1, 0],[ 1, 1],[ 1, 2],[ 1, 3],[ 1, 4]],
				  [[99,99],[ 2,-3],[ 2,-2],[ 2,-1],[ 2, 0],[ 2, 1],[ 2, 2],[ 2, 3],[99,99]],
				  [[99,99],[99,99],[ 3,-2],[ 3,-1],[ 3, 0],[ 3, 1],[ 3, 2],[ 3, 3],[99,99]],
				  [[99,99],[99,99],[ 4,-2],[ 4,-1],[ 4, 0],[ 4, 1],[ 4, 2],[99,99],[99,99]]]];
		
		public function Unit(gexLink_:Gex, area_:Object, team_:Boolean) {
			stop();
			currentHealth = health;
			
			team = team_;
			area = area_;
			gexLink = gexLink_;
			gexLink.gotoAndStop(4);
			gexLink.RemoveListener();
			gexLink.SetUnit(this);
			
			x = gexLink.x;
			y = gexLink.y;
			
			if(!team) {
				rotation = 180;
				gexLink.gotoAndStop(3);
			}
			gotoAndStop(NClass + (team ? 0 : 1) * 9);
			
			AddHealthBar();
			selected = false;
			moving = false;
			addEventListener(MouseEvent.CLICK, Select);
		}
		
		public function AttackTo(gex_:Gex) {
			RemoveHealthBar();
			RemoveHighlightAttack();
			targetLink = gex_;
			RotateTo(gex_);
			attacking = true;
			attackButton.Off();
		}
		
		public function MoveTo(gex_:Gex) {
			RemoveHealthBar();
			gexLink.SetUnit(null);
			gexLink.RefreshListener();
			RemoveHighlightMove();
			gexLink = gex_;
			gexLink.RemoveListener();
			gexLink.SetUnit(this);
			RotateTo(gex_);
			moving = true;
		}
		
		public function RotateTo(gex_:gex) {
			var _angle = (int)(Math.atan2(gex_.y - y, gex_.x - x) / (Math.PI / 180)) + 90;
			var rot = _angle - rotation;	
			
			if(rot > 180)
				rot = - 360 + rot;
			else if(rot < - 180)
				rot = 360 + rot;
			
			var rotateTimer:Timer;
			if(rot == 0) {
				rotateTimer = new Timer(2, 1);
			}
			else {
				rotateTimer = new Timer(2, (int)(Math.abs(rot) / rotateSpeed + 0.6));
				
				if(rot > 0)
					rotateTimer.addEventListener(TimerEvent.TIMER, onRotateRight);
				else
					rotateTimer.addEventListener(TimerEvent.TIMER, onRotateLeft);
			}
			
			rotateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRotateComplete);
			rotateTimer.start();
		}
		
		function onRotateRight(event:TimerEvent) { rotation += rotateSpeed; }
		function onRotateLeft(event:TimerEvent)  { rotation -= rotateSpeed; }
		
		function onRotateComplete(event:TimerEvent) {
			if(moving) {
				var len = Math.sqrt(Math.pow(Math.abs(x - gexLink.x), 2) + Math.pow(Math.abs(y - gexLink.y), 2));
				initiative -= (int)(len / 82);
				var moveTimer:Timer = new Timer(5, len / moveSpeed);
				var rot:Number = 90 - rotation;
				if(rot < 0) rot = 360 + rot;
				var rad:Number = rot * Math.PI / 180;
				dx = Math.cos(rad) * moveSpeed;
				dy = - Math.sin(rad) * moveSpeed;
				
				moveTimer.addEventListener(TimerEvent.TIMER, onMoving);
				moveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onMovingComplete);
				moveTimer.start();
			}
			if(attacking) {
				initiative = 0;
				RemoveHighlightMove();
				AddHealthBar();
				var bull = new Bullet(this);
				addChild(bull);
				bull.MoveTo(targetLink);
			}
		}
		
		function onMoving(event:TimerEvent) {
			x += dx;
			y += dy;
		}
		
		function onMovingComplete(event:TimerEvent) {
			gexLink.gotoAndStop(4);
			x = gexLink.x;
			y = gexLink.y;
			HighlightMove();
			moving = false;
			AddHealthBar();
			RefreshInfoBar();
		}
		
		public function HighlightAttack() {
			var i = gexLink.i, j = gexLink.j, k, l, r = attackRadius, rad = 2 * r + 1;
			if(i % 2 == 0) {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r - 1][k][l][0]][j + radius[r - 1][k][l][1]].AddAttackListener(); } catch(error:Error) {}
			}
			else {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r + 3][k][l][0]][j + radius[r + 3][k][l][1]].AddAttackListener(); } catch(error:Error) {}
			}
		}
		
		public function RemoveHighlightAttack() {
			var i = gexLink.i, j = gexLink.j, k, l, r = attackRadius, rad = 2 * r + 1;
			if(i % 2 == 0) {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r - 1][k][l][0]][j + radius[r - 1][k][l][1]].RemoveAttackListener(); } catch(error:Error) {}
			}
			else {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r + 3][k][l][0]][j + radius[r + 3][k][l][1]].RemoveAttackListener(); } catch(error:Error) {}
			}
		}
		
		public function HighlightMove() {
			var i = gexLink.i, j = gexLink.j, k, l, r = Math.min(moveRadius, initiative), rad = 2 * r + 1;
			if(r == 0) return;
			if(i % 2 == 0) {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r - 1][k][l][0]][j + radius[r - 1][k][l][1]].AddMoveListener(); } catch(error:Error) {}
			}
			else {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r + 3][k][l][0]][j + radius[r + 3][k][l][1]].AddMoveListener(); } catch(error:Error) {}
			}
		}
		
		public function RemoveHighlightMove() {
			var i = gexLink.i, j = gexLink.j, k, l, r = moveRadius, rad = 2 * r + 1;
			if(i % 2 == 0) {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r - 1][k][l][0]][j + radius[r - 1][k][l][1]].RemoveMoveListener(); } catch(error:Error) {}
			}
			else {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) 
						try { area[i + radius[r + 3][k][l][0]][j + radius[r + 3][k][l][1]].RemoveMoveListener(); } catch(error:Error) {}
			}
		}
		
		private function Select(event:MouseEvent):void {
			if(Global.playerTeam == team)
				if(selected) 
					SelectOff();
				else 
					SelectOn();
		}
		
		public function SelectOff() {
			Global.selectedUnit = null;
			gexLink.gotoAndStop(4);
			if(attackButton.GetPressed()) 
				RemoveHighlightAttack();
			else
				RemoveHighlightMove();
			RemoveInfoBar();
			selected = false;
		}
		
		public function SelectOn() {
			try { Global.selectedUnit.SelectOff(); } catch(error:Error) {}
			Global.selectedUnit = this;
			gexLink.gotoAndStop(5);
			HighlightMove();
			AddInfoBar();
			selected = true;
		}
		
		public function RefreshHealthBar() {
			RemoveHealthBar();
			AddHealthBar();
		}
		
		public function RefreshInfoBar() {
			RemoveInfoBar();
			AddInfoBar();
		}
		
		public function RemoveInfoBar() {
			stage.removeChild(info);
			stage.removeChild(attackButton);
		}
		
		public function AddInfoBar() {
			info = new InfoBar(this);
			attackButton = new AttackBtn(this);
			stage.addChild(info);
			stage.addChild(attackButton);
		}
		
		public function RemoveHealthBar() {
			gexLink.removeChild(hbar);
		}
		
		public function AddHealthBar() {
			hbar = new HealthBar(this);
			gexLink.addChild(hbar);
		}
		
		public function RemoveUnit() {
			RemoveHealthBar();
			gexLink.SetUnit(null);
			gexLink.RefreshListener();
			stage.removeChild(this);
		}
		
		public function SetHealth(health_:int) {
			if(health_ <= 0) 
				RemoveUnit();
			else {
				currentHealth = health_;
				RemoveHealthBar();
				AddHealthBar();
			}
		}
		
		public function GetGex() { return gexLink; }
		public function GetHealth() { return health; }
		public function GetCurrentHealth() { return currentHealth; }
		public function GetTeam() { return team; }
		public function GetDamageFirst() { return damageFirst; }
		public function GetClassName() { return className; }
		public function GetInitiative() { return initiative; }
		public function GetAttackRadius() { return attackRadius; }
		public function GetMoveRadius() { return moveRadius; }

		public function SetAttacking(a_:Boolean) { attacking = a_; }
	}
}