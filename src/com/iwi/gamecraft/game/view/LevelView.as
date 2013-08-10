package com.iwi.gamecraft.game.view
{
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;

	public class LevelView extends BaseView
	{
		private var _character:Character;

		private var _platformView:PlatformView;
		public function LevelView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_platformView =  new PlatformView();
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
		}
		
		private function checkCollision():void
		{
			var len:int = _platformView.platforms.length;
			for (var i:int = 0;i < len; i++)
			{
				var platform:Platform = _platformView.platforms[i];
				if(_character.x > platform.x && _character.x < platform.width + platform.platformWidth)
				{
					if(_character.prevY < platform.y && _character.y >= platform.y)
					{
						_character.stopJumping();
						_character.y = platform.y;
					}
				}
			}
		}
	}
}