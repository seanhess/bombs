package bombs.util
{
	import bombs.model.Character;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Checks to see whether a character is inactive
	 * or not. If inactive, we'll mark it for instant
	 * bombing!
	 * 
	 * Or, we could just remove them. That's probably
	 * a better idea. Boring! Yeah, but it makes sense
	 */
	public class CharacterTimer extends EventDispatcher
	{
		public static const SECONDS:int = 20;
		public static const INACTIVE:String = "inactive";
		 
		public var char:Character;
		
		private var timer:Timer;
		private var count:int = 0;
		
		public function checkInactivity(char:Character):void
		{
			this.char = char;
			count = 0;
			
			timer = new Timer(1000, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start(); 
		}
		
		public function active():void
		{
			count = 0;
		}
		
		private function onTimer(event:Event):void
		{
			count++;

			if (count >= SECONDS)
				onInactive();				
		}
		
		private function onInactive():void
		{
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer.stop();
			dispatchEvent(new Event(INACTIVE));
		}
		
		
	}
}