package com.iwi.gamecraft.game.hiscore
{	
	import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
	
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class HiScoreView extends Sprite implements IHiScoreView
	{
		public var hiScore:Hiscore;
		public var hiScoreList:HiScoreList;
		private var textField:TextField;
		
		public function HiScoreView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			hiScore = new Hiscore();
			hiScore.name = "Player";
			
			var	displayString:String = "";
			displayString += hiScore.score;
			
<<<<<<< HEAD
			textField = new TextField(400, 200, displayString, "Ubuntu", 18, 0x0c839f);
			textField.x = (textField.width + 25);
			textField.y = -30;
=======
			textField = new TextField(400, 200, displayString, "Desyrel", (BitmapFont.NATIVE_SIZE * 0.75), 0xffffff);
			textField.x = -60;//(Constants.STAGE_WIDTH - textField.width);
			textField.y = -60;
>>>>>>> e6774eabd71bd5991072db4e08bb72c718cc11ff
			
			addChild(textField);
		}
				
		public function refreshScoreList():void
		{			
			var	displayString:String = "";
			if (hiScoreList != null && hiScoreList.hiScoreArray[0] != hiScore)
			{
				displayString += hiScoreList.nameToBeat(hiScore) + " (" + hiScoreList.scoreToBeat(hiScore) + ") to beat!\n";
			}
			displayString += hiScore.name + "(" + hiScore.displayScore() + ")";
			textField.text = displayString;
		}
		
		public function setScoreList(scoreList:HiScoreList):void
		{
			hiScoreList = scoreList;
			if (! hiScoreList.contains(hiScore))
			{
				hiScore.name = "Player" + (hiScoreList.hiScoreArray.length - 3);
				hiScoreList.pushScore(hiScore);
			}
			refreshScoreList();
		}
		
		public function playBackingTrack():void
		{
			
		}
		
		public function stopBackingTrack():void
		{
			
		}
	}
}