/**3.相机
 * <相机camera类是观察3D世界必须借助的工具.其作用与现实世界里的相机一样,3D世界里的照相机应用通视原理将3D物进行缩放、
 * 聚焦、定位等。在本教程中你将会学到away3d里的三种类型的“相机”>
 * 1.三种相机
 * Away3D提供了三种类型的相机:Camera3D, TargetCamera3D 和HoverCamera3D.
 * 每种照相机都可以进行zoom(缩放)focus(焦距)、depth of field(景深)、pan（y轴旋转）、tilt（x轴旋转）、position（机位）的设置。
 * 三类相机都可以直接在构造函数里对这些特性进行设置
 * var cam:Camera3D = new Camera3D({zoom:5,focus:200});
 * 也可这样设置：
 * cam.zoom = 5;
 * cam.focus = 200;
 * 体会到focus与zoom的共同作用对所看到的场景的影响,可参看Basic03,focus属性值越小就相当于把渲染面移近相机，反之移远
 * cam.pan = 45;
 * cam.tilt = -10;
 * Pan和Tilt 方法的功能就如同其字面意思一样。它们可以让相机水平与铅垂方向旋转。这个属性的值可以正数也可以是负数。
 * 前面我们也提及景深这个属性，当与二维sprite混在一块的时候，这个属性可以设置3d物的深度效果
 * 
 */
package  
{
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import away3d.core.math.Number3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Sphere;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="30", backgroundColor="#FFFFFF")]
	public class Basic03 extends Sprite 
	{
		private var View:View3D;
		private var camera:Camera3D;
		private var camDrawing:Sprite;
		private var camDots:Sprite;
		private var label:TextField;
		private var label2:TextField;
		
		public function Basic03() 
		{
			// prep for handling resizing events
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP;
			
			// create a 3D-viewport
			camera = new Camera3D({zoom:1, focus:200, distance:50});
			View = new View3D({camera:camera,x:250, y:200});
			
			// add viewport to the stage
			addChild(View);
			camera.lookAt( new Number3D(0, 0, 0) );
			
			addControls();
			updateCameraDrawing();
			
			// Add some reference spheres
			for(var i:Number = 0; i < 50 ; i++){
				addRandomSphere(1000,5);
			}
			// Add a few that are closer to the centre
			for(var j:Number = 0; j < 10 ; j++){
				addRandomSphere(100,5);
			}
			// Add big red "sun"
			var sphere3:Sphere = new Sphere({radius:500, material:"red#white",x:0,y:0,z:3000,segmentsW:15,segmentsH:9});
			View.scene.addChild(sphere3);
			addCamDot(0xff0000,0,-500,30);
			
			// Update the view
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			camera.zoom = (stage.mouseY/stage.stageHeight) * 4+0.5;
			camera.focus = (stage.mouseX/stage.stageWidth) * 600;
			updateCameraDrawing();
			
			// Render viewport
			View.render();
			label2.text = "Zoom: "+(Math.floor(camera.zoom*10)/10)+" Focus: "+Math.floor(camera.focus);
		}
		
		private function addControls():void
		{
			// Add something that we can display the camera on
			var pan:Sprite = new Sprite();
			pan.graphics.beginFill(0xffffff);
			pan.graphics.drawRect(0,0,100,190);
			pan.graphics.endFill();
			addChild(pan);
			
			var txtFormat:TextFormat = new TextFormat("_sans",10);
			label = new TextField();
			label.x = 0;
			label.y = 0;
			label.defaultTextFormat = txtFormat;
			label.text = " As seen from above";
			pan.addChild(label);
			
			camDots = new Sprite();
			camDots.x = 50;
			camDots.y = 80;
			pan.addChild(camDots);
			
			camDrawing = new Sprite();
			camDrawing.x = 0;
			camDrawing.y = 160;
			pan.addChild(camDrawing);
			
			label2 = new TextField();
			label2.x = 0;
			label2.y = 170;
			label2.defaultTextFormat = txtFormat;
			pan.addChild(label2);
			
			// Add a mask to the camera sprite
			var panMask:Sprite = new Sprite();
			panMask.graphics.beginFill(0xf000f0);
			panMask.graphics.drawRect(0,0,100,190);
			panMask.graphics.endFill();
			pan.addChild(panMask);
			camDrawing.mask = panMask;
		}
		
		private function addRandomSphere(distance:Number,size:Number):void
		{
			var col:Number = Math.random() * (255*255*255);
			var mat:ColorMaterial = new ColorMaterial( col.toString(16) );
			var maxPos:Number = distance;
			var halfPos:Number = distance/2;
			var xPos:Number = (Math.random()*halfPos)-(halfPos/2);
			var yPos:Number = (Math.random()*halfPos)-(halfPos/2);
			var zPos:Number = (Math.random()*maxPos)-(maxPos/2);
			var sphere3:Sphere = new Sphere({radius:size, material:mat,x:xPos,y:yPos,z:zPos,bothsides:false});
			View.scene.addChild(sphere3);
			addCamDot(col,xPos,zPos,size);
		}
		
		private function addCamDot(col:Number,x:Number,z:Number,size:Number):void
		{
			camDots.graphics.beginFill(col);
			camDots.graphics.drawCircle(x/11,z/11,size/3);
			camDots.graphics.endFill();
		}
		
		private function updateCameraDrawing():void
		{
			var maxFOV:Number   = 100; // (width/x)
			var maxZoom:Number  = 70; // (height/y)
			var currFOV:Number  = ( (100/camera.focus) )*maxFOV/2;
			var currZoom:Number = ( ((camera.zoom/4)+0.5) * maxZoom);
			camDrawing.graphics.clear();
			camDrawing.graphics.lineStyle(1, 0x000000);
			
			// Draw lens triangle
			camDrawing.graphics.moveTo(maxFOV/2,0);
			camDrawing.graphics.lineTo((maxFOV/2)-(currFOV/2) , -currZoom);
			camDrawing.graphics.lineTo((maxFOV/2)+(currFOV/2) , -currZoom);
			camDrawing.graphics.lineTo(maxFOV/2 , 0);
			
			// Draw "camera body"
			camDrawing.graphics.moveTo(maxFOV/2-5,0);
			camDrawing.graphics.lineTo(maxFOV/2+5,0);
			camDrawing.graphics.lineTo(maxFOV/2+5,10);
			camDrawing.graphics.lineTo(maxFOV/2-5,10);
			camDrawing.graphics.lineTo(maxFOV/2-5,0);
		}
	}

}