package com.angrymole.mozzarella.game.core 
{
	import com.adobe.utils.StringUtil;
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.XMLAsset;
	import com.angrymole.mozzarella.constants.PieceSize;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import starling.display.Sprite;
	
	/**
	 * Given an xml Parse and expose level configuration 
	 * 
	 * @author Fabio Panettieri
	 */
	public class Configuration
	{
		private var m_asset:XMLAsset;
		private var m_xml:XML;
		
		private var m_rows:int;
		private var m_columns:int;
		private var m_pieceSize:int;
		private var m_pieceTypes:Vector.<PieceType>;
		private var m_spawnIterations:Vector.<int>;
		private var m_spawnCount:Vector.<int>;
		private var m_spawnLife:Vector.<int>;
		private var m_mastery:Vector.<int>;
		
		public function Configuration() 
		{
			m_asset = Assets.i.getAsset("level") as XMLAsset;
			m_xml = m_asset.xml;
			
			m_rows = m_xml.@rows;
			m_columns = m_xml.@columns;
			m_pieceSize = PieceSize.BUFFERED;
			m_pieceTypes = parsePieceTypes(m_xml.@pieceTypes);
			m_spawnIterations = parseIntVector(m_xml.@spawnIterations);
			m_spawnCount = parseIntVector(m_xml.@spawnCount);
			m_spawnLife = parseIntVector(m_xml.@spawnLife);
			m_mastery = parseIntVector(m_xml.@mastery);
		}
		
		private function parsePieceTypes(_types:String):Vector.<PieceType>
		{
			var types:Vector.<PieceType> = new Vector.<PieceType>();
			var typesArr:Array = _types.split(",");
			
			for ( var i:int = 0; i < typesArr.length; i++ ) {
				types.push(PieceType.fromString(StringUtil.trim(typesArr[i]).toLowerCase()));
			}
			
			return types;
		}
		
		private function parseIntVector(_ints:String):Vector.<int>
		{
			var ints:Vector.<int> = new Vector.<int>();
			var intsArr:Array = _ints.split(",");
			
			for ( var i:int = 0; i < intsArr.length; i++ ) {
				ints.push(int(StringUtil.trim(intsArr[i])));
			}
			
			return ints;
		}
		
		public function get rows():int 
		{
			return m_rows;
		}
		
		public function get columns():int 
		{
			return m_columns;
		}
		
		public function get pieceSize():int 
		{
			return m_pieceSize;
		}
		
		public function get pieceTypes():Vector.<PieceType> 
		{
			return m_pieceTypes;
		}
		
		public function get spawnIterations():Vector.<int> 
		{
			return m_spawnIterations;
		}

		public function get spawnCount():Vector.<int>  
		{
			return m_spawnCount;
		}
		
		public function get spawnLife():Vector.<int>
		{
			return m_spawnLife;
		}
		
		public function get mastery():Vector.<int> 
		{
			return m_mastery;
		}
	}
}