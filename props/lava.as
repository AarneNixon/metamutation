package props{
	import flash.display.MovieClip;
	public class lava extends MovieClip {
		public var dying = false;
		public function lava(xin,yin,heightin,degreein){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.rotation = degreein;
		}
		public function commitEndBehavior(){
			if (dying != true){
				gotoAndPlay(58);
				dying = true;
			}
		}
	}
}