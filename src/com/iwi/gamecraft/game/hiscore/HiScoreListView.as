package com.iwi.gamecraft.game.hiscore
{	
	import flash.text.engine.TextBaseline;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	public class HiScoreListView extends Sprite
	{
		public var hiScoreList:HiScoreList;
		public var hiScoreTextFields:Array;
		
		public function HiScoreListView()
		{
			super();
			hiScoreList = new HiScoreList();
			hiScoreTextFields = new Array();
		}
		
		public function alignTextField(hiScoreIndex:int, total:int, textField:TextField):void
		{
			var width:int = Constants.STAGE_WIDTH / 2;

			if (total < 7)
			{
				textField.x = width - (textField.width / 2);
			}
			else if (hiScoreIndex < 7)
			{
				textField.x = (width / 2) - (textField.width / 2);				
			}
			else
			{
				textField.x = (width * 3 / 2) - (textField.width / 2);
			}

			textField.y = (40 * (hiScoreIndex % 7)) + 70;
		}
		
		public function setNewTextField(hiScoreIndex:int):void
		{
			var hiscore:Hiscore = hiScoreList.hiScoreArray[hiScoreIndex] as Hiscore;
			var displayString:String = hiscore.name + " " + int(hiscore.score);
			
			var width:int = Constants.STAGE_WIDTH / 2;
			
			var textField:TextField = new TextField(width, 50, displayString, "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			alignTextField(hiScoreIndex, hiScoreList.hiScoreArray.length, textField);

			
			hiScoreTextFields.push(textField);
			addChild(textField);
		}
		
		public function refreshScoreList():void
		{
			var i:int = 0;
			for (; i < hiScoreList.hiScoreArray.length; i++)
			{
				if (i < 14)
				{
					if (i >= hiScoreTextFields.length)
					{
						setNewTextField(i);	
					}
					else
					{
						var hiscore:Hiscore = hiScoreList.hiScoreArray[i] as Hiscore;
						var displayString:String = hiscore.name + " " + int(hiscore.score);
					
						hiScoreTextFields[i].text = displayString;
						alignTextField(i, hiScoreList.hiScoreArray.length, hiScoreTextFields[i]);
					}
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

