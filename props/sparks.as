package props{
	import flash.display.MovieClip;
	public class sparks extends MovieClip {
		public var gone = true;
		public var progress = 0;
		public function sparks(xin,yin,heightin,frame){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.rotation = Math.random() * 360;
			this.gotoAndPlay(((frame - 1) * 10) + 1);
			this.rotation = 0;
		}
	}
}