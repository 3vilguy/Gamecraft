package
{
	import com.iwi.gamecraft.game.GameView;
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.view.scoreInterface;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite implements IHiScoreView
	{
		private var gameView:GameView;
		
		public function Game()
		{
			super();
			init();
		}
		
		private function init():void
		{
			gameView = new GameView();
			addChild(gameView);
		}
				
		public function setScoreList(scoreList:HiScoreList):void
		{
			gameView.setScoreList(scoreList);			
		}

	}
}