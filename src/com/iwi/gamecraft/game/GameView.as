package com.iwi.gamecraft.game
{
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.hiscore.HiScoreView;
	import com.iwi.gamecraft.game.hiscore.Hiscore;
	import com.iwi.gamecraft.game.view.LevelView;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameView extends Sprite implements IAnimatable, IHiScoreView
	{
		private static const TICK_TIME:Number = 1/60;		//60 fps
		
		private var timeSoFar:Number = 0;
		
		private var character:Character;
		
		private var levelView:LevelView;
		
		private var scoreView:HiScoreView;
						
		public function GameView()
		{
			super();
			scoreView = new HiScoreView();
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
			Starling.juggler.add( this );
			
			addChild(scoreView);
		}
		
		public function advanceTime(delta:Number):void
		{
			timeSoFar += delta;
			scoreView.hiScore.score += delta;
			scoreView.refreshScoreList();
			
			if(timeSoFar >= TICK_TIME)
			{
				levelView.tick(1);
				timeSoFar -= TICK_TIME;
			}
		}
		
		private function refreshScoreList():void
		{
			scoreView.refreshScoreList();
		}
		
		public function setScoreList(scoreList:HiScoreList):void
		{
			scoreView.setScoreList(scoreList);			
		}
	}
}