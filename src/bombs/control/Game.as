package bombs.control
{
	import bombs.model.Character;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	[Bindable]
	public class Game extends EventDispatcher
	{
		public var characters:IList = new ArrayCollection();
		public var bombs:IList = new ArrayCollection();
		
		public var mainCharacter:Character;
		public var playing:Boolean = false;
		
		public function join(character:Character):void
		{
			mainCharacter = character;
			playing = true;
			
			characters.addItem(mainCharacter);
		}
		
		public function move(x:int, y:int):void
		{
			mainCharacter.destinationX = x;
			mainCharacter.destinationY = y; // share you!
		}
		
		public function layone(x:int, y:int):void
		{
			
		}
		
	}
}