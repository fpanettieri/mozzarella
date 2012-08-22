/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#include "kernel.h"

#include <stdlib.h>
#include <time.h>

#include <SDL/SDL.h>

#include "../renderer/renderer.h"
#include "../game/game.h"

const int SCREEN_WIDTH = 1024;
const int SCREEN_HEIGHT = 768;
const int SCREEN_BPP = 32;

void K_Init( int argc, char** argv )
{
    // seed the random generator
    srand( time(NULL) );

    // Configure main loop
    R_TICKS_PER_SECOND = 60;
    R_TICK_INTERVAL = 1000 / R_TICKS_PER_SECOND;

    G_TICKS_PER_SECOND = 10;
    G_TICK_INTERVAL = 1000 / G_TICKS_PER_SECOND;

   	R_Vsync = false;
    G_Running = true;

    //Initialize SDL
    if( SDL_Init( SDL_INIT_EVERYTHING ) < 0 ) {
        exit( 1 );
    }

    // Ensure SDL is cleaned
    atexit( SDL_Quit );

    //Create Window
    if( SDL_SetVideoMode( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BPP, SDL_OPENGL ) == NULL ) {
        exit( 1 );
    }

    //Enable unicode
    SDL_EnableUNICODE( SDL_TRUE );

    //Initialize OpenGL
    R_Init();

    //Set caption
    SDL_WM_SetCaption( "Mozzarella", NULL );
}

void K_Input()
{
    //Event handler
    SDL_Event event;

     //While there are events to handle
    while( SDL_PollEvent( &event ) )
    {
        if( event.type == SDL_QUIT )
        {
            G_Running = false;
        }
        else if( event.type == SDL_KEYDOWN )
        {
            //Handle keypress with current mouse position
            int x = 0, y = 0;
            SDL_GetMouseState( &x, &y );

        }
    }
}

void K_Sleep( uint32_t delay)
{
    SDL_Delay( delay );
}

uint32_t K_HiResTimer()
{
    return SDL_GetTicks();
}
