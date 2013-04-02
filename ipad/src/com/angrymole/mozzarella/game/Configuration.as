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
		private var m_pieceTypes:Array;
		private var m_spawnMin:int;
		private var m_spawnMax:int;
		private var m_spawnProgression:Array;
		private var m_spawnInterval:Number;
		
		public function Configuration(_level:XML) 
		{
			// TODO: parse level configuration
			m_rows = 8;
			m_columns = 12;
			m_pieceSize = PieceSize.LARGE;
			m_pieceTypes = [new PieceType(0xffff9900), new PieceType(0xff9900ff), new PieceType(0xff00ff99)];
			m_spawnMin = 2;
			m_spawnMax = 4;
			m_spawnProgression = [20, 120];
			m_spawnInterval = 5;
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
		
		public function get pieceTypes():Array 
		{
			return m_pieceTypes;
		}
		
		public function get spawnMin():int 
		{
			return m_spawnMin;
		}
		
		public function get spawnMax():int 
		{
			return m_spawnMax;
		}
		
		public function get spawnProgression():Array 
		{
			return m_spawnProgression;
		}
		
		public function get spawnInterval():Number 
		{
			return m_spawnInterval;
		}
	}
}