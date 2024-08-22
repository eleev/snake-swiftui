//
//  Matrix.metal
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 matrix(float2 position, half4 color, float4 bounds, float time) {
    float2 uv = position / bounds.zw;
    
    float distance = length(uv - float2(0.5));
    float vignette = 1.0 - distance;
    
    vignette = smoothstep(0.13, 1.0, vignette);
    float lum = dot(color.rgb, half3(0.85, 0.37, 0.17));
    
    color.rgb = half3(0.0, lum, 0.1);
    color += 0.15 * sin(uv.y * bounds.z * 1);
    color += 0.007 * sin(time * 22);
    color *= vignette * 1.0;
    
    return color;
}
