package
{
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOverView extends Sprite implements IHiScoreView
	{
		private var _sigRestartGame:Signal = new Signal();
		public function GameOverView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "Start");
			button.fontName = "Ubuntu";
			button.fontSize = 16;
			button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
			button.y = Constants.STAGE_HEIGHT * 0.75;
			button.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(button);
			
		}
		
		private function onButtonTriggered():void
		{
			dispatchEventWith(Menu.START_GAME, true, "classic");
		}

		public function get sigRestartGame():Signal
		{
			return _sigRestartGame;
		}

		public function set sigRestartGame(value:Signal):void
		{
			_sigRestartGame = value;
		}
		public function setScoreList(scoreList:HiScoreList):void
		{
//			hiScoreListView.setScoreList(scoreList);
		}
	}
}