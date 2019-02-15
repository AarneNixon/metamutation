package mutations{
	import flash.display.MovieClip;
	public class jawpiece extends MovieClip {
		//public var dragonflies:Array = new Array(); //list all dragonflies
		public var isThisFollowing:Boolean = true;
		public var follows = null;
		public function jawpiece(follow) {
			follows = follow;
			this.rotation = 0;
			this.height = follows.height;
			this.scaleX = this.scaleY;
		}
	}
}