#include<iostream>
#include<assert.h>

using namespace std;
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

    delete[] temp;
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

void swap(int a[], int l, int r)
{
    // Insidious bugs cam creep in if l and r are same
    if(l==r) return;

    a[l] = a[l] + a[r];
    a[r] = a[l] - a[r];
    a[l] = a[l] - a[r];
}

void heapify(int a[], int startIndex, int size)
{
    int maxIndex = startIndex + size - 1;

    for(int i = (size - 1) / 2 + startIndex; i>= startIndex; i--)
    {
        int virti = i - startIndex;
        int lChild = 2*virti + 1 + startIndex;
        int rChild = 2*virti + 2 + startIndex;

        if(lChild <= maxIndex && a[i] > a[lChild])
        {
            swap(a,i,lChild);
        }
        if(rChild <= maxIndex && a[i] > a[rChild])
        {
            swap(a,i,rChild);
        }
    }

}


void heapsort(int a[], int size)
{
    for(int i = 0; i < size; i++)
    {
        heapify(a,i,size - i);
    }
}

void quicksortrec(int a[], int startIndex, int endIndex)
{

    int lo = startIndex;
    int hi = endIndex;
    cout<<"pivot:"<<a[startIndex]<<endl;
    for(;lo < hi;)
    {
        // find first element greater than pivot in left
        while(a[lo] <= a[startIndex]) {lo++;}

        //find first element less than pivot from right
        while(a[hi] > a[startIndex]) {hi--;}

        if(lo < hi)
        {
            assert(lo < endIndex);
            assert(hi > startIndex);
            swap(a,lo,hi);
        }
    }
    // a[lhi] now points to an element smaller than pivot. Swap with pivot and and we are done with all left
    // less than pivot and all right greater than pivot

    if(lo > hi) swap(a, startIndex, hi);

    if(hi > startIndex)
    {
        quicksortrec(a, startIndex, hi - 1);
    }
    if(hi + 1 < endIndex)
    {
        quicksortrec(a, hi + 1, endIndex);
    }

}

void quicksort(int a[], int size)
{
    quicksortrec(a,0,size-1);
}
