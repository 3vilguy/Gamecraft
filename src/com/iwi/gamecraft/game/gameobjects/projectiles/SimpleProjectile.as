package com.iwi.gamecraft.game.gameobjects.projectiles
{
	import com.iwi.gamecraft.game.gameobjects.GameObject;
	import com.iwi.gamecraft.game.gameobjects.components.MoveController;
	import com.iwi.gamecraft.game.gameobjects.components.ProjectileMoveController;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.display.Quad;
	
	public class SimpleProjectile extends GameObject
	{
		private var moveController:MoveController;
		private var _sigRemove:Signal = new Signal;;
		public function SimpleProjectile()
		{
			super();
			init();
		}
		
		private function init():void
		{
//			 var quad:Quad = new Quad(30,30,0xAABBAA);
//			 addChild(quad);
			 var charImg:Image = new Image( GameCraft.assetManager.getTexture("man_walk") );
			 charImg.scaleX = scaleY = 0.05;
			 charImg.y = -charImg.height;
			 addChild(charImg);
			 
			 moveController = new ProjectileMoveController();
			moveController.addVerticalForce(-4);
			moveController.addHorizontalForce(-1);
			 
		}
		
		override public function tick(frames:int):void
		{
			moveController.tick(frames);
			move();
		}
		
		private function move():void
		{
			x += moveController.xSpeed;
			y += moveController.ySpeed;
			if(y>2000)
				sigRemove.dispatch(this);
		}

		public function get sigRemove():Signal
		{
			return _sigRemove;
		}

		public function set sigRemove(value:Signal):void
		{
			_sigRemove = value;
		}

	}
}