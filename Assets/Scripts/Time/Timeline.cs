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
	
	public void Awake ()
	{
		events = new List<MozEvent> ();
	}
	
	public void Add (MozEvent e)
	{
		events.Add (e);
		Debug.Log ("Event added: " + e);
	}

	public bool Remove (MozEvent e)
	{
		return events.Remove (e);
	}
	
	public void Sort ()
	{
		events.Sort ();
	}
}
