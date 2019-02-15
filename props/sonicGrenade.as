package props{
	import flash.display.MovieClip;
	public class sonicGrenade extends MovieClip {
		public var gone = true;
		public var myExpire = 0.5;
		public function sonicGrenade(xin:int = 7000000,yin: int = 7000000,heightin: int = 7000000,degreein:int = 0){
			if (xin != 7000000){
				this.x = xin;
			}
			if (yin != 7000000){
				this.y = yin;
			}
			if (heightin != 7000000){
				this.height = heightin;
			}
			this.scaleX = this.scaleY;
			this.rotation = degreein;
		}
	}
}