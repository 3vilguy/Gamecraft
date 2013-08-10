package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	
	import starling.display.Sprite;
	
	public class PlatformView extends GameObject
	{
		private var _aiPlatforms:Vector.<Platform>;
		private var _platforms:Vector.<Platform>;
		private var _hiddingSpots:Array;
		private var parentContainer:Sprite;
		
		private var closestPlatform:Platform;
		
		
		public function PlatformView()
		{
			super();
			init();
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
		
		public function start():void
		{
			if(_platforms && _platforms.length)
			{
				closestPlatform = _platforms[0];
			}
			
			parentContainer = this.parent as Sprite;
		}
		
		override public function tick(frames:int):void
		{
			super.tick(frames);
			
			if(closestPlatform)
			{
				//trace("closestPlatform  =>", parentContainer, closestPlatform.x, " || ", parentContainer.x, " => ", -(closestPlatform.x+closestPlatform.width) );
				if(-(closestPlatform.x+closestPlatform.width) > parentContainer.x)
				{
					unflatten();
					//trace("REMOVE MEEE!!!", _platforms.length);
					closestPlatform.removeFromParent(true);
					closestPlatform.destroy();
					
					_platforms.splice(0, 1);
					//trace("REMOVE MEEE PO!!!", _platforms.length);
					
					closestPlatform = _platforms[0];
					
					addPlatformAtEnd();
					
					//trace("REMOVE MEEE PO PO!!!", _platforms.length);
				}
			}
		}
		
		private function addPlatformAtEnd():void
		{
			var lastObj:Platform = _platforms[ _platforms.length-1 ];
			var lastY:int = lastObj.y;
			
			lastY += int(Math.random()*12)%3 == 0 ?  50 : -50;
			lastY += Math.random() * 50 - 25;
			
			if(lastY < 50)
				lastY = StageSize.HEIGHT - 60;
			
			if(lastY > StageSize.HEIGHT - 60)
				lastY = StageSize.HEIGHT - 100;
			
			addPlatform(150 ,20, lastObj.x + 200 + Math.random()*100, lastY, PlatformTypes.PLATFORM_AI, "name");
			
			flatten();
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