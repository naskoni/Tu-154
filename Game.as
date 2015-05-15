﻿package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.media.*;

	public class Game extends MovieClip
	{
		private var myPlane:Plane;
		private var clouds:Array;
		private var cloudsGenerator:CloudsGenerator;
		private var fuels:Array;
		private var fuelGenerator:FuelGenerator;
		private var points:Number;
		private var myPlanePoint:Point;
		private var music:Sound;
		private var collectSound:CollectSound;
		private var soundChannel:SoundChannel;

		static const TOLERANCE:Number = 1;
		static const RANDOM_CHANCE:Number = 0.04;
		static const END_X:Number = 600;
		static const SPEED:Number = 8;
		static const START_POINTS:Number = 10;
		static const PASS_CLOUD:Number = 30;
		static const HIT_FUEL:Number = 25;

		public function Game()
		{
			myPlane = new Plane();
			clouds = new Array();
			fuels = new Array();
			cloudsGenerator = new CloudsGenerator();
			fuelGenerator = new FuelGenerator();
			music = new Freestyle();
			collectSound = new CollectSound();
		}

		public function startGame()
		{
			stage.addChild(myPlane);
			stage.addEventListener(Event.ENTER_FRAME,updateGame);
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
				var cloud = cloudsGenerator.makeClouds();
				clouds.push(cloud);
				stage.addChildAt(cloud, 2);
			}
			moveObjects(clouds);			
						
			// fuel
			if (Math.random() < RANDOM_CHANCE)
			{	
				var fuel = fuelGenerator.makeFuel();
				fuels.push(fuel);
				stage.addChildAt(fuel, 2);
			}
			moveObjects(fuels);
						
			// collisions
			myPlanePoint = new Point(myPlane.x, myPlane.y);
			
			for (var j = clouds.length-1; j >= 0; j--)
			{
				var cloudPoint:Point = new Point(clouds[j].x, clouds[j].y);
				if (Point.distance(myPlanePoint,cloudPoint) < PASS_CLOUD)
    			{
                	points--;
				}
			}
			
			for (var l = fuels.length-1; l >= 0; l--)
			{
				var fuelPoint:Point = new Point(fuels[l].x, fuels[l].y);
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
		
		private function moveObjects(arr:Array)
		{
			for (var i = arr.length-1; i >= 0; i--)
			{
				arr[i].x += SPEED;
				if (arr[i].x > END_X)
				{
					stage.removeChild(arr[i]);
					arr.splice(i,1);
				}
			}
		}
	}
}