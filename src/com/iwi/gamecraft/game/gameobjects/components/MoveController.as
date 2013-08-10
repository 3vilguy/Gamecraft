package com.iwi.gamecraft.game.gameobjects.components
{
	import com.iwi.gamecraft.game.InputController;
	
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import org.osflash.signals.Signal;

	public class MoveController extends BaseComponent implements IMoveController
	{
		protected var _xForce:Number = 0;
		protected var _yForce:Number = 0;
		protected var _xSpeed:Number = 0;
		protected var _ySpeed:Number = 0;
	
		public var  MOVE_RIGHT:Number = 1;
		public var currentMaxVel:Number = 10;
		public const MAX_VEL:Number = 10;
		public var MAX_SPEED:Number = 10;
		public var SLOW_DOWN_X:Number = 1;
		
		public var  MOVE_UP:Number = 22;
		private var MAX_VEL_Y:Number = 30;
		private var SLOW_DOWN_Y:Number = 1.1;
		private var _isJumping:Boolean;
		private var _isDouleJumping:Boolean;
		
		protected var _sigJump:Signal;
		private var DOUBLE_JUMP_TIME:int = 100;
		private var lastJump:int;
		
		
		public function MoveController()
		{
			super();
			init();
		}
		
		protected function init():void
		{
			sigJump = new Signal();
		}

		override public function tick(frames:int):void
		{
			handleInput(frames);
			move();
		}
		
		protected function handleInput(frames:Number):void
		{
			handleHorizontalMove();
			handleVerticalMove();
		}
		
		protected function handleHorizontalMove():void
		{
			if(InputController.keyState(Keyboard.RIGHT) || true)
			{
				addHorizontalForce(MOVE_RIGHT);
			}
			else if(InputController.keyState(Keyboard.LEFT))
			{
				addHorizontalForce(-MOVE_RIGHT);
			}
			else
			{
				resetSpeed();
			}
		}
		
		protected function handleVerticalMove():void
		{
			if(_ySpeed == 0 )
			{
				if(InputController.keyState(Keyboard.UP))
				{
					lastJump = getTimer();
					addVerticalForce(-MOVE_UP);
				}
			}
			else if(_isDouleJumping == false && getTimer() - lastJump > DOUBLE_JUMP_TIME)
			{
				doDoubleJump();
			}
			else
			{
				resetVerticalSpeed();
			}
		}
		
		protected function doDoubleJump():void
		{
			if(InputController.keyState(Keyboard.UP))
			{
				if(isJumping)
				{
					_isDouleJumping = true;
				}
				ySpeed = 0;
				addVerticalForce(-MOVE_UP);
			}
		}
		
		public function addVerticalForce(force:Number):void
		{
			_yForce += force;
			_isJumping = true;
			_sigJump.dispatch();
		}
		
		
		protected function resetVerticalSpeed():void
		{
			_yForce = 0;
		}
		
		
		
		
		public function addHorizontalForce(force:Number):void
		{
			_xForce += force;
			_xForce = Math.min(MAX_SPEED, _xForce);
			_xForce = Math.max(-MAX_SPEED, _xForce);
		}
		
		protected function resetSpeed():void
		{
			_xForce = 0;
		}
		
		protected function move():void
		{
			slowDown();
			xSpeed += _xForce;
			xSpeed = Math.min(xSpeed, currentMaxVel);
			xSpeed = Math.max(xSpeed, -currentMaxVel);
			
			ySpeed += _yForce;
			ySpeed = Math.min(ySpeed, MAX_VEL_Y);
			ySpeed = Math.max(ySpeed, -MAX_VEL_Y);
			resetVerticalSpeed();
//			trace('vel ' + xSpeed);
		}
		
		protected function slowDown():void
		{
			if(xSpeed > 0)
			{
				xSpeed -= SLOW_DOWN_X;
				if(xSpeed < 0)
					xSpeed = 0;
			}
			else if(xSpeed < 0)
			{
				xSpeed += SLOW_DOWN_X;
				if(xSpeed > 0)
					xSpeed = 0;
			}
			 
			if(_isJumping)
			{
				ySpeed += SLOW_DOWN_Y;
			}
		}
		
		
		
		public function get xSpeed():Number
		{
			return _xSpeed;
		}
		
		public function set xSpeed(value:Number):void
		{
			_xSpeed = value;
		}

		public function get ySpeed():Number
		{
			return _ySpeed;
		}

		public function set ySpeed(value:Number):void
		{
			_ySpeed = value;
		}

		public function stopJumping():void
		{
			_isJumping = false;
			_isDouleJumping = false;
			_ySpeed = 0;
		}
		
		public function fall():void
		{
			_isJumping = true;
			_ySpeed = 5;
		}

		public function jump():void
		{
			_isJumping = true;
			addVerticalForce(-MOVE_UP);
		}
		
		public function get isJumping():Boolean
		{
			return _isJumping;
		}

		public function get sigJump():Signal
		{
			return _sigJump;
		}

		public function set sigJump(value:Signal):void
		{
			_sigJump = value;
		}

	}
}