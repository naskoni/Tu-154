package 
{

	public class FuelGenerator
	{

		static const FUEL_START_Y:Number = 400;
		static const FUEL_START_X:Number = -30;
		
		public function FuelGenerator()
		{
			
		}
		
		public function makeFuel()
		{
			var newFuel:Fuel = new Fuel();
			newFuel.y = Math.random() * FUEL_START_Y;
			newFuel.x = FUEL_START_X;
			return newFuel;
		}

	}

}