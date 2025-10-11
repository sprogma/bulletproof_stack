int draw()
{
    int t, start, end, x, y;
    start = 24576;
    end = 24576;
    x = 0;
    while (x != 160)
    {
        y = 0;
        while (y != 90)
        {
            put4(end, 255*255);
            end = end + 4;
            y = y + 1;
        }
        x = x + 1;
    }
    t = out(start, end - start);
    return 0;
}

int main()
{
    int end, start, t, x, y;
    end = 24576;
    start = 24576;

    while (1)
    {
        t = draw();
    }
    return 0;
}

