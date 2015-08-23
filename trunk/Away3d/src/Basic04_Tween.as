/*5.改变注册点
 * 在三维里这个注册点会被说成是“轴心点”,
 * cube.movePivot(0,0,-120);
 * 
 * Roll、Pitch和yaw也是旋转3D物体，它们与前面的 cube.moveForward那六个方法异曲同工, 
 * 都是针对自身坐标。rotationX/Y/Z旋转相对是世界坐标。
 * 
 * */
package  
{
	import away3d.cameras.HoverCamera3D;
    import away3d.containers.View3D;
	import away3d.core.math.Number3D;
    import away3d.events.MouseEvent3D;
    import away3d.lights.DirectionalLight3D;
    import away3d.materials.PhongColorMaterial;
    import away3d.primitives.SeaTurtle;
	import com.greensock.TweenLite;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Vector3D;

	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic04_Tween extends Sprite 
	{
		private var view:View3D;
		private var cam:HoverCamera3D;
		private var plaything:SeaTurtle;
		private var mat:PhongColorMaterial;
		private var light:DirectionalLight3D;
		
		public function Basic04_Tween() 
		{
			// Create a cam
			cam = new HoverCamera3D();
			cam.z = -1000; // make sure it's positioned away from the default 0,0,0 coordinate
			cam.panangle = 0;
			cam.tiltangle = 0;
			cam.mintiltangle = -90;
			cam.hover();
			cam.zoom = 5;
			cam.focus = 200;
			
			// create a viewport
			view = new View3D({camera:cam, x:250,y:200});
			addChild(view);
			
			// set up light
			light = new DirectionalLight3D();
			light.ambient = .2;
			light.diffuse = .8;
			light.specular = 1;
            light.brightness = 2;
			
            /*light.direction = new Number3D(100,-200,-400);
			light.brightness = 0.5;
			view.scene.addLight(light);*/
			// create a cube and put it on stage
			mat = new PhongColorMaterial(0xff3366);
			plaything = new SeaTurtle({material:mat,segmentsH:15,segmentsW:20,heigth:100,radius:50,x:-80});
			plaything.scale(0.5);
			view.scene.addChild(plaything);

            view.render();
			plaything.addEventListener(MouseEvent3D.MOUSE_DOWN,doClick);
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		
		public function update(e:Event):void
		{
			cam.hover();
			view.render();
		}
        
		private function doClick(e:MouseEvent3D):void
		{
			var randomX:Number = Math.random()*200-100;
			var randomY:Number = Math.random()*200-100;
			var randomZ:Number = Math.random()*1200-600;
			var randomRot:Number = Math.random()*365;
			TweenLite.to(plaything, 1, {x:randomX,y:randomY,z:randomZ,rotationX:randomRot});
		}
		
	}

}