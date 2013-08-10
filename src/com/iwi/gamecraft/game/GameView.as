package com.iwi.gamecraft.game
{
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.view.BaseView;
	import com.iwi.gamecraft.game.view.LevelView;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameView extends Sprite
	{

		private var character:Character;

		private var levelView:LevelView;
		
		
		public function GameView()
		{
			super();
			if(stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, handleStage);
			}
			else
			{
				init();
			}
		}
		
		private function handleStage():void
		{
			new InputController(stage);
			removeEventListener(Event.ADDED_TO_STAGE, handleStage);
			init();
		}
		
		private function init():void
		{
			initCharacter();
			initLevel();
		}
		
		
		private function initCharacter():void
		{
			character = new Character();
		}

		private function initLevel():void
		{
			levelView = new LevelView();
			addChild(levelView);

			levelView.addCharcter(character);
			addEventListener(Event.ENTER_FRAME, handlEnterFrame);
		}
		
		private function handlEnterFrame():void
		{
			levelView.tick(1);
		}
	}
}