#ifndef TIMER_H
#define TIMER_H
//where we handle our timer functions
#define cpu_bpeek(a)    (*(unsigned char *)(a))
#define cpu_bpoke(a,b)  (*(unsigned char *)(a) = b)
#define ABS(N) ((N<0)?(-N):(N))

//65636*PEEK 23674 + 256*PEEK 23673 + PEEK 23672
//65536*PEEK 23674 + 256*PEEK 23673 + PEEK 23672)/50

/*
unsigned char microSec;
unsigned char seconds;
unsigned char minutes;
unsigned long timeStart;
unsigned long timeEnd;
unsigned long timeDiff;
*/
void timerStart (void)
{
    //clear to 0
    cpu_bpoke(23674,0);//minutes
    cpu_bpoke(23673,0);//seconds
    cpu_bpoke(23672,7);//microSec

    microSec = (long)cpu_bpeek(23672);
    seconds  = (long)cpu_bpeek(23673);
    minutes  = (long)cpu_bpeek(23674);

    //65536*PEEK 23674 + 256*PEEK 23673 + PEEK 23672)/50
    timeStart = (256 * seconds + microSec);

    //printf("\n time = %ld", timeStart);

    //printf("start: %ld\n", timeStart);
    //in_wait_key();
}

void timerEnd (void)
{
    microSec = cpu_bpeek(23672);
    seconds = cpu_bpeek(23673);
    minutes = cpu_bpeek(23674);

    //65536*PEEK 23674 + 256*PEEK 23673 + PEEK 23672)/50
    timeEnd = (256 * seconds + microSec);
    timeDiff = (timeEnd - timeStart) * 20;
    //printf("timeEnd: %ld\n", timeEnd);
    //printf("timeDiff: %ld\n", timeDiff);
}




#endif
//leave blank line after

