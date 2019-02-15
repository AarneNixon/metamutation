package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class costDisplay extends MovieClip {
		public var gone = true;
		public function costDisplay(){
			this.stop();
			this.x = 46.8;
			this.y = 557.8;
			this.height = 33;
			this.scaleX = this.scaleY;
			this.gotoAndStop(1);
			this.costText.selectable = false;
		}
	}
}