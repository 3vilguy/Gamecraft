package com.iwi.gamecraft.game.gameobjects.components
{
	public class AutoMoveController extends MoveController
	{

		private var moveRight:Boolean;
		private var isMovingRight:Boolean;
		public function AutoMoveController()
		{
			super();
			MAX_VEL = 8;
		}
		
		public function moveRight(value:Boolean):void
		{
			isMovingRight = value;	
		}
		
		override public function tick(frames:int):void
		{
			super.tick(frames);
		}
		
		override protected function handleInput(frames:Number):void
		{
			if(isMovingRight)
			{
				addHorizontalForce(MOVE_RIGHT);
			}
			else
			{
				_xForce = 0;
			}
		}
		
		public static function stop():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}