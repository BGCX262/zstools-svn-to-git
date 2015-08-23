/*2.TargetCamera3D（目标相机）
 * <目标相机拥有所有自由相机的属性，并且它还具有指向其它3D物或三维位置的能力。>
 * camera.target = sphere;
 * 1.使用导航键（A、D、W、S）操作上面使用目标相机的示例影片
 * 使用camera.moveLeft的实质是：让相机绕着目标旋转
 * 
 * */
package  
{
	import away3d.cameras.TargetCamera3D;
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
	public class Basic03_TargetCamera3D extends Sprite 
	{
		private var cam:TargetCamera3D;
		private var lastKey:uint;
		private var keyIsDown:Boolean = false;
		private var view:View3D;
		
		private var sphere:Sphere;
		private var cone:Cone;
		private var cube:Cube;
		private var cover:Cover;
		
		public function Basic03_TargetCamera3D() 
		{
			// create a basic camera
			cam = new TargetCamera3D();
			cam.z = -1000; // make sure it's positioned away from the default 0,0,0 coordinate
			
			// create a viewport
			view = new View3D({camera:cam,x:250,y:200});
			addChild(view);
			
			// make some objects and put it on the 3D stage
			sphere = new Sphere({material:"red#black",radius:50});
			view.scene.addChild(sphere);
			cone = new Cone({material:"green#black", radius:50, height:100, x:-150});
			view.scene.addChild(cone);
			cube = new Cube({material:"blue#black", depth:100, width:100, height:100, x:150});
			view.scene.addChild(cube);
			
			// add a huge surrounding sphere so we really can see what we're doing
			var largeSphere:Sphere = new Sphere({radius:1500,material:"yellow#black"});
			largeSphere.scaleX = -1;
			view.scene.addChild(largeSphere);
			view.render();
			this.cover = new Cover(this);
            addChild(this.cover);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			this.addEventListener(Event.ENTER_FRAME,update);
			
			// Listen for clicks on the objects
			sphere.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
			cone.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
			cube.addEventListener(MouseEvent3D.MOUSE_DOWN,objectClick);
		}
		
		private function update(e:Event):void
		{
			if (!this.cover.visible)
            {
				if(keyIsDown){
					// if the key is still pressed, just keep on moving
					switch(lastKey){
						case 87: 
							cam.moveUp(10); 
							break;
						case 83: 
							cam.moveDown(10); 
							break;
						case 65: 
							cam.moveLeft(10); 
							break;
						case 68: 
							cam.moveRight(10); 
							break;
						case Keyboard.UP: 
							cam.moveForward(10); 
							break;
						case Keyboard.DOWN: 
							cam.moveBackward(10); 
							break;
					}
				}
				// render the view
				view.render();
			}
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