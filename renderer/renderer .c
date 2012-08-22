/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#include "renderer.h"

#include <SDL/SDL_video.h>
#include <SDL/SDL_opengl.h>

#include "../kernel/log.h"
#include "../state/state.h"

const int WINDOW_WIDTH = 1024;
const int WINDOW_HEIGHT = 768;

bool R_Init()
{
    //Initialize Projection Matrix
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity();
    glOrtho( 0, WINDOW_WIDTH , WINDOW_HEIGHT, 0, -1, 10);

    //Initialize Modelview Matrix
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity();

    //Initialize clear color
    glClearColor( 0.f, 0.f, 0.f, 1.f );

    //Check for error
    GLenum error = glGetError();
    if( error != GL_NO_ERROR )
    {
        DEBUG_LOG( gluErrorString( error ) );
        return false;
    }

    return true;
}


void R_Render( S_GameState_t* state, uint32_t delta_time )
{
    //Clear color buffer
    glClear( GL_COLOR_BUFFER_BIT );

    //Render quad


    //Update screen
    SDL_GL_SwapBuffers();
}

