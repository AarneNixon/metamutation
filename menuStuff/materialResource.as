package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class materialResource extends MovieClip {
		public var gone = true;
		public function materialResource(){
			this.stop();
			this.x = 39.8;
			this.y = 700 + 48.6;
			this.height = 48.6;
			this.scaleX = this.scaleY;
			this.gotoAndPlay(1);
			this.materialText.selectable = false;
		}
	}
}