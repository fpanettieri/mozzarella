package com.angrymole.mozzarella.game 
{
	/**
	 * Define a possible piece that can spawn in game
	 * 
	 * @author ...
	 */
	public class PieceType 
	{
		private var m_color:uint;
		
		public function PieceType(_color:uint) 
		{
			m_color = _color;
		}
		
		public function get color():uint 
		{
			return m_color;
		}
		
		public function equals(_type:PieceType):Boolean
		{
			return _type.color == m_color;
		}
	}

}