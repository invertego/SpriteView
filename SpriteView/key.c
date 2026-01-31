#include "int.h"

#include <stdlib.h>

static u16 keyQueue[32];
static unsigned keyIndexR;
static unsigned keyIndexW;

#define KeyIndexInc(index) (index = (index + 1) % _countof(keyQueue))

void KeyPush(u16 key)
{
    keyQueue[keyIndexW] = key;
    KeyIndexInc(keyIndexW);
    if (keyIndexR == keyIndexW) {
        KeyIndexInc(keyIndexR);
    }
}

static bool KeyPeek(u16* key)
{
    bool result = false;
    if (keyIndexR != keyIndexW) {
        if (key) *key = keyQueue[keyIndexR];
        result = true;
    }
    return result;
}

static u16 KeyPop()
{
    assert(keyIndexR != keyIndexW);
    u16 key = keyQueue[keyIndexR];
    KeyIndexInc(keyIndexR);
    return key;
}

void KeyIntHandler(Registers* r)
{
    switch (r->ah) {
    case 0x00: { // wait for key
        u16 key = KeyPop();
        r->ah = key >> 8;
        r->al = key & 0xff;
        r->eflags &= ~ZF; // key
        break;
    }
    case 0x01: { // query key
        WinUpdate();

        u16 key;
        if (KeyPeek(&key)) {
            r->ah = key >> 8;
            r->al = key & 0xff;
            r->eflags &= ~ZF; // key
        }
        else {
            r->eflags |= ZF; // no key
        }
        break;
    }
    default: assert(0); break;
    }
}
