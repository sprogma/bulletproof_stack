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
    int diffuse;
    diffuse = fmul(lx, nx) + fmul(ly, ny) + fmul(lz, nz);
    diffuse = fmul(diffuse, 400);
    if (diffuse < 0)
    {
        diffuse = 0;
    }
    int x, y, z;
    x = lx - dx;
    y = ly - dy;
    z = lz - dz;
    l = sqrt(fmul(x, x) + fmul(y, y) + fmul(z, z));
    x = fdiv(x, l);
    y = fdiv(y, l);
    z = fdiv(z, l); 
    int blink;
    blink = fmul(x, nx) + fmul(y, ny) + fmul(z, nz);
    if (blink < 0)
    {
        blink = 0;
    }
    blink = fmul(blink, blink);
    blink = fmul(blink, blink);
    l = fmul(blink, blink);
    blink = fmul(blink, l);
    blink = fmul(blink, 400);
    return 200 + diffuse + blink;
}


int main()
{
    int res, t, x, y, gx, gy, gz, lx, ly, lz, ldx, ldy, ldz;

    lx = 500;
    ly = 1000;
    lz = -800;

    t = sqrt(fmul(lx, lx) + fmul(ly, ly) + fmul(lz, lz));
    lx = fdiv(lx, t);
    ly = fdiv(ly, t);
    lz = fdiv(lz, t);

    gx = 0;
    gy = 0;
    gz = -4000;

    while (1)
    {
        int start, end;
        start = 65536;
        end = 65536;

        gz = gz + 10;
        gx = gx - 10;
        
        y = 0;
        while (y < 90)
        {
            x = 0;
            while (x < 160)
            {
                int a, b;
                a = (x - 80) * 12;
                b = (45 - y) * 12;

                int dx, dy, dz, px, py, pz, nx, ny, nz;
                dx = a / 2;
                dy = b / 2;
                dz = 1000;
                res = intersect_ball(gx, gy, gz, dx, dy, dz, 0, 0, 5000, 1000);
                px = gx + fmul(dx, res);
                py = gy + fmul(dy, res);
                pz = gz + fmul(dz, res);
                nx = px - 0;
                ny = py - 0;
                nz = pz - 5000;

                t = put4(end, 255 * 255);
                if (res > 0)
                {
                    int spec;
                    spec = phong(lx, ly, lz, dx, dy, dz, nx, ny, nz);

                    int color;
                    color = (255 * spec) / 1000;
                    
                    t = put4(end, color + 255 * color + 65536 * color);
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
