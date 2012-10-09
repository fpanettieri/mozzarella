using UnityEngine;
using System.Collections;

public class PieceSpawner : MonoBehaviour, IEventListener
{
	private Grid grid;
	private PiecePool pool;
	
	private Piece piece;
	private Vector3 pieceSize;
	private PieceEvent e;
	
	public void Awake ()
	{
		Events.i.Register (MozEventType.PieceSpawn, this);
		Events.i.Register (MozEventType.PieceLock, this);
		
		grid = GetComponent<Grid> ();
		pool = GetComponent<PiecePool> ();
		
		MeshFilter filter = grid.piecePrefab.GetComponent<MeshFilter> ();
		pieceSize = filter.sharedMesh.bounds.size;
		
		// TODO: Initialize grid
	}
	
	public void Notify (MozEvent ev)
	{
		e = ev as PieceEvent;
		if (e.type == MozEventType.PieceSpawn) {
			if (TimeMachine.rewind) {
				DestroyPiece (e);
			} else {
				SpawnPiece (e);
			}
		} else if (e.type == MozEventType.PieceLock) {
			if (TimeMachine.rewind) {
				UnlockPiece (e);
			} else {
				LockPiece (e);
			}
		}
	}
	
	private void SpawnPiece (PieceEvent e)
	{
		piece = pool.Pick ();
		piece.transform.localPosition = new Vector3 (e.column * pieceSize.x, grid.rows * pieceSize.y, 0);
		piece.renderer.material = PieceMaterial.getMaterial (e.piece);
		piece.type = e.piece;
		piece.Enable ();
		
		grid.AddMovingPiece (piece);
		e.id = piece.id;
	}
	
	private void DestroyPiece (PieceEvent e)
	{
		pool.Release (e.id);
		piece = pool [e.id];
		piece.Disable ();
	}
	
	private void LockPiece (PieceEvent e)
	{
		grid.cells [e.column + e.row * grid.columns] = e.piece;
	}
	
	private void UnlockPiece (PieceEvent e)
	{
		grid.cells [e.column + e.row * grid.columns] = PieceType.Empty;
		grid.AddMovingPiece(pool[e.id]);
	}
}
