package com.iwi.gamecraft.game
{
	import com.iwi.gamecraft.game.chase.ChaseMessage;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.hiscore.HiScoreView;
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
		
		private var currentLevel:int;
		public var levelView:LevelView;
		
		private var scoreView:HiScoreView;
		
		private var chaseMessage:ChaseMessage;
		
		
		public function GameView()
		{
			super();
			scoreView = new HiScoreView();
			chaseMessage = new ChaseMessage();
			chaseMessage.setText("After him!");
			
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
			levelView.sigComplete.add(handleLevelComplete);
			levelView.y = -20;
			addChild(levelView);

			levelView.addCharcter(character);
			Starling.juggler.add( this );
			
			addChild(scoreView);
			addChild(chaseMessage);
		}
		
		private function handleLevelComplete(result:String):void
		{
			Starling.juggler.remove(this);
			InputController.result = result;
			dispatchEventWith(Game.GAME_OVER, true, "classic");
			removeFromParent(true);
			destroy();
		}
		
		public function advanceTime(delta:Number):void
		{
			timeSoFar += delta;

			scoreView.hiScore.score += delta;
			scoreView.refreshScoreList();
			chaseMessage.refresh(delta);
			
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
		
		public function playBackingTrack():void
		{
			
		}
		
		public function stopBackingTrack():void
		{
			
		}
		
		public function destroy():void
		{
			if(levelView)
			{
				levelView.removeFromParent(true);
				levelView.destroy();
			}
		}
	}
}