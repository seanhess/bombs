package bombs.adapt
{
	import bombs.model.Character;
	
	public class BasicAdapter
	{
		public function getCharacter(from:Object):Character
		{
			var char:Character = new Character();
				char.name = from.name;
				char.locationX = from.locationX;
				char.locationY = from.locationY;
				
			return char;	
		}

	}
}