package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class slimeResource extends MovieClip {
		public var gone = true;
		public function slimeResource(){
			this.stop();
			this.x = 39.8;
			this.y = 700;
			this.height = 48.6;
			this.scaleX = this.scaleY;
			this.gotoAndPlay(1);
			this.slimeText.selectable = false;
		}
	}
}