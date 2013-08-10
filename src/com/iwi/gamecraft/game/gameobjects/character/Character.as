package com.iwi.gamecraft.game.gameobjects.character
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.components.IMoveController;
	import com.iwi.gamecraft.game.gameobjects.components.MoveController;
	
	import starling.display.Quad;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	
	public class Character extends GameObject
	{
		private var _moveController:IMoveController;
		public var prevX:Number;
		public var prevY:Number;
		public var currentPlatform:Platform;
		
		public function Character()
		{
			super();
			var quad:Quad = new Quad(60,60, 0xFF0000);
			quad.y = - 60;
			addChild(quad);
			init();
		}

		private function init():void
		{
			_moveController = new MoveController();
		}
		
		override public function tick(frames:int):void
		{
			super.tick(frames);
			_moveController.tick(frames);
			_moveController.sigJump.add(handleJump);
			move();
		}
		
		private function handleJump():void
		{
			currentPlatform = null;
		}
		
		private function move():void
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
		}
	}
}