//
//  Texture2dShader.metal
//  SwiftHelper
//
//  Created by sauron on 2023/6/13.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#include <metal_stdlib>
#include "SPShaderTypes.h"
using namespace metal;

struct RasterizerData {
    // The [[position]] attribute of this member indicates that this value
    // is the clip space position of the vertex when this structure is
    // returned from the vertex function.
    float4 position [[position]];

    // Since this member does not have a special attribute, the rasterizer
    // interpolates its value with the values of the other triangle vertices
    // and then passes the interpolated value to the fragment shader for each
    // fragment in the triangle.
    float2 textureCoordinate;
};

vertex RasterizerData TextureVertexShader(uint vertexID [[ vertex_id ]],
             constant SPTextureVertex *vertices [[ buffer(0) ]],
             constant vector_uint2 *viewportSizePointer  [[ buffer(1) ]]) {

    RasterizerData out;

    // Index into the array of positions to get the current vertex.
    // The positions are specified in pixel dimensions (i.e. a value of 100
    // is 100 pixels from the origin).
//    float2 pixelSpacePosition = vertices[vertexID].position.xy;

    // Get the viewport size and cast to float.
    vector_float2 viewportSize = vector_float2(*viewportSizePointer);
    

    // To convert from positions in pixel space to positions in clip-space,
    //  divide the pixel coordinates by half the size of the viewport.
    out.position = vector_float4(0.0, 0.0, 0.0, 1.0);
    out.position.xy = vertices[vertexID].position.xy / viewportSize;
    out.position.z = vertices[vertexID].position.z;

    // Pass the input textureCoordinate straight to the output RasterizerData.  This value will be
    //   interpolated with the other textureCoordinate values in the vertices that make up the
    //   triangle.
    out.textureCoordinate = vertices[vertexID].textureCoordinate;

    return out;
}

fragment float4 TextureSamplingShader(RasterizerData  in           [[stage_in]],
                               texture2d<half> colorTexture [[ texture(0) ]])
{
    constexpr sampler textureSampler (mag_filter::linear,
                                      min_filter::linear);

    // Sample the texture and return the color to colorSample
    const half4 colorSample = colorTexture.sample (textureSampler, in.textureCoordinate);
    return float4(colorSample);
}
