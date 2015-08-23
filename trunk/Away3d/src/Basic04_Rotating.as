/*5.旋转
 * cube.rotationX = 45;
 * cube.rotationY = -10;
 * cube.rotationZ = 200;
 * 
 * cube.rotateTo(45,45,0);
 * 
 * 6.缩放
 * cube.scaleX = 2;
 * cube.scaleY = .5;
 * cube.scaleZ = 1;
 * 
 * cube.scale(2);
 * 
 * 7.组合三维物体
 * 
 * 当我们要同时操控多个三维物体，我想这时你绝对会先将这些三维物体组合在一块。在Away3d里组合三维物体会用到"ObjectContainer3D"，
 * 将3D物体添加"ObjectContainer3D"里面如同将其添加到场景里上一样。组合三维物体，先创建一个ObjectContainer3D然后将其加到场景中。
 * 下例中我们添加一个唱片(RegularPolygon),、立方体和球。这个组合每帧都要转动半度，其中立方体反方向转动，
 * 所以看上在你看来立方体总是朝向你。
 * 
 * ObjectContainer3D这类容器看不见地真实存在着，我们可以象一般三维物体一样移动它或实现别的一些操控。
 * 8.三维物体的缓动
 * 
 * 渐变三维物体，和flash里的渐变一样。安装你惯用的渐变类并指定好要渐变的属性，一切如此简单。
 * 
 * 
 * */
package  
{
	import away3d.containers.ObjectContainer3D;
    import away3d.containers.View3D;
	import away3d.core.math.Number3D;
    import away3d.primitives.Cube;
    import away3d.primitives.RegularPolygon;
    import away3d.primitives.Sphere;

    import flash.display.Sprite;
    import flash.events.Event;
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="250", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic04_Rotating extends Sprite 
	{
		public var view:View3D;
		
		private var group:ObjectContainer3D;
		private var disc:RegularPolygon;
		private var cube:Cube;
		private var sphere:Sphere;
		
		public function Basic04_Rotating() 
		{
			// create a viewport
			view = new View3D({x:250,y:125});
			addChild(view);
			view.camera.y = 300; // Move camera up
			view.camera.lookAt( new Number3D(0,0,0)); // Point it toward scene center again, so the target is right (setting y does not change where the camera is pointing)
			
			// Create a group and add to scene
			group = new ObjectContainer3D();
			view.scene.addChild(group);
			
			// attach objects to group
			disc = new RegularPolygon({radius:250,y:-25,sides:20,pushback:true});
			group.addChild(disc);
			cube = new Cube({depth:50,width:50,height:50,z:200});
			group.addChild(cube);
			sphere = new Sphere({radius:25,z:-200});
			group.addChild(sphere);
            
			// render the view
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		
		public function update(e:Event):void
		{
			// Rotate group
			group.rotationY += .5;
			
			// Counter-rotate the cube so it always faces the viewer
			cube.rotationY -= .5;
			
			// re-render the view
			view.render();
		}
		
	}

}