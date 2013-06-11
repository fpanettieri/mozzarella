package com.angrymole.mozzarella.util 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * Used to posotion
	 * 
	 * @author 
	 */
	public class Placeholder extends Sprite 
	{
		private var m_quad:Quad;
		private var m_text:TextField;
		
		public function Placeholder(_width:int, _height:int, _color:uint, _text:String = "", _textColor:uint = 0xffd0d0d0 ) 
		{
			m_quad = new Quad(_width, _height, _color);
			addChild(m_quad);
			
			m_text = new TextField(_width, _height, _text);
			m_text.color = _textColor;
		//	addChild(m_text);
			
			// trace("WARNING: you are still using a placeholder here");
		}
	}
}