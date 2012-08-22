/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/

#include "kernel/kernel.h"
#include "state/state.h"
#include "game/game.h"
#include "renderer/renderer.h"

int main( int argc, char *argv[] )
{
    DEBUG_LOG("Initializing");

    K_Init( argc, argv );
    K_MemBuffer_t* mem = K_MemAlloc( 512 * 1024 * 1024 );
    S_GameState_t* state = S_CreateState( mem );
    state->grid = S_CreateGrid( mem, 20, 10 );
    state->commands = S_CreateCommands( mem );

    DEBUG_LOG("Initialization complete");

    // Fill the grid with garbage so we can render something
    S_RandomFillGrid( state->grid );

    // Current frame time
	uint32_t new_time = K_HiResTimer();

    // Time elapsed since the last simulation tick
    uint32_t delta_time = 0;

    // How much should we wait the VBlank
    uint32_t vsync_time = 0;

     // Next game simulation and renderer tick markers
    uint32_t game_tick = new_time;
    uint32_t render_tick = new_time;

	while( G_Running ) {
	    new_time = K_HiResTimer();

	    // Time elapsed since the last physics update
        delta_time = game_tick - new_time;

        // Update input always
        K_Input();

        // Tick the game simulation at fixed speed
        if( new_time > game_tick ) {
            game_tick += G_TICK_INTERVAL;

            G_Update( state );
            delta_time = 0;
        }

        R_Render( state, delta_time );

        // sync to vblank
        if( R_Vsync ) {
            render_tick += R_TICK_INTERVAL;
            vsync_time = render_tick - K_HiResTimer();
            if( vsync_time >= 0 ){
                 K_Sleep( vsync_time );
            } else {
                DEBUG_LOG("WARNING: Frame dropped!\n");
            }
        }
	}

	return 0;
}
