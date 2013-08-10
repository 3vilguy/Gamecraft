package com.iwi.gamecraft.game.view
{
	import com.iwi.gamecraft.game.factory.PlatformViewFactory;
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;

	public class LevelView extends BaseView
	{
		private var _character:Character;

		private var _platformView:PlatformView;
		
		private var _currentLevel:int;
		
		
		public function LevelView(currentLevel:int)
		{
			_currentLevel = currentLevel;
			
			super();
			init();
		}
		
		private function init():void
		{
			_platformView = new PlatformViewFactory().getPlatformView(_currentLevel);
			addChild(_platformView);
		}
		
		public function addCharcter(character:Character):void
		{
			_character = character;
			addChild(_character);
			var startPlatform:Platform = _platformView.platforms[0];
			_character.y =  startPlatform.y - 100;
			_character.x = 10;
			_character.fall();
		}
		
		public function tick(frames:int):void
		{
			_platformView.tick(frames);
			_character.tick(frames);
			
			if(_character.isJumping && _character.y >= StageSize.HEIGHT - _character.height * 2)
			{
				_character.y = StageSize.HEIGHT - _character.height * 2;
				_character.stopJumping();
			}
			checkCollision();
			checkCamera();
		}
		
		private function checkCamera():void
		{
//			var local:Point = new Point();
			if(_character.x > StageSize.WIDTH/2)
			{
				x = - _character.x + StageSize.WIDTH / 2;
				if(x > 0)
					x = 0;
				trace(' camer a x ', x);
			}
		}
		
		private function checkCollision():void
		{
			var len:int = _platformView.platforms.length;
			
			if(_character.currentPlatform)
			{
//				trace('char x ', _character.x, _character.currentPlatform.x);
				if(_character.x < _character.currentPlatform.x || _character.x > _character.currentPlatform.x + _character.currentPlatform.platformWidth)
				{
					_character.fall();
					return;
				}
			}
			
			for (var i:int = 0;i < len; i++)
			{
				var platform:Platform = _platformView.platforms[i];
				if(_character.x > platform.x && _character.x < platform.x + platform.platformWidth)
				{
					trace('got you ' );
					if(_character.prevY < platform.y && _character.y >= platform.y)
					{
						_character.stopJumping();
						_character.y = platform.y;
						_character.currentPlatform = platform;
						break;
					}
				}
			}
		}
	}
}