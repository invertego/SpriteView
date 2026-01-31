#include "int.h"

extern u8 FrameBufferStorage[];

static u32 pindex;
static u8 palette[256][4];

void VidOutHandler(Registers* r)
{
    if (r->dx == 0x3c9) {
        u8 v = r->al;
        v = v << 2 | v >> 4;
        palette[pindex / 3][pindex % 3] = v;
        pindex++;
        pindex %= 768;
    }
}

void VidIntHandler(Registers* r)
{
    switch (r->ah) {
    case 0x00: { // set video mode
        assert(r->al == 0x03 || r->al == 0x13);
        break;
    }
    default: assert(0); break;
    }
}

void VidRender(void* pixels, int pitch)
{
    for (int y = 0; y < 200; y++) {
        u8* src = &FrameBufferStorage[y * 320];
        u32* line = (u32*)((u8*)pixels + y * pitch);
        for (int x = 0; x < 320; x++) {
            u8 v = src[x];
            const u8* col = palette[v];
            line[x] = (col[2] | col[1] << 8 | col[0] << 16);
        }
    }
}
