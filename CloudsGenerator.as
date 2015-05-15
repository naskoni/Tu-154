package 
{
	public class CloudsGenerator
	{
		
		static const CLOUD_START_Y:Number = 400;
		static const CLOUD_START_X:Number = -30;
		
		public function CloudsGenerator()
		{
			
		}

		public function makeClouds()
		{
			var newCloud:Cloud = new Cloud();
			newCloud.y = Math.random() * CLOUD_START_Y;
			newCloud.x = CLOUD_START_X;
			return newCloud;
		}
	}
}