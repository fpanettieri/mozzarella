/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.

 P: Platform layer
 K: Platform independent layer
 G: Game simulation layer
 S: Game state
 R: OpenGL ES 2.0 Rendition engine
===========================================================================
*/

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include <SDL/SDL.h>

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 240
#define SCREEN_DEPTH 8

#include "../platform/types.h"
#include "../kernel/log.h"
#include "../kernel/memory.h"
#include "../state/state.h"

/*
===========================================================================
  R_TICKS_PER_SECOND
  
  How many times does the rendition engine should be updated per second.
  This value is ignored if vsync is disabled.
  A good value is around 30 - 60.
===========================================================================
*/
uint16_t R_TICKS_PER_SECOND;

/*
===========================================================================
  R_TICK_INTERVAL
  
  Time in miliseconds elapsed between ticks to the rendition engine.
===========================================================================
*/
float32_t R_TICK_INTERVAL;

/*
===========================================================================
  G_TICKS_PER_SECOND
  
  How many times does the game simulation should be updated per second.
  This value is ignored if vsync is disabled.
  A good value should be close to 10 - 30.
===========================================================================
*/
uint16_t G_TICKS_PER_SECOND;

/*
===========================================================================
  G_TICK_INTERVAL
  
  Time in miliseconds elapsed between ticks to the game simulation.
===========================================================================
*/
float32_t G_TICK_INTERVAL;

/*
===========================================================================
  R_Vsync
  
  Determine if the engine should be bound.
===========================================================================
*/
bool R_Vsync; 

/*
===========================================================================
  G_Running
  
  Indicates if the game is running
===========================================================================
*/
bool G_Running;

/*
===========================================================================
  P_Init
  
  Initialize and configure game subsystems.
===========================================================================
*/
void P_Init( int argc, char** argv ){
	R_TICKS_PER_SECOND = 60;
	R_TICK_INTERVAL = 1.0f / R_TICKS_PER_SECOND;

	G_TICKS_PER_SECOND = 10;
	G_TICK_INTERVAL = 1.0f / G_TICKS_PER_SECOND;
	
	R_Vsync = true;
	G_Running = true;
	
	/* Initialize SDL */
    SDL_Init(SDL_INIT_EVERYTHING);
}

/*
===========================================================================
  P_HiResTime
  
  Returns the current number of milliseconds that have elapsed
  passed since the game started.
===========================================================================
*/
float32_t P_HiResTime(){ return ((float32_t)clock()) / CLOCKS_PER_SEC;}

/*
===========================================================================
  P_HandleInput
  
  Read the current input state, and store it
===========================================================================
*/
void P_HandleInput( int input ) {}

/*
===========================================================================
  K_QueueCommands
  
  Update the list of commands based on the current input, and game state
===========================================================================
*/
void K_QueueCommands( int input, int state, int commands ){}

/*
===========================================================================
  G_Update
  
  Parse the list of commands and update the game state
===========================================================================
*/
void G_Update( S_GameState_t* state, float32_t delta_time ){ printf("*U*"); }

/*
===========================================================================
  R_Render
  
  Render the current game state
===========================================================================
*/
void R_Render( S_GameState_t* state ){/*printf("R");*/}

/*
===========================================================================
  P_Sleep
  
  Hi resolution sleep method
===========================================================================
*/
void P_Sleep( uint32_t vsync_time ){}

/*
===========================================================================
  P_Quit
  
  Release allocated resources, and store log
===========================================================================
*/
void P_Quit( K_MemBuffer_t* mem ) { K_MemFree( &mem ); }

int main(int argc, char** argv)
{
	P_Init( argc, argv );
	DEBUG_LOG("Initialized");
	
	K_MemBuffer_t* mem = K_MemAlloc( 512 * 1024 * 1024 );
	DEBUG_LOG("Memory allocated");
	
	S_GameState_t* state = S_CreateState( mem );
	DEBUG_LOG("State created");
	
	state->grid = S_CreateGrid( mem, 20, 10 );
	DEBUG_LOG("Grid created");
	
	state->commands = S_CreateCommands( mem );
	DEBUG_LOG("Commands created");
	
	// TODO[sn00py]: Dynamic alloc this in the linear stack allocator ?
	float32_t game_tick = P_HiResTime();
	float32_t render_tick = P_HiResTime();
	
	float32_t new_time = 0;
	float32_t old_time = 0;
	float32_t delta_time = 0;
	float32_t vsync_time = 0;
		
	while( G_Running ) {
		new_time = P_HiResTime();
		delta_time = old_time - new_time;
		
		// P_HandleInput( input );
		// K_QueueCommands( input, state, commands );
		
		if( game_tick <= P_HiResTime() ) {
			game_tick += G_TICK_INTERVAL;			
			G_Update( state, delta_time );
		}
		
		R_Render( state );
		old_time = new_time;
		
		if( R_Vsync ) {
			render_tick += R_TICK_INTERVAL;
			vsync_time = render_tick - P_HiResTime();
			if( vsync_time >= 0 ){
				P_Sleep( vsync_time );
			} else {
				printf("WARNING: Frame dropped!\n");
			}
		}
	}
	
	S_DestroyCommands( mem, state->commands );
	S_DestroyGrid( mem, state->grid );
	S_DestroyState( mem, state );
	P_Quit( mem );
	
	free(mem);
	
	return 0;
}
