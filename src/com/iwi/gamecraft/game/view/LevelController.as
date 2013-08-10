package com.iwi.gamecraft.game.view
{
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.character.RunningCharacter;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;

	public class LevelController
	{
		private var _character:Character;
		private var _aiCharacter:Character;
		private var _platforms:PlatformView;
		
		private var _currentHiddingSpot:int = 0;
		
		public function LevelController(character:Character, aiCharacter:RunningCharacter, platforms:PlatformView)
		{
			_character = character;
			_aiCharacter = character;
			_platforms = platforms;
			init();
		}
		
		private function init():void
		{
			_platforms.getNextHiddingSpot(_currentHiddingSpot);
			_currentHiddingSpot++;
		}
	}
}