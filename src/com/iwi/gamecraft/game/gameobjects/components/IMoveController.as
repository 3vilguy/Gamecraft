package com.iwi.gamecraft.game.gameobjects.components
{
	import org.osflash.signals.Signal;

	public interface IMoveController
	{
		function get xSpeed():Number;
		function get ySpeed():Number;
		function tick(frames:int):void;
		
		function stopJumping():void;
		function get isJumping():Boolean;
		
		function fall():void;
		
		function get sigJump():Signal;
	}
}