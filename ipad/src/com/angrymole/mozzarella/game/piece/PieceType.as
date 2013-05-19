package com.angrymole.mozzarella.game.piece 
{
	/**
	 * Define a possible piece that can spawn in game
	 * 
	 * @author ...
	 */
	public class PieceType 
	{
		private var m_id:int;
		private var m_color:uint;
		
		public function PieceType(_id:int,  _color:uint) 
		{
			m_id = _id;
			m_color = _color;
		}
		
		public function get id():int 
		{
			return m_id;
		}
		
		public function get color():uint 
		{
			return m_color;
		}
		
		public function equals(_type:PieceType):Boolean
		{
			return m_id == _type.id && m_color == _type.color;
		}
	}

}