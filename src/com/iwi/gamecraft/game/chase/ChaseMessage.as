package com.iwi.gamecraft.game.chase
{	
	import com.iwi.gamecraft.game.gameobjects.StageSize;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class ChaseMessage extends Sprite
	{
		public var display:String;
		private var timeRemaining:Number;
		private const timeToElapse:Number = 2;

		private var charImg:Image;
		
		public function ChaseMessage()
		{
			super();
			init();
		}

		private function init():void
		{
			var walk:Texture = GameCraft.assetManager.getTexture("after");
			charImg = new Image( walk );
			charImg.scaleX = charImg.scaleY = 0.25;
//			charImg.y = -charImg.height;
		}
		
		public function setText(text:String):void
		{
			timeRemaining = timeToElapse;
			addChild(charImg);
			charImg.x = StageSize.WIDTH / 2 - charImg.width/2;
			charImg.y = StageSize.HEIGHT / 2 - charImg.height/2;
			
		}
		
		public function refresh(delta:Number):void
		{
			if (timeRemaining > 0)
			{
				timeRemaining -= delta;
			}
			if (timeRemaining <= 0)
			{
				timeRemaining = 0;
				removeChild(charImg);
			}
		}
	}
}