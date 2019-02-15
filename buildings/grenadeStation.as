package buildings{
	import flash.display.MovieClip;
	public class grenadeStation extends MovieClip {
		public var gone = true;
		public var myGhosts:Array = new Array();
		public function grenadeStation(xin: int = 7000000,yin: int = 7000000,heightin: int = 7000000){
			this.rotation = Math.random() * 360;
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
			this.rotation = 90 * Math.round(Math.random()*4);
		}
	}
}