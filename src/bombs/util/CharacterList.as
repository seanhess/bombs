package bombs.util
{
	import bombs.model.Character;
	
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.IConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	[Event(name="add",type="bombs.util.SimpleListEvent")]
	[Event(name="remove",type="bombs.util.SimpleListEvent")]
	[Event(name="update",type="bombs.util.SimpleListEvent")]
	public class CharacterList extends EventDispatcher
	{
		public var node:CollectionNode;
		public var characters:Dictionary;
		
		public function CharacterList()
		{
			node = new CollectionNode();
			node.sharedID = "characters";
			node.addEventListener(CollectionNodeEvent.ITEM_RECEIVE, onItemReceive);
			node.addEventListener(CollectionNodeEvent.NODE_DELETE, onCharDelete);
			characters = new Dictionary(true);
		}
		
		public function get items():Dictionary
		{
			return characters;
		}
		
		public function set session(value:IConnectSession):void
		{
			node.connectSession = value;
		}
		
		public function subscribe():void
		{
			node.subscribe();
		}
		
		/**
		 * Called when you join the game
		 */
		public function create(character:Character):void
		{
			var info:Object = {
				avatar: character.avatar,
				name: character.name
			};
			
			var message:MessageItem = new MessageItem(character.name, info, "info");
			node.publishItem(message);
			
			move(character, false);
			kills(character, false);
		}
		
		public function move(character:Character, update:Boolean = true):void
		{
			var dest:Point = new Point(character.destinationX, character.destinationY);
			var message:MessageItem = new MessageItem(character.name, dest, "dest");
			node.publishItem(message, update);
		}
		
		public function kills(character:Character, update:Boolean = true):void
		{
			var message:MessageItem = new MessageItem(character.name, character.kills, "kills");
			node.publishItem(message, update);
		}
		
		public function remove(character:Character):void
		{
			trace("Character REMOVE " + character.name);
			node.removeNode(character.name);
		}
		
		private function onItemReceive(event:CollectionNodeEvent):void
		{
			var message:MessageItem = event.item;
			var name:String = event.nodeName;
			var type:String = message.itemID;
			var character:Character = getCharacter(name);

			trace("Character Update: " + name + " " + type); 
			
			switch (type)
			{
				case "info":
					character.avatar = message.body.avatar;
					character.name = message.body.name;
					dispatchEvent(new SimpleListEvent(SimpleListEvent.ADD, character));
					break;
				case "dest":
					character.destinationX = message.body.x;
					character.destinationY = message.body.y;
					break;
				case "kills":
					character.updateKills(message.body as int);
					break;
				default:
					throw new Error("Character update of type: " + type);
			}
			
			dispatchEvent(new SimpleListEvent(SimpleListEvent.UPDATE, character));
		}
		
		private function onCharDelete(event:CollectionNodeEvent):void
		{
			
			var name:String = event.nodeName;
			var char:Character = characters[name];

			trace("Character Delete " + name);
			delete characters[name];
			
			dispatchEvent(new SimpleListEvent(SimpleListEvent.REMOVE, char));
		}
		
		private function getCharacter(name:String):Character
		{
			if (characters[name] == null)
			{
				characters[name] = new Character();
			}
			
			return characters[name];
		}
		
		
	}
}