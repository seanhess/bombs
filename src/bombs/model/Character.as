package bombs.model
{
	import mx.core.IUID;
	
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
		
		// Where are we going?
		public var destinationX:int = -1;
		public var destinationY:int = -1;
		
		// these values are not shared.. only used on the client to know where to lay bombs
		public var locationX:int = -1;
		public var locationY:int = -1;
	}
}