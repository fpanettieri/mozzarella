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
		piece = pool[e.id];
		grid.movingPieces.Remove(piece);
		piece.locked = true;
		// TODO: Play piece lock sound
	}
	

	private void UnlockPiece(PieceLockEvent e)
	{
		piece = pool[e.id];
		grid.pieceTypes[piece.column + piece.row * grid.columns] = PieceType.Empty;
		grid.pieceId[piece.column + piece.row * grid.columns] = -1;
		piece.moving = true;
		piece.locked = false;
		grid.movingPieces.Add(piece);
		timeline.Remove(e);
		// TODO: Play piece unlock sound
	}
}
