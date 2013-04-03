package com.angrymole.mozzarella.game 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * Used to posotion
	 * 
	 * @author 
	 */
	public class Placeholder extends Sprite 
	{
		private var m_quad:Quad;
		
		public function Placeholder(_width:int, _height:int, _color:uint) 
		{
			m_quad = new Quad(_width, _height, _color);
			addChild(m_quad);
			
			// trace("WARNING: you are still using a placeholder here");
		}
	}
}