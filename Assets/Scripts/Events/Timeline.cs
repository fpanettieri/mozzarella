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
	
	public MozEvent this [int i] {
		get { return events [i]; }
		set { events [i] = value; }
	}
	
	public int count { get { return events.Count; } }
	
	public void Awake ()
	{
		events = new List<MozEvent> ();
	}
	
	public void Add (MozEvent e)
	{
		events.Add (e);
	}
	
	public void Insert (int index, MozEvent e)
	{
		events.Insert (index, e);
	}

	public bool Remove (MozEvent e)
	{
		return events.Remove (e);
	}
	
	public void Sort ()
	{
		events.Sort ();
	}
	
	/**
	 * Given a specific point in time, find the nect event
	 */ 
	public int Find (float time)
	{
		for (int i = 0; i < events.Count - 1; i++) {
			if (events [i].time >= time) {
				return i;
			}
		}
		return 0;
	}
	
	/**
	 * Optimized event search
	 */ 
	public int Find (float time, int idx)
	{
		// In case of out of bounds idx, do a linear search
		if (idx < 0 || idx >= events.Count) {
			return Find (time);
		}
		
		if (time < events [idx].time) {
			for (int i = idx; i < events.Count - 1; i++) {
				if (events [i].time >= time) {
					return i;
				}	
			}
		} else {
			for (int i = idx; i >= 0; i--) {
				if (events [i].time < time) {
					return i + 1;
				}
			}
		}
		return 0;
	}
}
