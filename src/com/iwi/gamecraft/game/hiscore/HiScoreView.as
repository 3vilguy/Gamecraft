package com.iwi.gamecraft.game.hiscore
{	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class HiScoreView extends Sprite
	{
		var hiScoreList:HiScoreList;
		var hiScoreTextFields:Array;
		
		public function HiScoreView()
		{
			super();
			hiScoreTextFields = new Array();
		}
		
		public function setNewTextField(hiScoreIndex:int):void
		{
			var hiscore:Hiscore = hiScoreList.hiScoreArray[hiScoreIndex] as Hiscore;
			var displayString:String = hiscore.name + " " + hiscore.score;

			var textField:TextField = new TextField(250, 50, displayString, "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
			textField.y = (20 * hiScoreIndex) + 70;

			hiScoreTextFields.push(textField);
			addChild(textField);
		}
		
		public function refreshScoreList():void
		{
			var i:int = 0;
			for (; i < hiScoreList.hiScoreArray.length; i++)
			{
				if (i > hiScoreTextFields.length)
				{
					setNewTextField(i);	
				}
				else
				{
					var hiscore:Hiscore = hiScoreList.hiScoreArray[i] as Hiscore;
					var displayString:String = hiscore.name + " " + hiscore.score;

					hiScoreTextFields[i].text = displayString;
				}
			}
			for (; i < hiScoreTextFields.length; i++)
			{
				hiScoreTextFields.pop();
			}
		}
		
		public function setScoreList(scoreList:HiScoreList):void
		{
			hiScoreList = scoreList;
			refreshScoreList();
		}
	}
}