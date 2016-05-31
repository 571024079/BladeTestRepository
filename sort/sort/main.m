//
//  main.m
//  sort
//
//  Created by Handlecar on 16/5/30.
//  Copyright © 2016年 date. All rights reserved.
//

#import <Foundation/Foundation.h>

// 插入排序
void insertSort(int *arr, int count)
{
    int  temp;
    int i;
    int j;
    for (i = 1; i < count; i++)
    {
        temp = arr[i];
        for (j = i - 1; j >= 0; j--)
        {
            if (arr[j] <= temp)
            {
                break;
            }
            else
            {
                arr[j+1] = arr[j];
            }
        }
        arr[j+1] = temp;
        printf("\n\n\n");
        for (int i = 0; i<7 ; i++)
        {
            printf("%d ",arr[i]);
        }
    }
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int arr[] = {49,38,65,97,76,13,27};
        insertSort(arr, 7);
        printf("\n\n\n");
        for (int i = 0; i<7 ; i++)
        {
            printf("%d ",arr[i]);
        }
    }
    return 0;
}
