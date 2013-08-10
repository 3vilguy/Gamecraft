package com.iwi.gamecraft.game
{
	import flash.utils.Dictionary;
	
	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class InputController
	{
		private static var _keysState:Dictionary;
		
		public function InputController(stage:Stage)
		{
			_keysState = new Dictionary();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
//			trace("KEY DOWN " ,event.keyCode);
			_keysState[event.keyCode] = true;
		}

		private function handleKeyUp(event:KeyboardEvent):void
		{
//			trace("KEY UP " ,event.keyCode);
			_keysState[event.keyCode] = false;
		}
		
		public static function keyState(keyCode:uint):Boolean
		{
			return _keysState[keyCode];
		}
	}
}