package com.iwi.gamecraft.game
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class InputController
	{
		private static var _keysState:Dictionary;
		private var _stage:Stage;
		private static var touch:Boolean;
		
		public function InputController(stage:Stage)
		{
			_keysState = new Dictionary();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			
			stage.addEventListener(TouchEvent.TOUCH, handleTouch);
			
			_stage = stage;
		}
		
		private function handleTouch(event:TouchEvent):void
		{
			if(event.touches[0].phase == TouchPhase.BEGAN)
			{
				if(event.touches[0].globalX > _stage.stageWidth/2)
					_keysState[Keyboard.SPACE] = true;
				else
					_keysState[Keyboard.UP] = true;
				touch = true;
			}
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
		
		public static function resetTouch():void
		{
			if(touch)
			{	
				_keysState[Keyboard.SPACE] = false;
				_keysState[Keyboard.UP] = false;
				touch = false;
			}
		}
		
		public static function keyState(keyCode:uint):Boolean
		{
			return _keysState[keyCode];
		}
	}
}