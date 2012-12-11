using UnityEngine;
using System.Collections;

public class PieceGrouper : MonoBehaviour, IEventListener
{
	// Dependencies
	private Grid grid;
	private PiecePool pool;

	// Private / aux properties
	private Piece piece;
	
	public void Start()
	{
		Events.i.Register(MozEventType.PieceLock, this);
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
	}

	public void Notify(MozEvent e)
	{
		if(TimeMachine.rewind) {
			UngroupPiece(e as PieceLockEvent);
		} else {
			GroupPiece(e as PieceLockEvent);
		}
	}

	private void GroupPiece(PieceLockEvent e)
	{
		piece = pool[e.id];
		if(piece.row == 0){ return; }
		int spot = piece.column + piece.row * grid.columns;
		int down = spot - grid.columns;
		if (grid.pieceTypes[down] != piece.type){ return; }

		// left group
		if (piece.column > 0){
			int left = spot - 1;
			int diagLeft = down - 1;
			if(grid.pieceTypes[left] == piece.type && grid.pieceTypes[diagLeft] == piece.type) {
 				pool[grid.pieceId[spot]].groups.bl = true;
				pool[grid.pieceId[down]].groups.tl = true;
				pool[grid.pieceId[left]].groups.br = true;
				pool[grid.pieceId[diagLeft]].groups.tr = true;
				e.grouped = true;
			}
		}

		if (piece.column < grid.columns - 1){
			int right = spot + 1;
			int diagRight = down + 1;
			if(grid.pieceTypes[right] == piece.type && grid.pieceTypes[diagRight] == piece.type) {
				pool[grid.pieceId[spot]].groups.br = true;
				pool[grid.pieceId[down]].groups.tr = true;
				pool[grid.pieceId[right]].groups.bl = true;
				pool[grid.pieceId[diagRight]].groups.tl = true;
				e.grouped = true;
			}
		}
	}
	

	private void UngroupPiece(PieceLockEvent e)
	{
		piece = pool[e.id];
		piece.groups.Clear();
		if(!e.grouped || piece.row == 0){ return; }
		int spot = piece.column + piece.row * grid.columns;
		int down = spot - grid.columns;
		if (grid.pieceTypes[down] != piece.type){ return; }

		// left group
		if (piece.column > 0){
			int left = spot - 1;
			int diagLeft = down - 1;
			pool[grid.pieceId[down]].groups.tl = false;
			if(grid.pieceTypes[left] == piece.type){ pool[grid.pieceId[left]].groups.br = false; }
			if(grid.pieceTypes[diagLeft] == piece.type){ pool[grid.pieceId[diagLeft]].groups.tr = false; }
		}

		// right group
		if (piece.column < grid.columns - 1){
			int right = spot + 1;
			int diagRight = down + 1;
			pool[grid.pieceId[down]].groups.tr = false;
			if(grid.pieceTypes[right] == piece.type){ pool[grid.pieceId[right]].groups.bl = false; }
			if(grid.pieceTypes[diagRight] == piece.type){ pool[grid.pieceId[diagRight]].groups.tl = false; }
		}
	}
}
