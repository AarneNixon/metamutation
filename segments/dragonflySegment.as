package segments{
	import flash.display.MovieClip;
	public class dragonflySegment extends MovieClip {
		//public var dragonflies:Array = new Array(); //list all dragonflies
		public var isThisFollowing:Boolean = false;
		public var follows:dragonflySegment = null;
		public var speed;
		public function dragonflySegment(xin,yin,heightin,degreein,followThis,atSpeed,startFrame) {
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.speed = atSpeed;
			this.rotation = degreein;
			this.gotoAndPlay(startFrame);
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