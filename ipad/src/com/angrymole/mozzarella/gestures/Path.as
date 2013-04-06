package com.angrymole.mozzarella.gestures 
{
	import com.angrymole.mozzarella.util.Bounds;
	import flash.geom.Point;
	
	/**
	 * A Path is a long displacement of the finger in time
	 * It contains an array of intermediate nodes, and creates a group of intermediate swipes
	 * 
	 * @author Fabio Panettieri
	 */
	public class Path extends Gesture 
	{
		private var m_nodes:Vector.<Point>;
		private var m_bounds:Bounds;
		private var m_sections:Vector.<Section>;
		
		public function Path(_begin:Point, _end:Point, _duration:Number, _nodes:Vector.<Point>) 
		{
			super(_begin, _end, _duration);
			m_nodes = _nodes;
			m_bounds = new Bounds(m_begin, m_end);
			
			m_sections = new Vector.<Section>();
			m_sections.push(new Section(_begin, _nodes[0]));
			for (var i:int = 0; i < _nodes.length - 1; i++) {
				m_sections.push(new Section(_nodes[i], _nodes[i + 1]));
			}
			m_sections.push(new Section(_nodes[_nodes.length - 1], _end));
		}
		
		public function get nodes():Vector.<Point> 
		{
			return m_nodes;
		}
		
		public function get bounds():Bounds 
		{
			return m_bounds;
		}
		
		public function get sections():Vector.<Section> 
		{
			return m_sections;
		}
		
		override public function toString():String
		{
			var str:String = "[Path begin: " + m_begin.x + "," + m_begin.y + " end: " + m_end.x + "," + 	m_end.y + " duration: " + m_duration + " nodes: " + m_nodes.length + "]\n";
			for (var i:int = 0; i < m_sections.length; i++) {
				str += "\t" + m_sections[i] + "\n";
			}
			return str;
		}
	}
}