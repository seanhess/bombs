package bombs.util
{
	import bombs.model.Bomb;
	
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.IConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * Bombs need to ignore retracts from the server, issue
	 * their own remove command when they blow up.
	 */
	[Event(name="add",type="bombs.util.SimpleListEvent")]
	[Event(name="remove",type="bombs.util.SimpleListEvent")]
	public class BombList extends EventDispatcher
	{
		public var node:CollectionNode;
		public var nodeName:String = "list";
		public var idField:String = "id";
		public var itemType:Class;
		
		public var items:Dictionary;

		public function BombList()
		{
			node = new CollectionNode();
			node.sharedID = "bombs";
			node.addEventListener(CollectionNodeEvent.ITEM_RECEIVE, onItemReceive);
			items = new Dictionary(true);
		}
		
		public function set session(value:IConnectSession):void
		{
			node.connectSession = value;
		}
		
		public function subscribe():void
		{
			node.subscribe();
		}
		
		public function add(bomb:Bomb):void
		{
			trace("BOMB => " + bomb.owner + " " + bomb.id);
			
			var message:MessageItem = new MessageItem(nodeName, null, bomb.id)
				message.body = bomb;
				
			node.publishItem(message);
		}
		
		public function remove(bomb:Bomb):void
		{
			trace("BOMB Explode :: " + bomb.owner + " " + bomb.id); 
			
			if (contains(bomb))
				node.retractItem(nodeName, bomb.id);
		}
		
		public function removeAll():void
		{
			for (var id:String in items)
			{
				node.retractItem(nodeName, id);
			}
		}
		
		public function contains(bomb:Bomb):Boolean
		{
			return (items[bomb.id] != null);	
		}
		
		public function bombDoneExploding(bomb:Bomb):void
		{
			delete items[bomb.id];
			dispatchEvent(new SimpleListEvent(SimpleListEvent.REMOVE, bomb));
		}
		
		private function onItemReceive(event:CollectionNodeEvent):void
		{			
			var id:String = event.item.itemID;
			var update:Object = event.item.body;
			
			if (items[id] != null)
				throw new Error("Bomb already exists!");
			
			var bomb:Bomb = new Bomb();
				bomb.id = update.id;
				bomb.locationX = update.locationX;
				bomb.locationY = update.locationY;
				bomb.blastRadius = update.blastRadius;
				bomb.fuse = update.fuse;
				bomb.owner = update.owner;
				
			trace("BOMB <= " + bomb.owner + " " + bomb.id); 
			
			items[id] = bomb;
			dispatchEvent(new SimpleListEvent(SimpleListEvent.ADD, bomb));
		}
	}
}