package com.iwi.gamecraft.game.gameobjects
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Character extends Sprite
	{
		public function Character()
		{
			super();
			var quad:Quad = new Quad(60,60);
			addChild(quad);
		}
	}
}