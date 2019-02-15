package buildings{
	import flash.display.MovieClip;
	public class genesisPool extends MovieClip {
		public var hp = 100;
		public function genesisPool(){
			//trace("My x position is " + this.x + "and my y is " + this.y);
			//this.height = heightin;
			//this.height = 108.6;
//			this.scaleX = this.scaleY;
			this.rotation = 90 * Math.round(Math.random()*4); // this will actually set direction
			//this.gotoAndPlay(2);
//			this.hp = health;
		}
	}
}