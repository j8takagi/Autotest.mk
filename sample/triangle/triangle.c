/**********************************************************************
triangle.c
引数として指定された3つの整数が三角形の3辺を表すものとし、
次のうちどれであるかをきめるメッセージを印字する。
    不等辺三角形（scalene triangle）
    二等辺三角形（isosceles triangle）
    正三角形（equilateral triangle）

Glenford J Myers『ソフトウェア・テストの技法』（近代科学社、1980）
http://www.amazon.co.jp/dp/4764900599
第1章「自己診断テスト」に記載された「自己診断テスト」の仕様を実装
**********************************************************************/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int l[3], i;
    char *check;

    /* 引数が3つ以外の場合は、エラー終了 */
    if(argc != 4) {
        if(argc < 4) {
            fprintf(stderr, "too few argument.\n");
        }
        else if(argc > 4) {
            fprintf(stderr, "too many argument.\n");
        }
        return 1;
    }
    for(i = 0; i < 3; i++) {
        /* 引数を整数に変換 */
        l[i] = strtol(argv[i+1], &check, 10);
        /* 整数以外の場合はエラー終了 */
        if(*check != '\0') {
            fprintf(stderr, "%s: not integer\n", argv[i+1]);
            return 1;
        }
        /* 0未満の場合はエラー終了 */
        if(l[i] < 0) {
            fprintf(stderr, "%s: less than zero\n", argv[i+1]);
            return 1;
        }
    }
    /* 三角不等式により、三角形になるかを判定 */
    if(l[0] + l[1] <= l[2] || l[1] + l[2] <= l[0] || l[2] + l[0] <= l[1]) {
        puts("not triangle");
        return 1;
    }
    /* 3辺の長さが等しい場合は、正三角形 */
    if(l[0] == l[1] && l[1] == l[2] && l[2] == l[0]) {
        puts("equilateral triangle");
    }
    /* 2辺の長さが等しい場合は、二等辺三角形 */
    else if(l[0] == l[1] || l[1] == l[2] || l[2] == l[0]) {
        puts("isosceles triangle");
    }
    /* それ以外の場合は、不等辺三角形 */
    else {
        puts("scalene triangle");
    }
    return 0;
}
