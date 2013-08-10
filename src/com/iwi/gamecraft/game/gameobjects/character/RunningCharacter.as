package com.iwi.gamecraft.game.gameobjects.character
{
	import com.iwi.gamecraft.game.gameobjects.components.AutoMoveController;
	import com.iwi.gamecraft.game.gameobjects.components.IMoveController;
	import com.iwi.gamecraft.game.gameobjects.components.MoveController;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	
	import starling.display.Quad;

	public class RunningCharacter extends Character
	{
		private var _platforms:PlatformView;

		private var currentPlatformIndex:int;
		private var VERTICAL_SPEED:Number = 4;
		private var _targetIndex:int;
		public function RunningCharacter(platforms:PlatformView)
		{
			super();
			_platforms = platforms;
			init();
		}
		
		override protected function addGraphic():void
		{
			var quad:Quad = new Quad(60,60, 0x0000FF);
			quad.y = - 60;
			addChild(quad);
		}
		
		private function init():void
		{
			currentPlatform = _platforms.platforms[0]
			x = currentPlatform.x + currentPlatform.width / 2;
			y = currentPlatform.y;
			
		}
		
		public function moveToPlatform(index:int):void
		{
			_targetIndex = index;
			AutoMoveController(_moveController).moveRight(true);
		}	
		
		override public function tick(frames:int):void
		{
			if(currentPlatform.index >= _targetIndex && x > currentPlatform.x + 5)
				AutoMoveController(_moveController).moveRight(false);
//			trace('x ' ,x , currentPlatform.x + currentPlatform.platformWidth);
			if(x > currentPlatform.x + currentPlatform.platformWidth - 50)
			{
				_moveController.jump();
				currentPlatform = _platforms.platforms[currentPlatformIndex];
				currentPlatformIndex++;
			}
				
			super.tick(frames);
		}
		
		override protected function move():void
		{
			prevX = x;
			prevY = y;
			x += _moveController.xSpeed;
			if(y < currentPlatform.y)
			{
				y += VERTICAL_SPEED;
				if(y > currentPlatform.y)
					y = currentPlatform.y;
			}
			else if(y > currentPlatform.y)
			{	
				y -= VERTICAL_SPEED;
				if(y < currentPlatform.y)
					y = currentPlatform.y;
			}
		}
		
		override protected function getMoveContorller():IMoveController
		{
			return new AutoMoveController();
		}
		override public function set currentPlatform(value:Platform):void
		{
			if(value != null)
				super.currentPlatform = value;
			
		}
		
	}
}