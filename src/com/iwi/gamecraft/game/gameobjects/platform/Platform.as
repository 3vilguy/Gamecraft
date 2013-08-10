package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	
	import starling.display.Quad;
	
	public class Platform extends GameObject
	{
		private var _platformWidth:int;
		private var _platformHeight:int;
		public function Platform(width:int, height:int)
		{
			super();
			_platformWidth = width;
			_platformHeight = height;
			init();
		}
		
		private function init():void
		{
			var quad:Quad = new Quad(_platformWidth,_platformHeight,0x00FF00);
			addChild(quad);
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

		
		
	}
}