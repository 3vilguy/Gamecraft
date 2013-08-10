package com.iwi.gamecraft.game.chase
{	
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class ChaseMessage extends Sprite
	{
		public var display:String;
		private var textField:TextField;
		private var timeRemaining:Number;
		private const timeToElapse:Number = 3;
		
		public function ChaseMessage()
		{
			super();
			init();
		}

		private function init():void
		{
			textField = new TextField(300, 200, "", "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
			textField.y = -20;
			addChild(textField);			
		}
		
		public function setText(text:String):void
		{
			textField.text = text;
			timeRemaining = timeToElapse;
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
				textField.text = "";
			}
		}
	}
}