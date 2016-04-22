//
//  main.c
//  C
//
//  Created by Handlecar on 4/14/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#include <stdio.h>
#include "time.h"

int main(int argc, const char * argv[]) {
    time_t t_max = 0x7fffffff;

    printf("%d \n",sizeof(long));
    
    printf("%s",ctime(&t_max));
    return 0;
}
