package
{
	import com.iwi.gamecraft.game.GameView;
	
	import starling.display.Sprite;
	
	public class Menu extends Sprite
	{
		public function Menu()
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