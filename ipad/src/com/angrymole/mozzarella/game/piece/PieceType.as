package com.angrymole.mozzarella.game.piece 
{
	/**
	 * Define a possible piece that can spawn in game
	 * 
	 * @author ...
	 */
	public class PieceType 
	{
		public static const BLONDE:PieceType = new PieceType(0);
		public static const RAVEN:PieceType = new PieceType(1);
		public static const BROWN:PieceType = new PieceType(2);
		public static const REBEL:PieceType = new PieceType(3);
		public static const IRISH:PieceType = new PieceType(4);
		
		public static function fromString(_type:String):PieceType
		{
			switch(_type) {
				case "blonde": return BLONDE;
				case "raven": return RAVEN;
				case "brown": return BROWN;
				case "rebel": return REBEL;
				case "irish": return IRISH;
			}
			throw new Error("Unexpected PieceType: " + _type);
		}
		
		public static function fromInt(_type:int):PieceType
		{
			switch(_type) {
				case 0: return REBEL;
				case 1: return RAVEN;
				case 2: return BLONDE;
				case 3: return IRISH;
				case 4: return BROWN;
			}
			throw new Error("Unexpected PieceType: " + _type);
		}
		
		private var m_id:int;
		
		public function PieceType(_id:int) 
		{
			m_id = _id;
		}
		
		public function get id():int 
		{
			return m_id;
		}

		public function equals(_type:PieceType):Boolean
		{
			return m_id == _type.id;
		}
		
		public function toString():String
		{
			return m_id.toString();
		}
	}

}