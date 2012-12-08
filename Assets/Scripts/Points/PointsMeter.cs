using UnityEngine;
using System.Collections;

public class PointsMeter : MonoBehaviour
{
	public int max = 300;
	public float points = 0;
	public Vector3 top;

	private float progress = 0;

	public void Start()
	{
		top = new Vector2( renderer.bounds.center.x, renderer.bounds.max.y);
	}

	public void AddPoints(int p)
	{
		points += p;
		progress = Mathf.Clamp( points / max, 0, 1 );
		transform.localScale = new Vector3(1, progress, 1);
		renderer.material.SetTextureScale("_MainTex", new Vector2(1, progress));
		top = new Vector3( renderer.bounds.center.x, renderer.bounds.max.y, 0);
	}
}
