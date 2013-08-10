package com.iwi.gamecraft.game
{
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.view.LevelView;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameView extends Sprite implements IAnimatable
	{
		private static const TICK_TIME:Number = 1/60;		//60 fps
		
		private var timeSoFar:Number = 0;
		
		private var character:Character;
		
		private var currentLevel:int;
		private var levelView:LevelView;
		
		
		public function GameView()
		{
			super();
			
			currentLevel = 1;
			
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
			levelView = new LevelView(currentLevel);
			addChild(levelView);

			levelView.addCharcter(character);
			Starling.juggler.add( this );
		}
		
		public function advanceTime(delta:Number):void
		{
			timeSoFar += delta;
			
			if(timeSoFar >= TICK_TIME)
			{
				levelView.tick(1);
				timeSoFar -= TICK_TIME;
			}
		}
	}
}