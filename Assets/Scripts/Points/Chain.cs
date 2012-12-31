using UnityEngine;
using System.Collections;

public class Chain : MonoBehaviour
{
	public float cooldown;

	private int chain;
	private int visibleChain;
	private float delay;

	public void Start ()
	{
		chain = 1;
		visibleChain = 0;
		delay = 0;
	}

	public void Update ()
	{
		if(delay > 0){
			delay -= Time.deltaTime;
			if (delay <= 0) {
				delay = 0;
				chain = 1;
			}
		}

		if(visibleChain != chain) {
			visibleChain = chain;
			guiText.text = "x" + visibleChain;
		}
	}

	public void IncreaseChain()
	{
		chain++;
		delay = cooldown;
	}

	public int CurrentChain()
	{
		return chain;
	}
}
