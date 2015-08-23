package com.zs.ui
{
	import flash.display.Sprite;

	public function alert(value:String):void
	{
		var bg:Sprite = new Sprite();
		bg.graphics.beginFill(0xcccccc);
		bg.graphics.drawRect(0,0,100,100);
		bg.graphics.endFill();
	}
}