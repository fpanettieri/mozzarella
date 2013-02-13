using UnityEngine;
using System.Collections.Generic;

public class IncommingPieces : MonoBehaviour, IEventListener
{
	// inspector properties
	public int max = int.MaxValue;
	public int rows;
	public int columns;
	public GameObject prefab;
	public GUIText text;

	// internal state
	private IncommingPiece[] pieces;
	private List<int> types;
	private List<int> frames;

	// aux variables
	private bool dirty;
	private int count;

	public void Start()
	{
		count = rows * columns;

		MeshFilter filter = prefab.GetComponent<MeshFilter>();
		Vector3 pieceSize = filter.sharedMesh.bounds.size;

		pieces = new IncommingPiece[count];

		GameObject go;
		IncommingPiece incomming;
		for(int row = 0; row < rows; row++){
			for(int column = 0; column < columns; column++){
				go = Instantiate(prefab) as GameObject;
				go.transform.parent = transform;
				go.transform.localPosition = new Vector3(pieceSize.x * column, pieceSize.y * row);
				go.name = prefab.name;

				incomming = go.GetComponent<IncommingPiece>();
				incomming.offset = count - (column + count) - 1;
				pieces[column + row * columns] = incomming;
			}
		}

		Events.i.Register(MozEventType.PieceSpawn, this);
		types = new List<int>();
		frames = new List<int>();

		UpdatePreview();
	}

	public void Notify(MozEvent ev)
	{
		if(!TimeMachine.rewind){ return; }
		PieceSpawnEvent e = ev as PieceSpawnEvent;

		types.Add(e.piece);
		frames.Add(ev.frame);
		dirty = true;
		
		if(types.Count >= max){
			TimeMachine.paused = true;
		}
	}

	public void Update()
	{
		if(types.Count == max && Input.GetKeyUp(KeyCode.Space)){
			TimeMachine.paused = false;
		}
		
		if(dirty){ UpdatePreview(); }
		if(TimeMachine.rewind){ return; }
		
		while(types.Count > 0 && TimeMachine.frame == frames[frames.Count - 1]){
			frames.RemoveAt(frames.Count - 1);
			types.RemoveAt(types.Count - 1);
			dirty = true;
		}
	}

	private void UpdatePreview()
	{
		dirty = false;

		int offset = Mathf.FloorToInt(types.Count / count) * count;
		int filled = types.Count - offset;

		for(int i = 0; i < filled; i++){
			pieces[i].renderer.material = PieceMaterial.getMaterial(types[i + offset]);
		}

		for(int i = count - 1; i >= filled; i--){
			pieces[i].renderer.material = PieceMaterial.getMaterial(0);
		}

		text.text = types.Count.ToString("Incoming 000");
	}

}
