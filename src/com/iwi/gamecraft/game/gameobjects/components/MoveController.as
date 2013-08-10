package com.iwi.gamecraft.game.gameobjects.components
{
	import com.iwi.gamecraft.game.InputController;
	
	import flash.ui.Keyboard;

	public class MoveController extends BaseComponent implements IMoveController
	{
		private var _xForce:Number = 0;
		private var _yForce:Number = 0;
		private var _xSpeed:Number = 0;
		private var _ySpeed:Number = 0;
	
		private static const MOVE_RIGHT:Number = 1;
		private var MAX_VEL:Number = 10;
		private var MAX_SPEED:Number = 10;
		private var SLOW_DOWN_X:Number = 1;
		
		private static const MOVE_UP:Number = 15;
		private var MAX_VEL_Y:Number = 20;
		private var SLOW_DOWN_Y:Number = 0.5;
		private var _isJumping:Boolean;
		
		
		public function MoveController()
		{
			super();
		}

		override public function tick(frames:int):void
		{
			handleInput(frames);
			move();
		}
		
		private function handleInput(frames:Number):void
		{
			handleHorizontalMove();
			handleVerticalMove();
		}
		
		private function handleHorizontalMove():void
		{
			if(InputController.keyState(Keyboard.RIGHT))
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
		
		private function handleVerticalMove():void
		{
			if(_ySpeed == 0)
			{
				if(InputController.keyState(Keyboard.SPACE))
				{
					addVerticalForce(-MOVE_UP);
				}
			}
			else
			{
				resetVerticalSpeed();
			}
		}
		
		private function addVerticalForce(force:Number):void
		{
			_yForce += force;
			_isJumping = true;
		}
		
		
		private function resetVerticalSpeed():void
		{
			_yForce = 0;
		}
		
		
		
		
		private function addHorizontalForce(force:Number):void
		{
			_xForce += force;
			_xForce = Math.min(MAX_SPEED, _xForce);
			_xForce = Math.max(-MAX_SPEED, _xForce);
		}
		
		private function resetSpeed():void
		{
			_xForce = 0;
		}
		
		private function move():void
		{
			slowDown();
			xSpeed += _xForce;
			xSpeed = Math.min(xSpeed, MAX_VEL);
			xSpeed = Math.max(xSpeed, -MAX_VEL);
			
			ySpeed += _yForce;
			ySpeed = Math.min(ySpeed, MAX_VEL_Y);
			ySpeed = Math.max(ySpeed, -MAX_VEL_Y);
			trace('vel ' + xSpeed);
		}
		
		private function slowDown():void
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
			_ySpeed = 0;
		}
		
		public function fall():void
		{
			_isJumping = true;
			_ySpeed = 5;
		}
		
		public function get isJumping():Boolean
		{
			return _isJumping;
		}
	}
}