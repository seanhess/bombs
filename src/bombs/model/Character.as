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
		// This also tells us the last place we'd expect them to be
		public var destinationX:int = -1;
		public var destinationY:int = -1;
	}
}