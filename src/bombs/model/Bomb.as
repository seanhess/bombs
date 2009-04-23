package bombs.model
{
	[Bindable]
	public class Bomb
	{
		public var id:String = Math.random().toString();
		public var locationX:int = -1;
		public var locationY:int = -1;
		
		public var blastRadius:int = 20; // in pixels
		public var fuse:int = 3; // in seconds
		
		public var exploded:Boolean = false;
		
		// does it need an exploded property? // 
		// not really // 
		// As soon as it is created, you start the countdown //
		
		// They're ALL counting down // 
		// When they blow up, check to see if the mainCharacter is in the blast radius //  
		
		// Change it to exploded // 
		// Then remove it? //
		
		// Ignore removes from the server?  // 
		// Never send removes to the server // 
	}
}