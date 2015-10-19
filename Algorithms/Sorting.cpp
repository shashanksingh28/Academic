
// This will be used to create temporary copies of pieces of the main array in scope for merging
void copy(int source[], int destination[],int index, int size)
{
    for(int i = 0; i < size; i++,index++)
    {
        destination[i] = source[index];
    }
}

void merge(int a[], int left, int right, int size)
{
    // Initial thought of using below that is kind of a waste of space
    int * temp = new int[size];
    copy(a,temp,left,size);
    // temp is now a small temporary clipboard with in scope array elements only
    int tleft = 0;
    int tright = right - left;

    for(int i=left; i<(left+size);i++)
    {
        if(tleft < (right - left))
        {
            if(tright < (tleft + size))
            {
                if(temp[tleft] <= temp[tright])
                {
                    a[i] = temp[tleft];
                    tleft++;
                }
                else
                {
                    a[i] = temp[tright];
                    tright++;
                }
            }
            else
            {
                a[i] = temp[tleft];
                tleft++;
            }
        }
        else
        {
            a[i] = temp[tright];
            tright++;
        }
    }

    delete(temp);
}

void mergesortrecur(int a[], int start, int end)
{
    int mid = (start + end)/2;
    // In case of single element return
    if(start == mid) return;
    // mergesort left half
    mergesortrecur(a, start, mid - 1);
    // mergesort right half
    mergesortrecur(a, mid, end);
    // merge self
    merge(a, start, mid, (end - start + 1));
}

void mergesort(int a[], int size)
{
    mergesortrecur(a, 0, size - 1);
}

