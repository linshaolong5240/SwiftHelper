//
//  Add.metal
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

/* C souce code
 void add_arrays(const float* inA,
                 const float* inB,
                 float* result,
                 int length) {
     for (int index = 0; index < length ; index++)
     {
         result[index] = inA[index] + inB[index];
     }
 }
 */

///  kernel 关键字表示这是一个GPU函数或计算函数
/// device  关键字表示这些指针位于设备地址空间中。MSL为内存定义了几个不相交的地址空间。每当您在MSL中声明指针时，您必须提供一个关键字来声明其地址空间。使用设备地址空间声明GPU可以读取和写入的持久内存。
/// [[thread_position_in_grid]] * 为了替换之前由for-loop提供的索引，MSL关键字thread_position_in_grid使用C++属性语法指定的新索引参数。此关键字声明Metal应该为每个线程计算一个唯一的索引，并在此参数中传递该索引。由于add_arrays使用1D网格，因此索引被定义为标量整数。即使循环被删除了，清单1和清单2也使用同一行代码将两个数字加在一起。如果您想将类似的代码从C或C++转换为MSL，请以相同的方式用网格替换循环逻辑。
kernel void add_arrays(device const float* inA,
                       device const float* inB,
                       device float* result,
                       uint index [[thread_position_in_grid]]) {
    // the for-loop is replaced with a collection of threads, each of which
    // calls this function.
    result[index] = inA[index] + inB[index];
}
