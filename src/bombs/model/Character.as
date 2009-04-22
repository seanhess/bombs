package bombs.model
{
	import mx.core.IUID;
	
	[Bindable]
	public class Character extends Token
	{
		public var name:String;
		
		// Where are we going?
		public var destinationX:int;
		public var destinationY:int;
	}
}