package com.angrymole.mozzarella.game.piece 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class PieceAsset 
	{
		protected var m_type:PieceType;
		protected var m_asset:DisplayObject;
		
		public function PieceAsset(_type:PieceType)
		{
			m_type = _type;
		}
		
		public function get asset():DisplayObject
		{
			return m_asset;
		}
		
		public function clone():PieceAsset
		{
			return PieceAssetFactory.getAsset(m_type);
		}
		
		public function set alpha(_value:Number):void
		{
			m_asset.alpha = _value;
		}
	}
}