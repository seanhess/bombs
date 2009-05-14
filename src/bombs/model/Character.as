package bombs.model
{
	import flash.geom.Rectangle;
	
	/**
	 * Have it store startX and startY on here, but only use them if they change and if x and y aren't currently
	 * set. Use the view's x and y to determine where it actually is? Or something?
	 * 
	 * Shoot I don't know :)
	 * 
	 */
	
	[Bindable]
	public class Character
	{
		public var name:String;
		
		public var radius:int = 20; // square half-width
		
		// Where are we going?
		public var destinationX:int = -1;
		public var destinationY:int = -1;
		
		// these values are not shared.. only used on the client to know where to lay bombs
		public var locationX:int = -1;
		public var locationY:int = -1;
		
		public var dead:Boolean = false;
		
		public var bombs:int = 3;
		
		public var kills:int = 0;
		
		public var avatar:String;
		
		public function get space():Rectangle
		{
			return new Rectangle(locationX - radius, locationY - radius, 2*radius, 2*radius);
		}
	}
}