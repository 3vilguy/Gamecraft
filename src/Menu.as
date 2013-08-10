package
{
	import com.iwi.gamecraft.game.hiscore.HiScoreList;
	import com.iwi.gamecraft.game.hiscore.HiScoreView;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class Menu extends Sprite
	{
		public static const START_GAME:String = "Menu::startGame";
		
		public var hiScoreView:HiScoreView;
		public var hiScoreList:HiScoreList;
		
		public function Menu()
		{
			super();
			init();
		}
		
		private function init():void
		{
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
			
			hiScoreList = new HiScoreList();
			
			hiScoreView = new HiScoreView();
			hiScoreView.setScoreList(hiScoreList);
			addChild(hiScoreView);
		}
		
		private function onButtonTriggered():void
		{
			dispatchEventWith(START_GAME, true, "classic");
		}
		
		private function refreshScoreList():void
		{
			hiScoreView.refreshScoreList();
		}
	}
}