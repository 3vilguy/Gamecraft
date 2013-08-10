package com.iwi.gamecraft.game.gameobjects.platform
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	
	import starling.display.Quad;
	
	public class Platform extends GameObject
	{
		private var _platformWidth:int;
		private var _platformHeight:int;
		private var _index:int;
		
		public function Platform(width:int, height:int, index:int)
		{
			super();
			_platformWidth = width;
			_platformHeight = height;
			_index = index;
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

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		
		
		public function hide(param0:Boolean):void
		{
			visible = param0;
		}
	}
}