// SDL Headers
#include <SDL/SDL.h>
#include <SDL/SDL_opengl.h>

#include "kernel/types.h"
#include "kernel/log.h"
#include "kernel/memory.h"
#include "state/state.h"

/**
 * How many times does the rendition engine should be updated per second.
 * This value is ignored if vsync is disabled.
 * A good value is around 30 - 60.
 */
Uint16 R_TICKS_PER_SECOND;

/**
 * Time in miliseconds elapsed between ticks to the rendition engine.
 */
Uint16 R_TICK_INTERVAL;

/**
 * How many times does the game simulation should be updated per second.
 * This value is ignored if vsync is disabled.
 * A good value should be close to 10 - 30.
 */
Uint16 G_TICKS_PER_SECOND;

/**
 * Time in miliseconds elapsed between ticks to the game simulation.
 */
Uint16 G_TICK_INTERVAL;

/**
 * Determine if the engine should be bound.
 */
bool R_Vsync;

/**
 * SDL_True if the game is running
 */
bool G_Running;

// Screen attributes
// TODO: configure this
const int SCREEN_WIDTH = 1024;
const int SCREEN_HEIGHT = 768;
const int SCREEN_BPP = 32;

//Event handler
SDL_Event event;

//Rendering flag
bool renderQuad = true;

bool initGL()
{
    //Initialize Projection Matrix
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity();

    //Initialize Modelview Matrix
    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity();

    //Initialize clear color
    glClearColor( 0.f, 0.f, 0.f, 1.f );

    //Check for error
    GLenum error = glGetError();
    if( error != GL_NO_ERROR )
    {
        printf( "Error initializing OpenGL! %s\n", gluErrorString( error ) );
        return false;
    }

    return true;
}

void K_Init( int argc, char** argv )
{
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
    if( initGL() == false ) {
        exit( 1 );
    }

    //Set caption
    SDL_WM_SetCaption( "OpenGL Test", NULL );
}

void handleKeys( unsigned char key, int x, int y )
{
    //Toggle quad
    if( key == 'q' )
    {
        renderQuad = !renderQuad;
    }
}

void input()
{
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
            handleKeys( event.key.keysym.unicode, x, y );
        }
    }
}

void update()
{

}

void render()
{
    //Clear color buffer
    glClear( GL_COLOR_BUFFER_BIT );

    //Render quad
    if( renderQuad == true )
    {
        glBegin( GL_QUADS );
            glVertex2f( -0.5f, -0.5f );
            glVertex2f(  0.5f, -0.5f );
            glVertex2f(  0.5f,  0.5f );
            glVertex2f( -0.5f,  0.5f );
        glEnd();
    }

    //Update screen
    SDL_GL_SwapBuffers();
}

int main( int argc, char *argv[] )
{
    K_Init( argc, argv );
    DEBUG_LOG("Initialized");

    K_MemBuffer_t* mem = K_MemAlloc( 512 * 1024 * 1024 );
    DEBUG_LOG("Memory allocated");

    S_GameState_t* state = S_CreateState( mem );
    DEBUG_LOG("State created");

    state->grid = S_CreateGrid( mem, 20, 10 );
    DEBUG_LOG("Grid created");

    state->commands = S_CreateCommands( mem );
    DEBUG_LOG("Commands created");

    // Game simulation and renderer tick markers
    Uint32 game_tick = SDL_GetTicks();
    Uint32 render_tick = SDL_GetTicks();

	Uint32 new_time = 0;
    Uint32 old_time = 0;
    Uint32 delta_time = 0;
    Uint32 vsync_time = 0;

	//Wait for user exit
	while( G_Running ) {
	    new_time = SDL_GetTicks();
        delta_time = old_time - new_time;

        // only tick run the simulation at fixed speed
        if( new_time > game_tick ) {
            game_tick += G_TICK_INTERVAL;

            input();
            update();
        }

        render();
        old_time = new_time;

        // sync to vblank
        if( R_Vsync ) {
            render_tick += R_TICK_INTERVAL;
            vsync_time = render_tick - SDL_GetTicks();
            if( vsync_time >= 0 ){
                 SDL_Delay( vsync_time );
            } else {
                printf("WARNING: Frame dropped!\n");
            }
        }
	}

	return 0;
}
