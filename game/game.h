/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef GAME_GAME_H_INCLUDED
#define GAME_GAME_H_INCLUDED

#include "../kernel/types.h"
#include "../state/state.h"

/**
 * How many times does the game simulation should be updated per second.
 * This value is ignored if vsync is disabled.
 * A good value should be close to 10 - 30.
 */
uint16_t G_TICKS_PER_SECOND;

/**
 * Time in miliseconds elapsed between ticks to the game simulation.
 */
uint16_t G_TICK_INTERVAL;

/**
 * SDL_True if the game is running
 */
bool G_Running;

/**
 * Update the game state
 */
void G_Update( S_GameState_t* state );

#endif /* GAME_GAME_H_INCLUDED */
