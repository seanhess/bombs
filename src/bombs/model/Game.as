package bombs.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	[Bindable]
	public class Game extends EventDispatcher
	{
		public static const ADD_CHAR:String = "addChar";
		public static const REMOVE_CHAR:String = "removeChar";
		
		public var character:Character;
		public var characterName:String;
		
		public function addCharacter(value:Character):void
		{
			character = value;
			dispatchEvent(new Event(ADD_CHAR));
		}
		
		public function removeCharacter(name:String):void
		{
			characterName = name;
			dispatchEvent(new Event(REMOVE_CHAR));
		}
	}
}