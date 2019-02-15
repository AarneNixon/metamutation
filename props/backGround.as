package props{
	import flash.display.MovieClip;
	public class backGround extends MovieClip {
		public var gone = true;
		public function backGround(){
			this.stop();
			this.x = 550;
			this.y = 400;
			this.height = 800;
			this.scaleX = this.scaleY;
			this.gotoAndStop(2);
		}
	}
}