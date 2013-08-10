package com.iwi.gamecraft.game
{
	import com.iwi.gamecraft.game.gameobjects.Character;
	
	import starling.display.Sprite;
	
	public class GameView extends Sprite
	{
		public function GameView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			initCharacter();
		}
		
		private function initCharacter():void
		{
			var character:Character = new Character();
			addChild(character);
		}
	}
}