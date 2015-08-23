/**1.对一个简单类的解释
 * <本基础指南里会解释场景Scene, 视口View, Camera照相机, Primitives基本元素, Textures材质和其它一些会用到的概念>
 * 我们可以将计算机中的三维效果看作是一部电影。有四样东西是我们始终需要去牢记的，
 * 那就是Stage（舞台），Camera（摄影机），View（视角）以及所看到的内容。由于存在大量的“默认”属性，
 * 所以您在Away3D入门阶段只需建立一个来运行即可。
 * 
 * */
package 
{
	import away3d.containers.View3D;
	import away3d.primitives.Sphere;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author zhengs
	 */
	public class Basic01 extends Sprite 
	{
		public function Basic01():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//  创建一个视窗
			var  view:View3D = new View3D( { x:250, y:200 } );
			addChild(view);
			//  在三维舞台中创建一个球体
			var  sphere:Sphere = new Sphere();
			view.scene.addChild(sphere);
			//  渲染视窗
			view.render();
		}
		
	}
	
}