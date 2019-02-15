package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class marketPanel extends MovieClip {
		public var gone = false;
		public var appString;
		public var delay;
		public function marketPanel(xin,yin,heightin,inText,inDelay){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(1);
			this.rotation = 0;
			this.alpha = 0.707;
			this.appString = inText;
			this.delay = inDelay;
			this.panelText.selectable = false;
		}
	}
}//221.8 197.2 323.3 449.3