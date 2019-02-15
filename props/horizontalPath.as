package props{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	public class horizontalPath extends MovieClip {
		public function horizontalPath(){
			this.stop();
			this.x = 550;
			this.y = 400;
			this.height = 800;
			this.scaleX = this.scaleY;
			this.gotoAndStop(3);
			this.alpha = .3;
		}
	}
}