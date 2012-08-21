/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef STATE_STATE_H_INCLUDED
#define STATE_STATE_H_INCLUDED

#include "../kernel/types.h"
#include "grid.h"
#include "command.h"

/**
 * Current game state. It contains all the information needed to simulate
 * the world and render it.
 */
typedef struct _S_GameState_t {
	S_Grid_t* grid;
	S_Commands_t* commands;
	S_CommandTime_t time;
	uint64_t score;
} S_GameState_t;

/**
 * Given an unitilialized state pointer
 * It allocates the memory needed to hold the game state
 * state must be == NULL
 */
 S_GameState_t* S_CreateState( K_MemBuffer_t* mem );

/**
 *  Deallocates the memory used by the gamestate and it's inner objects
 *  ( in linear | stack buffer implementations it does nothing ).
 */
void S_DestroyState( K_MemBuffer_t* mem, S_GameState_t* state );

#endif /* STATE_STATE_H_INCLUDED */
