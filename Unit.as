package {
	import flash.events.MouseEvent; 
	import flash.events.TimerEvent; 
    import flash.utils.Timer; 
	import flash.display.Stage;
	
	public class Unit extends unit {
		protected var area:Object;
		protected var targetLink, gexLink:Gex;
		protected var health:int, currentHealth:int, moveRadius:int, attackRadius:int, 
		rotateSpeed:int = 4, moveSpeed:int = 4, NClass:int, damageFirst:int,
		initiative:int, currentInitiative:int;
		protected var className:String;
		protected var dx, dy:Number;
		protected var hbar:HealthBar;
		protected var attackButton:AttackBtn;
		protected var info:InfoBar;
		protected var selected, moving, attacking, team, dead:Boolean;
		protected var popUp:Popup;
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
			currentInitiative = initiative;
			dead = false;
			
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
			AddPopup();
			selected = false;
			moving = false;
		}
		
		public function AddPopupListener() {
			addEventListener(MouseEvent.MOUSE_OVER, popupMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, popupMouseOut);
		}
		
		public function RemovePopupListener() {
			removeEventListener(MouseEvent.MOUSE_OVER, popupMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, popupMouseOut);
		}
		
		public function AddPopup() {
			popUp = new Popup(this);
			AddPopupListener();
		}
		
		public function RemovePopup() {
			RemovePopupListener();
			popUp = null;
		}
		
		function popupMouseOver(event:MouseEvent) {
			popUp.Show();
		}
		
		function popupMouseOut(event:MouseEvent) {
			popUp.Hide();
		}
		
		public function RefreshInitiative() {
			currentInitiative = initiative;
		}
		
		public function AttackTo(gex_:Gex) {
			if(team) {
				RemoveHighlightAttack();
			}
			RemoveHealthBar();
			targetLink = gex_;
			RotateTo(gex_);
			attacking = true;
		}
		
		public function MoveTo(gex_:Gex) {
			if(team) {
				RemoveHighlightMove();
			}
			RemoveHealthBar();
			gexLink.gotoAndStop(1);
			gexLink.SetUnit(null);
			gexLink.AddListener();
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
				rotateTimer = new Timer(2, (int)(Math.abs(rot) / rotateSpeed + 0.9));
				
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
				//trace(len);
				//currentInitiative -= (int)(len / 73 - 0.55);//правильно вычислять расстояния до гекса в целых числах!
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
			Global.turnInfo = className + " переместился на гекс с координатами: " + gexLink.j + " и " + gexLink.i;
			if(team) {
				gexLink.gotoAndStop(4);
			}
			else {
				gexLink.gotoAndStop(3);
			}
			x = gexLink.x;
			y = gexLink.y;
			moving = false;
			AddHealthBar();
			currentInitiative = 0;
		}
		
		public function HighlightAttack() {
			var i = gexLink.i, j = gexLink.j, k, l, r = attackRadius, rad = 2 * r + 1, side = r + 3;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) 
					try { area[i + radius[side][k][l][0]][j + radius[side][k][l][1]].AddAttackListener(); } catch(error:Error) {}
		}
		
		public function RemoveHighlightAttack() {
			var i = gexLink.i, j = gexLink.j, k, l, r = attackRadius, rad = 2 * r + 1, side = r + 3;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) 
					try { area[i + radius[side][k][l][0]][j + radius[side][k][l][1]].RemoveAttackListener(); } catch(error:Error) {}
		}
		
		public function HighlightMove() {
			var i = gexLink.i, j = gexLink.j, k, l, r = Math.min(moveRadius, currentInitiative), rad = 2 * r + 1, side = r + 3;
			if(r == 0) return;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) 
					try { area[i + radius[side][k][l][0]][j + radius[side][k][l][1]].AddMoveListener(); } catch(error:Error) {}
			}
		
		public function RemoveHighlightMove() {
			var i = gexLink.i, j = gexLink.j, k, l, r = moveRadius, rad = 2 * r + 1, side = r + 3;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) 
						try { area[i + radius[side][k][l][0]][j + radius[side][k][l][1]].RemoveMoveListener(); } catch(error:Error) {}
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
		
		public function Remove() {
			RemoveHealthBar();
			RemovePopup();
			gexLink.SetUnit(null);
			gexLink.AddListener();
			gexLink.gotoAndStop(1);
			stage.removeChild(this);
			dead = true;
			if(team)
				Global.playerUnitsCount--;
			else
				Global.enemyUnitsCount--;
		}
		
		public function SetHealth(health_:int) {
			if(health_ <= 0) 
				Remove();
			else {
				currentHealth = health_;
				RefreshHealthBar();
			}
		}
		
		public function FindTargetUnit() {
			var i = gexLink.i, j = gexLink.j, k, l, r = attackRadius, rad = 2 * r + 1, targetUnit, side = r + 3;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) {
					targetUnit = null;
					try { targetUnit = area[i + radius[side][k][l][0]][j + radius[side][k][l][1]].GetUnit(); } catch(error:Error) {}
					if(targetUnit != null && targetUnit.GetTeam() != team) 
						return targetUnit;
				}
			return null;
		}
		
		public function FindTargetGex() {
			var tg, targetGex = [100];
			var i = gexLink.i, j = gexLink.j, k, l, r = Math.min(moveRadius, currentInitiative), rad = 2 * r + 1, side = r + 3;
			var count = 0;
			if(r == 0) return null;
			if(i % 2 == 0) side = r - 1;
			
			for(k = 0; k <= rad; k++)
				for(l = 0; l <= rad; l++) {
					tg = null;
					try { tg = area[i + radius[side][k][l][0]][j + radius[side][k][l][1]]; } catch(error:Error) {}
					if(tg != null && tg.GetUnit() == null) {
						targetGex[count] = tg;
						count++;
					}
				}
			var pos;
			do {
				pos = Math.round(Math.random() * count);
			} while(targetGex[pos] == null);
			return targetGex[pos];
		}
				
		public function GetGex() { return gexLink; }
		public function GetHealth() { return health; }
		public function GetCurrentHealth() { return currentHealth; }
		public function GetTeam() { return team; }
		public function GetDamageFirst() { return damageFirst; }
		public function GetClassName() { return className; }
		public function GetInitiative() { return currentInitiative; }
		public function GetAttackRadius() { return attackRadius; }
		public function GetMoveRadius() { return moveRadius; }
		public function IsDead() { return dead; }

		public function SetAttacking(a_:Boolean) { attacking = a_; }
		public function SetInitiative(i_:int) { currentInitiative = i_; }
	}
}