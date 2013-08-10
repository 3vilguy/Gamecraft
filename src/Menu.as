package
{
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.hiscore.HiScoreListView;
//	import com.iwi.gamecraft.game.hiscore.Hiscore;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import flash.media.Sound;
	import com.iwi.gamecraft.game.audiointerface.SoundManager;
	import com.iwi.gamecraft.game.audiointerface.IPlaysBackingTrack;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class Menu extends Sprite implements IHiScoreView, IPlaysBackingTrack
	{
		public static const START_GAME:String = "Menu::startGame";
		public static const MENU_SONG:String = "Menu song";
		public static const MENU_SONG_FILE:String = "Cartoon_Journey";
		
		private var soundManager:SoundManager;
		public var hiScoreListView:HiScoreListView;
		
		public function Menu()
		{
			super();
			init();
		}
		
		private function init():void
		{
			soundManager = new SoundManager();

			var textField:TextField = new TextField(250, 50, "MAIN MENU", "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
			textField.y = 20;
			addChild(textField);
			
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "Start");
			button.fontName = "Ubuntu";
			button.fontSize = 16;
			button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
			button.y = Constants.STAGE_HEIGHT * 0.75;
			button.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(button);
						
			hiScoreListView = new HiScoreListView();
			addChild(hiScoreListView);
		}
		
		private function onButtonTriggered():void
		{
			dispatchEventWith(START_GAME, true, "classic");
		}
		
		private function refreshScoreList():void
		{
			hiScoreListView.refreshScoreList();
		}
	
		public function setScoreList(scoreList:HiScoreList):void
		{
			hiScoreListView.setScoreList(scoreList);
		}
		
		public function playBackingTrack():void
		{
			var song:Sound = GameCraft.assetManager.getSound(MENU_SONG_FILE); 
			soundManager.addSound(MENU_SONG, song);
			if (soundManager.soundIsAdded(MENU_SONG))
			{
				soundManager.playSound(MENU_SONG, 1, 5, 0);
			}
			else
			{
				trace("sound manager menu fail");
			}
		}
		
		public function stopBackingTrack():void
		{
			if (soundManager.soundIsPlaying(MENU_SONG))
			{
				soundManager.stopSound(MENU_SONG);
			}
		}
	}
}