package segments{
	import flash.display.MovieClip;
	public class rattleBug extends MovieClip {
		public var isThisFollowing:Boolean = false;
		public var follows:centipedeSegment = null;
		public var speed;
		public var curveMemory:Number = 0;
		public var hp;
		public var followMe;
		public var fixAngle = -36;
		public var myJaw = null;
		public var myMaxMutations = 1;
		public var myMaxRequirements = 0;
		public var myMutations:Array = new Array;
		public var myRequirements:Array = new Array;
		public var mySway = null;
		public var mySwaySize = null;
		public var swayVelocity = null;
		public var deathPose = 21 + Math.round((Math.random() * 10) + 0.5);
		public var target = null;
		public var gone = false;
		public var hasGhosts = false;
		//public var turnRight = 1;
		public function rattleBug(xin,yin,heightin,degreein,followThis,atSpeed,startFrame,health,lead) {
			this.x = xin;
			this.y = yin;
			this.rotation = 0; //this will enable consistent sizing
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.speed = atSpeed;
			this.rotation = degreein; // this will actually set direction
			this.gotoAndPlay(startFrame);
			this.hp = health;
			this.followMe = lead;
			if (followThis != null) {
				isThisFollowing = true;
				follows = followThis;
			} else {
				isThisFollowing = false;
				follows = null;
			}
		}
	}
}