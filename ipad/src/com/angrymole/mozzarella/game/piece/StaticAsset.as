package com.angrymole.mozzarella.game.piece 
{
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class StaticAsset extends PieceAsset
	{
		public function StaticAsset(_type:PieceType, _texture:Texture)
		{
			super(_type);
			m_asset = new Image(_texture);
		}
	}
}