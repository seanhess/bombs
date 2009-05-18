package bombs.util
{
	import bombs.model.Bomb;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Counts down past the timer, sets exploded to true
	 * and fires an event
	 */
	[Event(name="explode", type="flash.events.Event")]
	public class BombTimer extends EventDispatcher
	{
		/**
		 * Marks the beginning of an explosion
		 */
		public static const EXPLODE:String = "explode";
		
		/**
		 * Marks the end of an explosion. 
		 */
		public static const DONE_EXPLODING:String = "exploded";
		
		public var bomb:Bomb;
		
		public function countDown(bomb:Bomb):void
		{
			this.bomb = bomb;
			var newTimer:Timer = new Timer(bomb.fuse * 1000, 1);
			newTimer.addEventListener(TimerEvent.TIMER, onExplode);
			newTimer.start();
		}
		
		private function onExplode(event:Event):void
		{
			event.target.removeEventListener(TimerEvent.TIMER, onExplode);
			bomb.exploded = true;  // causes it to show up exploded
			dispatchEvent(new Event(EXPLODE));
		}
		
		public function countExplosion(bomb:Bomb):void
		{
			this.bomb = bomb;
			var newTimer:Timer = new Timer(bomb.explosion * 1000, 1);
			newTimer.addEventListener(TimerEvent.TIMER, onExploded);
			newTimer.start();
		}
		
		private function onExploded(event:Event):void
		{
			event.target.removeEventListener(TimerEvent.TIMER, onExploded);
			dispatchEvent(new Event(DONE_EXPLODING));
		}
	}
}