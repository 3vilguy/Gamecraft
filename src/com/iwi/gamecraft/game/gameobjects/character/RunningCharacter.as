package com.iwi.gamecraft.game.gameobjects.character
{
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.gameobjects.components.AutoMoveController;
	import com.iwi.gamecraft.game.gameobjects.components.MoveController;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;

	public class RunningCharacter extends Character
	{
		private var VERTICAL_SPEED:Number = 8;
		
		private var _platforms:PlatformView;
		private var currentPlatformIndex:int;
		private var _targetIndex:int;
		private var _targetPlatform:Platform;
		
		private var charImg:Image;

		private var walkTexture:Texture;

		private var jumpTexture:Texture;
		
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
			//addChild(quad);
			walkTexture = GameCraft.assetManager.getTexture(InputController.character + "_walk");
			jumpTexture = GameCraft.assetManager.getTexture(InputController.character + "_jump");
			charImg = new Image( walkTexture );
			charImg.scaleX = scaleY = 0.1;
			charImg.y = -charImg.height;
			addChild(charImg);
		}
		
		private function init():void
		{
			currentPlatform = _platforms.platforms[0]
			x = currentPlatform.x + currentPlatform.width / 2;
			y = currentPlatform.y;
			
		}
		
		public function moveToPlatform(platform:Platform):void
		{
//			_targetIndex = index;
			_targetPlatform = platform
			AutoMoveController(_moveController).moveRight(true);
		}	
		
		override public function tick(frames:int):void
		{
//			if(currentPlatform.index >= _targetIndex && x > currentPlatform.x + 5)
//				AutoMoveController(_moveController).moveRight(false);
//			trace('x ' ,x , currentPlatform.x + currentPlatform.platformWidth);
//			trace('target ' + _targetIndex, currentPlatformIndex, currentPlatform);
			if(_targetPlatform && x > _targetPlatform.x + _targetPlatform.platformWidth - 100)
				AutoMoveController(_moveController).moveRight(false);
			if(x > currentPlatform.x + currentPlatform.platformWidth - 10)
			{
				_moveController.jump();
 				currentPlatform.hide(true);
				currentPlatform = _platforms.aiPlatforms[currentPlatformIndex];
				currentPlatformIndex++;
				currentPlatform.hide(false);
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
				charImg.texture = jumpTexture;
				y += VERTICAL_SPEED;
				if(y > currentPlatform.y)
					y = currentPlatform.y;
			}
			else if(y > currentPlatform.y)
			{	
				charImg.texture = jumpTexture;
				y -= VERTICAL_SPEED;
				if(y < currentPlatform.y)
					y = currentPlatform.y;
			}
			else
			{
				charImg.texture = walkTexture;
			}
		}
		
		override protected function getMoveContorller():MoveController
		{
			var moveController:MoveController = new AutoMoveController();
			moveController.sigJump.add(handleJumpAnim);
			return moveController;
		}
		
		private function handleJumpAnim():Object
		{
			// TODO Auto Generated method stub
			return null;
		}
		override public function set currentPlatform(value:Platform):void
		{
			if(value != null)
				super.currentPlatform = value;
			
		}
		
		
		override public function destroy():void
		{
			if(charImg)
			{
				charImg.removeFromParent(true);
				charImg = null;
			}
			
			super.destroy();
		}
	}
}