package com.angrymole.mozzarella.game.piece 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.TextureAsset;
	import com.angrymole.assets.TextureAtlasAsset;
	import com.angrymole.mozzarella.Game;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class GroupAssetFactory 
	{
		public static function getAsset(_type:PieceType):PieceAsset
		{
			switch(_type) {
				case PieceType.BLONDE: return atlasAsset(_type, "pelucas", "pelucon_01.png");
				case PieceType.RAVEN:  return atlasAsset(_type, "pelucas", "pelucon_02.png");
				case PieceType.BROWN:  return atlasAsset(_type, "pelucas", "pelucon_03.png");
				case PieceType.REBEL:  return atlasAsset(_type, "pelucas", "pelucon_05.png");
				case PieceType.IRISH:  return atlasAsset(_type, "pelucas", "pelucon_06.png");
			}
			throw new Error("Unsupported type: " + _type.id);
		}
		
		private static function staticAsset(_type:PieceType, _texture:String):StaticAsset
		{
			var asset:TextureAsset = Assets.i.getAsset(_texture) as TextureAsset;
			return new StaticAsset(_type, asset.texture);
		}
		
		private static function atlasAsset(_type:PieceType, _atlas:String, _texture:String):StaticAsset
		{
			var asset:TextureAtlasAsset = Assets.i.getAsset(_atlas) as TextureAtlasAsset;
			return new StaticAsset(_type, asset.atlas.getTexture(_texture));
		}
	}

}