package menuStuff{
	import flash.display.MovieClip;
	public class subCategorizer extends MovieClip {
		public var gone = false;
		public function subCategorizer(xin,yin,heightin,frame){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(frame);
			this.rotation = 0;
			this.alpha = 0.707;
		}
	}
}