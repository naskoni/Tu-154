package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.media.*;
	import src.core.GameObjectFactory;
	import src.models.*;
	import flashx.textLayout.operations.MoveChildrenOperation;

	public class Game extends MovieClip
	{
		private var myPlane:Plane;
		private var clouds:Array;
		private var fuels:Array;
		private var gameObjectFactory:GameObjectFactory;
		private var points:Number;
		private var myPlanePoint:Point;
		private var music:Sound;
		private var collectSound:CollectSound;
		private var soundChannel:SoundChannel;

		private static const TOLERANCE:Number = 1;
		private static const RANDOM_CHANCE:Number = 0.04;
		private static const END_X:Number = 600;
		private static const SPEED:Number = 8;
		private static const START_POINTS:Number = 10;
		private static const PASS_CLOUD:Number = 30;
		private static const HIT_FUEL:Number = 25;

		public function Game()
		{
			myPlane = new Plane();
			clouds = new Array();
			fuels = new Array();
			gameObjectFactory = new GameObjectFactory();
			music = new Freestyle();
			collectSound = new CollectSound();
		}

		public function startGame()
		{
			stage.addChild(myPlane);
			stage.addEventListener(Event.ENTER_FRAME, updateGame);
			points = START_POINTS;
			soundChannel = music.play(0,int.MAX_VALUE);
		}

		private function updateGame(evt:Event)
		{
			// plane
			var currentMouseY = mouseY;
			
			if (currentMouseY - TOLERANCE > myPlane.y)
			{
				myPlane.moveDown();
			}
			else if (currentMouseY + TOLERANCE < myPlane.y)
			{
				myPlane.moveUp();
			}

			// clouds
			if (Math.random() < RANDOM_CHANCE)
			{
				var cloud = gameObjectFactory.create("cloud");
				clouds.push(cloud);
				stage.addChildAt(cloud, 2);
			}

			for (var i = clouds.length-1; i >= 0; i--)
			{
				clouds[i].move();
				if (clouds[i].x > END_X)
				{
					stage.removeChild(clouds[i]);
					clouds.splice(i,1);
				}
			}
			
			// fuel
			if (Math.random() < RANDOM_CHANCE)
			{
				var fuel = gameObjectFactory.create("fuel");
				fuels.push(fuel);
				stage.addChildAt(fuel, 2);
			}

			for (i = fuels.length-1; i >= 0; i--)
			{
				fuels[i].move();
				if (fuels[i].x > END_X)
				{
					stage.removeChild(fuels[i]);
					fuels.splice(i,1);
				}
			}

			// collisions
			myPlanePoint = new Point(myPlane.x,myPlane.y);

			for (var j = clouds.length-1; j >= 0; j--)
			{
				var cloudPoint:Point = new Point(clouds[j].x,clouds[j].y);
				if (Point.distance(myPlanePoint,cloudPoint) < PASS_CLOUD)
				{
					points--;
				}
			}

			for (var l = fuels.length-1; l >= 0; l--)
			{
				var fuelPoint:Point = new Point(fuels[l].x,fuels[l].y);
				if (Point.distance(myPlanePoint,fuelPoint) < HIT_FUEL)
				{
					stage.removeChild(fuels[l]);
					fuels.splice(l,1);
					collectSound.play();
					points++;
				}
			}

			txtScore.text = String(points);
		}		
	}
}