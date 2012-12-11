/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

// Shuffle bag
public class PieceQueue : MonoBehaviour
{
	// Inspector properties
	public int size = 512;

	// samples_1xid_1;samples_2xid_2;...;samples_nxid_n;
	public string frequency = "1x1;1x2";

	// Private / aux properties
	private int[] pieces;
	private int idx = 0;

	public void Start()
	{
		Randomize();
		Populate();
		Shuffle();
	}

	public int Peek()
	{
		return pieces[idx];
	}

	public int Peek(int offset)
	{
		return pieces[(idx + offset) % size];
	}

	public int Next()
	{
		if(idx >= size) {
			idx = 0;
			Shuffle();
		}
		return pieces[idx++];
	}

	// FIXME: REMOVE THIS!!!
	// used in the prototype to randomize the posibility of playing 4 or 3 colors
	private void Randomize()
	{
		frequency = Random.value < 0.6 ? "1x1;1x2;1x3" : "1x1;1x2;1x3;1x4";
	}

	private void Populate()
	{
		pieces = new int[size];
		string[] types = frequency.Split(';');

		// number of requested pieces. Should be <= size
		int requested = 0;

		// calculate number of requested pieces and ratio
		string[] pair;
		for(int i = 0; i < types.Length; i++) {
			pair = types[i].Split('x');
			requested += int.Parse(pair[0]);
		}

		// how many times each piece should be multiplied to fill the pieces buffer
		int ratio = Mathf.FloorToInt(size / requested);

		// fill the first part of the buffer with the requested pieces distribution
		idx = 0;
		int samples = 0;
		int type = 0;
		for(int i = 0; i < types.Length; i++) {
			pair = types[i].Split('x');
			type = int.Parse(pair[1]);
			samples = int.Parse(pair[0]) * ratio;
			for(int j = 0; j < samples; j++) {
				pieces[idx++] = type;
			}
		}

		// fill the holes with random pieces
		while(idx < size) {
			pair = types[Mathf.FloorToInt(Random.value * types.Length)].Split('x');
			pieces[idx++] = int.Parse(pair[1]);
		}

		idx = 0;
	}

	private void Shuffle()
	{
		int swap = 0;
		int val = 0;
		for(int i = 0; i < pieces.Length; i++) {
			val = pieces[i];
			swap = Mathf.FloorToInt(Random.value * size);
			pieces[i] = pieces[swap];
			pieces[swap] = val;
		}
	}
}
