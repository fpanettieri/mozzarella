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
 * Global event hub.
 * 
 * Any object or component can register to receiv a specific type of event
 * notifications, in order to react to them.
 */ 
public class Events
{
	// Singleton
	private static Events instance;

	public static Events i {
		get {
			if(instance == null) {
				instance = new Events();
			}
			return instance;
		}
	}
	
	private Dictionary<int, List<IEventListener>> listeners;
		
	private Events()
	{
		listeners = new Dictionary<int, List<IEventListener>>();
	}
	
	public void Register(int type, IEventListener listener)
	{
		if(!listeners.ContainsKey(type)) {
			listeners.Add(type, new List<IEventListener>());
		}
		
		#if UNITY_EDITOR
		if (listeners[type].Contains (listener)) {
			throw new System.Exception("Listener already registered");
		}
		#endif
		listeners[type].Add(listener);
	}
	
	public void Unregister(int type, IEventListener listener)
	{
		if(listeners.ContainsKey(type)) {
			listeners[type].Remove(listener);
		}
	}
	
	public void Notify(MozEvent ev)
	{
		if(listeners.ContainsKey(ev.type)) {
			List<IEventListener> list = listeners[ev.type];
			foreach(IEventListener listener in list) {
				listener.Notify(ev);
			}
		}
	}
}
