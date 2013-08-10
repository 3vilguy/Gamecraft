package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	
	public class PlatformView extends GameObject
	{
		private var _platforms:Vector.<Platform>;
		public function PlatformView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_platforms = new Vector.<Platform>();
			//addMockPlatforms();
		}
		
		private function addMockPlatforms():void
		{
			var platform:Platform;
			for(var i:int = 0 ; i < 50; i++)
			{
				platform = new Platform(400,20);
				platform.x = i * 550;
				platform.y = StageSize.HEIGHT / 2;
				platform.y += i%2 ? 40 : 80;
				addChild(platform);
				_platforms.push(platform);
			}
		}
		
		public function addPlatform(pWidth:Number, pHeight:Number, px:Number, py:Number, instanceName:String = null):void
		{
			var platform:Platform = new Platform(pWidth, pHeight);
			platform.x = px;
			platform.y = py;
			if(instanceName) platform.name = instanceName;
			addChild(platform);
			_platforms.push(platform);
		}
		
		
		public function get platforms():Vector.<Platform>
		{
			return _platforms;
		}

		public function set platforms(value:Vector.<Platform>):void
		{
			_platforms = value;
		}
	}
}