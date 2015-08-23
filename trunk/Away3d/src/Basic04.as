/*4.操控3d物
 * <与二维flash里的物体一样,三维物体也可以进行定位、旋转、缩放、组合等操作>
 * （1）坐标系：
 * away3d的坐标系使用的是左手法则：笛卡尔坐标糸：大拇指Y轴、食指为Z轴、中指为X轴
 * （2）位移：
 *  cube.x = 100;
 *  cube.y = -100;
 *  cube.z = 100;
 * 
 *  cube.position = new Number3D(100,-100,300);
 * 
 *  cube.moveTo(100,-100,300);//这三种方法等效
 * （3）朝向：
 * 	如果你想让一个3D物体朝向另一3D物体或朝向场景中的一特定点时，你要用到lookAt方法：
 * 	cube.lookAt( new Number3D(0,0,0));
 *  cube.lookAt( sphere.position );
 * */
package  
{
	import away3d.containers.View3D;
	import away3d.core.math.Number3D;
	import away3d.primitives.Cube;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic04 extends Sprite 
	{
		
		public function Basic04() 
		{
			var view:View3D = new View3D( { x:250, y:200 } );
			addChild(view);
			var cube:Cube = new Cube();
			//cube.x = 100;
			//cube.y = 100;
			//cube.z = 500;
			//cube.position = new Number3D(100, 100, 500);
			cube.moveTo(100, 100, 500);
			view.scene.addChild(cube);
			view.render();
		}
		
	}

}