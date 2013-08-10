package
{
	import com.iwi.gamecraft.game.GameView;
	import com.iwi.gamecraft.game.audiointerface.IPlaysBackingTrack;
	import com.iwi.gamecraft.game.audiointerface.SoundManager;
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import flash.media.Sound;
	
	import starling.display.Sprite;

	public class Game extends Sprite implements IHiScoreView, IPlaysBackingTrack
	{
		public static const GAME_SONG:String = "Game song";
		public static const GAME_SONG_FILE:String = "The_Down_Beat";
		
		private var gameView:GameView;
		public static var GAME_OVER:String = "game over ";
		
		public function Game()
		{
			super();
			init();
		}
		
		private function init():void
		{
			soundManager = new SoundManager();
			
			gameView = new GameView();
			addChild(gameView);
		}
				
		public function setScoreList(scoreList:HiScoreList):void
		{
			gameView.setScoreList(scoreList);			
		}

		public function playBackingTrack():void
		{
			var song:Sound = GameCraft.assetManager.getSound(GAME_SONG_FILE); 
			soundManager.addSound(GAME_SONG, song);
			if (soundManager.soundIsAdded(GAME_SONG))
			{
				soundManager.playSound(GAME_SONG, 1, 5, 0);
			}
			else
			{
				trace("sound manager game fail");
			}
		}
		
		public function stopBackingTrack():void
		{
			if (soundManager.soundIsPlaying(GAME_SONG))
			{
				soundManager.stopSound(GAME_SONG);
			}
		}
	}
}