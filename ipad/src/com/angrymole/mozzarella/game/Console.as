package com.angrymole.mozzarella.game 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Console extends Sprite
	{
		private var m_text:TextField;
		
		public function Console(_width:Number, _height:Number, _text:String)
		{
			m_text = new TextField(_width, _height, _text, "Verdana", 12, 0xD1B993);
			m_text.hAlign =  HAlign.LEFT;
			m_text.vAlign =  VAlign.TOP;
			addChild(m_text);
		}
		
		public function debug(_msg:String):void
		{
			m_text.text = _msg;
		}
	}
}