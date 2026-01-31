# About

This is a quick and dirty port of SpriteView to Windows that replaces calls to DOS and the BIOS with equivalent functionality in the C standard library and SDL3. It is based on a disassembly of the 1.6.6 release from 2003. I am not the tool's original author.

Building requires Visual Studio to be installed.

# SpriteView

SpriteView is a small, speedy graphics viewer (not editor) that supports several formats of console systems (including all of those used by the SNES). For those interested, the readme documents the formats for the various modes it supports. Although mainly meant to display the console graphics contained in either savestates or ROM images, it can also display graphics from other sources like DOOM's WAD file, Windows 95's ShellIconCache file, DLLs, and executables.

Graphics modes:
- SNES 1,2,3,4,8bpl tiles
- SNES mode 7 linear/interleaved tiles
- SNES fx chip low/high nybble linear
- NES 2bpl tiles
- GameBoy 2bpl tiles (same as SNES 2bpl)
- Sega 4bit tiles
- VB 2bit tiles
- N64 15bit high color linear
- N64 24bit true color linear
- Generic 2,4,8bit linear
