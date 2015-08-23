/*4.前后左右上下操作
 * cube.moveForward(X);
 * cube.moveBackward(X);
 * cube.moveUp(X);
 * cube.moveDown(X);
 * 
 * cube.moveLeft(X);
 * cube.moveRight(X);
 * 
 * */
package  
{
	import away3d.containers.View3D;
	import away3d.core.render.Renderer;
	import away3d.primitives.Cube;
	import away3d.primitives.Sphere;
	import away3d.test.Button;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	/**
	 * ...
	 * @author zhengs
	 */
	[SWF(width="500", height="400", frameRate="60", backgroundColor="#FFFFFF")]
	public class Basic04_MoveForward extends Sprite 
	{
		public var view:View3D;
		private var cube:Cube;
		private var toggle:Boolean = false;
		private var bt:Button;
		private var cubeSpeed:Number = 5;
		private var label:TextField;
		
		public function Basic04_MoveForward() 
		{
			// add a button to toggle between the two ways of moving
			bt = new Button("Click to toggle",110);
			bt.x = 10;
			bt.y = 60;
			bt.addEventListener(MouseEvent.CLICK,resetCube);
			this.addChild(bt);
			
			// Add a textfield
			label = new TextField();
            label.autoSize = TextFieldAutoSize.LEFT;
            label.multiline = true;
            label.wordWrap = true;
            label.x = 10;
            label.y = 10;
            label.width = 480;
            label.defaultTextFormat = new TextFormat("Arial", 14, 0x000000);
            this.addChild(label);
            
			// create a viewport
			view = new View3D({x:250,y:200,radius:75,renderer:Renderer.INTERSECTING_OBJECTS});
			addChild(view);
			
			// create a sphere and put it on the 3D stage
			var sphere:Sphere = new Sphere({material:"red#black",radius:75});
			view.scene.addChild(sphere);
			
			// create a rectangular cube
			cube = new Cube({material:"green#black",depth:200,width:50,height:50});
			// We must rotate the cube, or you won't see any difference
			cube.rotationY = 45;
			// set the cube position
			resetCube();
			// add cube to scene
			view.scene.addChild(cube);
            
			// render the view
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		
		public function update(e:Event):void
		{
			// Keep cube within bounds
			if(cube.z+cubeSpeed > 200 || cube.z+cubeSpeed < -200){ cubeSpeed = cubeSpeed*(-1); }

			// use move method depending on toggle value
			if(toggle){
				cube.z += cubeSpeed;
			} else {
				cube.moveForward(cubeSpeed);
			}

			// re-render the view
			view.render();
		}
        
		private function resetCube(e:MouseEvent = null):void
		{
			// reset position
			cube.x = 0;
			cube.y = 0;
			cube.z = 0;
			
			// toggle movement method
			if(toggle){
				toggle = false;
				label.text = "Using cube.moveForward:\nThe cube moves forward according to it's rotation.";
			} else {
				toggle = true;
				label.text = "Using cube.z:\nThe cube moves relative to it's parent object (the view) ";
			}
		}
		
	}

}