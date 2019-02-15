package soldiers{
	import flash.display.MovieClip;
	public class chainsawer extends MovieClip {
		public var speed;
		public var hp;
		public var hpMax
		public var fixAngle = -36;
		public var following = false;
		public var target = false;
		public function chainsawer(xin,yin,heightin,degreein,atSpeed,health,level){
			this.x = xin;
			this.y = yin;
			this.rotation = 0; //this will enable consistent sizing
			this.height = heightin;
			this.scaleX = this.scaleY;
			this.hp = -1;
			this.hpMax = health;
			//this.damage = damageIn;
			this.rotation = degreein; // this will actually set direction
			this.gotoAndPlay(1);
		}
	}
}