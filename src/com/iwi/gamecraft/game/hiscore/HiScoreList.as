package
{	
	public class HiScoreList
	{
		public var hiScoreArray:Array;
		
		public function HiScoreList()
		{
			hiScoreArray = new Array();
		}
		
		public function sortHiScore(a:Hiscore, b:Hiscore):int
		{
			if (a.score > b.score)
			{
				return -1;
			}
			else if (a.score < b.score)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		
		public function pushScore(hiScore:Hiscore):void
		{
			hiScoreArray.push(hiScore);
			hiScoreArray.sort(sortHiScore);
		}
		
		public function popScore(hiScore:Hiscore):void
		{
			for (var index:int = 0; index < hiScoreArray.length; index++)
			{
				if (hiScoreArray[index] == hiScore)
				{
					hiScoreArray.splice(index, 1);
				}
			}
		}
		
		public function placeOfScore(hiscore:Hiscore):int
		{
			hiScoreArray.sort(sortHiScore);
			for (var i:int = 0; i < hiScoreArray.length; i++)
			{
				if (hiscore == hiScoreArray[i])
				{
					return i;
				}
				if (hiscore.score > hiScoreArray[i].score)
				{
					return i;
				}
			}
			return hiScoreArray.length;
		}
		
		public function scoreToBeat(hiscore:Hiscore):int
		{
			var place:int = placeOfScore(hiscore);
			if (place == 0)
			{
				return hiscore.score;
			}
			else
			{
				var onePlaceDown:int = place - 1;
				return hiScoreArray[onePlaceDown].score;
			}
		}
		
		public function nameToBeat(hiscore:Hiscore):String
		{
			var place:int = placeOfScore(hiscore);
			if (place == 0)
			{
				return hiscore.name;
			}
			else
			{
				var onePlaceDown:int = place - 1;
				return hiScoreArray[onePlaceDown].name;
			}			
		}
		
		public function printScoresInOrder():void
		{
			for (var i:int = 0; i < hiScoreArray.length; i++)
			{
				var current:Hiscore = hiScoreArray[i];
				var report:String = current.name + " " + current.score;
				trace(report);
			}
		}
	}
}