package props{
	import flash.display.MovieClip;
	public class chainsaw extends MovieClip {
		public var isThisFollowing:Boolean = false;
		public var follows:Object = null;
		public var damage;
		public var curveMemory:Number = 0;
		public var level;
		public var followMe;
		public var fixAngle = -36;
		public var hp = 1;
		public function chainsaw() { //xin,yin,heightin,degreein,followThis,damageIn,levelIn
			//this.x = xin;
//			this.y = yin;
//			this.rotation = 0; //this will enable consistent sizing
//			this.height = heightin;
//			this.scaleX = this.scaleY;
//			this.damage = damageIn;
//			this.rotation = degreein; // this will actually set direction
			this.gotoAndPlay(1);
			//this.gotoAndPlay(levelIn); //#task: add more chainsaw types/costumes/upgrades/levels
			//this.level = levelIn;
			//if (followThis != null) {
//				isThisFollowing = true;
//				follows = followThis;
//			} else {
//				isThisFollowing = false;
//				follows = null;
//			}
		}
	}
}