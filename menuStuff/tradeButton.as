package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class tradeButton extends MovieClip {
		public var gone = false;
		public var appString;
		public var delay;
		public function tradeButton(xin,yin,heightin){//43.4,355.3,55.9
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(1);
			this.rotation = 0;
			this.alpha = 0.707;
		}
	}
}