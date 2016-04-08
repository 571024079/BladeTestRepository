//
//  main.cpp
//  getPower
//
//  Created by Handlecar on 4/5/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#include <iostream>
using namespace std;
double getPower(double x, int y);
int getPower(int x, int y);


double getPower(double x, int y)
{
    if(x == 0)
    {
        return 0; // 如果y为负数也是无意义
    }
    
    double result = 1;
    if (y>0)
    {
        while (y-- > 0)
        {
            result *= x;
        }
    }
    else if(y < 0)
    {
        int m = y * -1;
        while (m-- > 0)
        {
            result *= x;
        }
        result = 1/result;
    }
    
    return result;
}

int getPower(int x, int y)
{
    int result = 1;
    
    if(x == 0)
    {
        return 0; // 如果y为负数也是无意义
    }
    
    if (y < 0)
    {
        return 0;
    }
    
    while (y-- > 0)
    {
        result *= x;
    }

    return result;
}

int main(int argc, const char * argv[]) {

    int a,b;
    double m;
    cout << "请输入整数底数:a,浮点底数:m" << endl;
    scanf("%d %lf",&a,&m);
//    cin >>a>>b;
    cout << "请输入指数b:"<<endl;
    scanf("%d",&b);
    
    cout<<"getPower("<<a<<","<<m<<")="<<getPower(a,b)<<endl;
    cout<<"getPower("<<b<<","<<m<<")="<<getPower(m,b)<<endl;
//    int result = getPower(-2, 10);
//    cout <<"计算结果为:"<<result << endl;
//    double decimal = getPower(2.0, 1000);
//    cout <<"计算结果为:"<<decimal << endl;

    return 0;
}
