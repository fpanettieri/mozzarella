package com.angrymole.mozzarella.game.piece 
{
	import com.angrymole.mozzarella.Game;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class PieceAssetFactory 
	{
		public static function getAsset(_type:PieceType):PieceAsset
		{
			switch(_type) {
				case PieceType.BLONDE: return staticAsset(_type, "peluca_01");
				case PieceType.RAVEN: return staticAsset(_type, "peluca_02");
				case PieceType.BROWN: return staticAsset(_type, "peluca_03");
				case PieceType.REBEL: return staticAsset(_type, "peluca_05");
				case PieceType.IRISH: return staticAsset(_type, "peluca_06");
			}
			throw new Error("Unsupported type: " + _type.id);
		}
		
		private static function staticAsset(_type:PieceType, _texture:String):StaticAsset
		{
			return new StaticAsset(_type, Game.current.assets.getAsset(_texture))
		}
	}

}