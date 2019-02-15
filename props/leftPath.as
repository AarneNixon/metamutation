package props{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	public class leftPath extends MovieClip {
		public function leftPath(){
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