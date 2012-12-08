using UnityEngine;
using System.Collections;

public class PointsText : MonoBehaviour
{
	// injected dependency
	private PointsMeter meter;

	void Start()
	{
		meter = GameObject.Find(GameObjectName.POINTS_METER).GetComponent<PointsMeter>();
	}
	
	public void Update()
	{
		guiText.text = meter.points.ToString("Points 0000");
	}
}
