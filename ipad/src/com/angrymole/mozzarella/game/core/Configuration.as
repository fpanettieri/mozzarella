package com.angrymole.mozzarella.game.core 
{
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
		private var m_rows:int;
		private var m_columns:int;
		private var m_pieceSize:int;
		private var m_pieceTypes:Vector.<PieceType>;
		private var m_spawnIterations:Vector.<int>;
		private var m_spawnCount:Vector.<int>;
		private var m_spawnLife:Vector.<int>;
		private var m_swapTime:Number;
		private var m_mastery:Vector.<int>;
		
		public function Configuration(_level:XML) 
		{
			// TODO: parse level configuration
			m_rows = 8;
			m_columns = 10;
			m_pieceSize = PieceSize.BUFFERED;
			m_pieceTypes = new <PieceType>[PieceType.BLONDE,PieceType.RAVEN, PieceType.IRISH, PieceType.REBEL];
			m_spawnIterations = new <int>[6, 20, 40, 80];
			m_spawnCount = new <int>[2, 4, 6, 10, 12];
			m_spawnLife = new <int>[10, 12, 12, 10, 10];
			m_swapTime = 0.3;
			m_mastery = new <int>[1000, 5000, 10000];
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
		
		public function get swapTime():Number
		{
			return m_swapTime;
		}
		
		public function get mastery():Vector.<int> 
		{
			return m_mastery;
		}
	}
}