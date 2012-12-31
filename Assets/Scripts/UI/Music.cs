using UnityEngine;
using System.Collections;

public class Music : MonoBehaviour
{
	public AudioClip intro;
	public AudioClip forward;
	public AudioClip backward;

	private bool rewind;

	void Start ()
	{
		rewind = false;
		audio.clip = intro;
		audio.Play();
	}
	
	void Update ()
	{
		if(audio.clip.Equals(intro) && !audio.isPlaying){
			audio.loop = true;
			audio.clip = forward;
			audio.Play();

		} else if(!rewind && TimeMachine.rewind){
			rewind = true;
			float time = forward.length - audio.time;
			audio.clip = backward;
			audio.time = time;
			audio.Play();

		} else if(rewind && !TimeMachine.rewind) {
			rewind = false;
			float time = backward.length - audio.time;
			audio.clip = forward;
			audio.time = time;
			audio.Play();
		}
	}
}
