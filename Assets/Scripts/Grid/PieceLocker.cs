using UnityEngine;
using System.Collections;

public class PieceLocker : MonoBehaviour, IEventListener
{
	// Dependencies
	private Grid grid;
	private PiecePool pool;
	private Timeline timeline;

	// Private / aux properties
	private Piece piece;
	private Vector3 pieceSize;
	
	public void Awake()
	{
		Events.i.Register(MozEventType.PieceLock, this);
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
		timeline = GameObject.Find(GameObjectName.TIME).GetComponent<Timeline>();
	}
	
	public void Notify(MozEvent e)
	{
		if(TimeMachine.rewind) {
			UnlockPiece(e as PieceLockEvent);
		} else {
			LockPiece(e as PieceLockEvent);
		}
	}

	private void LockPiece(PieceLockEvent e)
	{
		grid.cells[e.column + e.row * grid.columns] = e.type;
		piece = pool[e.id];
		grid.movingPieces.Remove(piece);
		// TODO: Play piece lock sound
	}

	private void UnlockPiece(PieceLockEvent e)
	{
		grid.cells[e.column + e.row * grid.columns] = PieceType.Empty;
		piece = pool[e.id];
		piece.moving = true;
		grid.movingPieces.Add(piece);
		timeline.Remove(e);
		// TODO: Play piece unlock sound
	}
}
