package props{
	import flash.display.MovieClip;
	public class dropMeter extends MovieClip {
		public var gone = false;
		public function dropMeter(xin,yin,heightin,frame){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(frame);
			this.rotation = 0;
		}
	}
}