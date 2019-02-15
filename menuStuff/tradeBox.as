package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class tradeBox extends MovieClip {
		public var gone = false;
		public var appString;
		public var delay;
		public function tradeBox(xin,yin,heightin){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(1);
			this.rotation = 0;
			this.alpha = 0.707;
			this.tradeCounter.text = "1";
			this.tradeCounter.selectable = false;
		}
	}
}//221.8 197.2 323.3 449.3