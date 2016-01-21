package src.core
{
	import src.models.MovableObject;
	import src.interfaces.ICreatable;

	public class GameObjectFactory implements ICreatable
	{
		public function create(gameObjectType:String)
		{
			var gameObject:MovableObject;
			switch (gameObjectType)
			{
				case "cloud" :
					gameObject = new Cloud();
					break;
				case "fuel" :
					gameObject = new Fuel();
					break;
				default :
					throw new ArgumentError("Unknown object type");
			}

			return gameObject;
		}
	}

}