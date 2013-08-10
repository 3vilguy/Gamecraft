package com.iwi.gamecraft.game.view
{
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.factory.PlatformViewFactory;
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.character.RunningCharacter;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	import com.iwi.gamecraft.game.gameobjects.projectiles.ProjectileCreator;
	import com.iwi.gamecraft.game.view.background.BackgroundScroller;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Sprite;

	public class LevelView extends BaseView
	{
		private var _character:Character;

		private var _platformView:PlatformView;
		
		private var autoCharacter:RunningCharacter;
		private var _currentLevel:int;
		private var _levelController:LevelController;
		private var _projectileCreator:ProjectileCreator;
		
		private var _platformContainer:Sprite;
		private var _bgScroller:BackgroundScroller;
		public var sigComplete:Signal = new Signal(String);
		
		
		
		public function LevelView(currentLevel:int)
		{
			_currentLevel = currentLevel;
			
			super();
			init();
		}
		
		private function init():void
		{
			_bgScroller = new BackgroundScroller();
			addChild(_bgScroller);
			
			_platformContainer = new Sprite();
			addChild(_platformContainer);
			
			_platformView = new PlatformViewFactory().getPlatformView(_currentLevel);
			_platformContainer.addChild(_platformView);
			_platformView.start();
		}
		
		public function addCharcter(character:Character):void
		{
			_character = character;
			_platformContainer.addChild(_character);
			var startPlatform:Platform = _platformView.platforms[0];
			_character.y =  startPlatform.y - 100;
			_character.x = 10;
			_character.fall();
			
			autoCharacter = new RunningCharacter(_platformView);
			_platformContainer.addChild(autoCharacter);
			
			_levelController = new LevelController(character, autoCharacter, _platformView);
			_projectileCreator = new ProjectileCreator(autoCharacter, character);
			_platformContainer.addChild(_projectileCreator);
		}
		
		public function tick(frames:int):void
		{
			_platformView.tick(frames);
			_character.tick(frames);
			autoCharacter.tick(frames);
			_levelController.tick(frames);
			_projectileCreator.tick(frames);
			
			if(_character.isJumping && _character.y >= stage.stageHeight)
			{
				_character.y = StageSize.HEIGHT - _character.height * 2;
				_character.stopJumping();
				sigComplete.dispatch("lool");
				return;
			}
			checkCollision(_character);
			checkCollision(autoCharacter);
			checkCamera();
			
			InputController.resetTouch()
		}
		
		private function checkCamera():void
		{
//			var local:Point = new Point();
			if(_character.x > StageSize.WIDTH/2)
			{
				_platformContainer.x = - _character.x + StageSize.WIDTH / 2;
				if(_platformContainer.x > 0)
					_platformContainer.x = 0;
			}
			if(_character.y < StageSize.HEIGHT / 2)
			{
				
			}
			else
			{
				
			}
			
			_bgScroller.moveBg(_platformContainer.x, _platformContainer.y);
		}
		
		private function checkCollision(checkCharacter:Character):void
		{
			var len:int = _platformView.platforms.length;
			
			if(checkCharacter.currentPlatform)
			{
//				trace('char x ', _character.x, _character.currentPlatform.x);
				if(checkCharacter.x + checkCharacter.width < checkCharacter.currentPlatform.x || checkCharacter.x > checkCharacter.currentPlatform.x + checkCharacter.currentPlatform.platformWidth)
				{
					checkCharacter.fall();
					return;
				}
			}
			
			for (var i:int = 0;i < len; i++)
			{
				var platform:Platform = _platformView.platforms[i];
				if(checkCharacter.x + checkCharacter.width> platform.x && checkCharacter.x < platform.x + platform.platformWidth)
				{
					if(checkCharacter.prevY < platform.y && checkCharacter.y >= platform.y)
					{
						checkCharacter.stopJumping();
						checkCharacter.y = platform.y;
						checkCharacter.currentPlatform = platform;
						break;
					}
				}
			}
		}
		
		public function destroy():void
		{
			removeChildren(0, numChildren)
		}
	}
}