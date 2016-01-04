package {

	import flash.display.MovieClip;


	public class Plane extends MovieClip {
		private static const SPEED:Number = 2;

		public function Plane() {
			x = 455;
			y = 200;
		}

		public function moveUp() {
			y -=  SPEED;
		}

		public function moveDown() {
			y +=  SPEED;
		}
	}

}