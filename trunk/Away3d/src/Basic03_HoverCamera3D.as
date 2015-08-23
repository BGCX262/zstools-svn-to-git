/*3.HoverCamera3D(旋转相机)
 * 旋转相机拥有目标相机的所用功能，另外它还增加了一个功能，这个功能在我们通过设置pan与tilt属性让相机绕3D
 * 物转动时会非常有用。同样会转动相机，因此用它会转动的更为平滑。它任由你想象的那样自由旋转相机，它是所有
 * 相机里最能干的一个。
 * 
 * */
package  
{
	import away3d.cameras.HoverCamera3D;
    import away3d.containers.View3D;
    import away3d.core.base.Object3D;
    import away3d.events.MouseEvent3D;
    import away3d.primitives.Cone;
    import away3d.primitives.Cube;
    import away3d.primitives.Sphere;
	import com.away3d.Cover;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic03_HoverCamera3D extends Sprite 
	{
		private var cam:HoverCamera3D;
        private var lastKey:uint;
        private var keyIsDown:Boolean = false;
        private var View:View3D;
        private var cover:Cover;
        private var sphere:Sphere;
        private var cone:Cone;
        private var cube:Cube;
		
		public function Basic03_HoverCamera3D() 
		{
			cam = new HoverCamera3D();
			cam.z = -1000; // make sure it's positioned away from the default 0,0,0 coordinate
			cam.targetpanangle = 0;
			cam.targettiltangle = 0;
			cam.mintiltangle = -90;
			cam.steps = 16;
			cam.hover();

			// create a viewport
			View = new View3D({camera:cam,x:250,y:200});
			addChild(View);
			
			// make some objects and put it on the 3D stage
			sphere = new Sphere({material:"red#black",radius:50});
			View.scene.addChild(sphere);
			cone = new Cone({material:"green#black", radius:50, height:100, x:-150});
			View.scene.addChild(cone);
			cube = new Cube({material:"blue#black", depth:100, width:100, height:100, x:150});
			View.scene.addChild(cube);
			
			// add a huge surrounding sphere so we really can see what we're doing
			var largeSphere:Sphere = new Sphere({radius:1500,material:"yellow#black"});
			largeSphere.scaleX = -1;
			View.scene.addChild(largeSphere);
			
			View.render();
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			this.addEventListener(Event.ENTER_FRAME,update);
			
			// Listen for clicks on the objects
			sphere.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
			cone.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
			cube.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
		}
		
		public function update(e:Event):void
		{
			if(keyIsDown){
                switch(lastKey){
                    case 87: 
						cam.targettiltangle -= 10; 
						break;
                    case 83: 
						cam.targettiltangle += 10; 
						break;
                    case 65: 
						cam.targetpanangle -= 10; 
						break;
                    case 68:
						cam.targetpanangle += 10;
						break;
                    case Keyboard.UP: 
						cam.distance -= 10; 
						break;
					case Keyboard.DOWN: 
						cam.distance += 10; 
						break;
                }
            }
            cam.hover();
            View.render();
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			lastKey = e.keyCode;
			keyIsDown = true;
		}
		
		private function keyUp(e:KeyboardEvent):void
		{
			keyIsDown = false;
		}
		
		private function objectClick(e:MouseEvent3D):void
		{
			cam.target = e.target as Object3D;
		}
	}

}