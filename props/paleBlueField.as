package props{
	import flash.display.MovieClip;
	public class paleBlueField extends MovieClip {
		public var gone = true;
		public var hp = 1;
		public function paleBlueField(){
			this.gotoAndStop(1);
			this.height = 10;
			this.scaleX = this.scaleY;
			
		}
	}
}