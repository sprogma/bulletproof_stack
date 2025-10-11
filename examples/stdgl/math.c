int fmul(int a, int b)
{
    return (a * b) / 1000;
}

int fdiv(int a, int b)
{
    return (a * 1000) / b;
}

int sqrt(int a)
{
    int aa, res, add;
    aa = a * 1000;
    res = 0;
    add = 46340;
    while (add > 1)
    {
        if ((res + add) * (res + add) < aa)
        {
            res = res + add;
        }
        add = add / 2;
    }
    return res;
}

int f(int a)
{
    return a * 1000;
}
