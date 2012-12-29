using UnityEngine;
using System.Collections;

public class Music : MonoBehaviour
{
	public AudioSource forward;
	public AudioSource backward;

	private bool rewind;
	private float length;

	void Start ()
	{
		rewind = false;
		forward.Play();
		length = forward.clip.length;
	}
	
	void Update ()
	{

		if(!rewind && TimeMachine.rewind){
			rewind = true;
			forward.Pause();
			backward.time = length - forward.time;
			backward.Play();

		} else if(rewind && !TimeMachine.rewind) {
			rewind = false;
			backward.Pause();
			forward.time = length - backward.time;
			forward.Play();
		}
	}
}
