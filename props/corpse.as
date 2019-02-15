package props{
	import flash.display.MovieClip;
	public class corpse extends MovieClip {
		public var hp = 0;
		public var gone = false;
		public var progress = 0;
		public function corpse (xin,yin,heightin,inputRot){
			this.x = xin;
			this.y = yin;
			this.alpha = 1;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.rotation = inputRot;
		}
	}
}