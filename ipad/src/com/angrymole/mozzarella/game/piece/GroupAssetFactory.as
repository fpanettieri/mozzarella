package com.angrymole.mozzarella.game.piece 
{
	import com.angrymole.mozzarella.Game;
	import com.angrymole.mozzarella.game.piece.PieceAsset;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import com.angrymole.mozzarella.game.piece.StaticAsset;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class GroupAssetFactory 
	{
		public static function getAsset(_type:PieceType):PieceAsset
		{
			switch(_type) {
				case PieceType.BLONDE: return staticAsset(_type, "pelucon_01");
				case PieceType.RAVEN: return staticAsset(_type, "pelucon_02");
				case PieceType.BROWN: return staticAsset(_type, "pelucon_03");
				case PieceType.REBEL: return staticAsset(_type, "pelucon_05");
				case PieceType.IRISH: return staticAsset(_type, "pelucon_06");
			}
			throw new Error("Unsupported type: " + _type.id);
		}
		
		private static function staticAsset(_type:PieceType, _texture:String):StaticAsset
		{
			return new StaticAsset(_type, Game.current.assets.getTexture(_texture))
		}
	}

}