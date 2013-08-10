package
{
	import com.bartek.midas.Game;
	import com.iwi.gamecraft.game.InputController;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	public class GameCraft extends Sprite
	{
		private var _starling:Starling;
		public function GameCraft()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.stageWidth = 755;
			stage.stageHeight = 600;
			Starling.handleLostContext = false;
			_starling = new Starling(Game, stage, null, stage.stage3Ds[0] );
			
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.start();	
		}
	}
}