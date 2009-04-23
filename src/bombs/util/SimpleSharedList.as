package bombs.util
{
	import com.adobe.rtc.events.CollectionNodeEvent;
	import com.adobe.rtc.messaging.MessageItem;
	import com.adobe.rtc.session.IConnectSession;
	import com.adobe.rtc.sharedModel.CollectionNode;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Shares a list of stuff on the server
	 * for you. SharedCollection doesn't work
	 * for me because there is no way to do 
	 * updates effectively. This shares add, 
	 * update, and remove without delay, but
	 * it assumes that you will only let one
	 * person change something at a time (if
	 * there are strong owners for a particular
	 * object). 
	 */
	[Event(name="add",type="bombs.util.SimpleListEvent")]
	[Event(name="remove",type="bombs.util.SimpleListEvent")]
	[Event(name="update",type="bombs.util.SimpleListEvent")]
	[Event(name="receive",type="bombs.util.SimpleListEvent")]
	public class SimpleSharedList extends EventDispatcher
	{
		public var node:CollectionNode;
		public var nodeName:String = "list";
		public var idField:String = "id";
		public var itemType:Class;
		
		public var items:Dictionary;
		
		public function SimpleSharedList()
		{
			node = new CollectionNode();
			node.addEventListener(CollectionNodeEvent.ITEM_RECEIVE, onItemReceive);
			node.addEventListener(CollectionNodeEvent.ITEM_RETRACT, onItemRetract);
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
		
		public function set sharedID(value:String):void
		{
			node.sharedID = value;
		}
		
		/**
		 * Updates the item (won't happen if it has been retracted
		 */
		public function update(item:*):void
		{
			var message:MessageItem = new MessageItem(nodeName, null, itemId(item))
				message.body = item;
				
			node.publishItem(message, true);
		}
		
		public function add(item:*):void
		{
			var message:MessageItem = new MessageItem(nodeName, null, itemId(item))
				message.body = item;
				
			node.publishItem(message);
		}
		
		public function remove(item:*):void
		{
			if (contains(item))
				node.retractItem(nodeName, itemId(item));
		}
		
		public function removeAll():void
		{
			for (var id:String in items)
			{
				node.retractItem(nodeName, id);
			}
		}
		
		public function contains(item:*):Boolean
		{
			return (items[itemId(item)] != null);	
		}
		
		private function onItemReceive(event:CollectionNodeEvent):void
		{
			var id:String = event.item.itemID;
			var isNew:Boolean = (items[id] == null);
			var update:Object = event.item.body;
			var item:* = getItem(id);
			
			dispatchEvent(new SimpleListEvent(SimpleListEvent.RECEIVE, item, update));
			
			if (isNew)
				dispatchEvent(new SimpleListEvent(SimpleListEvent.ADD, item));
				
			else
				dispatchEvent(new SimpleListEvent(SimpleListEvent.UPDATE, item));
		}
		
		private function onItemRetract(event:CollectionNodeEvent):void
		{
			var id:String = event.item.itemID;
			var item:* = items[id];
			delete items[id];
			
			dispatchEvent(new SimpleListEvent(SimpleListEvent.REMOVE, item));
		}
	
		protected function itemId(item:*):String
		{
			return item[idField];
		}
		
		protected function getItem(id:String):*
		{
			if (items[id] == null)
			{
				var item:* = new itemType();
					item[idField] = id;
					
				items[id] = item;
			}
			
			return items[id];
		}
			
		
	}
}