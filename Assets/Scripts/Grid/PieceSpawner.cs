using UnityEngine;
using System.Collections;

public class PieceSpawner : MonoBehaviour, IEventListener
{
	private Grid grid;
	private Vector3 pieceSize;
	private int pieceId;

	// Use this for initialization
	public void Start ()
	{
		Events.i.Register (MozEventType.PieceSpawn, this);
		
		grid = GetComponent<Grid> ();
		MeshFilter filter = grid.piecePrefab.GetComponent<MeshFilter> ();
		pieceSize = filter.sharedMesh.bounds.size;
		pieceId = 0;
	}
	
	public void Notify (MozEvent ev)
	{
		if (ev.type != MozEventType.PieceSpawn) {
			return;
		}
		
		PieceSpawnEvent e = ev as PieceSpawnEvent;
		if (TimeMachine.rewind) {
			DestroyPiece (e);
		} else {
			SpawnPiece (e);
		}
	}
	
	private void SpawnPiece (PieceSpawnEvent e)
	{
		if (e.piece == PieceType.Empty) {
			return;
		}
		
		GameObject go = Instantiate (grid.piecePrefab) as GameObject;
		go.transform.parent = grid.transform;
		go.transform.localPosition = new Vector3 (e.column * pieceSize.x, grid.rows * pieceSize.y, 0);
		
		MeshRenderer renderer = go.GetComponent<MeshRenderer> ();
		renderer.material = PieceMaterial.getMaterial (e.piece);
		
		Piece piece = go.GetComponent<Piece> ();
		piece.type = e.piece;
		piece.moving = true;
		grid.AddPiece (piece);
		
		// create a piece id the first time this event is executed.
		if (e.id < 0) { 
			e.id = pieceId; 
			piece.id = pieceId++;
		} else {
			piece.id = e.id;
		}
	}
	
	private void DestroyPiece (PieceSpawnEvent e)
	{
		Piece piece = grid.FindPiece (e.id);
		if (piece == null) { return; }
		Destroy (piece.gameObject);
		grid.RemovePiece (piece);
	}
}
