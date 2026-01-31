#pragma once

#include <assert.h>
#include <stdbool.h>
#include <stdint.h>

#define CF 0x01u
#define ZF 0x40u

typedef uint8_t u8;
typedef uint16_t u16;
typedef int32_t s32;
typedef uint32_t u32;

typedef struct {
    union { u32 edi; u16 di; };
    union { u32 esi; u16 si; };
    union { u32 ebp; u16 bp; };
    union { u32 esp; u16 sp; };
    union { u32 ebx; u16 bx; struct { u8 bl, bh; }; };
    union { u32 edx; u16 dx; struct { u8 dl, dh; }; };
    union { u32 ecx; u16 cx; struct { u8 cl, ch; }; };
    union { u32 eax; u16 ax; struct { u8 al, ah; }; };
    u32 eflags;
} Registers;

// DOS
void DosIntHandler(Registers* r);

// DPMI
void DpmiIntHandler(Registers* r);

// key
void KeyIntHandler(Registers* r);
void KeyPush(u16 key);

// video
void VidIntHandler(Registers* r);
void VidOutHandler(Registers* r);
void VidRender(void* pixels, int pitch);

// window
void WinUpdate();
