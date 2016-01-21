package 
{
	import flash.display.MovieClip;
	import src.interfaces.IMovable;

	public class Plane extends MovieClip
	{
		private static const SPEED:Number = 2;
		private static const START_X = 455;
		private static const START_Y = 200;		

		public function Plane()
		{
			this.x = START_X;
			this.y = START_Y;
		}

		public function moveUp()
		{
			this.y -=  SPEED;
		}

		public function moveDown()
		{
			this.y +=  SPEED;
		}		
	}
}