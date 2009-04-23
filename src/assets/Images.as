package assets
{
	import assets.TokenAssets;
	
	import flash.utils.Dictionary;
	
	public class Images
	{
		public static const BOY_PATH:String = "body";
		public static const CAT_GIRL_PATH:String = "catgirl";
		public static const HORN_GIRL_PATH:String = "horngirl";
		public static const PINK_GIRL_PATH:String = "pinkgirl";
		public static const PRINCESS_GIRL_PATH:String = "princessgirl";
		
		public static const CIRCLE_PATH:String = "circle";
		public static const SPLAT_PATH:String = "splat";
		public static const DEATH_EYES_PATH:String = "death";
		public static const TIMER_PATH:String = "timer";
		
		public var images:Dictionary;
		
		public function Images()
		{
			images = new Dictionary(true);
			
			images[BOY_PATH] = TokenAssets.BOY;
			images[CAT_GIRL_PATH] = TokenAssets.CAT_GIRL;
			images[HORN_GIRL_PATH] = TokenAssets.HORN_GIRL;
			images[PINK_GIRL_PATH] = TokenAssets.PINK_GIRL;
			images[PRINCESS_GIRL_PATH] = TokenAssets.PRINCESS_GIRL;
		
			images[CIRCLE_PATH] = TokenAssets.CIRCLE;
			images[SPLAT_PATH] = TokenAssets.SPLAT;
			images[DEATH_EYES_PATH] = TokenAssets.DEATH_EYES;
			images[TIMER_PATH] = TokenAssets.TIMER;
		}
		
		public function getSource(path:String):Class
		{
			return images[path];
		}
	}
}