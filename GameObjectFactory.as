package  {
	import flash.display.MovieClip;
	
	public class GameObjectFactory {

		private static const START_Y:Number = 400;
		private static const START_X:Number = -30;
		
		public function GameObjectFactory() {
			// constructor code
		}		
		
		public function create(objectType:String) {
			var gameObject:MovieClip;
			switch (objectType) {
				case "cloud" :
					gameObject = new Cloud();
					break;				
				case "fuel" :
					gameObject = new Fuel();
					break;
				default:
					throw new ArgumentError("Unknown object type");
			}
			
			gameObject.y = Math.random() * START_Y;
			gameObject.x = START_X;
			
			return gameObject;
		}
	}
	
}
