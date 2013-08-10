package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.powerups.PowerUp;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class Platform extends GameObject
	{
		private var _platformWidth:int;
		private var _platformHeight:int;
		private var _index:int;
		private var _powerup:PowerUp;
		
		public function Platform(width:int, height:int, index:int)
		{
			super();
			_platformWidth = width;
			_platformHeight = height;
			_index = index;
			init();
			addEventListener(Event.ADDED_TO_STAGE, handleStage)
		}
		
		private function handleStage():void
		{
			generatePowerUp();
		}
		
		private function init():void
		{
			var quad:Quad = new Quad(_platformWidth,_platformHeight,0x00FF00);
			addChild(quad);
		}
		
		private function generatePowerUp():void
		{
			if (PowerUp.gapCounter == 0)
			{
				if (PowerUp.probability > Math.random())
				{
					_powerup = new PowerUp();
					parent.addChild(_powerup);
					PowerUp.gapCounter = PowerUp.gap;
				}
			}
			else
			{
				PowerUp.gapCounter--;
			}
		}
		

		public function get platformWidth():int
		{
			return _platformWidth;
		}

		public function set platformWidth(value:int):void
		{
			_platformWidth = value;
		}

		public function get platformHeight():int
		{
			return _platformHeight;
		}

		public function set platformHeight(value:int):void
		{
			_platformHeight = value;
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function hasPowerUp():Boolean
		{
			return (_powerup != null);
		}
		
		public function get powerUp():PowerUp
		{
			return _powerup;
		}

		
		
		public function hide(param0:Boolean):void
		{
//			visible = param0;
		}
	}
}