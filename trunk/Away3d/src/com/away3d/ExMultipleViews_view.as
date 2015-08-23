package com.away3d 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.clip.RectangleClipping;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author zhengs
	 */
	public class ExMultipleViews_view extends Sprite 
	{
		public var cam:Camera3D;
		public var view:View3D;
		
		public function ExMultipleViews_view(w:Number,h:Number,x:Number,y:Number,viewScene:Scene3D) 
		{
			// create a camera
			cam = new Camera3D({zoom:10,focus:100});
			
			// create the viewport and attach it to the Sprite so we can mask and move it 
			view = new View3D({scene:viewScene,camera:cam,x:w/2,y:h/2});
			var myClip:RectangleClipping = new RectangleClipping({minX:-w/2,minY:-h/2,maxX:w/2,maxY:h/2});
			view.clipping = myClip;
			
			// add a border
			var border:Sprite = makeBorder(w,h);
			addChild(border);
			
			// Add View and position Sprite
			addChild(view);
			this.x = x;
			this.y = y;
		}
		
		private function makeBorder(w:Number,h:Number):Sprite
		{
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(0,0xcccccc);
			border.graphics.drawRect(0,0,w,h);
			return border;
		}
	}

}