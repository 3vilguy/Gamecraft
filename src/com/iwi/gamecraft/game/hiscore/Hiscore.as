package com.iwi.gamecraft.game.hiscore
{
	public class Hiscore
	{
		public var score:Number;
		public var name:String;

		public function Hiscore()
		{
			super();
			score = 0;
		}
		
		public function displayScore():int
		{
			return score;
		}
	}
}