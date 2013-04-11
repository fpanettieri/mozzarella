package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.constants.PieceSize;
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
		private var m_spawnProgression:Vector.<int>;
		private var m_spawnLife:Vector.<int>;
		private var m_swapTime:Number;
		
		public function Configuration(_level:XML) 
		{
			// TODO: parse level configuration
			m_rows = 8;
			m_columns = 12;
			m_pieceSize = PieceSize.LARGE;
			m_pieceTypes = new <PieceType>[new PieceType(0x5E43C8), new PieceType(0x5C4862), new PieceType(0xCB3BFB)];
			m_spawnIterations = new <int>[20, 40, 80];
			m_spawnProgression = new <int>[2, 4, 10, 12];
			m_spawnLife = new <int>[10, 8, 8, 6];
			m_swapTime = 0.5;
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

		public function get spawnProgression():Vector.<int>  
		{
			return m_spawnProgression;
		}
		
		public function get spawnLife():Vector.<int>
		{
			return m_spawnLife;
		}
		
		public function get swapTime():Number
		{
			return m_swapTime;
		}
	}
}