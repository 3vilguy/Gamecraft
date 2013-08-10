package
{
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.audiointerface.IPlaysBackingTrack;
	import com.iwi.gamecraft.game.audiointerface.SoundManager;
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.hiscore.HiScoreListView;
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import flash.media.Sound;
	import flash.text.Font;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class Menu extends Sprite implements IHiScoreView, IPlaysBackingTrack
	{
		// We embed the "Ubuntu" font. Beware: the 'embedAsCFF'-part IS REQUIRED!!!
		[Embed(source="/fonts/sharkformalfunnyness.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
		private static const sharko:Class;
		
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

			var charImg:Image = new Image( GameCraft.assetManager.getTexture("selecttarget") );
			addChild(charImg);
			
			var font:Font = new sharko();
			trace('name ', font.fontName);
			var textField:TextField = new TextField(250, 50, "MAIN MENU", font.fontName,28,0x0c839f);
			textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
			textField.y = 20;
			addChild(textField);
			
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "Start Guy");
			button.fontName = "Ubuntu";
			button.fontSize = 16;
			button.x = int((Constants.STAGE_WIDTH - button.width) / 2) + 180;
			button.y = Constants.STAGE_HEIGHT * 0.75;
			button.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(button);
			
			var button2:Button = new Button(Root.assets.getTexture("button_normal"), "Start Girl");
			button2.fontName = "Ubuntu";
			button2.fontSize = 16;
			button2.x = int((Constants.STAGE_WIDTH - button2.width) / 2) - 180;
			button2.y = Constants.STAGE_HEIGHT * 0.75; 
			button2.addEventListener(Event.TRIGGERED, onButtonTriggeredGuy);
			addChild(button2);
						
			hiScoreListView = new HiScoreListView();
			addChild(hiScoreListView);
		}
		
		private function onButtonTriggeredGuy():void
		{
			InputController.character = "man";
			dispatchEventWith(START_GAME, true, "classic");
		}
		
		private function onButtonTriggered():void
		{
			InputController.character = "woman";
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