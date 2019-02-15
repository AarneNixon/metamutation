package props{
	import flash.display.MovieClip;
	public class glowingRock extends MovieClip {
		public var gone = true;
		public var hp = 0;
		public function glowingRock(xin:int = 7777,yin:int = 7777,heightin:int = 7777){
			if(xin != 7777){
				this.x = xin;
			}
			if(yin != 7777){
				this.y = yin;
			}
			this.alpha = 0.5;
			if (heightin != 7777){
				this.height = heightin;
			}
			this.scaleX = this.scaleY;
			this.rotation = 0;
		}
	}
}