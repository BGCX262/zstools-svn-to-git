package com.away3d
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Cover extends Sprite
	{
		private var parentMovie:Sprite;
		private var coverSquare:Sprite;
		private var coverText:TextField;
		private var coverTextShadow:TextField;
		private var text:String;
		private var blurredParent:Bitmap;
		
		private var stageW:Number; 
		private var stageH:Number;
		
		public function Cover(parent:Sprite,w:Number = 500, h:Number = 400, txt:String = null)
		{
			parentMovie = parent;
			stageW = w;
			stageH = h;
			text = txt;
			super();
			// Build the "disabled" state
			coverSquare = new Sprite();
			coverSquare.graphics.beginFill(0xffffff,0.05);
			coverSquare.graphics.drawRect(0,0,parentMovie.stage.stageWidth,parentMovie.stage.stageHeight);
			coverSquare.graphics.endFill();
			addChild(coverSquare);
			
			// Create explanatory text
			var format1:TextFormat = new TextFormat();
			format1.color = 0x000000;
			format1.size = 12;
			format1.align = "center";
			format1.font = "_sans";
			var format2:TextFormat = new TextFormat();
			format2.color = 0xffffff;
			format2.size = 12;
			format2.align = "center";
			format2.font = "_sans";
			coverText = new TextField();
			coverTextShadow = new TextField();
			if(!text){
				coverText.text = "Roll over to view";
				coverTextShadow.text = "Roll over to view";
			} else {
				coverText.text = text;
				coverTextShadow.text = text;
			}
			coverText.setTextFormat(format1);
			coverTextShadow.setTextFormat(format2);
			coverText.width = parentMovie.stage.stageWidth;
			coverTextShadow.width = parentMovie.stage.stageWidth;
            coverTextShadow.filters = [new BlurFilter()];

			// Prep for blurred parent
			blurredParent = new Bitmap();
			this.addChild(blurredParent);
			parentMovie.stage.addEventListener(Event.MOUSE_LEAVE,showCover);
			parentMovie.stage.addEventListener(MouseEvent.MOUSE_OVER,hideCover);
			this.addEventListener(Event.ENTER_FRAME,initCover);
			showCover();
		}
		private function hideCover(event:MouseEvent):void
		{
			if (event.stageX < this.stageW)
			{
			}
			if (event.stageX > 0)
			{
			}
			if (event.stageY < this.stageH)
			{
			}
			if (event.stageY > 0)
			{
				this.visible = false;
			}
		}
		private function showCover(e:Event = null):void
		{
			if(!this.visible){
				refresh();
			}
			// Turn on cover
			this.visible = true;
            this.dispatchEvent( new Event(Event.ACTIVATE) );
		}
		private function initCover(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME,initCover);
			refresh();
			// Turn on cover
			this.visible = true;			
		}
		public function refresh():void
		{
			var bits:BitmapData = new BitmapData(stageW,stageH);
			bits.draw(coverSquare);
			bits.draw(parentMovie);
			var backgroundImage:Bitmap = new Bitmap(bits);
			backgroundImage.filters = new Array( new BlurFilter(6,6,4) );

			// Copy the blurred text and add the text
			var textOverlay:BitmapData = new BitmapData(stageW,stageW,false);
			textOverlay.draw(bits);
			textOverlay.draw(backgroundImage,null, null, BlendMode.MULTIPLY);
			
            textOverlay.applyFilter(textOverlay, textOverlay.rect, new Point(), new BlurFilter(5,5));
            textOverlay.draw(textOverlay);
			textOverlay.draw(coverTextShadow,null,null,null,null,true);
			textOverlay.draw(coverText,null,null,null,null,true);

			blurredParent.bitmapData = textOverlay;
		}
	}
}