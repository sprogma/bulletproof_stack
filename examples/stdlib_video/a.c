int put4(int ptr, int val);
int put1(int ptr, int val);
int out(int ptr, int count);

int main()
{
    int end, start, t, x, y;
    end = 24576;
    start = 24576;

    while (1)
    {
        y = 0;
        while (y != 90)
        {
            x = 0;
            while (x != 160)
            {
                t = put4(end, 0);
                
                int a, b, i;
                a = x - 80;
                b = y - 45;

                int ta, tb;
                a = (a * 1) / 2;
                b = (b * 1) / 2;
                ta = 0;
                tb = 0;
                i = 0;
                while (i != 100)
                {
                    t = (ta * ta - tb * tb) / 100 + a;
                    tb = (2 * ta * tb) / 100 + b;
                    ta = t;
                
                    if (ta * ta + tb * tb > 4 * 100)
                    {
                        if ((i / 2) * 2 == i)
                        {
                            t = put4(end, 16711680);
                            i = 99;
                        }
                    }
                    
                    i = i + 1;
                }
                
                end = end + 4;
                x = x + 1;
            }
            y = y + 1;
        }
        t = out(start, end - start);
        end = start;
    }
    return 0;
}
