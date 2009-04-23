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
		public static const EXPLODE:String = "explode";
		
		public var bomb:Bomb;
		
		public function countDown(bomb:Bomb):void
		{
			this.bomb = bomb;
			var newTimer:Timer = new Timer(bomb.fuse * 1000, 1);
			newTimer.addEventListener(TimerEvent.TIMER, onTimer);
			newTimer.start();
		}
		
		private function onTimer(event:Event):void
		{
			event.target.removeEventListener(TimerEvent.TIMER, onTimer);
			bomb.exploded = true; 
			dispatchEvent(new Event(EXPLODE));
		}
	}
}