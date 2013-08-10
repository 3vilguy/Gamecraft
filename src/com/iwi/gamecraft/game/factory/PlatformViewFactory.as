package com.iwi.gamecraft.game.factory
{
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformTypes;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	import com.iwi.gamecraft.game.view.LevelView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class PlatformViewFactory
	{
		private var _levelView:LevelView;
		public function PlatformViewFactory(levelView:LevelView)
		{
			_levelView = levelView;
		}
		
		public function getPlatformView(currentLevel:int):PlatformView
		{
			var levelClass:Sprite;
			
			switch(currentLevel)
			{
				case 1:
					levelClass = new Level1();
					break;
				
				default:
					return new PlatformView();
			}
			
			return parseLevelClass(levelClass);
		}
		
		
		private function parseLevelClass(levelClass:Sprite):PlatformView
		{
			var platformView:PlatformView = new PlatformView();
			
			trace("Ohai Parse =>", levelClass.numChildren, "elements.");
			
			var length:int = levelClass.numChildren;
			var platformID:int = 0;
			var platformType:String;
			for(var i:int = 0; i<length; i++)
			{
				var obj:DisplayObject = levelClass.getChildAt(i);
				//trace( obj, obj.name);
				
				platformType = PlatformTypes.PLATFORM_CLASSIC;
				
				if(obj is Platform_SWC)
				{
					//trace("PLATFORM INFO", obj.name, "("+obj.x+","+obj.y+") => ", obj.width, obj.height);
					var instanceName:String = null;
					if(obj.name != "SKIP")
					{
						platformID++;
						instanceName = "platform_"+platformID;
						platformType = PlatformTypes.PLATFORM_AI;
					}
					if(obj.name == "HIDDEN")
					{
						platformType = PlatformTypes.PLATFORM_HIDDEN;
					}
					
					platformView.addPlatform(obj.width, obj.height, obj.x, obj.y, platformType, instanceName);
				}
			}
			
			var lastY:int = StageSize.HEIGHT / 2;
			for(i = 0; i< 15; i++)
			{
				lastY += int(Math.random()*12)%3 == 0 ?  50 : -50;
				lastY += Math.random() * 50 - 25;
				if(lastY < 50)
					lastY = StageSize.HEIGHT - 60;
				if(lastY > StageSize.HEIGHT - 60)
					lastY = StageSize.HEIGHT - 100;
				platformView.addPlatform(150,20,obj.x + i * 200 + Math.random()*100, lastY, PlatformTypes.PLATFORM_AI, "name");
			}
			platformView.aiPlatforms = platformView.aiPlatforms.sort(sortOnName);
			platformView.hiddingSpots = platformView.hiddingSpots.sort(sortOnName);
			platformView.flatten();
			
			return platformView;
		}
		
		private function sortOnName(a:Platform, b:Platform):int
		{
			if(a.x > b.x)
				return 1
			else if(a.x < b.x)
				return -1;
			return 0;
		}
	}
}