package
{
	import com.iwi.gamecraft.game.GameView;
	import com.iwi.gamecraft.game.InputController;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var gameView:GameView = new GameView();
			addChild(gameView);
		}
	}
}