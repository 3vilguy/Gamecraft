package
{
	import com.iwi.gamecraft.game.GameView;
	
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