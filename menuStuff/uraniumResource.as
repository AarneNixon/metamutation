package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class uraniumResource extends MovieClip {
		public var gone = true;
		public function uraniumResource(){
			this.stop();
			this.x = 39.8 + 144.3;
			this.y = 700 + 48.6;
			this.height = 48.6;
			this.scaleX = this.scaleY;
			this.gotoAndPlay(1);
			this.uraniumText.selectable = false;
		}
	}
}