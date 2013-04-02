package com.angrymole.mozzarella.game 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Piece extends Sprite 
	{
		private var m_quad:Quad;
		private var m_color:int;
		
		public function Piece(_color:uint) 
		{
			m_color = _color;
			
			m_quad = new Quad(64, 64, _color);
			addChild(m_quad);
		}
	}
}