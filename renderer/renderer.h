/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef RENDERER_RENDERER_H_INCLUDED
#define RENDERER_RENDERER_H_INCLUDED

#include "../kernel/types.h"
#include "../state/state.h"

/**
 * How many times does the rendition engine should be updated per second.
 * This value is ignored if vsync is disabled.
 * A good value is around 30 - 60.
 */
uint16_t R_TICKS_PER_SECOND;

/**
 * Time in miliseconds elapsed between ticks to the rendition engine.
 */
uint16_t R_TICK_INTERVAL;

/**
 * Determine if the engine should be bound.
 */
bool R_Vsync;

/**
 * Initialize OpenGL
 */
bool R_Init();

/**
 * Interpolate and render the current game state
 */
void R_Render( S_GameState_t* state, uint32_t delta_time );

#endif /* RENDERER_RENDERER_H_INCLUDED */
