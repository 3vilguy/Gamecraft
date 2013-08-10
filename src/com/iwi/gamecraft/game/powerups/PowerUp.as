package com.iwi.gamecraft.game.powerups
{
	public class PowerUp
	{
		public static const powerUpTime:Number = 5;
		public static var timeRemaining:Number = 0;
		public static var probability:Number = 0.1;
		
		public static var gapCounter:int = 0;
		public static const gap:int = 5;
		
		public var powerUpType:String;
		public var heightAbovePlatform:int;
				
		public function PowerUp()
		{
			heightAbovePlatform = 200 * Math.random();
			
			var type:int = Math.random() * 3;
			switch (type)
			{
				case 0:
					powerUpType = PowerUpTypes.POWERUP_JUMP;
					break;
				case 1:
					powerUpType = PowerUpTypes.POWERUP_FAST;
					break;
				case 2:
					powerUpType = PowerUpTypes.POWERUP_SLOW;
					break;
			}
		}
	}
}