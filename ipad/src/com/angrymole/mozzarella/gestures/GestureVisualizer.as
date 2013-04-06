package com.angrymole.mozzarella.gestures 
{
	import com.angrymole.mozzarella.util.Bounds;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class GestureVisualizer extends Sprite 
	{
		public function visualize(_gesture:Gesture):void
		{
			clear();
			if (_gesture is Tap) {
				renderTap(_gesture as Tap);
				
			} else if (_gesture is Swipe) {
				renderSwipe(_gesture as Swipe);
				
			} else if (_gesture is Path) {
				renderPath(_gesture as Path);
				
			} else {
				throw new Error("Gesture not recognized: " + _gesture);
			}
		}
		
		private function clear():void
		{
			removeChildren();
		}
		
		private function renderTap(_tap:Tap):void
		{
			renderCircle(_tap.x, _tap.y, 0x336699, 22);
		}
		
		private function renderSwipe(_swipe:Swipe):void
		{
			renderCircle(_swipe.begin.x, _swipe.begin.y, 0x336699, 22);
			renderCircle(_swipe.end.x, _swipe.end.y, 0x336699, 22);
			renderLine(_swipe.begin, _swipe.end, 0x000000, 4);
		}
		
		private function renderPath(_path:Path):void
		{
			renderCircle(_path.begin.x, _path.begin.y, 0x336699FF, 22);
			renderCircle(_path.end.x, _path.end.y, 0x336699FF, 22);
			
			for (var i:int = 0; i < _path.sections.length; i++ ) {
				renderLine(_path.sections[i].begin, _path.sections[i].end, 0x000000, 4);
			}
		}
		
		private function renderCircle(_x:Number, _y:Number, _color:uint, _radius:int):void
		{
			var shape:flash.display.Sprite = new flash.display.Sprite();
			with (shape.graphics) {
				beginFill(_color, 1);
				drawCircle(_radius, _radius, _radius);
				endFill();
			}
			var bmd:BitmapData = new BitmapData(_radius * 2, _radius * 2, true, 0);
			bmd.draw(shape);
			var image:Image = new Image(Texture.fromBitmapData(bmd));
			image.x = _x - _radius;
			image.y = _y - _radius;
			addChild(image);
		}
		
		private function renderLine(_begin:Point, _end:Point, _color:uint, _thickness:int):void
		{
			var shape:flash.display.Sprite = new flash.display.Sprite();
			var bounds:Bounds = new Bounds(_begin, _end);
			
			with (shape.graphics) {
				moveTo(bounds.maxX - _begin.x, bounds.maxY - _begin.y);
				lineStyle(_thickness, _color);
				lineTo(bounds.maxX - _end.x, bounds.maxY - _end.y);
			}
			
			var bmd:BitmapData = new BitmapData(bounds.maxX - bounds.minX + _thickness, bounds.maxY - bounds.minY + _thickness, true, 0);
			bmd.draw(shape);
			var image:Image = new Image(Texture.fromBitmapData(bmd));
			image.x = bounds.minX;
			image.y = bounds.minY;
			addChild(image);
		}
	}
}