package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	import com.iwi.gamecraft.game.view.LevelView;
	
	import flash.utils.getTimer;
	
	public class PlatformView extends GameObject
	{
		private var _aiPlatforms:Vector.<Platform>;
		private var _platforms:Vector.<Platform>;
		private var _hiddingSpots:Array;
		private var _levelView:LevelView;

		private var CHECK_TIME:int = 1000;

		private var lastCheck:int;
		
		public function PlatformView(levelView:LevelView)
		{
			super();
			init();
			_levelView = levelView;
		}
		
		private function init():void
		{
			_aiPlatforms = new Vector.<Platform>();
			_platforms = new Vector.<Platform>();
			_hiddingSpots = [];
			//addMockPlatforms();
		}
		
		private function addMockPlatforms():void
		{
			var platform:Platform;
			for(var i:int = 0 ; i < 50; i++)
			{
				platform = new Platform(400,20, i);
				platform.x = i * 550;
				platform.y = StageSize.HEIGHT / 2;
				platform.y += i%2 ? 40 : 80;
				addChild(platform);
				_platforms.push(platform);
			}
		}
		
		public function addRandomPlatform():void
		{
//			trace('adding');
//			var lastY:int = StageSize.HEIGHT / 2;
//			var lastX:int = _platforms[_platforms.length-1].x;
//			for(var i:int = 0; i< 100; i++)
//			{
//				lastY += int(Math.random()*12)%3 == 0 ?  50 : -50;
//				lastY += Math.random() * 50 - 25;
//				if(lastY < 50)
//					lastY = StageSize.HEIGHT - 60;
//				if(lastY > StageSize.HEIGHT - 60)
//					lastY = StageSize.HEIGHT - 120;
//				addPlatform(150,20,lastX+ i * 200 + Math.random()*100, lastY, PlatformTypes.PLATFORM_AI, "name");
//			}
//			flatten();
		}
		
		public function addPlatform(pWidth:Number, pHeight:Number, px:Number, py:Number, platformType:String, instanceName:String = null):void
		{
			//trace("ADDING =>", platformType, instanceName);
			var platform:Platform = new Platform(pWidth, pHeight, _platforms.length);
			platform.x = px;
			platform.y = py;
			
			if(instanceName)
			{
				platform.name = instanceName;
				_aiPlatforms.push(platform);
			}
			
			_platforms.push(platform);
			
			if(platformType == PlatformTypes.PLATFORM_HIDDEN)
				_hiddingSpots.push(platform);
			
			addChild(platform);
		}
		
		
		public function get platforms():Vector.<Platform>
		{
			return _platforms;
		}

		public function set platforms(value:Vector.<Platform>):void
		{
			_platforms = value;
		}
		
		public function getNextHiddingSpot(index:int):Platform
		{
			if(index > _hiddingSpots.length)
				return _hiddingSpots[index];
			return _hiddingSpots[length];
		}
		
		override public function tick(frames:int):void
		{
			var len:int = _platforms.length;
			
			
			if(getTimer() - lastCheck > CHECK_TIME)
			{
//				lastCheck = getTimer();
//				for(var i:int = 0 ; i< len;i++)
//				{
//					var platformItme:Platform = _platforms[i];
//					if(platformItme.x + platformItme.width < -_levelView.platformContainer.x)
//					{
//						if(platformItme.parent)
//							platformItme.parent.removeChild(platformItme);
//						_platforms.splice(i,1);
//						addRandomPlatform();
//						i--;
//						len--;
//					}
//				}
			}
//			trace(" PSO " + _levelView.platformContainer.x + " : : " + (_platforms[0].x + _platforms[0].width));
		}

		public function get aiPlatforms():Vector.<Platform>
		{
			return _aiPlatforms;
		}

		public function set aiPlatforms(value:Vector.<Platform>):void
		{
			_aiPlatforms = value;
		}

		public function get hiddingSpots():Array
		{
			return _hiddingSpots;
		}

		public function set hiddingSpots(value:Array):void
		{
			_hiddingSpots = value;
		}


	}
}