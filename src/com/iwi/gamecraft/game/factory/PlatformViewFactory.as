package com.iwi.gamecraft.game.factory
{
	import com.iwi.gamecraft.game.gameobjects.platform.PlatformView;

	public class PlatformViewFactory
	{
		public function PlatformViewFactory()
		{
		}
		
		public function getPlatformView(currentLevel:int):PlatformView
		{
			return new PlatformView();
		}
	}
}