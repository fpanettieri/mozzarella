/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "state.h"
#include "grid.h"
#include "command.h"

#include <assert.h>

#include "../kernel/log.h"
#include "../kernel/memory.h"

void S_CreateState( K_MemBuffer_t* mem, S_GameState_t* state ) {
	state = ( S_GameState_t* ) K_LinearAlloc( mem, sizeof( S_GameState_t ) );
	state->grid = ( S_Grid_t* ) K_LinearAlloc( mem, sizeof( S_Grid_t ) );
	state->commands = ( S_Commands_t* ) K_LinearAlloc( mem, sizeof( S_Commands_t ) );
	state->time = 0;
	state->score = 0;
}

void S_DestroyState( K_MemBuffer_t* mem, S_GameState_t* state ) {
	// do nothing
}
