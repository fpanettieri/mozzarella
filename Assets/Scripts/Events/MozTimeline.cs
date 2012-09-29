/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-25
 @last-edit		2012-09-25
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

/**
 * Cronological list of events
 */
public class MozEventList : MonoBehaviour
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
