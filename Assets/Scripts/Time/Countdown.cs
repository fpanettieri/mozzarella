using UnityEngine;
using System.Collections;

public class Countdown : MonoBehaviour
{
	public float time = 60;
	public float fps = 60;

	private float max;
	private float second;

	public void Start()
	{
		max = time * fps;
	}

	public void Update()
	{
		// FIXME: cheat used to skip frames
		if(TimeMachine.skip) { return; }

		second = (max - TimeMachine.frame) / fps;
		guiText.text = second.ToString("00.0");
	}
}
