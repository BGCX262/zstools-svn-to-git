/**2.视口与场景
 * <要呈现3d内容，首先要有View(视口) 、Scene(场景);本篇教程主要讲讲这二者>
 * 
 * 1.视口
 * 当您通过窗口向里看时,你所看到的不是房内的所有景物,你能看到的由窗口大小、
 * 形状所决定的。你所见的只是被窗“裁剪”掉的不全的小部分景物。这能够恰如其分地说明“视口view”的工作原理，
 * 它就是我们观察3d世界的“窗口”。
 * 
 * 视口大小：视口的默认值是无穷大的，即相当于“窗口”是无限大的，我们看到的将是外面的所有景物，即flash尺寸是视口的有效视域
 * 
 * 视口位置：另外你还可以设置x/y属性对视口定位,但是对away3d新手来说这里有个非常容易搞混的地方,设置视口的x/y时不仅在舞台上
 * 移动视口的位置,同时还改变了视口里的坐标.为了尽可能避免出错，你应该总是将视口的x/y设置为高/宽的一半，这样可以确保内容显在中央。
 * 改变位置有两种方法：new View3D({x:232, y:200});或者：view.x = 232;view.y = 200;
 * 2.渲染
 * 创建好视口,不等于视口就可以显示其中场景中的3D景物.我们还要用render()方法告诉计算机对视口进行渲染
 * 
 * 3.场景
 * 场景就象是flash里的舞台,场景中的任何东西都可以展示出来。创建场景有二种方法。最简单的方法就是在创建view视口时away3D会
 * 自动创建一个场景。
 * 代码在创建视口的同时创建了一个场景。这样你就可以通过"view.scene"访问场景了。当然你也可以手动创建场景然后把场景传递给视口：
 * var myScene:Scene3D = new Scene3D();
 * var view:View3D = new View3D({x:232, y:200, scene:myScene});
 * 
 * 4.添加3d物品
 * 一旦场景安放到视口，我们就迫不及待的想放物品到场景里面。
 * var mySphere:Sphere = new Sphere({radius:50});创建一个球体
 * view.scene.addChild(mySphere);//跟FLASH里一样我们可以在把“显示对象”放在显示列表中
 * view.scene.removeChild(mySphere);//在away3d里场景与其它3D物一样，可以被移动、转动、缩放,删除等。
 * myScene.addEventListener(Object3DEvent.SCENECHANGED,someFunction);//同时你也可以侦听场景变化和鼠标动作.侦听与放弃侦听与flash里一样:
 * 
 * 
 * 5.一个场景可以赋值给多个视口，但是一个视口只能观察一个场景。
 * */
package
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.core.math.Number3D;
	import away3d.events.Object3DEvent;
	import away3d.primitives.Cube;
	import away3d.primitives.Sphere;
	import away3d.primitives.Trident;
	
	import com.away3d.Cover;
	import com.away3d.ExMultipleViews_view;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic02 extends Sprite 
	{
		private var box:Cube;
		private var sphere:Sphere;
		private var baseObject:ObjectContainer3D;
		private var view1:ExMultipleViews_view;
		private var view2:ExMultipleViews_view;
		private var view3:ExMultipleViews_view;
		private var view4:ExMultipleViews_view;
		private var myScene:Scene3D;
		private var cover:Cover;
		
		public function Basic02() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Don't scale
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			// Create Scene
			myScene = new Scene3D();

			// Don't recalc the scene automatically. By default, each view recalcs the scene. If we have multiple views, we should rather do this manually with myScene.updateScene()
			myScene.autoUpdate = false;

			// Add the trident for reference(坐标轴)
			var axis:Trident = new Trident(100,true);
			myScene.addChild(axis);
			
			// Create an object grop to hold the other geometry
			baseObject = new ObjectContainer3D();
			myScene.addChild(baseObject);
			
			// create a sphere and put it on the 3D stage
			box = new Cube({material:"blue#white",x:-100, width:50, height:50, depth:50});
			baseObject.addChild(box);
			
			// create a sphere and put it on the 3D stage
			sphere = new Sphere({material:"red#black",x:100,radius:50});
			baseObject.addChild(sphere);
			
			// create the four view(ports) using our custom class
			var w:Number = 249;
			var h:Number = 199;
			view1 = new ExMultipleViews_view(w,h,0,0,myScene);
			addChild(view1);
			
			view2 = new ExMultipleViews_view(w,h,w,0,myScene);
			addChild(view2);
			
			view3 = new ExMultipleViews_view(w,h,0,h,myScene);
			addChild(view3);
			
			view4 = new ExMultipleViews_view(w,h,w,h,myScene);
			addChild(view4);
			
			// position the cameras at various angles around the objects 
			view1.cam.position = new Number3D(0, 1000, 300);
			view2.cam.position = new Number3D(1000, 0, 0);
			view3.cam.position = new Number3D(0, 1000, 1000);
			view4.cam.position = new Number3D(1000, 1000, -500);
			
			// No need to try, just point to the center coordinate and we hit spot on!
			view1.cam.lookAt( new Number3D(0, 0, 0) );
			view2.cam.lookAt( new Number3D(0, 0, 0) );
			view3.cam.lookAt( new Number3D(0, 0, 0) );
			view4.cam.lookAt( new Number3D(0, 0, 0) );
			
			// render the view
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			if (!this.cover)
			{
				this.myScene.update();
				this.view1.view.render();
				this.view2.view.render();
				this.view3.view.render();
				this.view4.view.render();
				this.cover = new Cover(this);
				addChild(this.cover);
			}
			else
			{
				if (!this.cover.visible)
				{
					(this.baseObject.rotationX + 1);
					this.baseObject.rotationY = this.baseObject.rotationY + 0.5;
					this.myScene.update();
					this.view1.view.render();
					this.view2.view.render();
					this.view3.view.render();
					this.view4.view.render();
				}
			}
		}
		
	}

}