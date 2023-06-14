//
//  ShaderTypes.h
//  SwiftHelper
//
//  Created by sauron on 2023/5/28.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#ifdef __METAL_VERSION__
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define NSInteger metal::int32_t
#else

#import <Foundation/Foundation.h>

#endif /* __METAL_VERSION__ */

#include <simd/simd.h>

//typedef NS_ENUM(NSInteger, SPVertexInputIndex) {
//    SPVertexInputIndexVertices,
//    SPVertexInputIndexViewport,
//};
//
//typedef NS_ENUM(NSInteger, SPTextureIndex) {
//    SPTextureIndexInput,
//    SPTextureIndexOutput,
//};


typedef enum {
    SPVertexInputIndexVertices = 1,
    SPVertexInputIndexViewport,
} SPVertexInputIndex;

typedef enum {
    SPTextureIndexInput,
    SPTextureIndexOutput,
} SPTextureIndex;

typedef struct {
    vector_float4 position;
    vector_float4 color;
} SPVertex;

typedef struct {
    vector_float4 position;
    vector_float2 textureCoordinate;
} SPTextureVertex;

#endif /* ShaderTypes_h */
