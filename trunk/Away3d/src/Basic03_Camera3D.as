/*1.Camera3D（自由相机）
* <使用A、D、W、S及上下箭头键操控>
* <Camera3D 是最基本的,没有固定形态,你可以自由地移动与定位.>
* 1.camera.moveUp(10);camera.moveDown(10);camera.moveLeft(10);camera.moveRight(10); 
* 2.camera.moveForward(10);camera.moveBackward(10);
* 
* 1.移动相机：
* （1）改变相机空间的3维位置
* camera.z = -1000;camera.x = 0;camera.y = 0;
* （2）改变相机面向的位置
* 设置相机的x/y/z属性值会移动相机在三维空间里的位置，但是记住相机必须面向某一位置（三维点）
* 默认情况下相机面向的点是三维场景坐标的中央，如果要让相机面向其他点我们要用到： 
* camera.lookAt( new Number3D(x,y,z) );
* 
* 
* */
package
{
	import away3d.cameras.Camera3D;
    import away3d.containers.View3D;
    import away3d.primitives.Cone;
    import away3d.primitives.Cube;
    import away3d.primitives.Sphere;
	import com.away3d.Cover;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic03_Camera3D extends Sprite
	{
		private var cam:Camera3D;
		private var lastKey:uint;
		private var keyIsDown:Boolean = false;
		private var View:View3D;
		private var cover:Cover;
		
		public function Basic03_Camera3D()
		{
			// create a basic camera
			cam = new Camera3D();
			cam.z = -1000; // make sure it's positioned away from the default 0,0,0 coordinate
			
			// create a viewport
			View = new View3D({camera:cam,x:250,y:200});
			addChild(View);
			
			// make some objects and put it on the 3D stage
			var sphere:Sphere = new Sphere({material:"red#black",radius:50});
			View.scene.addChild(sphere);
			var cone:Cone = new Cone({material:"green#black", radius:50, height:100, x:-150});
			View.scene.addChild(cone);
			var cube:Cube = new Cube({material:"blue#black", depth:100, width:100, height:100, x:150});
			View.scene.addChild(cube);
			
			// add a huge surrounding sphere so we really can see what we're doing
			var largeSphere:Sphere = new Sphere({radius:1500,material:"yellow#black"});
			largeSphere.scaleX = -1;
			View.scene.addChild(largeSphere);
			View.render();
			this.cover = new Cover(this);
            addChild(this.cover);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		
		public function update(e:Event):void
		{
			 if (!this.cover.visible)
            {
                if (this.keyIsDown)
                {
                    switch(this.lastKey)
                    {
                        case 87:
                            this.cam.moveUp(10);
                            break;
                        case 83:
                            this.cam.moveDown(10);
                            break;
                        case 65:
                            this.cam.moveLeft(10);
                            break;
                        case 68:
                            this.cam.moveRight(10);
                            break;
                        case Keyboard.UP:
                            this.cam.moveForward(10);
                            break;
                        case Keyboard.DOWN:
                            this.cam.moveBackward(10);
                            break;
                    }
                }
                this.View.render();
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
	}
}