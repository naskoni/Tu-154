﻿package src.models
{
	import src.interfaces.IMovable;
	import flash.display.MovieClip;

	// pseudo abstract class
	public class MovableObject extends MovieClip implements IMovable
	{		
		private static const START_Y:Number = 400;
		private static const START_X:Number = -30;				
		
		public function MovableObject()
		{
			this.x = START_X;
			this.y = Math.random() * START_Y;
		}
		
		public function move(speed:Number):void
		{
			this.x += speed;			
		}		
	}

}