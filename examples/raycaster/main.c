int phong(int lx, int ly, int lz, int dx, int dy, int dz, int nx, int ny, int nz)
{
    int l;
    l = sqrt(fmul(dx, dx) + fmul(dy, dy) + fmul(dz, dz));
    dx = fdiv(dx, l);
    dy = fdiv(dy, l);
    dz = fdiv(dz, l); 
    l = sqrt(fmul(nx, nx) + fmul(ny, ny) + fmul(nz, nz));
    nx = fdiv(nx, l);
    ny = fdiv(ny, l);
    nz = fdiv(nz, l); 
    l = sqrt(fmul(lx, lx) + fmul(ly, ly) + fmul(lz, lz));
    if (l < 1)
    {
        return 0;
    }
    lx = fdiv(lx, l);
    ly = fdiv(ly, l);
    lz = fdiv(lz, l);
    int diffuse;
    diffuse = fmul(lx, nx) + fmul(ly, ny) + fmul(lz, nz);
    diffuse = fmul(diffuse, 400);
    if (diffuse < 0)
    {
        diffuse = 0;
    }
    int blink;
    blink = 0;
    if (lx * nx + ly * ny + lz * nz > 0)
    {
        int x, y, z;
        x = lx - dx;
        y = ly - dy;
        z = lz - dz;
        l = sqrt(fmul(x, x) + fmul(y, y) + fmul(z, z));
        if (l > 0)
        {
            x = fdiv(x, l);
            y = fdiv(y, l);
            z = fdiv(z, l); 
        }
        blink = fmul(x, nx) + fmul(y, ny) + fmul(z, nz);
        if (blink < 0)
        {
            blink = 0;
        }
        blink = fmul(blink, blink);
        blink = fmul(blink, blink);
        blink = fmul(blink, blink);
        blink = fmul(blink, 400);
    }
    int ans;
    ans = 200 + diffuse + blink;
    if (ans > 1000)
    {
        ans = 1000;
    }
    return ans;
}


int main()
{
    int res1, res2, res3, t, x, y, gx, gy, gz, lx, ly, lz, ldx, ldy, ldz, tim, ggdx;

    lx = 1000;
    ly = 0;
    lz = 0;

    gx = 50 * 100;
    ggdx = 0;
    gy = 0;
    gz = -8000;

    tim = 0;
    
    while (1)
    {
        int start, end;
        start = 65536;
        end = 65536;

        tim = tim + 1;

        int k1, k2, k3;
        k1 = lx;
        k2 = ly;
        k3 = lz;

        if (tim - (tim / 100) * 100 < 50)
        {
            lx = fmul(k1, 993) + fmul(k2, -59) + fmul(k3, 99);
            ly = fmul(k1, 65) + fmul(k2, 996) + fmul(k3, -59);
            lz = fmul(k1, -95) + fmul(k2, 65) + fmul(k3, 993);
        }
        else
        {
            lx = fmul(k1, 995) + fmul(k2, -89) + fmul(k3, 19);
            ly = fmul(k1, 89) + fmul(k2, 995) + fmul(k3, -19);
            lz = fmul(k1, -21) + fmul(k2, -18) + fmul(k3, 999);
        }
        if (tim - (tim / 400) * 400 < 200)
        {
            gx = gx - 50; 
        }
        else
        {
            gx = gx + 50;
        }
        t = sqrt(fmul(lx, lx) + fmul(ly, ly) + fmul(lz, lz)) / 2;
        lx = fdiv(lx, t);
        ly = fdiv(ly, t);
        lz = fdiv(lz, t);
        
        y = 0;
        while (y < 90)
        {
            x = 0;
            while (x < 160)
            {
                int a, b;
                a = (x - 80) * 12;
                b = (45 - y) * 12;

                int dx, dy, dz, px, py, pz, nx, ny, nz, ldx, ldy, ldz;
                
                dx = (a * 2) / 3;
                dy = (b * 2) / 3;
                dz = 1000;
                
                res1 = intersect_ball(gx, gy, gz, dx, dy, dz, -1200, -600, 0, 1500);

                t = put4(end, 255 * 255);
                if (res1 > 0)
                {
                    px = gx + fmul(dx, res1);
                    py = gy + fmul(dy, res1);
                    pz = gz + fmul(dz, res1);
                    nx = px + 1200;
                    ny = py + 600;
                    nz = pz - 0;
                    ldx = lx - px;
                    ldy = ly - py;
                    ldz = lz - pz;
                    int spec;
                    spec = phong(ldx, ldy, ldz, dx, dy, dz, nx, ny, nz);

                    int color;
                    color = (255 * spec) / 1000;
                    
                    t = put4(end, color + 255 * color + 65536 * color);
                }

                res3 = intersect_ball(gx, gy, gz, dx, dy, dz, 1500, 700, 800, 1000);
                if ((res3 < res1) + (res1 < 0))
                {
                    if (res3 > 0)
                    {
                        px = gx + fmul(dx, res3);
                        py = gy + fmul(dy, res3);
                        pz = gz + fmul(dz, res3);
                        nx = px - 1500;
                        ny = py - 700;
                        nz = pz - 800;
                        ldx = lx - px;
                        ldy = ly - py;
                        ldz = lz - pz;
                        int spec;
                        spec = phong(ldx, ldy, ldz, dx, dy, dz, nx, ny, nz);

                        int color;
                        color = (255 * spec) / 1000;
                        
                        t = put4(end, 255 * color);
                    }
                }
                
                res2 = intersect_ball(gx, gy, gz, dx, dy, dz, 2 * lx, 2 * ly, 5000 + 2 * lz, 100);
                if ((res2 < res1) + (res1 < 0))
                {
                    if ((res2 < res3) + (res3 < 0))
                    {
                        
                        if (res2 > 0)
                        {
                            t = put4(end, 255 * 65536);
                        }
                    }
                }
                
                end = end + 4;
                x = x + 1;
            }
            y = y + 1;
        }
        t = out(start, end - start);
    }

    return 0;
}
