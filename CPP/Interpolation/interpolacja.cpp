#include <iostream>

int main() {
    int i, j, n = 4;
    double m, arg = 0.1, sum = 0;

    double tableOfX[5] = {1.5, 2, 2.25, 2.75, 3};

    do {
        double tableOfY[5] = {0.99, 0.91, 0.78, 0.38, 0.14};
        sum = 0;

        for (j = 0; j < n-1; j++) {
            for(i = n-1; i > j; i--) {
                tableOfY[i] = (tableOfY[i] - tableOfY[i-1]) / (tableOfX[i] - tableOfX[i-j-1]);
            }
        }

        for (i = n-1; i >= 0; i--) {
            m = 1;
            for (j = 0; j < i; j++) {
                m *= (arg - tableOfX[j]);
            }

            m *= tableOfY[j];
            sum += m;
        }

        printf("f(%.1f) = %f\n", arg, sum);
        arg += 0.1;

    } while( arg <= 7 );

    return 0;
}