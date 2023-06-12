//
//  SPTGAImage.c
//  SwiftHelper
//
//  Created by sauron on 2023/6/12.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

#include "SPTGAImage.h"

SPTGAHeader MakeTGAHeader(void * data) {
    SPTGAHeader *p = data;
    return *p;
}
