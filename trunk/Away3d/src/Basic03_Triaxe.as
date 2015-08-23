/*4.用鼠标转动场景
 * 
 * 
 * */
package  
{
	import away3d.cameras.HoverCamera3D;
    import away3d.containers.View3D;
    import away3d.materials.ColorMaterial;
    import away3d.primitives.Sphere;
    import away3d.primitives.Trident;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="30", backgroundColor="#FFFFFF")]
	public class Basic03_Triaxe extends Sprite 
	{
		private var View:View3D;
		// HoverCam controls
		private var camera:HoverCamera3D;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var move:Boolean = false;
		
		public function Basic03_Triaxe() 
		{
			// prep for handling resizing events
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;
			
			// create a 3D-viewport
			camera = new HoverCamera3D({zoom:2, focus:100, distance:250});
			View = new View3D({camera:camera,x:250, y:200});
            
			// add viewport to the stage
			addChild(View);
			//设置下targetpanangle，和targettiltangle，这样可以让相机初始时就有一个角度。
			camera.targetpanangle = camera.panangle = 45;
			camera.targettiltangle = camera.tiltangle = 20;
			//将 'mintiltangle' 设为-90。这让我们可旋转至场景下方，默认情况是不允许的
			camera.mintiltangle = -90;
			camera.hover();
			
			//接下来，我们在场景中加些3D物体并让场景逐帧渲染。
			// Add some reference objects
			var mat:ColorMaterial = new ColorMaterial(0xffff00);
			var sphere1:Sphere = new Sphere({radius:10, material:mat, x:100,y:-150});
			View.scene.addChild(sphere1);
			
			mat = new ColorMaterial(0xff00ff);
			var sphere2:Sphere = new Sphere({radius:10, material:mat, y:200,z:150});
			View.scene.addChild(sphere2);
			
			mat = new ColorMaterial(0x00ffff);
			var sphere3:Sphere = new Sphere({radius:10, material:mat, z:100,x:-150});
			View.scene.addChild(sphere3);
			
			// Show the axis
			var axis:Trident = new Trident(180);
			View.scene.addChild(axis);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
		}
		
		private function MouseDown(event:MouseEvent):void
		{
			lastPanAngle = camera.panangle;
			lastTiltAngle = camera.tiltangle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			move = true;
		}
		
		private function MouseUp(event:MouseEvent):void
		{
			move = false;
		}
		
		private function onEnterFrame(e:Event):void
		{
			// re-render viewport
            var cameraSpeed:Number = 0.3; // Approximately same speed as mouse movement.
            if (move) {
                camera.targetpanangle = cameraSpeed*(stage.mouseX - lastMouseX) + lastPanAngle;
                camera.targettiltangle = cameraSpeed*(stage.mouseY - lastMouseY) + lastTiltAngle;
            }
            camera.hover();
            View.render();
		}
		
	}

}