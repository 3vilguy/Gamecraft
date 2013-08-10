package com.iwi.gamecraft.game.gameobjects.character
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.components.IMoveController;
	import com.iwi.gamecraft.game.gameobjects.components.MoveController;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	
	import flash.utils.getTimer;
	
	import starling.display.Quad;
	
	public class Character extends GameObject
	{
		protected var _moveController:MoveController;
		public var prevX:Number;
		public var prevY:Number;
		private var _currentPlatform:Platform;
		private var hitTime:int;
		private var isSlow:Boolean;
		private var HIT_RECOVERY_TIME:int = 2500;
		private var SLOW_DOWN_VALUE:Number = 1;;
		
		public function Character()
		{
			super();
			init();
		}

		protected function init():void
		{
			_moveController = getMoveContorller();
			
			addGraphic();
		}
		
		protected function addGraphic():void
		{
			var quad:Quad = new Quad(60,60, 0xFF0000);
			quad.y = - 60;
			addChild(quad);
		}
		
		protected function getMoveContorller():MoveController
		{
			var moveController:MoveController = new MoveController();
			moveController.sigJump.add(handleJump);
			return moveController;
		}
		
		override public function tick(frames:int):void
		{
			super.tick(frames);
			_moveController.tick(frames);
			
			move();
			
			if(isSlow && getTimer() - hitTime > HIT_RECOVERY_TIME)
			{
				_moveController.currentMaxVel += SLOW_DOWN_VALUE;
				_moveController.currentMaxVel = Math.min(_moveController.currentMaxVel , _moveController.MAX_VEL);
			}
		}
		
		protected function handleJump():void
		{
			currentPlatform = null;
		}
		
		protected function move():void
		{
			prevX = x;
			prevY = y;
			x += _moveController.xSpeed;
			y += _moveController.ySpeed;
		}		
		
		public function stopJumping():void
		{
			_moveController.stopJumping();
		}

		public function get isJumping():Boolean
		{
			return _moveController.isJumping;
		}

		public function fall():void
		{
			_moveController.fall();
			currentPlatform = null;
		}

		public function get currentPlatform():Platform
		{
			return _currentPlatform;
		}

		public function set currentPlatform(value:Platform):void
		{
			_currentPlatform = value;
		}

		public function hitMe():void
		{
			_moveController.currentMaxVel-=SLOW_DOWN_VALUE;
			hitTime = getTimer();
			isSlow = true;
		}
	}
}