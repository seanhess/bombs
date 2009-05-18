package bombs.util
{
	import bombs.model.Bomb;
	

	/**
	 * Bombs need to ignore retracts from the server, issue
	 * their own remove command when they blow up.
	 */
	public class SharedBombList extends SimpleSharedList
	{
		/**
		 * Called when a retract comes in from the server. We don't
		 * want to remove the bomb from our list until it has 
		 * finished exploding
		 */
		override protected function issueRemove(id:String):void
		{
			// ignore
		}
		
		/**
		 * When a bomb finishes exploding, the shared list should 
		 * issue events that get the view to remove it.
		 */
		public function bombDoneExploding(bomb:Bomb):void
		{
			super.issueRemove(bomb.id);
		}
	}
}