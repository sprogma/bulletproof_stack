int hash(int x, int y)
{
    int res;
    res = x * 3412 + y * 1241 + 1000000;
    return res - (res / 1000) * 1000;
}

int noise(int x, int y)
{
    int ix, iy;
    ix = x / 1000;
    iy = y / 1000;
    if (x < 0)
    {
        ix = ix - 1;
    }
    if (y < 0)
    {
        iy = iy - 1;
    }

    int fx, fy;
    fx = x - ix * 1000;
    fy = y - iy * 1000;

    int a, b, c, d;
    a = hash(ix, iy);
    b = hash(ix + 1, iy);
    c = hash(ix, iy + 1);
    d = hash(ix + 1, iy + 1);

    a = fmul(a, 1000 - fx) + fmul(b, fx);
    c = fmul(c, 1000 - fx) + fmul(d, fx);
    a = fmul(a, 1000 - fy) + fmul(c, fy);

    if (a < 363)
    {
        return a / 4;
    }
    if (a > 636)
    {
        return (a + 3000) / 4;
    }
    return 3 * a - 1000;

    return fmul(a, fmul(a, a));


    
    x = x - ix * 1000;
    y = y - iy * 1000;
    if ((ix / 2) * 2 == ix)
    {
        if ((iy / 2) * 2 == iy)
        {
            if (fmul(x, x) + fmul(y, y) < 1000)
            {
                return 800;
            }
        }
    }
    return 300;

}

int sunray(int x, int y, int z)
{
    int t, h;
    t = 0;
    while (t < 100)
    {
        h = noise(x, z);
        if (y < h)
        {
            return 0;
        }
        x = x + 6;
        y = y + 8;
        z = z + 2;
        t = t + 1;
    }
    return 1;
}

int sun_dif(int x, int y)
{
    int a, b;
    a = noise(x, y);
    b = noise(x - 90, y - 30);
    if (a - b < 40)
    {
        if (b - a < 40)
        {
            return 750 + fdiv(a - b, 200);
        }
    }
    if (a > b)
    {
        return 1000;
    }
    return 500;
}

int ray(int x, int y, int z, int dx, int dy, int dz)
{
    int t;
    t = 0;
    int h;
    while (t < 100)
    {
        h = noise(x, z);
        if (y > h)
        {
            x = x + fmul(dx, 50);
            y = y + fmul(dy, 50);
            z = z + fmul(dz, 50);
        }
        t = t + 1;
    }
    if (y - h > 200)
    {
        return 1000;
    }
    if (0)
    {
        h = fmul(h, sun_dif(x, z));
    }
    if (0)
    {
        if (sunray(x, y + 30, z) == 0)
        {
            return h / 2;
        }
    }
    return h;
}

int draw(int px, int py, int pz)
{
    int t, start, end, x, y, a, b;
    start = 65536;
    end = 65536;
    y = 0;
    while (y < 90)
    {
        x = 0;
        while (x < 160)
        {
            a = fdiv(f(x - 80), f(45));
            b = fdiv(f(45 - y), f(45));

            int c;
            c = ray(px, py, pz, a / 2, b / 2 - 180, 1000);
            c = (255 * c) / 1000;
            t = put4(end, c * 65536 + c * 256 + c);
            
            end = end + 4;
            x = x + 1;
        }
        y = y + 1;
    }
    t = out(start, end - start);
    return 0;
}

int main()
{
    int t, x, y, z;
    x = 0;
    y = 1600;
    z = -2000;
    while (1)
    {
        t = draw(x, y, z);
        z = z + 300;
        x = x + 100;
    }
    return 0;
}

