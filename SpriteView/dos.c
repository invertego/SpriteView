#include "int.h"

#include <errno.h>
#include <stdio.h>
#include <string.h>

void DosIntHandler(Registers* r)
{
    switch (r->ah) {
    case 0x02: { // display output
        putchar(r->dl);
        break;
    }
    case 0x09: { // display string
        const char* buf = (const char*)r->edx;
        const char* end = strchr(buf, '$');
        printf("%.*s", end - buf, buf);
        // simulate a bunch of key presses to dismiss the error message
        for (int i = 0; i < 16 + 1; i++) {
            KeyPush(' ');
        }
        break;
    }
    case 0x3d: { // open file
        const char* name = (char*)r->edx;
        const char* mode = "rb";
        switch (r->al) {
        case 0: mode = "rb"; break;
        default: assert(0); break;
        }
        FILE* file = fopen(name, mode);
        if (file) {
            r->eax = (u32)file;
            r->eflags &= ~CF;
        }
        else {
            r->eax = errno;
            r->eflags |= CF;
        }
        break;
    }
    case 0x3e: { // close file
        FILE* file = (FILE*)r->ebx;
        fclose(file);
        r->eflags &= ~CF;
        break;
    }
    case 0x3f: { // read file
        FILE* file = (FILE*)r->ebx;
        u16 len = r->cx;
        void* buf = (void*)r->edx;
        r->ax = (u16)fread(buf, 1, len, file);
        r->eflags &= ~CF;
        break;
    }
    case 0x4c: { // terminate
        //exit(r->al);
        assert(0);
        break;
    }
    case 0x42: { // set file pointer
        FILE* file = (FILE*)r->ebx;
        s32 dist = r->cx << 16 | r->dx;
        fseek(file, dist, r->al);
        u32 pos = ftell(file);
        r->dx = pos >> 16;
        r->ax = pos;
        r->eflags &= ~CF;
        break;
    }
    default: assert(0); break;
    }
}
