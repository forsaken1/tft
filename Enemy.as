package {
	public class Enemy {
		
		
		
		
		public function FindTargetGex() {
			var arraySize;
			
			switch(moveRadius) {
				case 1: arraySize = 6; break;
				case 2: arraySize = 18; break;
				case 3: arraySize = 36; break;
				case 4: arraySize = 60; break;
			}
			var targetGex = [arraySize];
			var tg;
			var i = gexLink.i, j = gexLink.j, k, l, r = Math.min(moveRadius, currentInitiative), rad = 2 * r + 1;
			if(r == 0) return null;
			
			var count = -1;
			if(i % 2 == 0) {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) {
						tg = null;
						try { tg = area[i + radius[r - 1][k][l][0]][j + radius[r - 1][k][l][1]]; } catch(error:Error) {}
						if(tg != null) {
							count++;
							targetGex[count] = tg;
						}
					}					
			}
			else {
				for(k = 0; k <= rad; k++)
					for(l = 0; l <= rad; l++) {
						tg = null;
						try { tg = area[i + radius[r + 3][k][l][0]][j + radius[r + 3][k][l][1]]; } catch(error:Error) {}
						if(tg != null) {
							count++;
							targetGex[count] = tg;
						}
					}
			}
			return targetGex[Math.round(Math.random() * arraySize - 1)];
		}
	}
}