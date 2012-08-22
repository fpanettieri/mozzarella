/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#include "state.h"

#include <assert.h>

#include "../kernel/memory.h"

S_GameState_t* S_CreateState( K_MemBuffer_t* mem ) {
	S_GameState_t* state = ( S_GameState_t* ) K_LinearAlloc( mem, sizeof( S_GameState_t ) );
	state->time = 0;
	state->score = 0;
	return state;
}

void S_DestroyState( K_MemBuffer_t* mem, S_GameState_t* state ) {
	// do nothing
}

void S_RandomFillGrid( S_Grid_t* grid )
{
    // iterate the bottom of the grid
    // set a flag to false
    // if chance < garbage ratio, select a random piece number
    //

}
