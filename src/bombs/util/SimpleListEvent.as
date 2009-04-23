package bombs.util
{
	import flash.events.Event;
	
	public class SimpleListEvent extends Event
	{
		public static const ADD:String = "add";
		public static const REMOVE:String = "remove";
		public static const UPDATE:String = "update";
		public static const RECEIVE:String = "receive";
		
		public var item:*;
		public var update:Object;
		
		public function SimpleListEvent(type:String, item:*, update:Object=null)
		{
			super(type);
			this.item = item;
			this.update = update;
		}
	}
}