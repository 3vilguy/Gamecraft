package com.iwi.gamecraft.game.factory
{
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class PlatformViewFactory
	{
		public function PlatformViewFactory()
		{
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
			for(var i:int = 0; i<length; i++)
			{
				var obj:DisplayObject = levelClass.getChildAt(i);
				trace( obj, obj.name, typeof obj);
				
				if(obj is Platform_SWC)
				{
					trace("WEEEEE", obj.name, "("+obj.x+","+obj.y+") => ", obj.width, obj.height);
					var instanceName:String = null;
					if(obj.name != "SKIP")
					{
						platformID++;
						instanceName = "platform_"+platformID
					}
					
					platformView.addPlatform(obj.width, obj.height, obj.x, obj.y, instanceName);
				}
			}
			
			return platformView;
		}
	}
}