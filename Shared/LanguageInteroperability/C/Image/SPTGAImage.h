//
//  SPTGAImage.h
//  SwiftHelper
//
//  Created by sauron on 2023/6/12.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#ifndef SPTGAImage_h
#define SPTGAImage_h

#include <stdio.h>

#ifdef __cplusplus //C and cpp compiled together must add exten C
extern "C" {
#endif

// https://en.wikipedia.org/wiki/Truevision_TGA
typedef struct __attribute__ ((packed)) SPTGAHeader
{
    uint8_t  idLength;       // Length of the image ID field (0-255)
    uint8_t  colorMapType;   // Whether a color map is included (0 - indicates that no color-map data is included with this image. 1 - indicates that a color-map is included with this image.)
    uint8_t  imageType;      // Compression and color types (0- No Image Data Included. 1- Uncompressed, Color mapped image, 2- Uncompressed, True Color Image, 9- Run-length encoded, Color mapped image, 11- Run-Length encoded, Black and white image)
    //Field 4: 5 bytes - Color map specification
    int16_t  colorMapStart;  // The offset to the color map in the palette.
    int16_t  colorMapLength; // The mumber of colors in the palette.
    uint8_t  colorMapBitsPerPalette;    // The number of bits per palette entry.
    //Field 5: 10 bytes - Image specification
    uint16_t xOrigin;        // The x Origin pixel of lower left corner if this file is a tile from a larger image.
    uint16_t yOrigin;        // The y Origin pixel of lower left corner if this file is a tile from a larger image
    uint16_t width;          // The width in pixels.
    uint16_t height;         // The height in pixels.
    uint8_t  bitsPerPixel;   // The bits per pixel. 8,16,24,32.
    //Image descriptor (1 byte): bits 3-0 give the alpha channel depth, bits 5-4 give pixel ordering. Bit 4 of the image descriptor byte indicates right-to-left pixel ordering if set. Bit 5 indicates an ordering of top-to-bottom. Otherwise, pixels are stored in bottom-to-top, left-to-right order.
    struct {
        uint8_t bitsPerAlpha : 4;
        uint8_t rightOrigin  : 1;
        uint8_t topOrigin    : 1;
        uint8_t reserved     : 2;
    } descriptor;
} SPTGAHeader;

SPTGAHeader MakeTGAHeader(void * data);

#ifdef __cplusplus//C and cpp compiled together must add exten C
}
#endif

#endif /* SPTGAImage_h */
