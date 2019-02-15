package props{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	public class unwalkable extends MovieClip {
		public function unwalkable(){
			this.stop();
			this.x = 550;
			this.y = 400;
			this.height = 800;
			this.scaleX = this.scaleY;
			this.gotoAndStop(2);
		}
	}
}