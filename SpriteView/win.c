#include <stdio.h>

#include <SDL3/SDL.h>
#include <SDL3/SDL_main.h>

#include "int.h"

#define SCALE_FACTOR 4

int SV_Main(int argc, char* argv[]);

static bool quitting;
static SDL_Window* window;
static SDL_Renderer* renderer;
static SDL_Texture* texture;
static Uint64 renderTicks;

static void Render()
{
    Uint64 ticks = SDL_GetTicks();
    if (ticks < renderTicks + 10) {
        return;
    }
    renderTicks = ticks;

    void* pixels = NULL;
    int pitch = 0;
    if (SDL_LockTexture(texture, NULL, &pixels, &pitch)) {
        VidRender(pixels, pitch);
        SDL_UnlockTexture(texture);
    }
    SDL_RenderClear(renderer);
    SDL_RenderTexture(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
}

static void ProcessEvents()
{
    SDL_Event event;
    if (!SDL_WaitEventTimeout(&event, 10)) {
        return;
    }

    do {
        switch (event.type) {
        case SDL_EVENT_QUIT:
            quitting = true;
            break;
        case SDL_EVENT_TEXT_INPUT: {
            u8 ascii = event.text.text[0];
            if (ascii < 0x80) {
                KeyPush(ascii);
            }
            break;
        }
        case SDL_EVENT_KEY_DOWN: {
            u8 scancode = 0;
            u8 ascii = 0;
            switch (event.key.key) {
            case SDLK_ESCAPE:
                scancode = 0x01;
                ascii = 0x1B;
                break;
            case SDLK_UP:
                scancode = 0x48;
                break;
            case SDLK_DOWN:
                scancode = 0x50;
                break;
            case SDLK_PAGEUP:
                scancode = (event.key.mod & SDL_KMOD_CTRL) ? 0x84 : 0x49;
                break;
            case SDLK_PAGEDOWN:
                scancode = (event.key.mod & SDL_KMOD_CTRL) ? 0x76 : 0x51;
                break;
            case SDLK_LEFT:
                scancode = (event.key.mod & SDL_KMOD_CTRL) ? 0x73 : 0x4B;
                break;
            case SDLK_RIGHT:
                scancode = (event.key.mod & SDL_KMOD_CTRL) ? 0x74 : 0x4D;
                break;
            case SDLK_HOME:
                scancode = 0x47;
                break;
            case SDLK_END:
                scancode = 0x4F;
                break;
            case SDLK_F1:
                scancode = 0x3B;
                break;
            }
            if (scancode || ascii) {
                KeyPush(scancode << 8 | ascii);
            }
            break;
        }
        }
    } while (SDL_PollEvent(&event));
}

void WinUpdate()
{
    Render();

    ProcessEvents();

    // if quit event received, just keep simulating escape presses
    if (quitting) {
        KeyPush(0x01 << 8 | 0x1B); // escape
    }
}

int main(int argc, char* argv[])
{
    if (!SDL_Init(SDL_INIT_VIDEO)) {
        fprintf(stderr, "SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }

    if (!SDL_CreateWindowAndRenderer("SpriteView", 320 * SCALE_FACTOR, 200 * SCALE_FACTOR, 0, &window, &renderer)) {
        fprintf(stderr, "SDL_CreateWindowAndRenderer failed: %s\n", SDL_GetError());
        return 1;
    }

    texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_BGRX32, SDL_TEXTUREACCESS_STREAMING, 320, 200);
    if (!texture) {
        fprintf(stderr, "SDL_CreateTexture failed: %s\n", SDL_GetError());
        return 1;
    }

    SDL_SetTextureScaleMode(texture, SDL_SCALEMODE_NEAREST);

    SDL_SetHint(SDL_HINT_KEYCODE_OPTIONS, "hide_numpad");
    SDL_StartTextInput(window);

    int exitCode = SV_Main(argc, argv);

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);

    SDL_Quit();

    return exitCode;
}
