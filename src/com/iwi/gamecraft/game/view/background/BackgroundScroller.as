package com.iwi.gamecraft.game.view.background
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class BackgroundScroller extends Sprite
	{
		private var bgImages:Vector.<Texture>;
		private var bgContainer:Sprite;
		private var bg1:Image;
		private var bg2:Image;
		private var bgWidth:Number;
		private var bgHalfWidth:Number;
		
		private var currX:Number = 0;
		private var prevX:Number = 0;
		
		
		public function BackgroundScroller()
		{
			super();
			init();
		}
		
		private function init():void
		{
			bgImages = new Vector.<Texture>();
			bgImages.push( GameCraft.assetManager.getTexture("bg1") );
			bgImages.push( GameCraft.assetManager.getTexture("bg2") );
			
			bgContainer = new Sprite();
			
			bg1 = new Image( bgImages[ Math.floor(Math.random() * bgImages.length) ] );
			bg1.scaleX = bg1.scaleY = 0.77;
			//bg1.y = -50;
			bgContainer.addChild(bg1);
			
			bg2 = new Image( bgImages[ Math.floor(Math.random() * bgImages.length) ] );
			bg2.scaleX = bg2.scaleY = 0.77;
			bg2.x = bg1.width;
			//bg2.y = -50;
			bgContainer.addChild(bg2);
			
			bgWidth = -bg1.width*2;
			bgHalfWidth = bgWidth >> 1;
			
			addChild(bgContainer);
		}
		
		
		public function moveBg(parentX:Number, parentY:Number):void
		{
			currX = parentX % bgHalfWidth;
			x = currX;
			
			if(currX > prevX)
			{
				while(bgContainer.numChildren)
				{
					(bgContainer.getChildAt(0) as Image).removeFromParent(true);
				}
				
				bg1 = bg2;
				bg1.x = 0;
				bgContainer.addChild(bg1);
				
				bg2 = new Image( bgImages[ Math.floor(Math.random() * bgImages.length) ] );
				//bg2.readjustSize();
				bg2.scaleX = bg2.scaleY = 0.77;
				bg2.x = bg1.width;
				//bg2.y = -50;
				bgContainer.addChild(bg2);
			}
			
			prevX = currX;
		}
	}
}