/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#include "state.h"

#include <assert.h>
#include <stdlib.h>

#include "../kernel/memory.h"

/**
 * Number of possible piece colors
 */
const int S_PIECE_COLORS = 6;

S_GameState_t* S_CreateState( K_MemBuffer_t* mem )
{
	S_GameState_t* state = ( S_GameState_t* ) K_LinearAlloc( mem, sizeof( S_GameState_t ) );
	state->time = 0;
	state->score = 0;
	return state;
}

void S_DestroyState( K_MemBuffer_t* mem, S_GameState_t* state )
{
	// do nothing
}

void S_RandomFillGrid( S_Grid_t* grid )
{
    uint8_t i, j;
    for( i = grid->rows - 1; i > 0; i-- ) {
        for( j = 0; j < grid->columns; j++ ) {
            S_RandomFillCell( grid, i, j );
        }
    }
}

void S_RandomFillCell( S_Grid_t* grid, uint8_t row, uint8_t column )
{
    // Half of the pieces should be filled
    if( rand() % 2 ){
        return;
    }

    S_Piece_t* piece = S_GetPieceAt( grid, row, column );
    if( row == grid->rows -1 ) {
        piece->color = rand() % S_PIECE_COLORS;

    } else if ( S_GetPieceAt( grid, row + 1, column )->color > 0 ) {

        piece->color = rand() % S_PIECE_COLORS;
    }
}

