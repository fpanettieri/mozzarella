using UnityEngine;
using System.Collections;

public class BackgroundColor : MonoBehaviour
{
	private Color current;
	private Color next;

	private const float interval = 3.0f;
	private float delay = 0.0f;

	public void Start()
	{
		current = PickColor();
		next = PickColor();
		delay = interval;
	}

	public void Update()
	{
		renderer.material.color = Color.Lerp(current, next, 1 - delay / interval);
		delay -= Time.deltaTime;
		if(delay < 0){
			delay = interval;
			current = next;
			next = PickColor();
		}
	}

	private Color PickColor()
	{
		return new ColorHSV(Random.Range(0.0f, 360.0f), Random.Range(0.3f, 0.7f), Random.Range(0.5f, 0.7f), 1).ToColor();
	}
}
