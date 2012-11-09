/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

/**
 * Cronological list of events
 */
public class Timeline : MonoBehaviour
{
	private List<MozEvent> events;
	
	public MozEvent this[int i] {
		get { return events[i]; }
		set { events[i] = value; }
	}
	
	public int count { get { return events.Count; } }
	
	public void Awake()
	{
		events = new List<MozEvent>();
	}
	
	public void Add(MozEvent e)
	{
		events.Add(e);
	}

	public void Insert(int index, MozEvent e)
	{
		events.Insert(index, e);
	}

	public void Remove(MozEvent e)
	{
		int idx = events.IndexOf(e);
		if(idx < TimeMachine.idx) {
			TimeMachine.idx--;
		}
		events.Remove(e);
	}
	
	public void Sort()
	{
		events.Sort();
	}
	
	/**
	 * DEPRECATED:
	 * Given a specific point in time, find the next event
	 */ 
	public int Find(int frame)
	{
		for(int i = 0; i < events.Count - 1; i++) {
			if(events[i].frame >= frame) {
				return i;
			}
		}
		return 0;
	}
	
	/**
	 * DEPRECATED:
	 * Optimized event search
	 */ 
	public int Find(int frame, int idx)
	{
		// In case of out of bounds idx, do a linear search
		if(idx < 0 || idx >= events.Count) {
			return Find(frame);
		}
		
		if(frame < events[idx].frame) {
			for(int i = idx; i < events.Count - 1; i++) {
				if(events[i].frame >= frame) {
					return i;
				}	
			}
		} else {
			for(int i = idx; i >= 0; i--) {
				if(events[i].frame < frame) {
					return i + 1;
				}
			}
		}
		return 0;
	}

	override public string ToString()
	{
		string str = "F " + TimeMachine.frame + "\t";
		for(int i = 0; i < events.Count; i++) {
			str += events[i].initial + " " + events[i].frame + "; ";
		}
		return str;
	}
}
