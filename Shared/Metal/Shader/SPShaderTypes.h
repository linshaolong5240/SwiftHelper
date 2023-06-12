//
//  ShaderTypes.h
//  SwiftHelper
//
//  Created by sauron on 2023/5/28.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>
//#include <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, SPVertexInputIndex) {
//    SPVertexInputIndexVertices = 1,
//    SPVertexInputIndexViewport = 2,
//};

typedef enum SPVertexInputIndex {
    SPVertexInputIndexVertices,
    SPVertexInputIndexViewport,
} SPVertexInputIndex;

typedef enum AAPLTextureIndex
{
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
