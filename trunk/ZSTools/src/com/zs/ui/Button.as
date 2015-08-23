package com.zs.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Button extends Sprite
	{
		private var labelText:TextField = new TextField();
		
		public function Button()
		{
			drawUI();
			this.buttonMode = true;
		}
		
		private function drawUI():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x00ff00,0.6);
			this.graphics.drawRoundRect(0,0,70,20,10,10);
			this.graphics.endFill();
		}
		
		public function set label(value:String):void
		{
			var format:TextFormat = new TextFormat();
			format.align = 'center';
			labelText.width = 70;
			labelText.height = 20;
			labelText.y = 5;
			labelText.defaultTextFormat = format;
			labelText.text = value;
			labelText.mouseEnabled = false;
			addChild(labelText);
		}
	}
}