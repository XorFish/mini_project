#include <stdio.h>

#define BNP "%d%d%d%d"
#define B2N(byte)  \
  (byte & 0x08 ? 1 : 0), \
  (byte & 0x04 ? 1 : 0), \
  (byte & 0x02 ? 1 : 0), \
  (byte & 0x01 ? 1 : 0) 

main()
{
	FILE * speed;
	FILE * direction;
	FILE * left;
	FILE * right;
	speed = fopen( "speed.txt", "w");
	direction = fopen( "direction.txt", "w");
	
	left= fopen( "left.txt", "w");
	right= fopen( "right.txt", "w");
	int i;
	if((speed != NULL) && (direction != NULL) && 
	   (left  != NULL) && (right != NULL)) {
		for(i = 0; i < 0x100; i++) {
			int s_right=0;
			int s_left=0; 
			int inSpeed=i/16;
			int inDirection=i%16;
			int fastSpeed=inSpeed&0x07;
			int directionValue=inDirection&0x07;
			int slowSpeed=fastSpeed-directionValue;
			if(inDirection<0x08) {
				s_left=fastSpeed;
				if(slowSpeed>=0) {
					s_right=slowSpeed;				
				} else {
					s_right=-slowSpeed+0x08;				
				}
			} else {
				s_right=fastSpeed;
				if(slowSpeed>=0) {
					s_left=slowSpeed;				
				} else {
					s_left=-slowSpeed+0x08;				
				}

			}
			if(inSpeed>=0x08) {
				s_left+=0x8;
				s_right+=0x8;
			}
			fprintf(speed, BNP"\n", B2N(inSpeed));
			fprintf(direction, BNP"\n", B2N(inDirection));
			fprintf(left, BNP"\n", B2N(s_left));
			fprintf(right, BNP"\n", B2N(s_right));

		}
	}
}
