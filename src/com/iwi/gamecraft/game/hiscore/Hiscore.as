package
{
	public class Hiscore extends Object
	{		
		public var score:Number;
		public var name:String;

		public function Hiscore()
		{
			super();
			score = 0;
		}
		
		public function setNewScore(newScore:Number):void
		{
			score = newScore;
		}
	}
}