package com.iwi.gamecraft.game.gameobjects.projectiles
{
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.character.RunningCharacter;
	
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	public class ProjectileCreator extends GameObject
	{
		private var lastTime:int;

		private var MIN_TIME:int = 500;
		private var _runningCharacter:RunningCharacter;
		private var _projectiles:Array;
		private var _cameraCharacter:Character;
		public function ProjectileCreator(character:RunningCharacter, cameraCharacter:Character)
		{
			super();
			_runningCharacter = character;
			_cameraCharacter = cameraCharacter;
			
			_projectiles = [];
		}
		
		override public function tick(frames:int):void
		{
			for each(var projectile:SimpleProjectile in _projectiles)
			{
				projectile.tick(frames);
			}
			if(InputController.keyState(Keyboard.SPACE))
			{
				throwProjectile();
			}
			checkCollision();
		}
		
		private function checkCollision():void
		{
			for each(var projectile:SimpleProjectile in _projectiles)
			{
				if(projectile.x + projectile.width < _cameraCharacter.x || projectile.x > _cameraCharacter.x + _cameraCharacter.width
					|| projectile.y + projectile.height < _cameraCharacter.y || projectile.y > _cameraCharacter.y + _cameraCharacter.height)
					continue;
				
				_cameraCharacter.hitMe();
				trace("HIIIIIIIIIIIIIIIIIIIIIIIIT");
				handleRemove(projectile);
				break;
			}
		}
		
		private function throwProjectile():void
		{
			if(getTimer() - lastTime > MIN_TIME)
			{
				lastTime = getTimer();
				var projectile:SimpleProjectile = new SimpleProjectile();
				addChild(projectile);
				projectile.sigRemove.add(handleRemove);
				projectile.x = _runningCharacter.x + _runningCharacter.width / 2;
				projectile.y = _runningCharacter.y - _runningCharacter.height + 15;
				_projectiles.push(projectile);
			}
		}
		
		private function handleRemove(projectile:SimpleProjectile):void
		{
			var index:int = _projectiles.indexOf(projectile);
			if(index != -1)
				_projectiles.splice(index,1);
		}
	}
}