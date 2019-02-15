package props{
	import flash.display.MovieClip;
	public class gore extends MovieClip {
		public var gone = true;
		public function gore(xin,yin,heightin,frame){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(frame);
			this.rotation = 0;
		}
	}
}