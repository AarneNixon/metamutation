package menuStuff{
	import flash.display.MovieClip;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class marketBars extends MovieClip {
		public var gone = false;
		public function marketBars(xin,yin,heightin,tint){
			this.x = xin;
			this.y = yin;
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.gotoAndStop(1);
			this.rotation = 0;
			var cTint:Color = new Color();//thanks to jweeks123
			cTint.setTint(tint, 1);
			this.transform.colorTransform = cTint;
			this.alpha = 0.707;
		}
	}
}