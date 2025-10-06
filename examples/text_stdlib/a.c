int put4(int ptr, int val);
int put1(int ptr, int val);
int out(int ptr, int count);

int main()
{
    int x;
    x = put4(16384 + 1024, 16909060);
    x = put4(16384 + 1024 + 4, 16909060);
    x = out(16384 + 1024, 8);
    return 0;
}
