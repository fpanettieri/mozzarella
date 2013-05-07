package com.angrymole.mozzarella.game 
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
		
		public function Placeholder(_width:int, _height:int, _color:uint, _text:String = "") 
		{
			m_quad = new Quad(_width, _height, _color);
			addChild(m_quad);
			
			m_text = new TextField(_width, _height, _text);
			addChild(m_text);
			
			// trace("WARNING: you are still using a placeholder here");
		}
	}
}