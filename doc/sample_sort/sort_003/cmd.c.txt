#include <stdio.h>
#ifndef ARRAYSIZE
#define ARRAYSIZE(array) (sizeof(array)/sizeof(array[0]))
#endif

void sort(int array[], int num);

int main() {
    int i, array[] = {7, 11, 3, 2, 5};

    sort(array, ARRAYSIZE(array));
    for(i = 0; i < ARRAYSIZE(array); i++) {
        printf("%d\n", array[i]);
    }
    return 0;
}
