/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef KERNEL_KERNEL_H_INCLUDED
#define KERNEL_KERNEL_H_INCLUDED

#include "types.h"
#include "log.h"
#include "memory.h"

/**
 * Initialize and configure game engine
 */
void K_Init( int argc, char** argv );

/**
 * Process input and update state
 */
void K_Input( );

/**
 * Wait a specified number of milliseconds
 */
void K_Sleep( uint32_t delay );

/**
 * Get the number of miliseconds since the game started
 */
uint32_t K_HiResTimer();

#endif /* KERNEL_KERNEL_H_INCLUDED */
