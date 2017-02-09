int cube(int);

int main()
{
	int result;
	result = cube(3);
	printf("%d", result);
}

int cube(int i)
{
	return i * i * i;
}