//十二支を答える
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int  main( )
{
    char   buf[128],eto[32];    // 文字型配列
    int    yy;                  // 年

    printf("\nあなたは西暦何生まれですか？ ");
    fflush(stdin);
    gets(buf);                 // 文字列を入力し配列bufに格納
    yy=atoi(buf);              // 整数値に変換

    switch ( yy%12 )           // 年を12で割った余り
      {
        case  0: strcpy(eto,"申（さる）"); break;
        case  1: strcpy(eto,"酉（とり）"); break;
        case  2: strcpy(eto,"戌（いぬ）"); break;
        case  3: strcpy(eto,"亥（い）"); break;
        case  4: strcpy(eto,"子（ね）"); break;
        case  5: strcpy(eto,"丑（うし）"); break;
        case  6: strcpy(eto,"寅（とら）"); break;
        case  7: strcpy(eto,"卯（う）"); break;
        case  8: strcpy(eto,"辰（たつ）"); break;
        case  9: strcpy(eto,"巳（み）"); break;
        case 10: strcpy(eto,"午（うま）"); break;
        case 11: strcpy(eto,"未（ひつじ）"); break;
      }

    printf("\n%s年生まれのあなたの十二支は、%sですね\n",buf,eto);
}
