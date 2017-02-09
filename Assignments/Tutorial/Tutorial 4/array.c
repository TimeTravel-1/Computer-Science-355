int main()
{	
	int arr[5] = {1, 45, -16, 23, 48};
	int n;
	n = 5;
	register int i, max;

	max = arr[0];

	for(i = 1; i < n; i++)
	{
		if (arr[i] > max)
		{
			max = arr[i];
		}
	}

	printf("%d\n",max);
}
