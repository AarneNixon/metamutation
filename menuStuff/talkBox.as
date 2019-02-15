package menuStuff{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class talkBox extends MovieClip {
		public var gone = false;
		public var appString;
		public var delay;
		public var storyTextFormat:TextFormat = new TextFormat();
		public function talkBox(xin,yin,heightin){//43.4,355.3,55.9
			storyTextFormat.letterSpacing = 12;
			storyTextFormat.size = 22;
			storyTextFormat.bold = true;
			storyTextFormat.color = 0x0000ff;
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(4);
			this.rotation = 0;
			this.alpha = 0.9;
			this.dialogue.selectable = false;
			this.dialogue.defaultTextFormat = storyTextFormat;
		}
	}
}