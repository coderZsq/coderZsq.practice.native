#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>


int main(int argc, char *argv[])
{


  int fd = -1;
  int ret = 1;
  int buffer = 1024;
  int num = 0;


  if((fd=open("./test", O_RDWR|O_CREAT|O_TRUNC))==-1)
  {
    printf("Open Error\n");
    exit(1);
  }


  ret = write(fd, &buffer, sizeof(int));
  if( ret < 0)
  {
    printf("write Error\n");
    exit(1);
  }
  printf("write %d byte(s)\n",ret);


  lseek(fd, 0L, SEEK_SET);
  ret= read(fd, &num, sizeof(int));
  if(ret==-1)
  {
    printf("read Error\n");
    exit(1);
  }
  printf("read %d byte(s)，the number is %d\n", ret, num);


  close(fd);


  return 0;
}