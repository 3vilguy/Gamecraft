package com.iwi.gamecraft.game.view
{
	import com.iwi.gamecraft.game.InputController;
	import com.iwi.gamecraft.game.gameobjects.character.Character;
	import com.iwi.gamecraft.game.gameobjects.character.RunningCharacter;
	import com.iwi.gamecraft.game.gameobjects.platform.Platform;
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;
	
	import flash.ui.Keyboard;
	
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class LevelController
	{
		private var _character:Character;
		private var _aiCharacter:RunningCharacter;
		private var _platforms:PlatformView;
		
		private var _currentHiddingSpot:int = 0;
		private var resetCount:int;
		private var canMove:Boolean;
		
		public function LevelController(character:Character, aiCharacter:RunningCharacter, platforms:PlatformView)
		{
			_character = character;
			_aiCharacter = aiCharacter;
			_platforms = platforms;
			init();
			
			if(character.stage == null)
				_character.addEventListener(Event.ADDED_TO_STAGE, test);
			else 
				test(null);
		}
		
		private function test(event:Event):void
		{
			_character.stage.addEventListener(KeyboardEvent.KEY_DOWN, testJKEy);
		}
		
		private function testJKEy(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.B)
				moveToNextSpot();
		}
		
		private function init():void
		{
			moveToNextSpot();
		}
		
		private function moveToNextSpot():void
		{
			if(canMove == false)
				return
			canMove = false;
			resetCount = 0;
			
			var hiddinSpot:Platform = _platforms.getNextHiddingSpot(1);
			_currentHiddingSpot++;
		
			trace('hidding index ', _currentHiddingSpot);
			trace('hidding index sad ', _platforms.hiddingSpots[_currentHiddingSpot].name);
			_aiCharacter.moveToPlatform( _platforms.hiddingSpots[_currentHiddingSpot] );
		}
		
		public function tick(frames:int):void
		{
			resetCount+=frames;
			if(resetCount > 50)
			{
				canMove = true;
				resetCount = 0;
			}
		}
	}
}