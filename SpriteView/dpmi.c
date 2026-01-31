#include "int.h"

#include <malloc.h>

void DpmiIntHandler(Registers* r)
{
    switch (r->ax) {
    case 0x0500: { // get free
        *(u32*)r->edi = 1 << 30; // 1 GiB
        r->eflags &= ~CF;
        break;
    }
    case 0x0501: { // allocate
        u32 addr = (u32)malloc(r->bx << 16 | r->cx);
        if (addr) {
            r->bx = r->si = addr >> 16;
            r->cx = r->di = addr;
            r->eflags &= ~CF;
        }
        else {
            r->eflags |= CF;
        }
        break;
    }
    case 0x0502: { // free
        u32 addr = r->si << 16 | r->di;
        free((void*)addr);
        r->eflags &= ~CF;
        break;
    }
    default: assert(0); break;
    }
}
