package bombs.model
{
	[Bindable]
	public class Bomb
	{
		public var id:String = Math.random().toString();
		public var locationX:int = -1;
		public var locationY:int = -1;
	}
}