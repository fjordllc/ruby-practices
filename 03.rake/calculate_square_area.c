/*
 * C言語のサンプルプログラム - Webkaru
 * - 正方形の面積を計算 -
 */
#include <stdio.h>
  
int main(void)
{
 
  /* 正方形の面積 */
  float area;
 
  /* 一辺の長さ */
  float length;
 
  /* 一辺の長さを入力 */
  printf("正方形の一辺の長さを入力: a = ");
  scanf("%f", &length);
 
  /* 正方形の面積を計算・出力 */
  area = length * length;
  printf("正方形の面積: S = %.3f\n", area);
 
  return 0;
}
