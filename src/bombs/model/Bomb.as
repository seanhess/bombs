package bombs.model
{
	import flash.geom.Rectangle;
	
	[Bindable]
	public class Bomb
	{
		public var id:String = Math.random().toString();
		public var locationX:int = -1;
		public var locationY:int = -1;
		
		public var blastRadius:int = 20; // in pixels
		public var fuse:int = 3; // in seconds
		
		public var owner:String;
		
		public var exploded:Boolean = false;
		
		public function get space():Rectangle
		{
			return new Rectangle(locationX - blastRadius, locationY - blastRadius, 2*blastRadius, 2*blastRadius);
		}
	}
}