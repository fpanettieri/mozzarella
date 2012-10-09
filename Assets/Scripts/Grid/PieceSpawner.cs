using UnityEngine;
using System.Collections;

public class PieceSpawner : MonoBehaviour, IEventListener
{
	private Grid grid;
	private PiecePool pool;
	private Piece piece;
	private Vector3 pieceSize;
	
	public void Awake ()
	{
		Events.i.Register (MozEventType.PieceSpawn, this);
		
		grid = GetComponent<Grid> ();
		pool = GetComponent<PiecePool> ();
		
		MeshFilter filter = grid.piecePrefab.GetComponent<MeshFilter> ();
		pieceSize = filter.sharedMesh.bounds.size;
		
		// TODO: Initialize grid
	}
	
	public void Notify (MozEvent ev)
	{
		PieceEvent e = ev as PieceEvent;
		if (TimeMachine.rewind) {
			DestroyPiece (e);
		} else {
			SpawnPiece (e);
		}
	}
	
	private void SpawnPiece (PieceEvent e)
	{
		piece = pool.Pick ();
		piece.transform.localPosition = new Vector3 (e.column * pieceSize.x, grid.rows * pieceSize.y, 0);
		piece.renderer.material = PieceMaterial.getMaterial (e.piece);
		piece.type = e.piece;
		piece.moving = true;
		piece.Enable ();
		
		grid.AddPiece (piece);
		e.id = piece.id;
	}
	
	private void DestroyPiece (PieceEvent e)
	{
		pool.Release (e.id);
		piece = pool [e.id];
		piece.Disable ();
	}
}
