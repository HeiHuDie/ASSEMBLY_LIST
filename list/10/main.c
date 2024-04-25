#include <stdio.h>
extern void bubble_sort(char *arr, int n);
int main() {
    char arr[] = {"Hello, World!"};
    int n = 13;
    bubble_sort(arr, n);
    printf("Sorted array: \n");
    for (int i = 0; i < n; i++) {
        printf("%c", arr[i]);
    }
    printf("\n");
    return 0;
}