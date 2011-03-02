
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 08 44 00 00       	mov    0x4408,%eax
       b:	c7 44 24 04 90 31 00 	movl   $0x3190,0x4(%esp)
      12:	00 
      13:	89 04 24             	mov    %eax,(%esp)
      16:	e8 55 2e 00 00       	call   2e70 <printf>
  fd = open("echo", 0);
      1b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      22:	00 
      23:	c7 04 24 9b 31 00 00 	movl   $0x319b,(%esp)
      2a:	e8 35 2d 00 00       	call   2d64 <open>
  if(fd < 0){
      2f:	85 c0                	test   %eax,%eax
      31:	78 37                	js     6a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
      33:	89 04 24             	mov    %eax,(%esp)
      36:	e8 11 2d 00 00       	call   2d4c <close>
  fd = open("doesnotexist", 0);
      3b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      42:	00 
      43:	c7 04 24 b3 31 00 00 	movl   $0x31b3,(%esp)
      4a:	e8 15 2d 00 00       	call   2d64 <open>
  if(fd >= 0){
      4f:	85 c0                	test   %eax,%eax
      51:	79 31                	jns    84 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
      53:	a1 08 44 00 00       	mov    0x4408,%eax
      58:	c7 44 24 04 de 31 00 	movl   $0x31de,0x4(%esp)
      5f:	00 
      60:	89 04 24             	mov    %eax,(%esp)
      63:	e8 08 2e 00 00       	call   2e70 <printf>
}
      68:	c9                   	leave  
      69:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
      6a:	a1 08 44 00 00       	mov    0x4408,%eax
      6f:	c7 44 24 04 a0 31 00 	movl   $0x31a0,0x4(%esp)
      76:	00 
      77:	89 04 24             	mov    %eax,(%esp)
      7a:	e8 f1 2d 00 00       	call   2e70 <printf>
    exit();
      7f:	e8 a0 2c 00 00       	call   2d24 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
      84:	a1 08 44 00 00       	mov    0x4408,%eax
      89:	c7 44 24 04 c0 31 00 	movl   $0x31c0,0x4(%esp)
      90:	00 
      91:	89 04 24             	mov    %eax,(%esp)
      94:	e8 d7 2d 00 00       	call   2e70 <printf>
    exit();
      99:	e8 86 2c 00 00       	call   2d24 <exit>
      9e:	66 90                	xchg   %ax,%ax

000000a0 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
      a0:	55                   	push   %ebp
      a1:	89 e5                	mov    %esp,%ebp
      a3:	56                   	push   %esi
      a4:	53                   	push   %ebx
      a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      a8:	a1 08 44 00 00       	mov    0x4408,%eax
      ad:	c7 44 24 04 ec 31 00 	movl   $0x31ec,0x4(%esp)
      b4:	00 
      b5:	89 04 24             	mov    %eax,(%esp)
      b8:	e8 b3 2d 00 00       	call   2e70 <printf>
  fd = open("small", O_CREATE|O_RDWR);
      bd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
      c4:	00 
      c5:	c7 04 24 fd 31 00 00 	movl   $0x31fd,(%esp)
      cc:	e8 93 2c 00 00       	call   2d64 <open>
  if(fd >= 0){
      d1:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
      d3:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
      d5:	0f 88 b1 01 00 00    	js     28c <writetest+0x1ec>
    printf(stdout, "creat small succeeded; ok\n");
      db:	a1 08 44 00 00       	mov    0x4408,%eax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
      e0:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
      e2:	c7 44 24 04 03 32 00 	movl   $0x3203,0x4(%esp)
      e9:	00 
      ea:	89 04 24             	mov    %eax,(%esp)
      ed:	e8 7e 2d 00 00       	call   2e70 <printf>
      f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      f8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
      ff:	00 
     100:	c7 44 24 04 3a 32 00 	movl   $0x323a,0x4(%esp)
     107:	00 
     108:	89 34 24             	mov    %esi,(%esp)
     10b:	e8 34 2c 00 00       	call   2d44 <write>
     110:	83 f8 0a             	cmp    $0xa,%eax
     113:	0f 85 e9 00 00 00    	jne    202 <writetest+0x162>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
     119:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     120:	00 
     121:	c7 44 24 04 45 32 00 	movl   $0x3245,0x4(%esp)
     128:	00 
     129:	89 34 24             	mov    %esi,(%esp)
     12c:	e8 13 2c 00 00       	call   2d44 <write>
     131:	83 f8 0a             	cmp    $0xa,%eax
     134:	0f 85 e6 00 00 00    	jne    220 <writetest+0x180>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
     13a:	83 c3 01             	add    $0x1,%ebx
     13d:	83 fb 64             	cmp    $0x64,%ebx
     140:	75 b6                	jne    f8 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     142:	a1 08 44 00 00       	mov    0x4408,%eax
     147:	c7 44 24 04 50 32 00 	movl   $0x3250,0x4(%esp)
     14e:	00 
     14f:	89 04 24             	mov    %eax,(%esp)
     152:	e8 19 2d 00 00       	call   2e70 <printf>
  close(fd);
     157:	89 34 24             	mov    %esi,(%esp)
     15a:	e8 ed 2b 00 00       	call   2d4c <close>
  fd = open("small", O_RDONLY);
     15f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     166:	00 
     167:	c7 04 24 fd 31 00 00 	movl   $0x31fd,(%esp)
     16e:	e8 f1 2b 00 00       	call   2d64 <open>
  if(fd >= 0){
     173:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     175:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     177:	0f 88 c1 00 00 00    	js     23e <writetest+0x19e>
    printf(stdout, "open small succeeded ok\n");
     17d:	a1 08 44 00 00       	mov    0x4408,%eax
     182:	c7 44 24 04 5b 32 00 	movl   $0x325b,0x4(%esp)
     189:	00 
     18a:	89 04 24             	mov    %eax,(%esp)
     18d:	e8 de 2c 00 00       	call   2e70 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     192:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     199:	00 
     19a:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     1a1:	00 
     1a2:	89 1c 24             	mov    %ebx,(%esp)
     1a5:	e8 92 2b 00 00       	call   2d3c <read>
  if(i == 2000) {
     1aa:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     1af:	0f 85 a3 00 00 00    	jne    258 <writetest+0x1b8>
    printf(stdout, "read succeeded ok\n");
     1b5:	a1 08 44 00 00       	mov    0x4408,%eax
     1ba:	c7 44 24 04 8f 32 00 	movl   $0x328f,0x4(%esp)
     1c1:	00 
     1c2:	89 04 24             	mov    %eax,(%esp)
     1c5:	e8 a6 2c 00 00       	call   2e70 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     1ca:	89 1c 24             	mov    %ebx,(%esp)
     1cd:	e8 7a 2b 00 00       	call   2d4c <close>

  if(unlink("small") < 0) {
     1d2:	c7 04 24 fd 31 00 00 	movl   $0x31fd,(%esp)
     1d9:	e8 96 2b 00 00       	call   2d74 <unlink>
     1de:	85 c0                	test   %eax,%eax
     1e0:	0f 88 8c 00 00 00    	js     272 <writetest+0x1d2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     1e6:	a1 08 44 00 00       	mov    0x4408,%eax
     1eb:	c7 44 24 04 b7 32 00 	movl   $0x32b7,0x4(%esp)
     1f2:	00 
     1f3:	89 04 24             	mov    %eax,(%esp)
     1f6:	e8 75 2c 00 00       	call   2e70 <printf>
}
     1fb:	83 c4 10             	add    $0x10,%esp
     1fe:	5b                   	pop    %ebx
     1ff:	5e                   	pop    %esi
     200:	5d                   	pop    %ebp
     201:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      printf(stdout, "error: write aa %d new file failed\n", i);
     202:	a1 08 44 00 00       	mov    0x4408,%eax
     207:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     20b:	c7 44 24 04 78 3e 00 	movl   $0x3e78,0x4(%esp)
     212:	00 
     213:	89 04 24             	mov    %eax,(%esp)
     216:	e8 55 2c 00 00       	call   2e70 <printf>
      exit();
     21b:	e8 04 2b 00 00       	call   2d24 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
     220:	a1 08 44 00 00       	mov    0x4408,%eax
     225:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     229:	c7 44 24 04 9c 3e 00 	movl   $0x3e9c,0x4(%esp)
     230:	00 
     231:	89 04 24             	mov    %eax,(%esp)
     234:	e8 37 2c 00 00       	call   2e70 <printf>
      exit();
     239:	e8 e6 2a 00 00       	call   2d24 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     23e:	a1 08 44 00 00       	mov    0x4408,%eax
     243:	c7 44 24 04 74 32 00 	movl   $0x3274,0x4(%esp)
     24a:	00 
     24b:	89 04 24             	mov    %eax,(%esp)
     24e:	e8 1d 2c 00 00       	call   2e70 <printf>
    exit();
     253:	e8 cc 2a 00 00       	call   2d24 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000) {
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     258:	a1 08 44 00 00       	mov    0x4408,%eax
     25d:	c7 44 24 04 b5 35 00 	movl   $0x35b5,0x4(%esp)
     264:	00 
     265:	89 04 24             	mov    %eax,(%esp)
     268:	e8 03 2c 00 00       	call   2e70 <printf>
    exit();
     26d:	e8 b2 2a 00 00       	call   2d24 <exit>
  }
  close(fd);

  if(unlink("small") < 0) {
    printf(stdout, "unlink small failed\n");
     272:	a1 08 44 00 00       	mov    0x4408,%eax
     277:	c7 44 24 04 a2 32 00 	movl   $0x32a2,0x4(%esp)
     27e:	00 
     27f:	89 04 24             	mov    %eax,(%esp)
     282:	e8 e9 2b 00 00       	call   2e70 <printf>
    exit();
     287:	e8 98 2a 00 00       	call   2d24 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     28c:	a1 08 44 00 00       	mov    0x4408,%eax
     291:	c7 44 24 04 1e 32 00 	movl   $0x321e,0x4(%esp)
     298:	00 
     299:	89 04 24             	mov    %eax,(%esp)
     29c:	e8 cf 2b 00 00       	call   2e70 <printf>
    exit();
     2a1:	e8 7e 2a 00 00       	call   2d24 <exit>
     2a6:	8d 76 00             	lea    0x0(%esi),%esi
     2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     2b0:	55                   	push   %ebp
     2b1:	89 e5                	mov    %esp,%ebp
     2b3:	56                   	push   %esi
     2b4:	53                   	push   %ebx
     2b5:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2b8:	a1 08 44 00 00       	mov    0x4408,%eax
     2bd:	c7 44 24 04 cb 32 00 	movl   $0x32cb,0x4(%esp)
     2c4:	00 
     2c5:	89 04 24             	mov    %eax,(%esp)
     2c8:	e8 a3 2b 00 00       	call   2e70 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     2cd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     2d4:	00 
     2d5:	c7 04 24 45 33 00 00 	movl   $0x3345,(%esp)
     2dc:	e8 83 2a 00 00       	call   2d64 <open>
  if(fd < 0){
     2e1:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
     2e3:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     2e5:	0f 88 7a 01 00 00    	js     465 <writetest1+0x1b5>
     2eb:	31 db                	xor    %ebx,%ebx
     2ed:	8d 76 00             	lea    0x0(%esi),%esi
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
     2f0:	89 1d 40 44 00 00    	mov    %ebx,0x4440
    if(write(fd, buf, 512) != 512) {
     2f6:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     2fd:	00 
     2fe:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     305:	00 
     306:	89 34 24             	mov    %esi,(%esp)
     309:	e8 36 2a 00 00       	call   2d44 <write>
     30e:	3d 00 02 00 00       	cmp    $0x200,%eax
     313:	0f 85 b2 00 00 00    	jne    3cb <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
     319:	83 c3 01             	add    $0x1,%ebx
     31c:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     322:	75 cc                	jne    2f0 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     324:	89 34 24             	mov    %esi,(%esp)
     327:	e8 20 2a 00 00       	call   2d4c <close>

  fd = open("big", O_RDONLY);
     32c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     333:	00 
     334:	c7 04 24 45 33 00 00 	movl   $0x3345,(%esp)
     33b:	e8 24 2a 00 00       	call   2d64 <open>
  if(fd < 0){
     340:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     342:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     344:	0f 88 01 01 00 00    	js     44b <writetest1+0x19b>
     34a:	30 db                	xor    %bl,%bl
     34c:	eb 1d                	jmp    36b <writetest1+0xbb>
     34e:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
     350:	3d 00 02 00 00       	cmp    $0x200,%eax
     355:	0f 85 b0 00 00 00    	jne    40b <writetest1+0x15b>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
     35b:	a1 40 44 00 00       	mov    0x4440,%eax
     360:	39 d8                	cmp    %ebx,%eax
     362:	0f 85 81 00 00 00    	jne    3e9 <writetest1+0x139>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     368:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
     36b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     372:	00 
     373:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     37a:	00 
     37b:	89 34 24             	mov    %esi,(%esp)
     37e:	e8 b9 29 00 00       	call   2d3c <read>
    if(i == 0) {
     383:	85 c0                	test   %eax,%eax
     385:	75 c9                	jne    350 <writetest1+0xa0>
      if(n == MAXFILE - 1) {
     387:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     38d:	0f 84 96 00 00 00    	je     429 <writetest1+0x179>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     393:	89 34 24             	mov    %esi,(%esp)
     396:	e8 b1 29 00 00       	call   2d4c <close>
  if(unlink("big") < 0) {
     39b:	c7 04 24 45 33 00 00 	movl   $0x3345,(%esp)
     3a2:	e8 cd 29 00 00       	call   2d74 <unlink>
     3a7:	85 c0                	test   %eax,%eax
     3a9:	0f 88 d0 00 00 00    	js     47f <writetest1+0x1cf>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     3af:	a1 08 44 00 00       	mov    0x4408,%eax
     3b4:	c7 44 24 04 6c 33 00 	movl   $0x336c,0x4(%esp)
     3bb:	00 
     3bc:	89 04 24             	mov    %eax,(%esp)
     3bf:	e8 ac 2a 00 00       	call   2e70 <printf>
}
     3c4:	83 c4 10             	add    $0x10,%esp
     3c7:	5b                   	pop    %ebx
     3c8:	5e                   	pop    %esi
     3c9:	5d                   	pop    %ebp
     3ca:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    if(write(fd, buf, 512) != 512) {
      printf(stdout, "error: write big file failed\n", i);
     3cb:	a1 08 44 00 00       	mov    0x4408,%eax
     3d0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     3d4:	c7 44 24 04 f5 32 00 	movl   $0x32f5,0x4(%esp)
     3db:	00 
     3dc:	89 04 24             	mov    %eax,(%esp)
     3df:	e8 8c 2a 00 00       	call   2e70 <printf>
      exit();
     3e4:	e8 3b 29 00 00       	call   2d24 <exit>
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
     3e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
     3ed:	a1 08 44 00 00       	mov    0x4408,%eax
     3f2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     3f6:	c7 44 24 04 c0 3e 00 	movl   $0x3ec0,0x4(%esp)
     3fd:	00 
     3fe:	89 04 24             	mov    %eax,(%esp)
     401:	e8 6a 2a 00 00       	call   2e70 <printf>
             n, ((int*)buf)[0]);
      exit();
     406:	e8 19 29 00 00       	call   2d24 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
     40b:	89 44 24 08          	mov    %eax,0x8(%esp)
     40f:	a1 08 44 00 00       	mov    0x4408,%eax
     414:	c7 44 24 04 49 33 00 	movl   $0x3349,0x4(%esp)
     41b:	00 
     41c:	89 04 24             	mov    %eax,(%esp)
     41f:	e8 4c 2a 00 00       	call   2e70 <printf>
      exit();
     424:	e8 fb 28 00 00       	call   2d24 <exit>
  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    if(i == 0) {
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
     429:	a1 08 44 00 00       	mov    0x4408,%eax
     42e:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     435:	00 
     436:	c7 44 24 04 2c 33 00 	movl   $0x332c,0x4(%esp)
     43d:	00 
     43e:	89 04 24             	mov    %eax,(%esp)
     441:	e8 2a 2a 00 00       	call   2e70 <printf>
        exit();
     446:	e8 d9 28 00 00       	call   2d24 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     44b:	a1 08 44 00 00       	mov    0x4408,%eax
     450:	c7 44 24 04 13 33 00 	movl   $0x3313,0x4(%esp)
     457:	00 
     458:	89 04 24             	mov    %eax,(%esp)
     45b:	e8 10 2a 00 00       	call   2e70 <printf>
    exit();
     460:	e8 bf 28 00 00       	call   2d24 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     465:	a1 08 44 00 00       	mov    0x4408,%eax
     46a:	c7 44 24 04 db 32 00 	movl   $0x32db,0x4(%esp)
     471:	00 
     472:	89 04 24             	mov    %eax,(%esp)
     475:	e8 f6 29 00 00       	call   2e70 <printf>
    exit();
     47a:	e8 a5 28 00 00       	call   2d24 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0) {
    printf(stdout, "unlink big failed\n");
     47f:	a1 08 44 00 00       	mov    0x4408,%eax
     484:	c7 44 24 04 59 33 00 	movl   $0x3359,0x4(%esp)
     48b:	00 
     48c:	89 04 24             	mov    %eax,(%esp)
     48f:	e8 dc 29 00 00       	call   2e70 <printf>
    exit();
     494:	e8 8b 28 00 00       	call   2d24 <exit>
     499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     4a4:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     4a9:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4ac:	a1 08 44 00 00       	mov    0x4408,%eax
     4b1:	c7 44 24 04 e0 3e 00 	movl   $0x3ee0,0x4(%esp)
     4b8:	00 
     4b9:	89 04 24             	mov    %eax,(%esp)
     4bc:	e8 af 29 00 00       	call   2e70 <printf>

  name[0] = 'a';
     4c1:	c6 05 40 4c 00 00 61 	movb   $0x61,0x4c40
  name[2] = '\0';
     4c8:	c6 05 42 4c 00 00 00 	movb   $0x0,0x4c42
     4cf:	90                   	nop
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
     4d0:	88 1d 41 4c 00 00    	mov    %bl,0x4c41
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
     4d6:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     4d9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     4e0:	00 
     4e1:	c7 04 24 40 4c 00 00 	movl   $0x4c40,(%esp)
     4e8:	e8 77 28 00 00       	call   2d64 <open>
    close(fd);
     4ed:	89 04 24             	mov    %eax,(%esp)
     4f0:	e8 57 28 00 00       	call   2d4c <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
     4f5:	80 fb 64             	cmp    $0x64,%bl
     4f8:	75 d6                	jne    4d0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     4fa:	c6 05 40 4c 00 00 61 	movb   $0x61,0x4c40
  name[2] = '\0';
     501:	bb 30 00 00 00       	mov    $0x30,%ebx
     506:	c6 05 42 4c 00 00 00 	movb   $0x0,0x4c42
     50d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
     510:	88 1d 41 4c 00 00    	mov    %bl,0x4c41
    unlink(name);
     516:	83 c3 01             	add    $0x1,%ebx
     519:	c7 04 24 40 4c 00 00 	movl   $0x4c40,(%esp)
     520:	e8 4f 28 00 00       	call   2d74 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
     525:	80 fb 64             	cmp    $0x64,%bl
     528:	75 e6                	jne    510 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     52a:	a1 08 44 00 00       	mov    0x4408,%eax
     52f:	c7 44 24 04 08 3f 00 	movl   $0x3f08,0x4(%esp)
     536:	00 
     537:	89 04 24             	mov    %eax,(%esp)
     53a:	e8 31 29 00 00       	call   2e70 <printf>
}
     53f:	83 c4 14             	add    $0x14,%esp
     542:	5b                   	pop    %ebx
     543:	5d                   	pop    %ebp
     544:	c3                   	ret    
     545:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <dirtest>:

void dirtest(void)
{
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     556:	a1 08 44 00 00       	mov    0x4408,%eax
     55b:	c7 44 24 04 7a 33 00 	movl   $0x337a,0x4(%esp)
     562:	00 
     563:	89 04 24             	mov    %eax,(%esp)
     566:	e8 05 29 00 00       	call   2e70 <printf>

  if(mkdir("dir0") < 0) {
     56b:	c7 04 24 86 33 00 00 	movl   $0x3386,(%esp)
     572:	e8 15 28 00 00       	call   2d8c <mkdir>
     577:	85 c0                	test   %eax,%eax
     579:	78 4b                	js     5c6 <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
     57b:	c7 04 24 86 33 00 00 	movl   $0x3386,(%esp)
     582:	e8 0d 28 00 00       	call   2d94 <chdir>
     587:	85 c0                	test   %eax,%eax
     589:	0f 88 85 00 00 00    	js     614 <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
     58f:	c7 04 24 01 39 00 00 	movl   $0x3901,(%esp)
     596:	e8 f9 27 00 00       	call   2d94 <chdir>
     59b:	85 c0                	test   %eax,%eax
     59d:	78 5b                	js     5fa <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
     59f:	c7 04 24 86 33 00 00 	movl   $0x3386,(%esp)
     5a6:	e8 c9 27 00 00       	call   2d74 <unlink>
     5ab:	85 c0                	test   %eax,%eax
     5ad:	78 31                	js     5e0 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test\n");
     5af:	a1 08 44 00 00       	mov    0x4408,%eax
     5b4:	c7 44 24 04 7a 33 00 	movl   $0x337a,0x4(%esp)
     5bb:	00 
     5bc:	89 04 24             	mov    %eax,(%esp)
     5bf:	e8 ac 28 00 00       	call   2e70 <printf>
}
     5c4:	c9                   	leave  
     5c5:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0) {
    printf(stdout, "mkdir failed\n");
     5c6:	a1 08 44 00 00       	mov    0x4408,%eax
     5cb:	c7 44 24 04 8b 33 00 	movl   $0x338b,0x4(%esp)
     5d2:	00 
     5d3:	89 04 24             	mov    %eax,(%esp)
     5d6:	e8 95 28 00 00       	call   2e70 <printf>
    exit();
     5db:	e8 44 27 00 00       	call   2d24 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    printf(stdout, "unlink dir0 failed\n");
     5e0:	a1 08 44 00 00       	mov    0x4408,%eax
     5e5:	c7 44 24 04 bd 33 00 	movl   $0x33bd,0x4(%esp)
     5ec:	00 
     5ed:	89 04 24             	mov    %eax,(%esp)
     5f0:	e8 7b 28 00 00       	call   2e70 <printf>
    exit();
     5f5:	e8 2a 27 00 00       	call   2d24 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    printf(stdout, "chdir .. failed\n");
     5fa:	a1 08 44 00 00       	mov    0x4408,%eax
     5ff:	c7 44 24 04 ac 33 00 	movl   $0x33ac,0x4(%esp)
     606:	00 
     607:	89 04 24             	mov    %eax,(%esp)
     60a:	e8 61 28 00 00       	call   2e70 <printf>
    exit();
     60f:	e8 10 27 00 00       	call   2d24 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    printf(stdout, "chdir dir0 failed\n");
     614:	a1 08 44 00 00       	mov    0x4408,%eax
     619:	c7 44 24 04 99 33 00 	movl   $0x3399,0x4(%esp)
     620:	00 
     621:	89 04 24             	mov    %eax,(%esp)
     624:	e8 47 28 00 00       	call   2e70 <printf>
    exit();
     629:	e8 f6 26 00 00       	call   2d24 <exit>
     62e:	66 90                	xchg   %ax,%ax

00000630 <exectest>:
  printf(stdout, "mkdir test\n");
}

void
exectest(void)
{
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     636:	a1 08 44 00 00       	mov    0x4408,%eax
     63b:	c7 44 24 04 d1 33 00 	movl   $0x33d1,0x4(%esp)
     642:	00 
     643:	89 04 24             	mov    %eax,(%esp)
     646:	e8 25 28 00 00       	call   2e70 <printf>
  if(exec("echo", echo_args) < 0) {
     64b:	c7 44 24 04 e8 43 00 	movl   $0x43e8,0x4(%esp)
     652:	00 
     653:	c7 04 24 9b 31 00 00 	movl   $0x319b,(%esp)
     65a:	e8 fd 26 00 00       	call   2d5c <exec>
     65f:	85 c0                	test   %eax,%eax
     661:	78 02                	js     665 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     663:	c9                   	leave  
     664:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echo_args) < 0) {
    printf(stdout, "exec echo failed\n");
     665:	a1 08 44 00 00       	mov    0x4408,%eax
     66a:	c7 44 24 04 dc 33 00 	movl   $0x33dc,0x4(%esp)
     671:	00 
     672:	89 04 24             	mov    %eax,(%esp)
     675:	e8 f6 27 00 00       	call   2e70 <printf>
    exit();
     67a:	e8 a5 26 00 00       	call   2d24 <exit>
     67f:	90                   	nop

00000680 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	57                   	push   %edi
     684:	56                   	push   %esi
     685:	53                   	push   %ebx
     686:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     689:	8d 45 e0             	lea    -0x20(%ebp),%eax
     68c:	89 04 24             	mov    %eax,(%esp)
     68f:	e8 a0 26 00 00       	call   2d34 <pipe>
     694:	85 c0                	test   %eax,%eax
     696:	0f 85 4e 01 00 00    	jne    7ea <pipe1+0x16a>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     69c:	e8 7b 26 00 00       	call   2d1c <fork>
  seq = 0;
  if(pid == 0){
     6a1:	83 f8 00             	cmp    $0x0,%eax
     6a4:	0f 84 80 00 00 00    	je     72a <pipe1+0xaa>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     6aa:	0f 8e 53 01 00 00    	jle    803 <pipe1+0x183>
    close(fds[1]);
     6b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    total = 0;
     6b3:	31 ff                	xor    %edi,%edi
    cc = 1;
     6b5:	be 01 00 00 00       	mov    $0x1,%esi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     6ba:	31 db                	xor    %ebx,%ebx
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
     6bc:	89 04 24             	mov    %eax,(%esp)
     6bf:	e8 88 26 00 00       	call   2d4c <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     6c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6c7:	89 74 24 08          	mov    %esi,0x8(%esp)
     6cb:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     6d2:	00 
     6d3:	89 04 24             	mov    %eax,(%esp)
     6d6:	e8 61 26 00 00       	call   2d3c <read>
     6db:	85 c0                	test   %eax,%eax
     6dd:	0f 8e a5 00 00 00    	jle    788 <pipe1+0x108>
     6e3:	31 d2                	xor    %edx,%edx
     6e5:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     6e8:	38 9a 40 44 00 00    	cmp    %bl,0x4440(%edx)
     6ee:	75 1e                	jne    70e <pipe1+0x8e>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     6f0:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     6f3:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     6f6:	39 d0                	cmp    %edx,%eax
     6f8:	7f ee                	jg     6e8 <pipe1+0x68>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     6fa:	01 f6                	add    %esi,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     6fc:	01 c7                	add    %eax,%edi
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
     6fe:	81 fe 01 08 00 00    	cmp    $0x801,%esi
     704:	b8 00 08 00 00       	mov    $0x800,%eax
     709:	0f 43 f0             	cmovae %eax,%esi
     70c:	eb b6                	jmp    6c4 <pipe1+0x44>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     70e:	c7 44 24 04 0b 34 00 	movl   $0x340b,0x4(%esp)
     715:	00 
     716:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     71d:	e8 4e 27 00 00       	call   2e70 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     722:	83 c4 2c             	add    $0x2c,%esp
     725:	5b                   	pop    %ebx
     726:	5e                   	pop    %esi
     727:	5f                   	pop    %edi
     728:	5d                   	pop    %ebp
     729:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     72a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     72d:	31 db                	xor    %ebx,%ebx
  if(pid == 0){
    close(fds[0]);
     72f:	89 04 24             	mov    %eax,(%esp)
     732:	e8 15 26 00 00       	call   2d4c <close>

// simple fork and pipe read/write

void
pipe1(void)
{
     737:	31 c0                	xor    %eax,%eax
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

// simple fork and pipe read/write

void
pipe1(void)
     740:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     743:	88 90 40 44 00 00    	mov    %dl,0x4440(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     749:	83 c0 01             	add    $0x1,%eax
     74c:	3d 09 04 00 00       	cmp    $0x409,%eax
     751:	75 ed                	jne    740 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     753:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     756:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     75c:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     763:	00 
     764:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     76b:	00 
     76c:	89 04 24             	mov    %eax,(%esp)
     76f:	e8 d0 25 00 00       	call   2d44 <write>
     774:	3d 09 04 00 00       	cmp    $0x409,%eax
     779:	75 56                	jne    7d1 <pipe1+0x151>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     77b:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     781:	75 b4                	jne    737 <pipe1+0xb7>
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
     783:	e8 9c 25 00 00       	call   2d24 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
     788:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
     78e:	74 18                	je     7a8 <pipe1+0x128>
      printf(1, "pipe1 oops 3 total %d\n", total);
     790:	89 7c 24 08          	mov    %edi,0x8(%esp)
     794:	c7 44 24 04 19 34 00 	movl   $0x3419,0x4(%esp)
     79b:	00 
     79c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7a3:	e8 c8 26 00 00       	call   2e70 <printf>
    close(fds[0]);
     7a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7ab:	89 04 24             	mov    %eax,(%esp)
     7ae:	e8 99 25 00 00       	call   2d4c <close>
    wait();
     7b3:	e8 74 25 00 00       	call   2d2c <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     7b8:	c7 44 24 04 30 34 00 	movl   $0x3430,0x4(%esp)
     7bf:	00 
     7c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7c7:	e8 a4 26 00 00       	call   2e70 <printf>
     7cc:	e9 51 ff ff ff       	jmp    722 <pipe1+0xa2>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     7d1:	c7 44 24 04 fd 33 00 	movl   $0x33fd,0x4(%esp)
     7d8:	00 
     7d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7e0:	e8 8b 26 00 00       	call   2e70 <printf>
        exit();
     7e5:	e8 3a 25 00 00       	call   2d24 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     7ea:	c7 44 24 04 ee 33 00 	movl   $0x33ee,0x4(%esp)
     7f1:	00 
     7f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7f9:	e8 72 26 00 00       	call   2e70 <printf>
    exit();
     7fe:	e8 21 25 00 00       	call   2d24 <exit>
    if(total != 5 * 1033)
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     803:	c7 44 24 04 3a 34 00 	movl   $0x343a,0x4(%esp)
     80a:	00 
     80b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     812:	e8 59 26 00 00       	call   2e70 <printf>
     817:	e9 67 ff ff ff       	jmp    783 <pipe1+0x103>
     81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000820 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     829:	c7 44 24 04 49 34 00 	movl   $0x3449,0x4(%esp)
     830:	00 
     831:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     838:	e8 33 26 00 00       	call   2e70 <printf>
  pid1 = fork();
     83d:	e8 da 24 00 00       	call   2d1c <fork>
  if(pid1 == 0)
     842:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
     844:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     846:	75 02                	jne    84a <preempt+0x2a>
     848:	eb fe                	jmp    848 <preempt+0x28>
     84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
     850:	e8 c7 24 00 00       	call   2d1c <fork>
  if(pid2 == 0)
     855:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     857:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     859:	75 02                	jne    85d <preempt+0x3d>
     85b:	eb fe                	jmp    85b <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
     85d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     860:	89 04 24             	mov    %eax,(%esp)
     863:	e8 cc 24 00 00       	call   2d34 <pipe>
  pid3 = fork();
     868:	e8 af 24 00 00       	call   2d1c <fork>
  if(pid3 == 0){
     86d:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     86f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     871:	75 4c                	jne    8bf <preempt+0x9f>
    close(pfds[0]);
     873:	8b 45 e0             	mov    -0x20(%ebp),%eax
     876:	89 04 24             	mov    %eax,(%esp)
     879:	e8 ce 24 00 00       	call   2d4c <close>
    if(write(pfds[1], "x", 1) != 1)
     87e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     881:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     888:	00 
     889:	c7 44 24 04 e5 39 00 	movl   $0x39e5,0x4(%esp)
     890:	00 
     891:	89 04 24             	mov    %eax,(%esp)
     894:	e8 ab 24 00 00       	call   2d44 <write>
     899:	83 e8 01             	sub    $0x1,%eax
     89c:	74 14                	je     8b2 <preempt+0x92>
      printf(1, "preempt write error");
     89e:	c7 44 24 04 53 34 00 	movl   $0x3453,0x4(%esp)
     8a5:	00 
     8a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8ad:	e8 be 25 00 00       	call   2e70 <printf>
    close(pfds[1]);
     8b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8b5:	89 04 24             	mov    %eax,(%esp)
     8b8:	e8 8f 24 00 00       	call   2d4c <close>
     8bd:	eb fe                	jmp    8bd <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
     8bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8c2:	89 04 24             	mov    %eax,(%esp)
     8c5:	e8 82 24 00 00       	call   2d4c <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     8ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8cd:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     8d4:	00 
     8d5:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     8dc:	00 
     8dd:	89 04 24             	mov    %eax,(%esp)
     8e0:	e8 57 24 00 00       	call   2d3c <read>
     8e5:	83 e8 01             	sub    $0x1,%eax
     8e8:	74 1c                	je     906 <preempt+0xe6>
    printf(1, "preempt read error");
     8ea:	c7 44 24 04 67 34 00 	movl   $0x3467,0x4(%esp)
     8f1:	00 
     8f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8f9:	e8 72 25 00 00       	call   2e70 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     8fe:	83 c4 2c             	add    $0x2c,%esp
     901:	5b                   	pop    %ebx
     902:	5e                   	pop    %esi
     903:	5f                   	pop    %edi
     904:	5d                   	pop    %ebp
     905:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     906:	8b 45 e0             	mov    -0x20(%ebp),%eax
     909:	89 04 24             	mov    %eax,(%esp)
     90c:	e8 3b 24 00 00       	call   2d4c <close>
  printf(1, "kill... ");
     911:	c7 44 24 04 7a 34 00 	movl   $0x347a,0x4(%esp)
     918:	00 
     919:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     920:	e8 4b 25 00 00       	call   2e70 <printf>
  kill(pid1);
     925:	89 3c 24             	mov    %edi,(%esp)
     928:	e8 27 24 00 00       	call   2d54 <kill>
  kill(pid2);
     92d:	89 34 24             	mov    %esi,(%esp)
     930:	e8 1f 24 00 00       	call   2d54 <kill>
  kill(pid3);
     935:	89 1c 24             	mov    %ebx,(%esp)
     938:	e8 17 24 00 00       	call   2d54 <kill>
  printf(1, "wait... ");
     93d:	c7 44 24 04 83 34 00 	movl   $0x3483,0x4(%esp)
     944:	00 
     945:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     94c:	e8 1f 25 00 00       	call   2e70 <printf>
  wait();
     951:	e8 d6 23 00 00       	call   2d2c <wait>
  wait();
     956:	e8 d1 23 00 00       	call   2d2c <wait>
     95b:	90                   	nop
     95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
     960:	e8 c7 23 00 00       	call   2d2c <wait>
  printf(1, "preempt ok\n");
     965:	c7 44 24 04 8c 34 00 	movl   $0x348c,0x4(%esp)
     96c:	00 
     96d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     974:	e8 f7 24 00 00       	call   2e70 <printf>
     979:	eb 83                	jmp    8fe <preempt+0xde>
     97b:	90                   	nop
     97c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000980 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	56                   	push   %esi
     984:	be 64 00 00 00       	mov    $0x64,%esi
     989:	53                   	push   %ebx
     98a:	83 ec 10             	sub    $0x10,%esp
     98d:	eb 13                	jmp    9a2 <exitwait+0x22>
     98f:	90                   	nop
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     990:	74 79                	je     a0b <exitwait+0x8b>
      if(wait() != pid){
     992:	e8 95 23 00 00       	call   2d2c <wait>
     997:	39 d8                	cmp    %ebx,%eax
     999:	75 35                	jne    9d0 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     99b:	83 ee 01             	sub    $0x1,%esi
     99e:	66 90                	xchg   %ax,%ax
     9a0:	74 4e                	je     9f0 <exitwait+0x70>
    pid = fork();
     9a2:	e8 75 23 00 00       	call   2d1c <fork>
    if(pid < 0){
     9a7:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     9aa:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     9ac:	7d e2                	jge    990 <exitwait+0x10>
      printf(1, "fork failed\n");
     9ae:	c7 44 24 04 98 34 00 	movl   $0x3498,0x4(%esp)
     9b5:	00 
     9b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9bd:	e8 ae 24 00 00       	call   2e70 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	5b                   	pop    %ebx
     9c6:	5e                   	pop    %esi
     9c7:	5d                   	pop    %ebp
     9c8:	c3                   	ret    
     9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     9d0:	c7 44 24 04 a5 34 00 	movl   $0x34a5,0x4(%esp)
     9d7:	00 
     9d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9df:	e8 8c 24 00 00       	call   2e70 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	5b                   	pop    %ebx
     9e8:	5e                   	pop    %esi
     9e9:	5d                   	pop    %ebp
     9ea:	c3                   	ret    
     9eb:	90                   	nop
     9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     9f0:	c7 44 24 04 b5 34 00 	movl   $0x34b5,0x4(%esp)
     9f7:	00 
     9f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9ff:	e8 6c 24 00 00       	call   2e70 <printf>
}
     a04:	83 c4 10             	add    $0x10,%esp
     a07:	5b                   	pop    %ebx
     a08:	5e                   	pop    %esi
     a09:	5d                   	pop    %ebp
     a0a:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     a0b:	e8 14 23 00 00       	call   2d24 <exit>

00000a10 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	56                   	push   %esi
     a14:	53                   	push   %ebx
     a15:	83 ec 10             	sub    $0x10,%esp
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
     a18:	e8 ff 22 00 00       	call   2d1c <fork>
     a1d:	85 c0                	test   %eax,%eax
     a1f:	75 6f                	jne    a90 <mem+0x80>
     a21:	31 db                	xor    %ebx,%ebx
     a23:	eb 07                	jmp    a2c <mem+0x1c>
     a25:	8d 76 00             	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
     a28:	89 18                	mov    %ebx,(%eax)
     a2a:	89 c3                	mov    %eax,%ebx
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
     a2c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     a33:	e8 58 26 00 00       	call   3090 <malloc>
     a38:	85 c0                	test   %eax,%eax
     a3a:	75 ec                	jne    a28 <mem+0x18>
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
     a3c:	85 db                	test   %ebx,%ebx
     a3e:	75 0a                	jne    a4a <mem+0x3a>
     a40:	eb 16                	jmp    a58 <mem+0x48>
     a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
     a48:	89 f3                	mov    %esi,%ebx
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
      m2 = *(char**)m1;
     a4a:	8b 33                	mov    (%ebx),%esi
      free(m1);
     a4c:	89 1c 24             	mov    %ebx,(%esp)
     a4f:	e8 ac 25 00 00       	call   3000 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
     a54:	85 f6                	test   %esi,%esi
     a56:	75 f0                	jne    a48 <mem+0x38>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     a58:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     a5f:	e8 2c 26 00 00       	call   3090 <malloc>
    if(m1 == 0) {
     a64:	85 c0                	test   %eax,%eax
     a66:	74 38                	je     aa0 <mem+0x90>
      printf(1, "couldn't allocate mem?!!\n");
      exit();
    }
    free(m1);
     a68:	89 04 24             	mov    %eax,(%esp)
     a6b:	e8 90 25 00 00       	call   3000 <free>
    printf(1, "mem ok\n");
     a70:	c7 44 24 04 dc 34 00 	movl   $0x34dc,0x4(%esp)
     a77:	00 
     a78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a7f:	e8 ec 23 00 00       	call   2e70 <printf>
    exit();
     a84:	e8 9b 22 00 00       	call   2d24 <exit>
     a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else {
    wait();
  }
}
     a90:	83 c4 10             	add    $0x10,%esp
     a93:	5b                   	pop    %ebx
     a94:	5e                   	pop    %esi
     a95:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     a96:	e9 91 22 00 00       	jmp    2d2c <wait>
     a9b:	90                   	nop
     a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0) {
      printf(1, "couldn't allocate mem?!!\n");
     aa0:	c7 44 24 04 c2 34 00 	movl   $0x34c2,0x4(%esp)
     aa7:	00 
     aa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     aaf:	e8 bc 23 00 00       	call   2e70 <printf>
      exit();
     ab4:	e8 6b 22 00 00       	call   2d24 <exit>
     ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ac0 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	57                   	push   %edi
     ac4:	56                   	push   %esi
     ac5:	53                   	push   %ebx
     ac6:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
     ac9:	c7 04 24 e4 34 00 00 	movl   $0x34e4,(%esp)
     ad0:	e8 9f 22 00 00       	call   2d74 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     ad5:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     adc:	00 
     add:	c7 04 24 e4 34 00 00 	movl   $0x34e4,(%esp)
     ae4:	e8 7b 22 00 00       	call   2d64 <open>
  if(fd < 0){
     ae9:	85 c0                	test   %eax,%eax
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
     aeb:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     aed:	0f 88 4d 01 00 00    	js     c40 <sharedfd+0x180>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     af3:	e8 24 22 00 00       	call   2d1c <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     af8:	8d 75 de             	lea    -0x22(%ebp),%esi
     afb:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     b00:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     b07:	00 
     b08:	89 34 24             	mov    %esi,(%esp)
     b0b:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     b0e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     b11:	19 c0                	sbb    %eax,%eax
     b13:	83 e0 f3             	and    $0xfffffff3,%eax
     b16:	83 c0 70             	add    $0x70,%eax
     b19:	89 44 24 04          	mov    %eax,0x4(%esp)
     b1d:	e8 5e 20 00 00       	call   2b80 <memset>
     b22:	eb 09                	jmp    b2d <sharedfd+0x6d>
     b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     b28:	83 eb 01             	sub    $0x1,%ebx
     b2b:	74 2d                	je     b5a <sharedfd+0x9a>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     b2d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     b34:	00 
     b35:	89 74 24 04          	mov    %esi,0x4(%esp)
     b39:	89 3c 24             	mov    %edi,(%esp)
     b3c:	e8 03 22 00 00       	call   2d44 <write>
     b41:	83 f8 0a             	cmp    $0xa,%eax
     b44:	74 e2                	je     b28 <sharedfd+0x68>
      printf(1, "fstests: write sharedfd failed\n");
     b46:	c7 44 24 04 5c 3f 00 	movl   $0x3f5c,0x4(%esp)
     b4d:	00 
     b4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b55:	e8 16 23 00 00       	call   2e70 <printf>
      break;
    }
  }
  if(pid == 0)
     b5a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b5d:	85 c0                	test   %eax,%eax
     b5f:	0f 84 0d 01 00 00    	je     c72 <sharedfd+0x1b2>
    exit();
  else
    wait();
     b65:	e8 c2 21 00 00       	call   2d2c <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
     b6a:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
     b6c:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
     b6f:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
     b71:	e8 d6 21 00 00       	call   2d4c <close>
  fd = open("sharedfd", 0);
     b76:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b7d:	00 
     b7e:	c7 04 24 e4 34 00 00 	movl   $0x34e4,(%esp)
     b85:	e8 da 21 00 00       	call   2d64 <open>
  if(fd < 0){
     b8a:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
     b8c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
     b8f:	0f 88 c7 00 00 00    	js     c5c <sharedfd+0x19c>
     b95:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     b98:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b9b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     ba2:	00 
     ba3:	89 74 24 04          	mov    %esi,0x4(%esp)
     ba7:	89 04 24             	mov    %eax,(%esp)
     baa:	e8 8d 21 00 00       	call   2d3c <read>
     baf:	85 c0                	test   %eax,%eax
     bb1:	7e 26                	jle    bd9 <sharedfd+0x119>
     bb3:	31 c0                	xor    %eax,%eax
     bb5:	eb 14                	jmp    bcb <sharedfd+0x10b>
     bb7:	90                   	nop
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
     bb8:	80 fa 70             	cmp    $0x70,%dl
     bbb:	0f 94 c2             	sete   %dl
     bbe:	0f b6 d2             	movzbl %dl,%edx
     bc1:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     bc3:	83 c0 01             	add    $0x1,%eax
     bc6:	83 f8 0a             	cmp    $0xa,%eax
     bc9:	74 cd                	je     b98 <sharedfd+0xd8>
      if(buf[i] == 'c')
     bcb:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
     bcf:	80 fa 63             	cmp    $0x63,%dl
     bd2:	75 e4                	jne    bb8 <sharedfd+0xf8>
        nc++;
     bd4:	83 c7 01             	add    $0x1,%edi
     bd7:	eb ea                	jmp    bc3 <sharedfd+0x103>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     bd9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bdc:	89 04 24             	mov    %eax,(%esp)
     bdf:	e8 68 21 00 00       	call   2d4c <close>
  unlink("sharedfd");
     be4:	c7 04 24 e4 34 00 00 	movl   $0x34e4,(%esp)
     beb:	e8 84 21 00 00       	call   2d74 <unlink>
  if(nc == 10000 && np == 10000)
     bf0:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     bf6:	74 24                	je     c1c <sharedfd+0x15c>
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
     bf8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     bfc:	89 7c 24 08          	mov    %edi,0x8(%esp)
     c00:	c7 44 24 04 fa 34 00 	movl   $0x34fa,0x4(%esp)
     c07:	00 
     c08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c0f:	e8 5c 22 00 00       	call   2e70 <printf>
}
     c14:	83 c4 3c             	add    $0x3c,%esp
     c17:	5b                   	pop    %ebx
     c18:	5e                   	pop    %esi
     c19:	5f                   	pop    %edi
     c1a:	5d                   	pop    %ebp
     c1b:	c3                   	ret    
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
     c1c:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     c22:	75 d4                	jne    bf8 <sharedfd+0x138>
    printf(1, "sharedfd ok\n");
     c24:	c7 44 24 04 ed 34 00 	movl   $0x34ed,0x4(%esp)
     c2b:	00 
     c2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c33:	e8 38 22 00 00       	call   2e70 <printf>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
     c38:	83 c4 3c             	add    $0x3c,%esp
     c3b:	5b                   	pop    %ebx
     c3c:	5e                   	pop    %esi
     c3d:	5f                   	pop    %edi
     c3e:	5d                   	pop    %ebp
     c3f:	c3                   	ret    
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     c40:	c7 44 24 04 30 3f 00 	movl   $0x3f30,0x4(%esp)
     c47:	00 
     c48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c4f:	e8 1c 22 00 00       	call   2e70 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
     c54:	83 c4 3c             	add    $0x3c,%esp
     c57:	5b                   	pop    %ebx
     c58:	5e                   	pop    %esi
     c59:	5f                   	pop    %edi
     c5a:	5d                   	pop    %ebp
     c5b:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c5c:	c7 44 24 04 7c 3f 00 	movl   $0x3f7c,0x4(%esp)
     c63:	00 
     c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c6b:	e8 00 22 00 00       	call   2e70 <printf>
    return;
     c70:	eb a2                	jmp    c14 <sharedfd+0x154>
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
     c72:	e8 ad 20 00 00       	call   2d24 <exit>
     c77:	89 f6                	mov    %esi,%esi
     c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c80 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	57                   	push   %edi
     c84:	56                   	push   %esi
     c85:	53                   	push   %ebx
     c86:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     c89:	c7 44 24 04 0f 35 00 	movl   $0x350f,0x4(%esp)
     c90:	00 
     c91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c98:	e8 d3 21 00 00       	call   2e70 <printf>

  unlink("f1");
     c9d:	c7 04 24 5f 36 00 00 	movl   $0x365f,(%esp)
     ca4:	e8 cb 20 00 00       	call   2d74 <unlink>
  unlink("f2");
     ca9:	c7 04 24 63 36 00 00 	movl   $0x3663,(%esp)
     cb0:	e8 bf 20 00 00       	call   2d74 <unlink>

  pid = fork();
     cb5:	e8 62 20 00 00       	call   2d1c <fork>
  if(pid < 0){
     cba:	83 f8 00             	cmp    $0x0,%eax
  printf(1, "twofiles test\n");

  unlink("f1");
  unlink("f2");

  pid = fork();
     cbd:	89 c7                	mov    %eax,%edi
  if(pid < 0){
     cbf:	0f 8c 70 01 00 00    	jl     e35 <twofiles+0x1b5>
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
     cc5:	ba 63 36 00 00       	mov    $0x3663,%edx
     cca:	b8 5f 36 00 00       	mov    $0x365f,%eax
     ccf:	0f 44 c2             	cmove  %edx,%eax
  fd = open(fname, O_CREATE | O_RDWR);
     cd2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     cd9:	00 
     cda:	89 04 24             	mov    %eax,(%esp)
     cdd:	e8 82 20 00 00       	call   2d64 <open>
  if(fd < 0){
     ce2:	85 c0                	test   %eax,%eax
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
     ce4:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     ce6:	0f 88 99 01 00 00    	js     e85 <twofiles+0x205>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
     cec:	83 ff 01             	cmp    $0x1,%edi
     cef:	bb 0c 00 00 00       	mov    $0xc,%ebx
     cf4:	19 c0                	sbb    %eax,%eax
     cf6:	83 e0 f3             	and    $0xfffffff3,%eax
     cf9:	83 c0 70             	add    $0x70,%eax
     cfc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     d03:	00 
     d04:	89 44 24 04          	mov    %eax,0x4(%esp)
     d08:	c7 04 24 40 44 00 00 	movl   $0x4440,(%esp)
     d0f:	e8 6c 1e 00 00       	call   2b80 <memset>
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
     d18:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
     d1f:	00 
     d20:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     d27:	00 
     d28:	89 34 24             	mov    %esi,(%esp)
     d2b:	e8 14 20 00 00       	call   2d44 <write>
     d30:	3d f4 01 00 00       	cmp    $0x1f4,%eax
     d35:	0f 85 2d 01 00 00    	jne    e68 <twofiles+0x1e8>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
     d3b:	83 eb 01             	sub    $0x1,%ebx
     d3e:	75 d8                	jne    d18 <twofiles+0x98>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
     d40:	89 34 24             	mov    %esi,(%esp)
     d43:	e8 04 20 00 00       	call   2d4c <close>
  if(pid)
     d48:	85 ff                	test   %edi,%edi
     d4a:	0f 84 e0 00 00 00    	je     e30 <twofiles+0x1b0>
    wait();
     d50:	e8 d7 1f 00 00       	call   2d2c <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     d55:	31 db                	xor    %ebx,%ebx
    fd = open(i?"f1":"f2", 0);
     d57:	b8 63 36 00 00       	mov    $0x3663,%eax
     d5c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d63:	00 
    total = 0;
     d64:	31 f6                	xor    %esi,%esi
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
     d66:	89 04 24             	mov    %eax,(%esp)
     d69:	e8 f6 1f 00 00       	call   2d64 <open>
     d6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     d78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d7b:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     d82:	00 
     d83:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     d8a:	00 
     d8b:	89 04 24             	mov    %eax,(%esp)
     d8e:	e8 a9 1f 00 00       	call   2d3c <read>
     d93:	85 c0                	test   %eax,%eax
     d95:	7e 2a                	jle    dc1 <twofiles+0x141>
     d97:	31 c9                	xor    %ecx,%ecx
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
     da0:	83 fb 01             	cmp    $0x1,%ebx
     da3:	0f be b9 40 44 00 00 	movsbl 0x4440(%ecx),%edi
     daa:	19 d2                	sbb    %edx,%edx
     dac:	83 e2 f3             	and    $0xfffffff3,%edx
     daf:	83 c2 70             	add    $0x70,%edx
     db2:	39 d7                	cmp    %edx,%edi
     db4:	75 66                	jne    e1c <twofiles+0x19c>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     db6:	83 c1 01             	add    $0x1,%ecx
     db9:	39 c8                	cmp    %ecx,%eax
     dbb:	7f e3                	jg     da0 <twofiles+0x120>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     dbd:	01 c6                	add    %eax,%esi
     dbf:	eb b7                	jmp    d78 <twofiles+0xf8>
    }
    close(fd);
     dc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dc4:	89 04 24             	mov    %eax,(%esp)
     dc7:	e8 80 1f 00 00       	call   2d4c <close>
    if(total != 12*500){
     dcc:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
     dd2:	75 77                	jne    e4b <twofiles+0x1cb>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
     dd4:	83 fb 01             	cmp    $0x1,%ebx
     dd7:	75 34                	jne    e0d <twofiles+0x18d>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
     dd9:	c7 04 24 5f 36 00 00 	movl   $0x365f,(%esp)
     de0:	e8 8f 1f 00 00       	call   2d74 <unlink>
  unlink("f2");
     de5:	c7 04 24 63 36 00 00 	movl   $0x3663,(%esp)
     dec:	e8 83 1f 00 00       	call   2d74 <unlink>

  printf(1, "twofiles ok\n");
     df1:	c7 44 24 04 4c 35 00 	movl   $0x354c,0x4(%esp)
     df8:	00 
     df9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e00:	e8 6b 20 00 00       	call   2e70 <printf>
}
     e05:	83 c4 2c             	add    $0x2c,%esp
     e08:	5b                   	pop    %ebx
     e09:	5e                   	pop    %esi
     e0a:	5f                   	pop    %edi
     e0b:	5d                   	pop    %ebp
     e0c:	c3                   	ret    
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
     e0d:	bb 01 00 00 00       	mov    $0x1,%ebx
     e12:	b8 5f 36 00 00       	mov    $0x365f,%eax
     e17:	e9 40 ff ff ff       	jmp    d5c <twofiles+0xdc>
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
     e1c:	c7 44 24 04 2f 35 00 	movl   $0x352f,0x4(%esp)
     e23:	00 
     e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e2b:	e8 40 20 00 00       	call   2e70 <printf>
          exit();
     e30:	e8 ef 1e 00 00       	call   2d24 <exit>
  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
     e35:	c7 44 24 04 98 34 00 	movl   $0x3498,0x4(%esp)
     e3c:	00 
     e3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e44:	e8 27 20 00 00       	call   2e70 <printf>
    return;
     e49:	eb ba                	jmp    e05 <twofiles+0x185>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
     e4b:	89 74 24 08          	mov    %esi,0x8(%esp)
     e4f:	c7 44 24 04 3b 35 00 	movl   $0x353b,0x4(%esp)
     e56:	00 
     e57:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e5e:	e8 0d 20 00 00       	call   2e70 <printf>
      exit();
     e63:	e8 bc 1e 00 00       	call   2d24 <exit>
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
     e68:	89 44 24 08          	mov    %eax,0x8(%esp)
     e6c:	c7 44 24 04 1e 35 00 	movl   $0x351e,0x4(%esp)
     e73:	00 
     e74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e7b:	e8 f0 1f 00 00       	call   2e70 <printf>
      exit();
     e80:	e8 9f 1e 00 00       	call   2d24 <exit>
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create failed\n");
     e85:	c7 44 24 04 93 37 00 	movl   $0x3793,0x4(%esp)
     e8c:	00 
     e8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e94:	e8 d7 1f 00 00       	call   2e70 <printf>
    exit();
     e99:	e8 86 1e 00 00       	call   2d24 <exit>
     e9e:	66 90                	xchg   %ax,%ax

00000ea0 <createdelete>:
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     ea9:	c7 44 24 04 59 35 00 	movl   $0x3559,0x4(%esp)
     eb0:	00 
     eb1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     eb8:	e8 b3 1f 00 00       	call   2e70 <printf>
  pid = fork();
     ebd:	e8 5a 1e 00 00       	call   2d1c <fork>
  if(pid < 0){
     ec2:	85 c0                	test   %eax,%eax
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
     ec4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(pid < 0){
     ec7:	0f 88 12 02 00 00    	js     10df <createdelete+0x23f>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     ecd:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
  name[2] = '\0';
     ed1:	bf 01 00 00 00       	mov    $0x1,%edi
     ed6:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
     eda:	8d 75 c8             	lea    -0x38(%ebp),%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     edd:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
     edf:	31 db                	xor    %ebx,%ebx
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     ee1:	83 e0 f3             	and    $0xfffffff3,%eax
     ee4:	83 c0 70             	add    $0x70,%eax
     ee7:	88 45 c8             	mov    %al,-0x38(%ebp)
     eea:	eb 0f                	jmp    efb <createdelete+0x5b>
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  name[2] = '\0';
  for(i = 0; i < N; i++){
     ef0:	83 ff 13             	cmp    $0x13,%edi
     ef3:	7f 6b                	jg     f60 <createdelete+0xc0>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
     ef5:	83 c3 01             	add    $0x1,%ebx
     ef8:	83 c7 01             	add    $0x1,%edi
  printf(1, "twofiles ok\n");
}

// two processes create and delete different files in same directory
void
createdelete(void)
     efb:	8d 43 30             	lea    0x30(%ebx),%eax
     efe:	88 45 c9             	mov    %al,-0x37(%ebp)

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
     f01:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     f08:	00 
     f09:	89 34 24             	mov    %esi,(%esp)
     f0c:	e8 53 1e 00 00       	call   2d64 <open>
    if(fd < 0){
     f11:	85 c0                	test   %eax,%eax
     f13:	0f 88 3e 01 00 00    	js     1057 <createdelete+0x1b7>
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
     f19:	89 04 24             	mov    %eax,(%esp)
     f1c:	e8 2b 1e 00 00       	call   2d4c <close>
    if(i > 0 && (i % 2 ) == 0){
     f21:	85 db                	test   %ebx,%ebx
     f23:	74 d0                	je     ef5 <createdelete+0x55>
     f25:	f6 c3 01             	test   $0x1,%bl
     f28:	75 c6                	jne    ef0 <createdelete+0x50>
      name[1] = '0' + (i / 2);
     f2a:	89 d8                	mov    %ebx,%eax
     f2c:	d1 f8                	sar    %eax
     f2e:	83 c0 30             	add    $0x30,%eax
     f31:	88 45 c9             	mov    %al,-0x37(%ebp)
      if(unlink(name) < 0){
     f34:	89 34 24             	mov    %esi,(%esp)
     f37:	e8 38 1e 00 00       	call   2d74 <unlink>
     f3c:	85 c0                	test   %eax,%eax
     f3e:	79 b0                	jns    ef0 <createdelete+0x50>
        printf(1, "unlink failed\n");
     f40:	c7 44 24 04 6c 35 00 	movl   $0x356c,0x4(%esp)
     f47:	00 
     f48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f4f:	e8 1c 1f 00 00       	call   2e70 <printf>
        exit();
     f54:	e8 cb 1d 00 00       	call   2d24 <exit>
     f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }
  }

  if(pid==0)
     f60:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     f63:	85 d2                	test   %edx,%edx
     f65:	0f 84 6f 01 00 00    	je     10da <createdelete+0x23a>
    exit();
  else
    wait();
     f6b:	e8 bc 1d 00 00       	call   2d2c <wait>

  for(i = 0; i < N; i++){
     f70:	31 db                	xor    %ebx,%ebx
     f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  printf(1, "twofiles ok\n");
}

// two processes create and delete different files in same directory
void
createdelete(void)
     f78:	8d 7b 30             	lea    0x30(%ebx),%edi
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
     f7b:	89 f8                	mov    %edi,%eax
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
     f7d:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
     f81:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
     f84:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     f8b:	00 
     f8c:	89 34 24             	mov    %esi,(%esp)
     f8f:	e8 d0 1d 00 00       	call   2d64 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     f94:	83 fb 09             	cmp    $0x9,%ebx
     f97:	0f 9f c1             	setg   %cl
     f9a:	85 db                	test   %ebx,%ebx
     f9c:	0f 94 c2             	sete   %dl
     f9f:	08 d1                	or     %dl,%cl
     fa1:	88 4d c3             	mov    %cl,-0x3d(%ebp)
     fa4:	74 08                	je     fae <createdelete+0x10e>
     fa6:	85 c0                	test   %eax,%eax
     fa8:	0f 88 14 01 00 00    	js     10c2 <createdelete+0x222>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
     fae:	8d 53 ff             	lea    -0x1(%ebx),%edx
     fb1:	83 fa 08             	cmp    $0x8,%edx
     fb4:	89 c2                	mov    %eax,%edx
     fb6:	f7 d2                	not    %edx
     fb8:	0f 96 45 c4          	setbe  -0x3c(%ebp)
     fbc:	c1 ea 1f             	shr    $0x1f,%edx
     fbf:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
     fc3:	0f 85 b7 00 00 00    	jne    1080 <createdelete+0x1e0>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
     fc9:	84 d2                	test   %dl,%dl
     fcb:	74 08                	je     fd5 <createdelete+0x135>
      close(fd);
     fcd:	89 04 24             	mov    %eax,(%esp)
     fd0:	e8 77 1d 00 00       	call   2d4c <close>

    name[0] = 'c';
    name[1] = '0' + i;
     fd5:	89 f8                	mov    %edi,%eax
      exit();
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
     fd7:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    name[1] = '0' + i;
     fdb:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
     fde:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     fe5:	00 
     fe6:	89 34 24             	mov    %esi,(%esp)
     fe9:	e8 76 1d 00 00       	call   2d64 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     fee:	80 7d c3 00          	cmpb   $0x0,-0x3d(%ebp)
     ff2:	74 08                	je     ffc <createdelete+0x15c>
     ff4:	85 c0                	test   %eax,%eax
     ff6:	0f 88 a9 00 00 00    	js     10a5 <createdelete+0x205>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
     ffc:	85 c0                	test   %eax,%eax
     ffe:	66 90                	xchg   %ax,%ax
    1000:	79 6e                	jns    1070 <createdelete+0x1d0>
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    1002:	83 c3 01             	add    $0x1,%ebx
    1005:	83 fb 14             	cmp    $0x14,%ebx
    1008:	0f 85 6a ff ff ff    	jne    f78 <createdelete+0xd8>
    100e:	bb 30 00 00 00       	mov    $0x30,%ebx
    1013:	90                   	nop
    1014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    1018:	88 5d c9             	mov    %bl,-0x37(%ebp)
    unlink(name);
    name[0] = 'c';
    unlink(name);
    101b:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    101e:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    unlink(name);
    1022:	89 34 24             	mov    %esi,(%esp)
    1025:	e8 4a 1d 00 00       	call   2d74 <unlink>
    name[0] = 'c';
    102a:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    unlink(name);
    102e:	89 34 24             	mov    %esi,(%esp)
    1031:	e8 3e 1d 00 00       	call   2d74 <unlink>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1036:	80 fb 44             	cmp    $0x44,%bl
    1039:	75 dd                	jne    1018 <createdelete+0x178>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    103b:	c7 44 24 04 7b 35 00 	movl   $0x357b,0x4(%esp)
    1042:	00 
    1043:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104a:	e8 21 1e 00 00       	call   2e70 <printf>
}
    104f:	83 c4 4c             	add    $0x4c,%esp
    1052:	5b                   	pop    %ebx
    1053:	5e                   	pop    %esi
    1054:	5f                   	pop    %edi
    1055:	5d                   	pop    %ebp
    1056:	c3                   	ret    
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "create failed\n");
    1057:	c7 44 24 04 93 37 00 	movl   $0x3793,0x4(%esp)
    105e:	00 
    105f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1066:	e8 05 1e 00 00       	call   2e70 <printf>
      exit();
    106b:	e8 b4 1c 00 00       	call   2d24 <exit>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1070:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
    1074:	75 12                	jne    1088 <createdelete+0x1e8>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
      close(fd);
    1076:	89 04 24             	mov    %eax,(%esp)
    1079:	e8 ce 1c 00 00       	call   2d4c <close>
    107e:	eb 82                	jmp    1002 <createdelete+0x162>
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1080:	84 d2                	test   %dl,%dl
    1082:	0f 84 4d ff ff ff    	je     fd5 <createdelete+0x135>
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf(1, "oops createdelete %s did exist\n", name);
    1088:	89 74 24 08          	mov    %esi,0x8(%esp)
    108c:	c7 44 24 04 cc 3f 00 	movl   $0x3fcc,0x4(%esp)
    1093:	00 
    1094:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109b:	e8 d0 1d 00 00       	call   2e70 <printf>
      exit();
    10a0:	e8 7f 1c 00 00       	call   2d24 <exit>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    10a5:	89 74 24 08          	mov    %esi,0x8(%esp)
    10a9:	c7 44 24 04 a8 3f 00 	movl   $0x3fa8,0x4(%esp)
    10b0:	00 
    10b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b8:	e8 b3 1d 00 00       	call   2e70 <printf>
      exit();
    10bd:	e8 62 1c 00 00       	call   2d24 <exit>
  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
    10c2:	89 74 24 08          	mov    %esi,0x8(%esp)
    10c6:	c7 44 24 04 a8 3f 00 	movl   $0x3fa8,0x4(%esp)
    10cd:	00 
    10ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d5:	e8 96 1d 00 00       	call   2e70 <printf>
      exit();
    10da:	e8 45 1c 00 00       	call   2d24 <exit>
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    10df:	c7 44 24 04 98 34 00 	movl   $0x3498,0x4(%esp)
    10e6:	00 
    10e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ee:	e8 7d 1d 00 00       	call   2e70 <printf>
    exit();
    10f3:	e8 2c 1c 00 00       	call   2d24 <exit>
    10f8:	90                   	nop
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001100 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	56                   	push   %esi
    1104:	53                   	push   %ebx
    1105:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1108:	c7 44 24 04 8c 35 00 	movl   $0x358c,0x4(%esp)
    110f:	00 
    1110:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1117:	e8 54 1d 00 00       	call   2e70 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    111c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1123:	00 
    1124:	c7 04 24 9d 35 00 00 	movl   $0x359d,(%esp)
    112b:	e8 34 1c 00 00       	call   2d64 <open>
  if(fd < 0){
    1130:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1132:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1134:	0f 88 fe 00 00 00    	js     1238 <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    113a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1141:	00 
    1142:	c7 44 24 04 c2 35 00 	movl   $0x35c2,0x4(%esp)
    1149:	00 
    114a:	89 04 24             	mov    %eax,(%esp)
    114d:	e8 f2 1b 00 00       	call   2d44 <write>
  close(fd);
    1152:	89 1c 24             	mov    %ebx,(%esp)
    1155:	e8 f2 1b 00 00       	call   2d4c <close>

  fd = open("unlinkread", O_RDWR);
    115a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1161:	00 
    1162:	c7 04 24 9d 35 00 00 	movl   $0x359d,(%esp)
    1169:	e8 f6 1b 00 00       	call   2d64 <open>
  if(fd < 0){
    116e:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1170:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1172:	0f 88 3d 01 00 00    	js     12b5 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1178:	c7 04 24 9d 35 00 00 	movl   $0x359d,(%esp)
    117f:	e8 f0 1b 00 00       	call   2d74 <unlink>
    1184:	85 c0                	test   %eax,%eax
    1186:	0f 85 10 01 00 00    	jne    129c <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    118c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1193:	00 
    1194:	c7 04 24 9d 35 00 00 	movl   $0x359d,(%esp)
    119b:	e8 c4 1b 00 00       	call   2d64 <open>
  write(fd1, "yyy", 3);
    11a0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    11a7:	00 
    11a8:	c7 44 24 04 fa 35 00 	movl   $0x35fa,0x4(%esp)
    11af:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    11b0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    11b2:	89 04 24             	mov    %eax,(%esp)
    11b5:	e8 8a 1b 00 00       	call   2d44 <write>
  close(fd1);
    11ba:	89 34 24             	mov    %esi,(%esp)
    11bd:	e8 8a 1b 00 00       	call   2d4c <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    11c2:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    11c9:	00 
    11ca:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    11d1:	00 
    11d2:	89 1c 24             	mov    %ebx,(%esp)
    11d5:	e8 62 1b 00 00       	call   2d3c <read>
    11da:	83 f8 05             	cmp    $0x5,%eax
    11dd:	0f 85 a0 00 00 00    	jne    1283 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    11e3:	80 3d 40 44 00 00 68 	cmpb   $0x68,0x4440
    11ea:	75 7e                	jne    126a <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    11ec:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    11f3:	00 
    11f4:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    11fb:	00 
    11fc:	89 1c 24             	mov    %ebx,(%esp)
    11ff:	e8 40 1b 00 00       	call   2d44 <write>
    1204:	83 f8 0a             	cmp    $0xa,%eax
    1207:	75 48                	jne    1251 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1209:	89 1c 24             	mov    %ebx,(%esp)
    120c:	e8 3b 1b 00 00       	call   2d4c <close>
  unlink("unlinkread");
    1211:	c7 04 24 9d 35 00 00 	movl   $0x359d,(%esp)
    1218:	e8 57 1b 00 00       	call   2d74 <unlink>
  printf(1, "unlinkread ok\n");
    121d:	c7 44 24 04 45 36 00 	movl   $0x3645,0x4(%esp)
    1224:	00 
    1225:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    122c:	e8 3f 1c 00 00       	call   2e70 <printf>
}
    1231:	83 c4 10             	add    $0x10,%esp
    1234:	5b                   	pop    %ebx
    1235:	5e                   	pop    %esi
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1238:	c7 44 24 04 a8 35 00 	movl   $0x35a8,0x4(%esp)
    123f:	00 
    1240:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1247:	e8 24 1c 00 00       	call   2e70 <printf>
    exit();
    124c:	e8 d3 1a 00 00       	call   2d24 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1251:	c7 44 24 04 2c 36 00 	movl   $0x362c,0x4(%esp)
    1258:	00 
    1259:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1260:	e8 0b 1c 00 00       	call   2e70 <printf>
    exit();
    1265:	e8 ba 1a 00 00       	call   2d24 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    126a:	c7 44 24 04 15 36 00 	movl   $0x3615,0x4(%esp)
    1271:	00 
    1272:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1279:	e8 f2 1b 00 00       	call   2e70 <printf>
    exit();
    127e:	e8 a1 1a 00 00       	call   2d24 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1283:	c7 44 24 04 fe 35 00 	movl   $0x35fe,0x4(%esp)
    128a:	00 
    128b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1292:	e8 d9 1b 00 00       	call   2e70 <printf>
    exit();
    1297:	e8 88 1a 00 00       	call   2d24 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    129c:	c7 44 24 04 e0 35 00 	movl   $0x35e0,0x4(%esp)
    12a3:	00 
    12a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12ab:	e8 c0 1b 00 00       	call   2e70 <printf>
    exit();
    12b0:	e8 6f 1a 00 00       	call   2d24 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    12b5:	c7 44 24 04 c8 35 00 	movl   $0x35c8,0x4(%esp)
    12bc:	00 
    12bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12c4:	e8 a7 1b 00 00       	call   2e70 <printf>
    exit();
    12c9:	e8 56 1a 00 00       	call   2d24 <exit>
    12ce:	66 90                	xchg   %ax,%ax

000012d0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	53                   	push   %ebx
    12d4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    12d7:	c7 44 24 04 54 36 00 	movl   $0x3654,0x4(%esp)
    12de:	00 
    12df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12e6:	e8 85 1b 00 00       	call   2e70 <printf>

  unlink("lf1");
    12eb:	c7 04 24 5e 36 00 00 	movl   $0x365e,(%esp)
    12f2:	e8 7d 1a 00 00       	call   2d74 <unlink>
  unlink("lf2");
    12f7:	c7 04 24 62 36 00 00 	movl   $0x3662,(%esp)
    12fe:	e8 71 1a 00 00       	call   2d74 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1303:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    130a:	00 
    130b:	c7 04 24 5e 36 00 00 	movl   $0x365e,(%esp)
    1312:	e8 4d 1a 00 00       	call   2d64 <open>
  if(fd < 0){
    1317:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    1319:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    131b:	0f 88 26 01 00 00    	js     1447 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1321:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1328:	00 
    1329:	c7 44 24 04 c2 35 00 	movl   $0x35c2,0x4(%esp)
    1330:	00 
    1331:	89 04 24             	mov    %eax,(%esp)
    1334:	e8 0b 1a 00 00       	call   2d44 <write>
    1339:	83 f8 05             	cmp    $0x5,%eax
    133c:	0f 85 cd 01 00 00    	jne    150f <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1342:	89 1c 24             	mov    %ebx,(%esp)
    1345:	e8 02 1a 00 00       	call   2d4c <close>

  if(link("lf1", "lf2") < 0){
    134a:	c7 44 24 04 62 36 00 	movl   $0x3662,0x4(%esp)
    1351:	00 
    1352:	c7 04 24 5e 36 00 00 	movl   $0x365e,(%esp)
    1359:	e8 26 1a 00 00       	call   2d84 <link>
    135e:	85 c0                	test   %eax,%eax
    1360:	0f 88 90 01 00 00    	js     14f6 <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1366:	c7 04 24 5e 36 00 00 	movl   $0x365e,(%esp)
    136d:	e8 02 1a 00 00       	call   2d74 <unlink>

  if(open("lf1", 0) >= 0){
    1372:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1379:	00 
    137a:	c7 04 24 5e 36 00 00 	movl   $0x365e,(%esp)
    1381:	e8 de 19 00 00       	call   2d64 <open>
    1386:	85 c0                	test   %eax,%eax
    1388:	0f 89 4f 01 00 00    	jns    14dd <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    138e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1395:	00 
    1396:	c7 04 24 62 36 00 00 	movl   $0x3662,(%esp)
    139d:	e8 c2 19 00 00       	call   2d64 <open>
  if(fd < 0){
    13a2:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    13a4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    13a6:	0f 88 18 01 00 00    	js     14c4 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    13ac:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    13b3:	00 
    13b4:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    13bb:	00 
    13bc:	89 04 24             	mov    %eax,(%esp)
    13bf:	e8 78 19 00 00       	call   2d3c <read>
    13c4:	83 f8 05             	cmp    $0x5,%eax
    13c7:	0f 85 de 00 00 00    	jne    14ab <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    13cd:	89 1c 24             	mov    %ebx,(%esp)
    13d0:	e8 77 19 00 00       	call   2d4c <close>

  if(link("lf2", "lf2") >= 0){
    13d5:	c7 44 24 04 62 36 00 	movl   $0x3662,0x4(%esp)
    13dc:	00 
    13dd:	c7 04 24 62 36 00 00 	movl   $0x3662,(%esp)
    13e4:	e8 9b 19 00 00       	call   2d84 <link>
    13e9:	85 c0                	test   %eax,%eax
    13eb:	0f 89 a1 00 00 00    	jns    1492 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    13f1:	c7 04 24 62 36 00 00 	movl   $0x3662,(%esp)
    13f8:	e8 77 19 00 00       	call   2d74 <unlink>
  if(link("lf2", "lf1") >= 0){
    13fd:	c7 44 24 04 5e 36 00 	movl   $0x365e,0x4(%esp)
    1404:	00 
    1405:	c7 04 24 62 36 00 00 	movl   $0x3662,(%esp)
    140c:	e8 73 19 00 00       	call   2d84 <link>
    1411:	85 c0                	test   %eax,%eax
    1413:	79 64                	jns    1479 <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1415:	c7 44 24 04 5e 36 00 	movl   $0x365e,0x4(%esp)
    141c:	00 
    141d:	c7 04 24 02 39 00 00 	movl   $0x3902,(%esp)
    1424:	e8 5b 19 00 00       	call   2d84 <link>
    1429:	85 c0                	test   %eax,%eax
    142b:	79 33                	jns    1460 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    142d:	c7 44 24 04 fc 36 00 	movl   $0x36fc,0x4(%esp)
    1434:	00 
    1435:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    143c:	e8 2f 1a 00 00       	call   2e70 <printf>
}
    1441:	83 c4 14             	add    $0x14,%esp
    1444:	5b                   	pop    %ebx
    1445:	5d                   	pop    %ebp
    1446:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1447:	c7 44 24 04 66 36 00 	movl   $0x3666,0x4(%esp)
    144e:	00 
    144f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1456:	e8 15 1a 00 00       	call   2e70 <printf>
    exit();
    145b:	e8 c4 18 00 00       	call   2d24 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1460:	c7 44 24 04 e0 36 00 	movl   $0x36e0,0x4(%esp)
    1467:	00 
    1468:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    146f:	e8 fc 19 00 00       	call   2e70 <printf>
    exit();
    1474:	e8 ab 18 00 00       	call   2d24 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1479:	c7 44 24 04 14 40 00 	movl   $0x4014,0x4(%esp)
    1480:	00 
    1481:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1488:	e8 e3 19 00 00       	call   2e70 <printf>
    exit();
    148d:	e8 92 18 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1492:	c7 44 24 04 c2 36 00 	movl   $0x36c2,0x4(%esp)
    1499:	00 
    149a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14a1:	e8 ca 19 00 00       	call   2e70 <printf>
    exit();
    14a6:	e8 79 18 00 00       	call   2d24 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    14ab:	c7 44 24 04 b1 36 00 	movl   $0x36b1,0x4(%esp)
    14b2:	00 
    14b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ba:	e8 b1 19 00 00       	call   2e70 <printf>
    exit();
    14bf:	e8 60 18 00 00       	call   2d24 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    14c4:	c7 44 24 04 a0 36 00 	movl   $0x36a0,0x4(%esp)
    14cb:	00 
    14cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14d3:	e8 98 19 00 00       	call   2e70 <printf>
    exit();
    14d8:	e8 47 18 00 00       	call   2d24 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    14dd:	c7 44 24 04 ec 3f 00 	movl   $0x3fec,0x4(%esp)
    14e4:	00 
    14e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ec:	e8 7f 19 00 00       	call   2e70 <printf>
    exit();
    14f1:	e8 2e 18 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    14f6:	c7 44 24 04 8b 36 00 	movl   $0x368b,0x4(%esp)
    14fd:	00 
    14fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1505:	e8 66 19 00 00       	call   2e70 <printf>
    exit();
    150a:	e8 15 18 00 00       	call   2d24 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    150f:	c7 44 24 04 79 36 00 	movl   $0x3679,0x4(%esp)
    1516:	00 
    1517:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    151e:	e8 4d 19 00 00       	call   2e70 <printf>
    exit();
    1523:	e8 fc 17 00 00       	call   2d24 <exit>
    1528:	90                   	nop
    1529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001530 <concreate>:
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	56                   	push   %esi
    1535:	53                   	push   %ebx
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1536:	31 db                	xor    %ebx,%ebx
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    1538:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    153b:	c7 44 24 04 09 37 00 	movl   $0x3709,0x4(%esp)
    1542:	00 
    1543:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    1546:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154d:	e8 1e 19 00 00       	call   2e70 <printf>
  file[0] = 'C';
    1552:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1556:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    155a:	eb 4f                	jmp    15ab <concreate+0x7b>
    155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1560:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1565:	f7 eb                	imul   %ebx
    1567:	89 d8                	mov    %ebx,%eax
    1569:	c1 f8 1f             	sar    $0x1f,%eax
    156c:	29 c2                	sub    %eax,%edx
    156e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1571:	89 da                	mov    %ebx,%edx
    1573:	29 c2                	sub    %eax,%edx
    1575:	83 fa 01             	cmp    $0x1,%edx
    1578:	74 7e                	je     15f8 <concreate+0xc8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    157a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1581:	00 
    1582:	89 3c 24             	mov    %edi,(%esp)
    1585:	e8 da 17 00 00       	call   2d64 <open>
      if(fd < 0){
    158a:	85 c0                	test   %eax,%eax
    158c:	0f 88 db 01 00 00    	js     176d <concreate+0x23d>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1592:	89 04 24             	mov    %eax,(%esp)
    1595:	e8 b2 17 00 00       	call   2d4c <close>
    }
    if(pid == 0)
    159a:	85 f6                	test   %esi,%esi
    159c:	74 52                	je     15f0 <concreate+0xc0>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    159e:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    15a1:	e8 86 17 00 00       	call   2d2c <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    15a6:	83 fb 28             	cmp    $0x28,%ebx
    15a9:	74 6d                	je     1618 <concreate+0xe8>
  printf(1, "linktest ok\n");
}

// test concurrent create and unlink of the same file
void
concreate(void)
    15ab:	8d 43 30             	lea    0x30(%ebx),%eax
    15ae:	88 45 e6             	mov    %al,-0x1a(%ebp)
  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    15b1:	89 3c 24             	mov    %edi,(%esp)
    15b4:	e8 bb 17 00 00       	call   2d74 <unlink>
    pid = fork();
    15b9:	e8 5e 17 00 00       	call   2d1c <fork>
    if(pid && (i % 3) == 1){
    15be:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    15c0:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    15c2:	75 9c                	jne    1560 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    15c4:	b8 67 66 66 66       	mov    $0x66666667,%eax
    15c9:	f7 eb                	imul   %ebx
    15cb:	89 d8                	mov    %ebx,%eax
    15cd:	c1 f8 1f             	sar    $0x1f,%eax
    15d0:	d1 fa                	sar    %edx
    15d2:	29 c2                	sub    %eax,%edx
    15d4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    15d7:	89 da                	mov    %ebx,%edx
    15d9:	29 c2                	sub    %eax,%edx
    15db:	83 fa 01             	cmp    $0x1,%edx
    15de:	75 9a                	jne    157a <concreate+0x4a>
      link("C0", file);
    15e0:	89 7c 24 04          	mov    %edi,0x4(%esp)
    15e4:	c7 04 24 19 37 00 00 	movl   $0x3719,(%esp)
    15eb:	e8 94 17 00 00       	call   2d84 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    15f0:	e8 2f 17 00 00       	call   2d24 <exit>
    15f5:	8d 76 00             	lea    0x0(%esi),%esi
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    15f8:	83 c3 01             	add    $0x1,%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    15fb:	89 7c 24 04          	mov    %edi,0x4(%esp)
    15ff:	c7 04 24 19 37 00 00 	movl   $0x3719,(%esp)
    1606:	e8 79 17 00 00       	call   2d84 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    160b:	e8 1c 17 00 00       	call   2d2c <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1610:	83 fb 28             	cmp    $0x28,%ebx
    1613:	75 96                	jne    15ab <concreate+0x7b>
    1615:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1618:	8d 45 ac             	lea    -0x54(%ebp),%eax
    161b:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1622:	00 
    1623:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    1626:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    162d:	00 
    162e:	89 04 24             	mov    %eax,(%esp)
    1631:	e8 4a 15 00 00       	call   2b80 <memset>
  fd = open(".", 0);
    1636:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    163d:	00 
    163e:	c7 04 24 02 39 00 00 	movl   $0x3902,(%esp)
    1645:	e8 1a 17 00 00       	call   2d64 <open>
  n = 0;
    164a:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    1651:	89 c3                	mov    %eax,%ebx
    1653:	90                   	nop
    1654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1658:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    165f:	00 
    1660:	89 74 24 04          	mov    %esi,0x4(%esp)
    1664:	89 1c 24             	mov    %ebx,(%esp)
    1667:	e8 d0 16 00 00       	call   2d3c <read>
    166c:	85 c0                	test   %eax,%eax
    166e:	7e 40                	jle    16b0 <concreate+0x180>
    if(de.inum == 0)
    1670:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    1675:	74 e1                	je     1658 <concreate+0x128>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1677:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    167b:	75 db                	jne    1658 <concreate+0x128>
    167d:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    1681:	75 d5                	jne    1658 <concreate+0x128>
      i = de.name[1] - '0';
    1683:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    1687:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    168a:	83 f8 27             	cmp    $0x27,%eax
    168d:	0f 87 f7 00 00 00    	ja     178a <concreate+0x25a>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1693:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    1698:	0f 85 25 01 00 00    	jne    17c3 <concreate+0x293>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    169e:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    16a3:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    16a7:	eb af                	jmp    1658 <concreate+0x128>
    16a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    16b0:	89 1c 24             	mov    %ebx,(%esp)
    16b3:	e8 94 16 00 00       	call   2d4c <close>

  if(n != 40){
    16b8:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    16bc:	0f 85 e8 00 00 00    	jne    17aa <concreate+0x27a>
    16c2:	31 db                	xor    %ebx,%ebx
    16c4:	eb 33                	jmp    16f9 <concreate+0x1c9>
    16c6:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    16c8:	85 f6                	test   %esi,%esi
    16ca:	74 5e                	je     172a <concreate+0x1fa>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    16cc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    16d3:	00 
    16d4:	89 3c 24             	mov    %edi,(%esp)
    16d7:	e8 88 16 00 00       	call   2d64 <open>
      close(fd);
    16dc:	89 04 24             	mov    %eax,(%esp)
    16df:	e8 68 16 00 00       	call   2d4c <close>
    } else {
      unlink(file);
    }
    if(pid == 0)
    16e4:	85 f6                	test   %esi,%esi
    16e6:	0f 84 04 ff ff ff    	je     15f0 <concreate+0xc0>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    16ec:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    16ef:	e8 38 16 00 00       	call   2d2c <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    16f4:	83 fb 28             	cmp    $0x28,%ebx
    16f7:	74 3f                	je     1738 <concreate+0x208>
  printf(1, "linktest ok\n");
}

// test concurrent create and unlink of the same file
void
concreate(void)
    16f9:	8d 43 30             	lea    0x30(%ebx),%eax
    16fc:	88 45 e6             	mov    %al,-0x1a(%ebp)
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    16ff:	e8 18 16 00 00       	call   2d1c <fork>
    if(pid < 0){
    1704:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    1706:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    1708:	78 4a                	js     1754 <concreate+0x224>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    170a:	b8 56 55 55 55       	mov    $0x55555556,%eax
    170f:	f7 eb                	imul   %ebx
    1711:	89 d8                	mov    %ebx,%eax
    1713:	c1 f8 1f             	sar    $0x1f,%eax
    1716:	29 c2                	sub    %eax,%edx
    1718:	8d 04 52             	lea    (%edx,%edx,2),%eax
    171b:	89 da                	mov    %ebx,%edx
    171d:	29 c2                	sub    %eax,%edx
    171f:	89 d0                	mov    %edx,%eax
    1721:	09 f0                	or     %esi,%eax
    1723:	74 a7                	je     16cc <concreate+0x19c>
    1725:	83 fa 01             	cmp    $0x1,%edx
    1728:	74 9e                	je     16c8 <concreate+0x198>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    172a:	89 3c 24             	mov    %edi,(%esp)
    172d:	e8 42 16 00 00       	call   2d74 <unlink>
    1732:	eb b0                	jmp    16e4 <concreate+0x1b4>
    1734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1738:	c7 44 24 04 6e 37 00 	movl   $0x376e,0x4(%esp)
    173f:	00 
    1740:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1747:	e8 24 17 00 00       	call   2e70 <printf>
}
    174c:	83 c4 6c             	add    $0x6c,%esp
    174f:	5b                   	pop    %ebx
    1750:	5e                   	pop    %esi
    1751:	5f                   	pop    %edi
    1752:	5d                   	pop    %ebp
    1753:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1754:	c7 44 24 04 98 34 00 	movl   $0x3498,0x4(%esp)
    175b:	00 
    175c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1763:	e8 08 17 00 00       	call   2e70 <printf>
      exit();
    1768:	e8 b7 15 00 00       	call   2d24 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    176d:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1771:	c7 44 24 04 1c 37 00 	movl   $0x371c,0x4(%esp)
    1778:	00 
    1779:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1780:	e8 eb 16 00 00       	call   2e70 <printf>
        exit();
    1785:	e8 9a 15 00 00       	call   2d24 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    178a:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    178d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1791:	c7 44 24 04 38 37 00 	movl   $0x3738,0x4(%esp)
    1798:	00 
    1799:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a0:	e8 cb 16 00 00       	call   2e70 <printf>
    17a5:	e9 46 fe ff ff       	jmp    15f0 <concreate+0xc0>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    17aa:	c7 44 24 04 38 40 00 	movl   $0x4038,0x4(%esp)
    17b1:	00 
    17b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17b9:	e8 b2 16 00 00       	call   2e70 <printf>
    exit();
    17be:	e8 61 15 00 00       	call   2d24 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    17c3:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    17c6:	89 44 24 08          	mov    %eax,0x8(%esp)
    17ca:	c7 44 24 04 51 37 00 	movl   $0x3751,0x4(%esp)
    17d1:	00 
    17d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17d9:	e8 92 16 00 00       	call   2e70 <printf>
        exit();
    17de:	e8 41 15 00 00       	call   2d24 <exit>
    17e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    17e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000017f0 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	56                   	push   %esi
    17f4:	53                   	push   %ebx
    17f5:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    17f8:	c7 44 24 04 7c 37 00 	movl   $0x377c,0x4(%esp)
    17ff:	00 
    1800:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1807:	e8 64 16 00 00       	call   2e70 <printf>
  unlink("bd");
    180c:	c7 04 24 89 37 00 00 	movl   $0x3789,(%esp)
    1813:	e8 5c 15 00 00       	call   2d74 <unlink>

  fd = open("bd", O_CREATE);
    1818:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    181f:	00 
    1820:	c7 04 24 89 37 00 00 	movl   $0x3789,(%esp)
    1827:	e8 38 15 00 00       	call   2d64 <open>
  if(fd < 0){
    182c:	85 c0                	test   %eax,%eax
    182e:	0f 88 e6 00 00 00    	js     191a <bigdir+0x12a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1834:	89 04 24             	mov    %eax,(%esp)

  for(i = 0; i < 500; i++){
    1837:	31 db                	xor    %ebx,%ebx
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1839:	e8 0e 15 00 00       	call   2d4c <close>
    183e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1848:	89 d8                	mov    %ebx,%eax
    184a:	c1 f8 06             	sar    $0x6,%eax
    184d:	83 c0 30             	add    $0x30,%eax
    1850:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1853:	89 d8                	mov    %ebx,%eax
    1855:	83 e0 3f             	and    $0x3f,%eax
    1858:	83 c0 30             	add    $0x30,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    185b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    185f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1862:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1866:	89 74 24 04          	mov    %esi,0x4(%esp)
    186a:	c7 04 24 89 37 00 00 	movl   $0x3789,(%esp)
    1871:	e8 0e 15 00 00       	call   2d84 <link>
    1876:	85 c0                	test   %eax,%eax
    1878:	75 6e                	jne    18e8 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    187a:	83 c3 01             	add    $0x1,%ebx
    187d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1883:	75 c3                	jne    1848 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1885:	c7 04 24 89 37 00 00 	movl   $0x3789,(%esp)
  for(i = 0; i < 500; i++){
    188c:	66 31 db             	xor    %bx,%bx
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    188f:	e8 e0 14 00 00       	call   2d74 <unlink>
    1894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1898:	89 d8                	mov    %ebx,%eax
    189a:	c1 f8 06             	sar    $0x6,%eax
    189d:	83 c0 30             	add    $0x30,%eax
    18a0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    18a3:	89 d8                	mov    %ebx,%eax
    18a5:	83 e0 3f             	and    $0x3f,%eax
    18a8:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    18ab:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    18af:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    18b2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    18b6:	89 34 24             	mov    %esi,(%esp)
    18b9:	e8 b6 14 00 00       	call   2d74 <unlink>
    18be:	85 c0                	test   %eax,%eax
    18c0:	75 3f                	jne    1901 <bigdir+0x111>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    18c2:	83 c3 01             	add    $0x1,%ebx
    18c5:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    18cb:	75 cb                	jne    1898 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    18cd:	c7 44 24 04 cb 37 00 	movl   $0x37cb,0x4(%esp)
    18d4:	00 
    18d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18dc:	e8 8f 15 00 00       	call   2e70 <printf>
}
    18e1:	83 c4 20             	add    $0x20,%esp
    18e4:	5b                   	pop    %ebx
    18e5:	5e                   	pop    %esi
    18e6:	5d                   	pop    %ebp
    18e7:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    18e8:	c7 44 24 04 a2 37 00 	movl   $0x37a2,0x4(%esp)
    18ef:	00 
    18f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18f7:	e8 74 15 00 00       	call   2e70 <printf>
      exit();
    18fc:	e8 23 14 00 00       	call   2d24 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1901:	c7 44 24 04 b6 37 00 	movl   $0x37b6,0x4(%esp)
    1908:	00 
    1909:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1910:	e8 5b 15 00 00       	call   2e70 <printf>
      exit();
    1915:	e8 0a 14 00 00       	call   2d24 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    191a:	c7 44 24 04 8c 37 00 	movl   $0x378c,0x4(%esp)
    1921:	00 
    1922:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1929:	e8 42 15 00 00       	call   2e70 <printf>
    exit();
    192e:	e8 f1 13 00 00       	call   2d24 <exit>
    1933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001940 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1940:	55                   	push   %ebp
    1941:	89 e5                	mov    %esp,%ebp
    1943:	53                   	push   %ebx
    1944:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1947:	c7 44 24 04 d6 37 00 	movl   $0x37d6,0x4(%esp)
    194e:	00 
    194f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1956:	e8 15 15 00 00       	call   2e70 <printf>

  unlink("ff");
    195b:	c7 04 24 5f 38 00 00 	movl   $0x385f,(%esp)
    1962:	e8 0d 14 00 00       	call   2d74 <unlink>
  if(mkdir("dd") != 0){
    1967:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    196e:	e8 19 14 00 00       	call   2d8c <mkdir>
    1973:	85 c0                	test   %eax,%eax
    1975:	0f 85 07 06 00 00    	jne    1f82 <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    197b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1982:	00 
    1983:	c7 04 24 35 38 00 00 	movl   $0x3835,(%esp)
    198a:	e8 d5 13 00 00       	call   2d64 <open>
  if(fd < 0){
    198f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1991:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1993:	0f 88 d0 05 00 00    	js     1f69 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1999:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    19a0:	00 
    19a1:	c7 44 24 04 5f 38 00 	movl   $0x385f,0x4(%esp)
    19a8:	00 
    19a9:	89 04 24             	mov    %eax,(%esp)
    19ac:	e8 93 13 00 00       	call   2d44 <write>
  close(fd);
    19b1:	89 1c 24             	mov    %ebx,(%esp)
    19b4:	e8 93 13 00 00       	call   2d4c <close>
  
  if(unlink("dd") >= 0){
    19b9:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    19c0:	e8 af 13 00 00       	call   2d74 <unlink>
    19c5:	85 c0                	test   %eax,%eax
    19c7:	0f 89 83 05 00 00    	jns    1f50 <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    19cd:	c7 04 24 10 38 00 00 	movl   $0x3810,(%esp)
    19d4:	e8 b3 13 00 00       	call   2d8c <mkdir>
    19d9:	85 c0                	test   %eax,%eax
    19db:	0f 85 56 05 00 00    	jne    1f37 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    19e1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    19e8:	00 
    19e9:	c7 04 24 32 38 00 00 	movl   $0x3832,(%esp)
    19f0:	e8 6f 13 00 00       	call   2d64 <open>
  if(fd < 0){
    19f5:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    19f7:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    19f9:	0f 88 25 04 00 00    	js     1e24 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    19ff:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1a06:	00 
    1a07:	c7 44 24 04 53 38 00 	movl   $0x3853,0x4(%esp)
    1a0e:	00 
    1a0f:	89 04 24             	mov    %eax,(%esp)
    1a12:	e8 2d 13 00 00       	call   2d44 <write>
  close(fd);
    1a17:	89 1c 24             	mov    %ebx,(%esp)
    1a1a:	e8 2d 13 00 00       	call   2d4c <close>

  fd = open("dd/dd/../ff", 0);
    1a1f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a26:	00 
    1a27:	c7 04 24 56 38 00 00 	movl   $0x3856,(%esp)
    1a2e:	e8 31 13 00 00       	call   2d64 <open>
  if(fd < 0){
    1a33:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1a35:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1a37:	0f 88 ce 03 00 00    	js     1e0b <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1a3d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1a44:	00 
    1a45:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1a4c:	00 
    1a4d:	89 04 24             	mov    %eax,(%esp)
    1a50:	e8 e7 12 00 00       	call   2d3c <read>
  if(cc != 2 || buf[0] != 'f'){
    1a55:	83 f8 02             	cmp    $0x2,%eax
    1a58:	0f 85 fe 02 00 00    	jne    1d5c <subdir+0x41c>
    1a5e:	80 3d 40 44 00 00 66 	cmpb   $0x66,0x4440
    1a65:	0f 85 f1 02 00 00    	jne    1d5c <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1a6b:	89 1c 24             	mov    %ebx,(%esp)
    1a6e:	e8 d9 12 00 00       	call   2d4c <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1a73:	c7 44 24 04 96 38 00 	movl   $0x3896,0x4(%esp)
    1a7a:	00 
    1a7b:	c7 04 24 32 38 00 00 	movl   $0x3832,(%esp)
    1a82:	e8 fd 12 00 00       	call   2d84 <link>
    1a87:	85 c0                	test   %eax,%eax
    1a89:	0f 85 c7 03 00 00    	jne    1e56 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1a8f:	c7 04 24 32 38 00 00 	movl   $0x3832,(%esp)
    1a96:	e8 d9 12 00 00       	call   2d74 <unlink>
    1a9b:	85 c0                	test   %eax,%eax
    1a9d:	0f 85 eb 02 00 00    	jne    1d8e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1aa3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1aaa:	00 
    1aab:	c7 04 24 32 38 00 00 	movl   $0x3832,(%esp)
    1ab2:	e8 ad 12 00 00       	call   2d64 <open>
    1ab7:	85 c0                	test   %eax,%eax
    1ab9:	0f 89 5f 04 00 00    	jns    1f1e <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1abf:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1ac6:	e8 c9 12 00 00       	call   2d94 <chdir>
    1acb:	85 c0                	test   %eax,%eax
    1acd:	0f 85 32 04 00 00    	jne    1f05 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1ad3:	c7 04 24 ca 38 00 00 	movl   $0x38ca,(%esp)
    1ada:	e8 b5 12 00 00       	call   2d94 <chdir>
    1adf:	85 c0                	test   %eax,%eax
    1ae1:	0f 85 8e 02 00 00    	jne    1d75 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1ae7:	c7 04 24 f0 38 00 00 	movl   $0x38f0,(%esp)
    1aee:	e8 a1 12 00 00       	call   2d94 <chdir>
    1af3:	85 c0                	test   %eax,%eax
    1af5:	0f 85 7a 02 00 00    	jne    1d75 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1afb:	c7 04 24 ff 38 00 00 	movl   $0x38ff,(%esp)
    1b02:	e8 8d 12 00 00       	call   2d94 <chdir>
    1b07:	85 c0                	test   %eax,%eax
    1b09:	0f 85 2e 03 00 00    	jne    1e3d <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1b0f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b16:	00 
    1b17:	c7 04 24 96 38 00 00 	movl   $0x3896,(%esp)
    1b1e:	e8 41 12 00 00       	call   2d64 <open>
  if(fd < 0){
    1b23:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1b25:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b27:	0f 88 81 05 00 00    	js     20ae <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1b2d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1b34:	00 
    1b35:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1b3c:	00 
    1b3d:	89 04 24             	mov    %eax,(%esp)
    1b40:	e8 f7 11 00 00       	call   2d3c <read>
    1b45:	83 f8 02             	cmp    $0x2,%eax
    1b48:	0f 85 47 05 00 00    	jne    2095 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1b4e:	89 1c 24             	mov    %ebx,(%esp)
    1b51:	e8 f6 11 00 00       	call   2d4c <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1b56:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b5d:	00 
    1b5e:	c7 04 24 32 38 00 00 	movl   $0x3832,(%esp)
    1b65:	e8 fa 11 00 00       	call   2d64 <open>
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	0f 89 4e 02 00 00    	jns    1dc0 <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1b72:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1b79:	00 
    1b7a:	c7 04 24 4a 39 00 00 	movl   $0x394a,(%esp)
    1b81:	e8 de 11 00 00       	call   2d64 <open>
    1b86:	85 c0                	test   %eax,%eax
    1b88:	0f 89 19 02 00 00    	jns    1da7 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1b8e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1b95:	00 
    1b96:	c7 04 24 6f 39 00 00 	movl   $0x396f,(%esp)
    1b9d:	e8 c2 11 00 00       	call   2d64 <open>
    1ba2:	85 c0                	test   %eax,%eax
    1ba4:	0f 89 42 03 00 00    	jns    1eec <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1baa:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1bb1:	00 
    1bb2:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1bb9:	e8 a6 11 00 00       	call   2d64 <open>
    1bbe:	85 c0                	test   %eax,%eax
    1bc0:	0f 89 0d 03 00 00    	jns    1ed3 <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1bc6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1bcd:	00 
    1bce:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1bd5:	e8 8a 11 00 00       	call   2d64 <open>
    1bda:	85 c0                	test   %eax,%eax
    1bdc:	0f 89 d8 02 00 00    	jns    1eba <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1be2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1be9:	00 
    1bea:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1bf1:	e8 6e 11 00 00       	call   2d64 <open>
    1bf6:	85 c0                	test   %eax,%eax
    1bf8:	0f 89 a3 02 00 00    	jns    1ea1 <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1bfe:	c7 44 24 04 de 39 00 	movl   $0x39de,0x4(%esp)
    1c05:	00 
    1c06:	c7 04 24 4a 39 00 00 	movl   $0x394a,(%esp)
    1c0d:	e8 72 11 00 00       	call   2d84 <link>
    1c12:	85 c0                	test   %eax,%eax
    1c14:	0f 84 6e 02 00 00    	je     1e88 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1c1a:	c7 44 24 04 de 39 00 	movl   $0x39de,0x4(%esp)
    1c21:	00 
    1c22:	c7 04 24 6f 39 00 00 	movl   $0x396f,(%esp)
    1c29:	e8 56 11 00 00       	call   2d84 <link>
    1c2e:	85 c0                	test   %eax,%eax
    1c30:	0f 84 39 02 00 00    	je     1e6f <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1c36:	c7 44 24 04 96 38 00 	movl   $0x3896,0x4(%esp)
    1c3d:	00 
    1c3e:	c7 04 24 35 38 00 00 	movl   $0x3835,(%esp)
    1c45:	e8 3a 11 00 00       	call   2d84 <link>
    1c4a:	85 c0                	test   %eax,%eax
    1c4c:	0f 84 a0 01 00 00    	je     1df2 <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    1c52:	c7 04 24 4a 39 00 00 	movl   $0x394a,(%esp)
    1c59:	e8 2e 11 00 00       	call   2d8c <mkdir>
    1c5e:	85 c0                	test   %eax,%eax
    1c60:	0f 84 73 01 00 00    	je     1dd9 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    1c66:	c7 04 24 6f 39 00 00 	movl   $0x396f,(%esp)
    1c6d:	e8 1a 11 00 00       	call   2d8c <mkdir>
    1c72:	85 c0                	test   %eax,%eax
    1c74:	0f 84 02 04 00 00    	je     207c <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    1c7a:	c7 04 24 96 38 00 00 	movl   $0x3896,(%esp)
    1c81:	e8 06 11 00 00       	call   2d8c <mkdir>
    1c86:	85 c0                	test   %eax,%eax
    1c88:	0f 84 d5 03 00 00    	je     2063 <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    1c8e:	c7 04 24 6f 39 00 00 	movl   $0x396f,(%esp)
    1c95:	e8 da 10 00 00       	call   2d74 <unlink>
    1c9a:	85 c0                	test   %eax,%eax
    1c9c:	0f 84 a8 03 00 00    	je     204a <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1ca2:	c7 04 24 4a 39 00 00 	movl   $0x394a,(%esp)
    1ca9:	e8 c6 10 00 00       	call   2d74 <unlink>
    1cae:	85 c0                	test   %eax,%eax
    1cb0:	0f 84 7b 03 00 00    	je     2031 <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1cb6:	c7 04 24 35 38 00 00 	movl   $0x3835,(%esp)
    1cbd:	e8 d2 10 00 00       	call   2d94 <chdir>
    1cc2:	85 c0                	test   %eax,%eax
    1cc4:	0f 84 4e 03 00 00    	je     2018 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    1cca:	c7 04 24 e1 39 00 00 	movl   $0x39e1,(%esp)
    1cd1:	e8 be 10 00 00       	call   2d94 <chdir>
    1cd6:	85 c0                	test   %eax,%eax
    1cd8:	0f 84 21 03 00 00    	je     1fff <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    1cde:	c7 04 24 96 38 00 00 	movl   $0x3896,(%esp)
    1ce5:	e8 8a 10 00 00       	call   2d74 <unlink>
    1cea:	85 c0                	test   %eax,%eax
    1cec:	0f 85 9c 00 00 00    	jne    1d8e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1cf2:	c7 04 24 35 38 00 00 	movl   $0x3835,(%esp)
    1cf9:	e8 76 10 00 00       	call   2d74 <unlink>
    1cfe:	85 c0                	test   %eax,%eax
    1d00:	0f 85 e0 02 00 00    	jne    1fe6 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1d06:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1d0d:	e8 62 10 00 00       	call   2d74 <unlink>
    1d12:	85 c0                	test   %eax,%eax
    1d14:	0f 84 b3 02 00 00    	je     1fcd <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    1d1a:	c7 04 24 11 38 00 00 	movl   $0x3811,(%esp)
    1d21:	e8 4e 10 00 00       	call   2d74 <unlink>
    1d26:	85 c0                	test   %eax,%eax
    1d28:	0f 88 86 02 00 00    	js     1fb4 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    1d2e:	c7 04 24 fc 38 00 00 	movl   $0x38fc,(%esp)
    1d35:	e8 3a 10 00 00       	call   2d74 <unlink>
    1d3a:	85 c0                	test   %eax,%eax
    1d3c:	0f 88 59 02 00 00    	js     1f9b <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1d42:	c7 44 24 04 de 3a 00 	movl   $0x3ade,0x4(%esp)
    1d49:	00 
    1d4a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d51:	e8 1a 11 00 00       	call   2e70 <printf>
}
    1d56:	83 c4 14             	add    $0x14,%esp
    1d59:	5b                   	pop    %ebx
    1d5a:	5d                   	pop    %ebp
    1d5b:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    1d5c:	c7 44 24 04 7b 38 00 	movl   $0x387b,0x4(%esp)
    1d63:	00 
    1d64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d6b:	e8 00 11 00 00       	call   2e70 <printf>
    exit();
    1d70:	e8 af 0f 00 00       	call   2d24 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1d75:	c7 44 24 04 d6 38 00 	movl   $0x38d6,0x4(%esp)
    1d7c:	00 
    1d7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d84:	e8 e7 10 00 00       	call   2e70 <printf>
    exit();
    1d89:	e8 96 0f 00 00       	call   2d24 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    1d8e:	c7 44 24 04 a1 38 00 	movl   $0x38a1,0x4(%esp)
    1d95:	00 
    1d96:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d9d:	e8 ce 10 00 00       	call   2e70 <printf>
    exit();
    1da2:	e8 7d 0f 00 00       	call   2d24 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    1da7:	c7 44 24 04 53 39 00 	movl   $0x3953,0x4(%esp)
    1dae:	00 
    1daf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1db6:	e8 b5 10 00 00       	call   2e70 <printf>
    exit();
    1dbb:	e8 64 0f 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1dc0:	c7 44 24 04 dc 40 00 	movl   $0x40dc,0x4(%esp)
    1dc7:	00 
    1dc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dcf:	e8 9c 10 00 00       	call   2e70 <printf>
    exit();
    1dd4:	e8 4b 0f 00 00       	call   2d24 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1dd9:	c7 44 24 04 e7 39 00 	movl   $0x39e7,0x4(%esp)
    1de0:	00 
    1de1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1de8:	e8 83 10 00 00       	call   2e70 <printf>
    exit();
    1ded:	e8 32 0f 00 00       	call   2d24 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1df2:	c7 44 24 04 4c 41 00 	movl   $0x414c,0x4(%esp)
    1df9:	00 
    1dfa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e01:	e8 6a 10 00 00       	call   2e70 <printf>
    exit();
    1e06:	e8 19 0f 00 00       	call   2d24 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    1e0b:	c7 44 24 04 62 38 00 	movl   $0x3862,0x4(%esp)
    1e12:	00 
    1e13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e1a:	e8 51 10 00 00       	call   2e70 <printf>
    exit();
    1e1f:	e8 00 0f 00 00       	call   2d24 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    1e24:	c7 44 24 04 3b 38 00 	movl   $0x383b,0x4(%esp)
    1e2b:	00 
    1e2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e33:	e8 38 10 00 00       	call   2e70 <printf>
    exit();
    1e38:	e8 e7 0e 00 00       	call   2d24 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    1e3d:	c7 44 24 04 04 39 00 	movl   $0x3904,0x4(%esp)
    1e44:	00 
    1e45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e4c:	e8 1f 10 00 00       	call   2e70 <printf>
    exit();
    1e51:	e8 ce 0e 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1e56:	c7 44 24 04 94 40 00 	movl   $0x4094,0x4(%esp)
    1e5d:	00 
    1e5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e65:	e8 06 10 00 00       	call   2e70 <printf>
    exit();
    1e6a:	e8 b5 0e 00 00       	call   2d24 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    1e6f:	c7 44 24 04 28 41 00 	movl   $0x4128,0x4(%esp)
    1e76:	00 
    1e77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e7e:	e8 ed 0f 00 00       	call   2e70 <printf>
    exit();
    1e83:	e8 9c 0e 00 00       	call   2d24 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    1e88:	c7 44 24 04 04 41 00 	movl   $0x4104,0x4(%esp)
    1e8f:	00 
    1e90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e97:	e8 d4 0f 00 00       	call   2e70 <printf>
    exit();
    1e9c:	e8 83 0e 00 00       	call   2d24 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    1ea1:	c7 44 24 04 c3 39 00 	movl   $0x39c3,0x4(%esp)
    1ea8:	00 
    1ea9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1eb0:	e8 bb 0f 00 00       	call   2e70 <printf>
    exit();
    1eb5:	e8 6a 0e 00 00       	call   2d24 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    1eba:	c7 44 24 04 aa 39 00 	movl   $0x39aa,0x4(%esp)
    1ec1:	00 
    1ec2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ec9:	e8 a2 0f 00 00       	call   2e70 <printf>
    exit();
    1ece:	e8 51 0e 00 00       	call   2d24 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    1ed3:	c7 44 24 04 94 39 00 	movl   $0x3994,0x4(%esp)
    1eda:	00 
    1edb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ee2:	e8 89 0f 00 00       	call   2e70 <printf>
    exit();
    1ee7:	e8 38 0e 00 00       	call   2d24 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    1eec:	c7 44 24 04 78 39 00 	movl   $0x3978,0x4(%esp)
    1ef3:	00 
    1ef4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1efb:	e8 70 0f 00 00       	call   2e70 <printf>
    exit();
    1f00:	e8 1f 0e 00 00       	call   2d24 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    1f05:	c7 44 24 04 b9 38 00 	movl   $0x38b9,0x4(%esp)
    1f0c:	00 
    1f0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f14:	e8 57 0f 00 00       	call   2e70 <printf>
    exit();
    1f19:	e8 06 0e 00 00       	call   2d24 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1f1e:	c7 44 24 04 b8 40 00 	movl   $0x40b8,0x4(%esp)
    1f25:	00 
    1f26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f2d:	e8 3e 0f 00 00       	call   2e70 <printf>
    exit();
    1f32:	e8 ed 0d 00 00       	call   2d24 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    1f37:	c7 44 24 04 17 38 00 	movl   $0x3817,0x4(%esp)
    1f3e:	00 
    1f3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f46:	e8 25 0f 00 00       	call   2e70 <printf>
    exit();
    1f4b:	e8 d4 0d 00 00       	call   2d24 <exit>
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1f50:	c7 44 24 04 6c 40 00 	movl   $0x406c,0x4(%esp)
    1f57:	00 
    1f58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f5f:	e8 0c 0f 00 00       	call   2e70 <printf>
    exit();
    1f64:	e8 bb 0d 00 00       	call   2d24 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    1f69:	c7 44 24 04 fb 37 00 	movl   $0x37fb,0x4(%esp)
    1f70:	00 
    1f71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f78:	e8 f3 0e 00 00       	call   2e70 <printf>
    exit();
    1f7d:	e8 a2 0d 00 00       	call   2d24 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    1f82:	c7 44 24 04 e3 37 00 	movl   $0x37e3,0x4(%esp)
    1f89:	00 
    1f8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f91:	e8 da 0e 00 00       	call   2e70 <printf>
    exit();
    1f96:	e8 89 0d 00 00       	call   2d24 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    1f9b:	c7 44 24 04 cc 3a 00 	movl   $0x3acc,0x4(%esp)
    1fa2:	00 
    1fa3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1faa:	e8 c1 0e 00 00       	call   2e70 <printf>
    exit();
    1faf:	e8 70 0d 00 00       	call   2d24 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    1fb4:	c7 44 24 04 b7 3a 00 	movl   $0x3ab7,0x4(%esp)
    1fbb:	00 
    1fbc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fc3:	e8 a8 0e 00 00       	call   2e70 <printf>
    exit();
    1fc8:	e8 57 0d 00 00       	call   2d24 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    1fcd:	c7 44 24 04 70 41 00 	movl   $0x4170,0x4(%esp)
    1fd4:	00 
    1fd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fdc:	e8 8f 0e 00 00       	call   2e70 <printf>
    exit();
    1fe1:	e8 3e 0d 00 00       	call   2d24 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    1fe6:	c7 44 24 04 a2 3a 00 	movl   $0x3aa2,0x4(%esp)
    1fed:	00 
    1fee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ff5:	e8 76 0e 00 00       	call   2e70 <printf>
    exit();
    1ffa:	e8 25 0d 00 00       	call   2d24 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    1fff:	c7 44 24 04 8a 3a 00 	movl   $0x3a8a,0x4(%esp)
    2006:	00 
    2007:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    200e:	e8 5d 0e 00 00       	call   2e70 <printf>
    exit();
    2013:	e8 0c 0d 00 00       	call   2d24 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    2018:	c7 44 24 04 72 3a 00 	movl   $0x3a72,0x4(%esp)
    201f:	00 
    2020:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2027:	e8 44 0e 00 00       	call   2e70 <printf>
    exit();
    202c:	e8 f3 0c 00 00       	call   2d24 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2031:	c7 44 24 04 56 3a 00 	movl   $0x3a56,0x4(%esp)
    2038:	00 
    2039:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2040:	e8 2b 0e 00 00       	call   2e70 <printf>
    exit();
    2045:	e8 da 0c 00 00       	call   2d24 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    204a:	c7 44 24 04 3a 3a 00 	movl   $0x3a3a,0x4(%esp)
    2051:	00 
    2052:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2059:	e8 12 0e 00 00       	call   2e70 <printf>
    exit();
    205e:	e8 c1 0c 00 00       	call   2d24 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2063:	c7 44 24 04 1d 3a 00 	movl   $0x3a1d,0x4(%esp)
    206a:	00 
    206b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2072:	e8 f9 0d 00 00       	call   2e70 <printf>
    exit();
    2077:	e8 a8 0c 00 00       	call   2d24 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    207c:	c7 44 24 04 02 3a 00 	movl   $0x3a02,0x4(%esp)
    2083:	00 
    2084:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    208b:	e8 e0 0d 00 00       	call   2e70 <printf>
    exit();
    2090:	e8 8f 0c 00 00       	call   2d24 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    2095:	c7 44 24 04 2f 39 00 	movl   $0x392f,0x4(%esp)
    209c:	00 
    209d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20a4:	e8 c7 0d 00 00       	call   2e70 <printf>
    exit();
    20a9:	e8 76 0c 00 00       	call   2d24 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    20ae:	c7 44 24 04 17 39 00 	movl   $0x3917,0x4(%esp)
    20b5:	00 
    20b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20bd:	e8 ae 0d 00 00       	call   2e70 <printf>
    exit();
    20c2:	e8 5d 0c 00 00       	call   2d24 <exit>
    20c7:	89 f6                	mov    %esi,%esi
    20c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000020d0 <bigfile>:
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
    20d0:	55                   	push   %ebp
    20d1:	89 e5                	mov    %esp,%ebp
    20d3:	57                   	push   %edi
    20d4:	56                   	push   %esi
    20d5:	53                   	push   %ebx
    20d6:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    20d9:	c7 44 24 04 e9 3a 00 	movl   $0x3ae9,0x4(%esp)
    20e0:	00 
    20e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20e8:	e8 83 0d 00 00       	call   2e70 <printf>

  unlink("bigfile");
    20ed:	c7 04 24 05 3b 00 00 	movl   $0x3b05,(%esp)
    20f4:	e8 7b 0c 00 00       	call   2d74 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    20f9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2100:	00 
    2101:	c7 04 24 05 3b 00 00 	movl   $0x3b05,(%esp)
    2108:	e8 57 0c 00 00       	call   2d64 <open>
  if(fd < 0){
    210d:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    210f:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2111:	0f 88 7f 01 00 00    	js     2296 <bigfile+0x1c6>
    2117:	31 db                	xor    %ebx,%ebx
    2119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2120:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2127:	00 
    2128:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    212c:	c7 04 24 40 44 00 00 	movl   $0x4440,(%esp)
    2133:	e8 48 0a 00 00       	call   2b80 <memset>
    if(write(fd, buf, 600) != 600){
    2138:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    213f:	00 
    2140:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    2147:	00 
    2148:	89 34 24             	mov    %esi,(%esp)
    214b:	e8 f4 0b 00 00       	call   2d44 <write>
    2150:	3d 58 02 00 00       	cmp    $0x258,%eax
    2155:	0f 85 09 01 00 00    	jne    2264 <bigfile+0x194>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    215b:	83 c3 01             	add    $0x1,%ebx
    215e:	83 fb 14             	cmp    $0x14,%ebx
    2161:	75 bd                	jne    2120 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2163:	89 34 24             	mov    %esi,(%esp)
    2166:	e8 e1 0b 00 00       	call   2d4c <close>

  fd = open("bigfile", 0);
    216b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2172:	00 
    2173:	c7 04 24 05 3b 00 00 	movl   $0x3b05,(%esp)
    217a:	e8 e5 0b 00 00       	call   2d64 <open>
  if(fd < 0){
    217f:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2181:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2183:	0f 88 f4 00 00 00    	js     227d <bigfile+0x1ad>
    2189:	31 f6                	xor    %esi,%esi
    218b:	30 db                	xor    %bl,%bl
    218d:	eb 2f                	jmp    21be <bigfile+0xee>
    218f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2190:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2195:	0f 85 97 00 00 00    	jne    2232 <bigfile+0x162>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    219b:	0f be 05 40 44 00 00 	movsbl 0x4440,%eax
    21a2:	89 da                	mov    %ebx,%edx
    21a4:	d1 fa                	sar    %edx
    21a6:	39 d0                	cmp    %edx,%eax
    21a8:	75 6f                	jne    2219 <bigfile+0x149>
    21aa:	0f be 15 6b 45 00 00 	movsbl 0x456b,%edx
    21b1:	39 d0                	cmp    %edx,%eax
    21b3:	75 64                	jne    2219 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    21b5:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    21bb:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    21be:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    21c5:	00 
    21c6:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    21cd:	00 
    21ce:	89 3c 24             	mov    %edi,(%esp)
    21d1:	e8 66 0b 00 00       	call   2d3c <read>
    if(cc < 0){
    21d6:	83 f8 00             	cmp    $0x0,%eax
    21d9:	7c 70                	jl     224b <bigfile+0x17b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    21db:	75 b3                	jne    2190 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    21dd:	89 3c 24             	mov    %edi,(%esp)
    21e0:	e8 67 0b 00 00       	call   2d4c <close>
  if(total != 20*600){
    21e5:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    21eb:	0f 85 be 00 00 00    	jne    22af <bigfile+0x1df>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    21f1:	c7 04 24 05 3b 00 00 	movl   $0x3b05,(%esp)
    21f8:	e8 77 0b 00 00       	call   2d74 <unlink>

  printf(1, "bigfile test ok\n");
    21fd:	c7 44 24 04 94 3b 00 	movl   $0x3b94,0x4(%esp)
    2204:	00 
    2205:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    220c:	e8 5f 0c 00 00       	call   2e70 <printf>
}
    2211:	83 c4 1c             	add    $0x1c,%esp
    2214:	5b                   	pop    %ebx
    2215:	5e                   	pop    %esi
    2216:	5f                   	pop    %edi
    2217:	5d                   	pop    %ebp
    2218:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2219:	c7 44 24 04 61 3b 00 	movl   $0x3b61,0x4(%esp)
    2220:	00 
    2221:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2228:	e8 43 0c 00 00       	call   2e70 <printf>
      exit();
    222d:	e8 f2 0a 00 00       	call   2d24 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    2232:	c7 44 24 04 4d 3b 00 	movl   $0x3b4d,0x4(%esp)
    2239:	00 
    223a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2241:	e8 2a 0c 00 00       	call   2e70 <printf>
      exit();
    2246:	e8 d9 0a 00 00       	call   2d24 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    224b:	c7 44 24 04 38 3b 00 	movl   $0x3b38,0x4(%esp)
    2252:	00 
    2253:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    225a:	e8 11 0c 00 00       	call   2e70 <printf>
      exit();
    225f:	e8 c0 0a 00 00       	call   2d24 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2264:	c7 44 24 04 0d 3b 00 	movl   $0x3b0d,0x4(%esp)
    226b:	00 
    226c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2273:	e8 f8 0b 00 00       	call   2e70 <printf>
      exit();
    2278:	e8 a7 0a 00 00       	call   2d24 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    227d:	c7 44 24 04 23 3b 00 	movl   $0x3b23,0x4(%esp)
    2284:	00 
    2285:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    228c:	e8 df 0b 00 00       	call   2e70 <printf>
    exit();
    2291:	e8 8e 0a 00 00       	call   2d24 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2296:	c7 44 24 04 f7 3a 00 	movl   $0x3af7,0x4(%esp)
    229d:	00 
    229e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22a5:	e8 c6 0b 00 00       	call   2e70 <printf>
    exit();
    22aa:	e8 75 0a 00 00       	call   2d24 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    22af:	c7 44 24 04 7a 3b 00 	movl   $0x3b7a,0x4(%esp)
    22b6:	00 
    22b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22be:	e8 ad 0b 00 00       	call   2e70 <printf>
    exit();
    22c3:	e8 5c 0a 00 00       	call   2d24 <exit>
    22c8:	90                   	nop
    22c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000022d0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    22d0:	55                   	push   %ebp
    22d1:	89 e5                	mov    %esp,%ebp
    22d3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    22d6:	c7 44 24 04 a5 3b 00 	movl   $0x3ba5,0x4(%esp)
    22dd:	00 
    22de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22e5:	e8 86 0b 00 00       	call   2e70 <printf>

  if(mkdir("12345678901234") != 0){
    22ea:	c7 04 24 e0 3b 00 00 	movl   $0x3be0,(%esp)
    22f1:	e8 96 0a 00 00       	call   2d8c <mkdir>
    22f6:	85 c0                	test   %eax,%eax
    22f8:	0f 85 92 00 00 00    	jne    2390 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    22fe:	c7 04 24 90 41 00 00 	movl   $0x4190,(%esp)
    2305:	e8 82 0a 00 00       	call   2d8c <mkdir>
    230a:	85 c0                	test   %eax,%eax
    230c:	0f 85 fb 00 00 00    	jne    240d <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2312:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2319:	00 
    231a:	c7 04 24 e0 41 00 00 	movl   $0x41e0,(%esp)
    2321:	e8 3e 0a 00 00       	call   2d64 <open>
  if(fd < 0){
    2326:	85 c0                	test   %eax,%eax
    2328:	0f 88 c6 00 00 00    	js     23f4 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    232e:	89 04 24             	mov    %eax,(%esp)
    2331:	e8 16 0a 00 00       	call   2d4c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2336:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    233d:	00 
    233e:	c7 04 24 50 42 00 00 	movl   $0x4250,(%esp)
    2345:	e8 1a 0a 00 00       	call   2d64 <open>
  if(fd < 0){
    234a:	85 c0                	test   %eax,%eax
    234c:	0f 88 89 00 00 00    	js     23db <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    2352:	89 04 24             	mov    %eax,(%esp)
    2355:	e8 f2 09 00 00       	call   2d4c <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    235a:	c7 04 24 d1 3b 00 00 	movl   $0x3bd1,(%esp)
    2361:	e8 26 0a 00 00       	call   2d8c <mkdir>
    2366:	85 c0                	test   %eax,%eax
    2368:	74 58                	je     23c2 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    236a:	c7 04 24 ec 42 00 00 	movl   $0x42ec,(%esp)
    2371:	e8 16 0a 00 00       	call   2d8c <mkdir>
    2376:	85 c0                	test   %eax,%eax
    2378:	74 2f                	je     23a9 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    237a:	c7 44 24 04 ef 3b 00 	movl   $0x3bef,0x4(%esp)
    2381:	00 
    2382:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2389:	e8 e2 0a 00 00       	call   2e70 <printf>
}
    238e:	c9                   	leave  
    238f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2390:	c7 44 24 04 b4 3b 00 	movl   $0x3bb4,0x4(%esp)
    2397:	00 
    2398:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    239f:	e8 cc 0a 00 00       	call   2e70 <printf>
    exit();
    23a4:	e8 7b 09 00 00       	call   2d24 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    23a9:	c7 44 24 04 0c 43 00 	movl   $0x430c,0x4(%esp)
    23b0:	00 
    23b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23b8:	e8 b3 0a 00 00       	call   2e70 <printf>
    exit();
    23bd:	e8 62 09 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    23c2:	c7 44 24 04 bc 42 00 	movl   $0x42bc,0x4(%esp)
    23c9:	00 
    23ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23d1:	e8 9a 0a 00 00       	call   2e70 <printf>
    exit();
    23d6:	e8 49 09 00 00       	call   2d24 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    23db:	c7 44 24 04 80 42 00 	movl   $0x4280,0x4(%esp)
    23e2:	00 
    23e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23ea:	e8 81 0a 00 00       	call   2e70 <printf>
    exit();
    23ef:	e8 30 09 00 00       	call   2d24 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    23f4:	c7 44 24 04 10 42 00 	movl   $0x4210,0x4(%esp)
    23fb:	00 
    23fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2403:	e8 68 0a 00 00       	call   2e70 <printf>
    exit();
    2408:	e8 17 09 00 00       	call   2d24 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    240d:	c7 44 24 04 b0 41 00 	movl   $0x41b0,0x4(%esp)
    2414:	00 
    2415:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    241c:	e8 4f 0a 00 00       	call   2e70 <printf>
    exit();
    2421:	e8 fe 08 00 00       	call   2d24 <exit>
    2426:	8d 76 00             	lea    0x0(%esi),%esi
    2429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002430 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    2430:	55                   	push   %ebp
    2431:	89 e5                	mov    %esp,%ebp
    2433:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    2436:	c7 44 24 04 fc 3b 00 	movl   $0x3bfc,0x4(%esp)
    243d:	00 
    243e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2445:	e8 26 0a 00 00       	call   2e70 <printf>
  if(mkdir("dots") != 0){
    244a:	c7 04 24 08 3c 00 00 	movl   $0x3c08,(%esp)
    2451:	e8 36 09 00 00       	call   2d8c <mkdir>
    2456:	85 c0                	test   %eax,%eax
    2458:	0f 85 9a 00 00 00    	jne    24f8 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    245e:	c7 04 24 08 3c 00 00 	movl   $0x3c08,(%esp)
    2465:	e8 2a 09 00 00       	call   2d94 <chdir>
    246a:	85 c0                	test   %eax,%eax
    246c:	0f 85 35 01 00 00    	jne    25a7 <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2472:	c7 04 24 02 39 00 00 	movl   $0x3902,(%esp)
    2479:	e8 f6 08 00 00       	call   2d74 <unlink>
    247e:	85 c0                	test   %eax,%eax
    2480:	0f 84 08 01 00 00    	je     258e <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2486:	c7 04 24 01 39 00 00 	movl   $0x3901,(%esp)
    248d:	e8 e2 08 00 00       	call   2d74 <unlink>
    2492:	85 c0                	test   %eax,%eax
    2494:	0f 84 db 00 00 00    	je     2575 <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    249a:	c7 04 24 50 3c 00 00 	movl   $0x3c50,(%esp)
    24a1:	e8 ee 08 00 00       	call   2d94 <chdir>
    24a6:	85 c0                	test   %eax,%eax
    24a8:	0f 85 ae 00 00 00    	jne    255c <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    24ae:	c7 04 24 62 3c 00 00 	movl   $0x3c62,(%esp)
    24b5:	e8 ba 08 00 00       	call   2d74 <unlink>
    24ba:	85 c0                	test   %eax,%eax
    24bc:	0f 84 81 00 00 00    	je     2543 <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    24c2:	c7 04 24 80 3c 00 00 	movl   $0x3c80,(%esp)
    24c9:	e8 a6 08 00 00       	call   2d74 <unlink>
    24ce:	85 c0                	test   %eax,%eax
    24d0:	74 58                	je     252a <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    24d2:	c7 04 24 08 3c 00 00 	movl   $0x3c08,(%esp)
    24d9:	e8 96 08 00 00       	call   2d74 <unlink>
    24de:	85 c0                	test   %eax,%eax
    24e0:	75 2f                	jne    2511 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    24e2:	c7 44 24 04 b5 3c 00 	movl   $0x3cb5,0x4(%esp)
    24e9:	00 
    24ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24f1:	e8 7a 09 00 00       	call   2e70 <printf>
}
    24f6:	c9                   	leave  
    24f7:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    24f8:	c7 44 24 04 0d 3c 00 	movl   $0x3c0d,0x4(%esp)
    24ff:	00 
    2500:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2507:	e8 64 09 00 00       	call   2e70 <printf>
    exit();
    250c:	e8 13 08 00 00       	call   2d24 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    2511:	c7 44 24 04 a0 3c 00 	movl   $0x3ca0,0x4(%esp)
    2518:	00 
    2519:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2520:	e8 4b 09 00 00       	call   2e70 <printf>
    exit();
    2525:	e8 fa 07 00 00       	call   2d24 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    252a:	c7 44 24 04 88 3c 00 	movl   $0x3c88,0x4(%esp)
    2531:	00 
    2532:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2539:	e8 32 09 00 00       	call   2e70 <printf>
    exit();
    253e:	e8 e1 07 00 00       	call   2d24 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2543:	c7 44 24 04 69 3c 00 	movl   $0x3c69,0x4(%esp)
    254a:	00 
    254b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2552:	e8 19 09 00 00       	call   2e70 <printf>
    exit();
    2557:	e8 c8 07 00 00       	call   2d24 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    255c:	c7 44 24 04 52 3c 00 	movl   $0x3c52,0x4(%esp)
    2563:	00 
    2564:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    256b:	e8 00 09 00 00       	call   2e70 <printf>
    exit();
    2570:	e8 af 07 00 00       	call   2d24 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2575:	c7 44 24 04 41 3c 00 	movl   $0x3c41,0x4(%esp)
    257c:	00 
    257d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2584:	e8 e7 08 00 00       	call   2e70 <printf>
    exit();
    2589:	e8 96 07 00 00       	call   2d24 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    258e:	c7 44 24 04 33 3c 00 	movl   $0x3c33,0x4(%esp)
    2595:	00 
    2596:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    259d:	e8 ce 08 00 00       	call   2e70 <printf>
    exit();
    25a2:	e8 7d 07 00 00       	call   2d24 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    25a7:	c7 44 24 04 20 3c 00 	movl   $0x3c20,0x4(%esp)
    25ae:	00 
    25af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25b6:	e8 b5 08 00 00       	call   2e70 <printf>
    exit();
    25bb:	e8 64 07 00 00       	call   2d24 <exit>

000025c0 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    25c0:	55                   	push   %ebp
    25c1:	89 e5                	mov    %esp,%ebp
    25c3:	53                   	push   %ebx
    25c4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
    25c7:	c7 44 24 04 bf 3c 00 	movl   $0x3cbf,0x4(%esp)
    25ce:	00 
    25cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25d6:	e8 95 08 00 00       	call   2e70 <printf>

  fd = open("dirfile", O_CREATE);
    25db:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    25e2:	00 
    25e3:	c7 04 24 cc 3c 00 00 	movl   $0x3ccc,(%esp)
    25ea:	e8 75 07 00 00       	call   2d64 <open>
  if(fd < 0){
    25ef:	85 c0                	test   %eax,%eax
    25f1:	0f 88 4e 01 00 00    	js     2745 <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    25f7:	89 04 24             	mov    %eax,(%esp)
    25fa:	e8 4d 07 00 00       	call   2d4c <close>
  if(chdir("dirfile") == 0){
    25ff:	c7 04 24 cc 3c 00 00 	movl   $0x3ccc,(%esp)
    2606:	e8 89 07 00 00       	call   2d94 <chdir>
    260b:	85 c0                	test   %eax,%eax
    260d:	0f 84 19 01 00 00    	je     272c <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    2613:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    261a:	00 
    261b:	c7 04 24 05 3d 00 00 	movl   $0x3d05,(%esp)
    2622:	e8 3d 07 00 00       	call   2d64 <open>
  if(fd >= 0){
    2627:	85 c0                	test   %eax,%eax
    2629:	0f 89 e4 00 00 00    	jns    2713 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    262f:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2636:	00 
    2637:	c7 04 24 05 3d 00 00 	movl   $0x3d05,(%esp)
    263e:	e8 21 07 00 00       	call   2d64 <open>
  if(fd >= 0){
    2643:	85 c0                	test   %eax,%eax
    2645:	0f 89 c8 00 00 00    	jns    2713 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    264b:	c7 04 24 05 3d 00 00 	movl   $0x3d05,(%esp)
    2652:	e8 35 07 00 00       	call   2d8c <mkdir>
    2657:	85 c0                	test   %eax,%eax
    2659:	0f 84 7c 01 00 00    	je     27db <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    265f:	c7 04 24 05 3d 00 00 	movl   $0x3d05,(%esp)
    2666:	e8 09 07 00 00       	call   2d74 <unlink>
    266b:	85 c0                	test   %eax,%eax
    266d:	0f 84 4f 01 00 00    	je     27c2 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2673:	c7 44 24 04 05 3d 00 	movl   $0x3d05,0x4(%esp)
    267a:	00 
    267b:	c7 04 24 69 3d 00 00 	movl   $0x3d69,(%esp)
    2682:	e8 fd 06 00 00       	call   2d84 <link>
    2687:	85 c0                	test   %eax,%eax
    2689:	0f 84 1a 01 00 00    	je     27a9 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    268f:	c7 04 24 cc 3c 00 00 	movl   $0x3ccc,(%esp)
    2696:	e8 d9 06 00 00       	call   2d74 <unlink>
    269b:	85 c0                	test   %eax,%eax
    269d:	0f 85 ed 00 00 00    	jne    2790 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    26a3:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    26aa:	00 
    26ab:	c7 04 24 02 39 00 00 	movl   $0x3902,(%esp)
    26b2:	e8 ad 06 00 00       	call   2d64 <open>
  if(fd >= 0){
    26b7:	85 c0                	test   %eax,%eax
    26b9:	0f 89 b8 00 00 00    	jns    2777 <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    26bf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    26c6:	00 
    26c7:	c7 04 24 02 39 00 00 	movl   $0x3902,(%esp)
    26ce:	e8 91 06 00 00       	call   2d64 <open>
  if(write(fd, "x", 1) > 0){
    26d3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    26da:	00 
    26db:	c7 44 24 04 e5 39 00 	movl   $0x39e5,0x4(%esp)
    26e2:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    26e3:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    26e5:	89 04 24             	mov    %eax,(%esp)
    26e8:	e8 57 06 00 00       	call   2d44 <write>
    26ed:	85 c0                	test   %eax,%eax
    26ef:	7f 6d                	jg     275e <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    26f1:	89 1c 24             	mov    %ebx,(%esp)
    26f4:	e8 53 06 00 00       	call   2d4c <close>

  printf(1, "dir vs file OK\n");
    26f9:	c7 44 24 04 9c 3d 00 	movl   $0x3d9c,0x4(%esp)
    2700:	00 
    2701:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2708:	e8 63 07 00 00       	call   2e70 <printf>
}
    270d:	83 c4 14             	add    $0x14,%esp
    2710:	5b                   	pop    %ebx
    2711:	5d                   	pop    %ebp
    2712:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2713:	c7 44 24 04 10 3d 00 	movl   $0x3d10,0x4(%esp)
    271a:	00 
    271b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2722:	e8 49 07 00 00       	call   2e70 <printf>
    exit();
    2727:	e8 f8 05 00 00       	call   2d24 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    272c:	c7 44 24 04 eb 3c 00 	movl   $0x3ceb,0x4(%esp)
    2733:	00 
    2734:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    273b:	e8 30 07 00 00       	call   2e70 <printf>
    exit();
    2740:	e8 df 05 00 00       	call   2d24 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2745:	c7 44 24 04 d4 3c 00 	movl   $0x3cd4,0x4(%esp)
    274c:	00 
    274d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2754:	e8 17 07 00 00       	call   2e70 <printf>
    exit();
    2759:	e8 c6 05 00 00       	call   2d24 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    275e:	c7 44 24 04 88 3d 00 	movl   $0x3d88,0x4(%esp)
    2765:	00 
    2766:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    276d:	e8 fe 06 00 00       	call   2e70 <printf>
    exit();
    2772:	e8 ad 05 00 00       	call   2d24 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2777:	c7 44 24 04 60 43 00 	movl   $0x4360,0x4(%esp)
    277e:	00 
    277f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2786:	e8 e5 06 00 00       	call   2e70 <printf>
    exit();
    278b:	e8 94 05 00 00       	call   2d24 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2790:	c7 44 24 04 70 3d 00 	movl   $0x3d70,0x4(%esp)
    2797:	00 
    2798:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    279f:	e8 cc 06 00 00       	call   2e70 <printf>
    exit();
    27a4:	e8 7b 05 00 00       	call   2d24 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    27a9:	c7 44 24 04 40 43 00 	movl   $0x4340,0x4(%esp)
    27b0:	00 
    27b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27b8:	e8 b3 06 00 00       	call   2e70 <printf>
    exit();
    27bd:	e8 62 05 00 00       	call   2d24 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    27c2:	c7 44 24 04 4b 3d 00 	movl   $0x3d4b,0x4(%esp)
    27c9:	00 
    27ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27d1:	e8 9a 06 00 00       	call   2e70 <printf>
    exit();
    27d6:	e8 49 05 00 00       	call   2d24 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    27db:	c7 44 24 04 2e 3d 00 	movl   $0x3d2e,0x4(%esp)
    27e2:	00 
    27e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ea:	e8 81 06 00 00       	call   2e70 <printf>
    exit();
    27ef:	e8 30 05 00 00       	call   2d24 <exit>
    27f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    27fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002800 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2800:	55                   	push   %ebp
    2801:	89 e5                	mov    %esp,%ebp
    2803:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2804:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2809:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
    280c:	c7 44 24 04 ac 3d 00 	movl   $0x3dac,0x4(%esp)
    2813:	00 
    2814:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    281b:	e8 50 06 00 00       	call   2e70 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2820:	c7 04 24 bd 3d 00 00 	movl   $0x3dbd,(%esp)
    2827:	e8 60 05 00 00       	call   2d8c <mkdir>
    282c:	85 c0                	test   %eax,%eax
    282e:	0f 85 af 00 00 00    	jne    28e3 <iref+0xe3>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2834:	c7 04 24 bd 3d 00 00 	movl   $0x3dbd,(%esp)
    283b:	e8 54 05 00 00       	call   2d94 <chdir>
    2840:	85 c0                	test   %eax,%eax
    2842:	0f 85 b4 00 00 00    	jne    28fc <iref+0xfc>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2848:	c7 04 24 db 34 00 00 	movl   $0x34db,(%esp)
    284f:	e8 38 05 00 00       	call   2d8c <mkdir>
    link("README", "");
    2854:	c7 44 24 04 db 34 00 	movl   $0x34db,0x4(%esp)
    285b:	00 
    285c:	c7 04 24 69 3d 00 00 	movl   $0x3d69,(%esp)
    2863:	e8 1c 05 00 00       	call   2d84 <link>
    fd = open("", O_CREATE);
    2868:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    286f:	00 
    2870:	c7 04 24 db 34 00 00 	movl   $0x34db,(%esp)
    2877:	e8 e8 04 00 00       	call   2d64 <open>
    if(fd >= 0)
    287c:	85 c0                	test   %eax,%eax
    287e:	78 08                	js     2888 <iref+0x88>
      close(fd);
    2880:	89 04 24             	mov    %eax,(%esp)
    2883:	e8 c4 04 00 00       	call   2d4c <close>
    fd = open("xx", O_CREATE);
    2888:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    288f:	00 
    2890:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    2897:	e8 c8 04 00 00       	call   2d64 <open>
    if(fd >= 0)
    289c:	85 c0                	test   %eax,%eax
    289e:	78 08                	js     28a8 <iref+0xa8>
      close(fd);
    28a0:	89 04 24             	mov    %eax,(%esp)
    28a3:	e8 a4 04 00 00       	call   2d4c <close>
    unlink("xx");
    28a8:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    28af:	e8 c0 04 00 00       	call   2d74 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    28b4:	83 eb 01             	sub    $0x1,%ebx
    28b7:	0f 85 63 ff ff ff    	jne    2820 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    28bd:	c7 04 24 50 3c 00 00 	movl   $0x3c50,(%esp)
    28c4:	e8 cb 04 00 00       	call   2d94 <chdir>
  printf(1, "empty file name OK\n");
    28c9:	c7 44 24 04 eb 3d 00 	movl   $0x3deb,0x4(%esp)
    28d0:	00 
    28d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28d8:	e8 93 05 00 00       	call   2e70 <printf>
}
    28dd:	83 c4 14             	add    $0x14,%esp
    28e0:	5b                   	pop    %ebx
    28e1:	5d                   	pop    %ebp
    28e2:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    28e3:	c7 44 24 04 c3 3d 00 	movl   $0x3dc3,0x4(%esp)
    28ea:	00 
    28eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28f2:	e8 79 05 00 00       	call   2e70 <printf>
      exit();
    28f7:	e8 28 04 00 00       	call   2d24 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    28fc:	c7 44 24 04 d7 3d 00 	movl   $0x3dd7,0x4(%esp)
    2903:	00 
    2904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    290b:	e8 60 05 00 00       	call   2e70 <printf>
      exit();
    2910:	e8 0f 04 00 00       	call   2d24 <exit>
    2915:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002920 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2920:	55                   	push   %ebp
    2921:	89 e5                	mov    %esp,%ebp
    2923:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2924:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2926:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
    2929:	c7 44 24 04 ff 3d 00 	movl   $0x3dff,0x4(%esp)
    2930:	00 
    2931:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2938:	e8 33 05 00 00       	call   2e70 <printf>
    293d:	eb 0e                	jmp    294d <forktest+0x2d>
    293f:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2940:	74 6a                	je     29ac <forktest+0x8c>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2942:	83 c3 01             	add    $0x1,%ebx
    2945:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    294b:	74 4b                	je     2998 <forktest+0x78>
    pid = fork();
    294d:	e8 ca 03 00 00       	call   2d1c <fork>
    if(pid < 0)
    2952:	83 f8 00             	cmp    $0x0,%eax
    2955:	7d e9                	jge    2940 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    2957:	85 db                	test   %ebx,%ebx
    2959:	74 15                	je     2970 <forktest+0x50>
    295b:	90                   	nop
    295c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(wait() < 0){
    2960:	e8 c7 03 00 00       	call   2d2c <wait>
    2965:	85 c0                	test   %eax,%eax
    2967:	78 48                	js     29b1 <forktest+0x91>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    2969:	83 eb 01             	sub    $0x1,%ebx
    296c:	85 db                	test   %ebx,%ebx
    296e:	7f f0                	jg     2960 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    2970:	e8 b7 03 00 00       	call   2d2c <wait>
    2975:	83 f8 ff             	cmp    $0xffffffff,%eax
    2978:	75 50                	jne    29ca <forktest+0xaa>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
    297a:	c7 44 24 04 31 3e 00 	movl   $0x3e31,0x4(%esp)
    2981:	00 
    2982:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2989:	e8 e2 04 00 00       	call   2e70 <printf>
}
    298e:	83 c4 14             	add    $0x14,%esp
    2991:	5b                   	pop    %ebx
    2992:	5d                   	pop    %ebp
    2993:	c3                   	ret    
    2994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2998:	c7 44 24 04 80 43 00 	movl   $0x4380,0x4(%esp)
    299f:	00 
    29a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29a7:	e8 c4 04 00 00       	call   2e70 <printf>
    exit();
    29ac:	e8 73 03 00 00       	call   2d24 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    29b1:	c7 44 24 04 0a 3e 00 	movl   $0x3e0a,0x4(%esp)
    29b8:	00 
    29b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29c0:	e8 ab 04 00 00       	call   2e70 <printf>
      exit();
    29c5:	e8 5a 03 00 00       	call   2d24 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
    29ca:	c7 44 24 04 1e 3e 00 	movl   $0x3e1e,0x4(%esp)
    29d1:	00 
    29d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29d9:	e8 92 04 00 00       	call   2e70 <printf>
    exit();
    29de:	e8 41 03 00 00       	call   2d24 <exit>
    29e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    29e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000029f0 <main>:
  printf(1, "fork test OK\n");
}

int
main(int argc, char *argv[])
{
    29f0:	55                   	push   %ebp
    29f1:	89 e5                	mov    %esp,%ebp
    29f3:	83 e4 f0             	and    $0xfffffff0,%esp
    29f6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    29f9:	c7 44 24 04 3f 3e 00 	movl   $0x3e3f,0x4(%esp)
    2a00:	00 
    2a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a08:	e8 63 04 00 00       	call   2e70 <printf>

  if(open("usertests.ran", 0) >= 0){
    2a0d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a14:	00 
    2a15:	c7 04 24 53 3e 00 00 	movl   $0x3e53,(%esp)
    2a1c:	e8 43 03 00 00       	call   2d64 <open>
    2a21:	85 c0                	test   %eax,%eax
    2a23:	78 1b                	js     2a40 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    2a25:	c7 44 24 04 a4 43 00 	movl   $0x43a4,0x4(%esp)
    2a2c:	00 
    2a2d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a34:	e8 37 04 00 00       	call   2e70 <printf>
    exit();
    2a39:	e8 e6 02 00 00       	call   2d24 <exit>
    2a3e:	66 90                	xchg   %ax,%ax
  }
  close(open("usertests.ran", O_CREATE));
    2a40:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2a47:	00 
    2a48:	c7 04 24 53 3e 00 00 	movl   $0x3e53,(%esp)
    2a4f:	e8 10 03 00 00       	call   2d64 <open>
    2a54:	89 04 24             	mov    %eax,(%esp)
    2a57:	e8 f0 02 00 00       	call   2d4c <close>

  opentest();
    2a5c:	e8 9f d5 ff ff       	call   0 <opentest>
  writetest();
    2a61:	e8 3a d6 ff ff       	call   a0 <writetest>
  writetest1();
    2a66:	e8 45 d8 ff ff       	call   2b0 <writetest1>
    2a6b:	90                   	nop
    2a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  createtest();
    2a70:	e8 2b da ff ff       	call   4a0 <createtest>

  mem();
    2a75:	e8 96 df ff ff       	call   a10 <mem>
  pipe1();
    2a7a:	e8 01 dc ff ff       	call   680 <pipe1>
    2a7f:	90                   	nop
  preempt();
    2a80:	e8 9b dd ff ff       	call   820 <preempt>
  exitwait();
    2a85:	e8 f6 de ff ff       	call   980 <exitwait>

  rmdot();
    2a8a:	e8 a1 f9 ff ff       	call   2430 <rmdot>
    2a8f:	90                   	nop
  fourteen();
    2a90:	e8 3b f8 ff ff       	call   22d0 <fourteen>
  bigfile();
    2a95:	e8 36 f6 ff ff       	call   20d0 <bigfile>
  subdir();
    2a9a:	e8 a1 ee ff ff       	call   1940 <subdir>
    2a9f:	90                   	nop
  concreate();
    2aa0:	e8 8b ea ff ff       	call   1530 <concreate>
  linktest();
    2aa5:	e8 26 e8 ff ff       	call   12d0 <linktest>
  unlinkread();
    2aaa:	e8 51 e6 ff ff       	call   1100 <unlinkread>
    2aaf:	90                   	nop
  createdelete();
    2ab0:	e8 eb e3 ff ff       	call   ea0 <createdelete>
  twofiles();
    2ab5:	e8 c6 e1 ff ff       	call   c80 <twofiles>
  sharedfd();
    2aba:	e8 01 e0 ff ff       	call   ac0 <sharedfd>
    2abf:	90                   	nop
  dirfile();
    2ac0:	e8 fb fa ff ff       	call   25c0 <dirfile>
  iref();
    2ac5:	e8 36 fd ff ff       	call   2800 <iref>
  forktest();
    2aca:	e8 51 fe ff ff       	call   2920 <forktest>
    2acf:	90                   	nop
  bigdir(); // slow
    2ad0:	e8 1b ed ff ff       	call   17f0 <bigdir>

  exectest();
    2ad5:	e8 56 db ff ff       	call   630 <exectest>

  exit();
    2ada:	e8 45 02 00 00       	call   2d24 <exit>
    2adf:	90                   	nop

00002ae0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
    2ae0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    2ae1:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
    2ae3:	89 e5                	mov    %esp,%ebp
    2ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    2ae8:	53                   	push   %ebx
    2ae9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    2aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    2af0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    2af4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    2af7:	83 c2 01             	add    $0x1,%edx
    2afa:	84 c9                	test   %cl,%cl
    2afc:	75 f2                	jne    2af0 <strcpy+0x10>
    ;
  return os;
}
    2afe:	5b                   	pop    %ebx
    2aff:	5d                   	pop    %ebp
    2b00:	c3                   	ret    
    2b01:	eb 0d                	jmp    2b10 <strcmp>
    2b03:	90                   	nop
    2b04:	90                   	nop
    2b05:	90                   	nop
    2b06:	90                   	nop
    2b07:	90                   	nop
    2b08:	90                   	nop
    2b09:	90                   	nop
    2b0a:	90                   	nop
    2b0b:	90                   	nop
    2b0c:	90                   	nop
    2b0d:	90                   	nop
    2b0e:	90                   	nop
    2b0f:	90                   	nop

00002b10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    2b10:	55                   	push   %ebp
    2b11:	89 e5                	mov    %esp,%ebp
    2b13:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2b16:	53                   	push   %ebx
    2b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    2b1a:	0f b6 01             	movzbl (%ecx),%eax
    2b1d:	84 c0                	test   %al,%al
    2b1f:	75 14                	jne    2b35 <strcmp+0x25>
    2b21:	eb 25                	jmp    2b48 <strcmp+0x38>
    2b23:	90                   	nop
    2b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    2b28:	83 c1 01             	add    $0x1,%ecx
    2b2b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    2b2e:	0f b6 01             	movzbl (%ecx),%eax
    2b31:	84 c0                	test   %al,%al
    2b33:	74 13                	je     2b48 <strcmp+0x38>
    2b35:	0f b6 1a             	movzbl (%edx),%ebx
    2b38:	38 d8                	cmp    %bl,%al
    2b3a:	74 ec                	je     2b28 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    2b3c:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    2b3f:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    2b42:	29 d8                	sub    %ebx,%eax
}
    2b44:	5b                   	pop    %ebx
    2b45:	5d                   	pop    %ebp
    2b46:	c3                   	ret    
    2b47:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    2b48:	0f b6 1a             	movzbl (%edx),%ebx
    2b4b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    2b4d:	0f b6 db             	movzbl %bl,%ebx
    2b50:	29 d8                	sub    %ebx,%eax
}
    2b52:	5b                   	pop    %ebx
    2b53:	5d                   	pop    %ebp
    2b54:	c3                   	ret    
    2b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b60 <strlen>:

uint
strlen(char *s)
{
    2b60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    2b61:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    2b63:	89 e5                	mov    %esp,%ebp
    2b65:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    2b68:	80 39 00             	cmpb   $0x0,(%ecx)
    2b6b:	74 0e                	je     2b7b <strlen+0x1b>
    2b6d:	31 d2                	xor    %edx,%edx
    2b6f:	90                   	nop
    2b70:	83 c2 01             	add    $0x1,%edx
    2b73:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    2b77:	89 d0                	mov    %edx,%eax
    2b79:	75 f5                	jne    2b70 <strlen+0x10>
    ;
  return n;
}
    2b7b:	5d                   	pop    %ebp
    2b7c:	c3                   	ret    
    2b7d:	8d 76 00             	lea    0x0(%esi),%esi

00002b80 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	8b 4d 10             	mov    0x10(%ebp),%ecx
    2b86:	53                   	push   %ebx
    2b87:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
    2b8a:	85 c9                	test   %ecx,%ecx
    2b8c:	74 14                	je     2ba2 <memset+0x22>
    2b8e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
    2b92:	31 d2                	xor    %edx,%edx
    2b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
    2b98:	88 1c 10             	mov    %bl,(%eax,%edx,1)
    2b9b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
    2b9e:	39 ca                	cmp    %ecx,%edx
    2ba0:	75 f6                	jne    2b98 <memset+0x18>
    *d++ = c;
  return dst;
}
    2ba2:	5b                   	pop    %ebx
    2ba3:	5d                   	pop    %ebp
    2ba4:	c3                   	ret    
    2ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002bb0 <strchr>:

char*
strchr(const char *s, char c)
{
    2bb0:	55                   	push   %ebp
    2bb1:	89 e5                	mov    %esp,%ebp
    2bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    2bb6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    2bba:	0f b6 10             	movzbl (%eax),%edx
    2bbd:	84 d2                	test   %dl,%dl
    2bbf:	75 11                	jne    2bd2 <strchr+0x22>
    2bc1:	eb 15                	jmp    2bd8 <strchr+0x28>
    2bc3:	90                   	nop
    2bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2bc8:	83 c0 01             	add    $0x1,%eax
    2bcb:	0f b6 10             	movzbl (%eax),%edx
    2bce:	84 d2                	test   %dl,%dl
    2bd0:	74 06                	je     2bd8 <strchr+0x28>
    if(*s == c)
    2bd2:	38 ca                	cmp    %cl,%dl
    2bd4:	75 f2                	jne    2bc8 <strchr+0x18>
      return (char*) s;
  return 0;
}
    2bd6:	5d                   	pop    %ebp
    2bd7:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
    2bd8:	31 c0                	xor    %eax,%eax
}
    2bda:	5d                   	pop    %ebp
    2bdb:	90                   	nop
    2bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2be0:	c3                   	ret    
    2be1:	eb 0d                	jmp    2bf0 <gets>
    2be3:	90                   	nop
    2be4:	90                   	nop
    2be5:	90                   	nop
    2be6:	90                   	nop
    2be7:	90                   	nop
    2be8:	90                   	nop
    2be9:	90                   	nop
    2bea:	90                   	nop
    2beb:	90                   	nop
    2bec:	90                   	nop
    2bed:	90                   	nop
    2bee:	90                   	nop
    2bef:	90                   	nop

00002bf0 <gets>:

char*
gets(char *buf, int max)
{
    2bf0:	55                   	push   %ebp
    2bf1:	89 e5                	mov    %esp,%ebp
    2bf3:	57                   	push   %edi
    2bf4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2bf5:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
    2bf7:	53                   	push   %ebx
    2bf8:	83 ec 2c             	sub    $0x2c,%esp
    2bfb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2bfe:	eb 31                	jmp    2c31 <gets+0x41>
    cc = read(0, &c, 1);
    2c00:	8d 45 e7             	lea    -0x19(%ebp),%eax
    2c03:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2c0a:	00 
    2c0b:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c0f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c16:	e8 21 01 00 00       	call   2d3c <read>
    if(cc < 1)
    2c1b:	85 c0                	test   %eax,%eax
    2c1d:	7e 1a                	jle    2c39 <gets+0x49>
      break;
    buf[i++] = c;
    2c1f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    2c23:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    2c25:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    2c29:	74 1d                	je     2c48 <gets+0x58>
    2c2b:	3c 0a                	cmp    $0xa,%al
    2c2d:	74 19                	je     2c48 <gets+0x58>
    2c2f:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2c31:	8d 5e 01             	lea    0x1(%esi),%ebx
    2c34:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    2c37:	7c c7                	jl     2c00 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    2c39:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    2c3d:	89 f8                	mov    %edi,%eax
    2c3f:	83 c4 2c             	add    $0x2c,%esp
    2c42:	5b                   	pop    %ebx
    2c43:	5e                   	pop    %esi
    2c44:	5f                   	pop    %edi
    2c45:	5d                   	pop    %ebp
    2c46:	c3                   	ret    
    2c47:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2c48:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
    2c4a:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    2c4c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    2c50:	83 c4 2c             	add    $0x2c,%esp
    2c53:	5b                   	pop    %ebx
    2c54:	5e                   	pop    %esi
    2c55:	5f                   	pop    %edi
    2c56:	5d                   	pop    %ebp
    2c57:	c3                   	ret    
    2c58:	90                   	nop
    2c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002c60 <stat>:

int
stat(char *n, struct stat *st)
{
    2c60:	55                   	push   %ebp
    2c61:	89 e5                	mov    %esp,%ebp
    2c63:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c66:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    2c69:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    2c6c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    2c6f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c74:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2c7b:	00 
    2c7c:	89 04 24             	mov    %eax,(%esp)
    2c7f:	e8 e0 00 00 00       	call   2d64 <open>
  if(fd < 0)
    2c84:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c86:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    2c88:	78 19                	js     2ca3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    2c8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c8d:	89 1c 24             	mov    %ebx,(%esp)
    2c90:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c94:	e8 e3 00 00 00       	call   2d7c <fstat>
  close(fd);
    2c99:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    2c9c:	89 c6                	mov    %eax,%esi
  close(fd);
    2c9e:	e8 a9 00 00 00       	call   2d4c <close>
  return r;
}
    2ca3:	89 f0                	mov    %esi,%eax
    2ca5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    2ca8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    2cab:	89 ec                	mov    %ebp,%esp
    2cad:	5d                   	pop    %ebp
    2cae:	c3                   	ret    
    2caf:	90                   	nop

00002cb0 <atoi>:

int
atoi(const char *s)
{
    2cb0:	55                   	push   %ebp
  int n;

  n = 0;
    2cb1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    2cb3:	89 e5                	mov    %esp,%ebp
    2cb5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2cb8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2cb9:	0f b6 11             	movzbl (%ecx),%edx
    2cbc:	8d 5a d0             	lea    -0x30(%edx),%ebx
    2cbf:	80 fb 09             	cmp    $0x9,%bl
    2cc2:	77 1c                	ja     2ce0 <atoi+0x30>
    2cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    2cc8:	0f be d2             	movsbl %dl,%edx
    2ccb:	83 c1 01             	add    $0x1,%ecx
    2cce:	8d 04 80             	lea    (%eax,%eax,4),%eax
    2cd1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2cd5:	0f b6 11             	movzbl (%ecx),%edx
    2cd8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    2cdb:	80 fb 09             	cmp    $0x9,%bl
    2cde:	76 e8                	jbe    2cc8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    2ce0:	5b                   	pop    %ebx
    2ce1:	5d                   	pop    %ebp
    2ce2:	c3                   	ret    
    2ce3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002cf0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    2cf0:	55                   	push   %ebp
    2cf1:	89 e5                	mov    %esp,%ebp
    2cf3:	56                   	push   %esi
    2cf4:	8b 45 08             	mov    0x8(%ebp),%eax
    2cf7:	53                   	push   %ebx
    2cf8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    2cfb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    2cfe:	85 db                	test   %ebx,%ebx
    2d00:	7e 14                	jle    2d16 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    2d02:	31 d2                	xor    %edx,%edx
    2d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    2d08:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    2d0c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    2d0f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    2d12:	39 da                	cmp    %ebx,%edx
    2d14:	75 f2                	jne    2d08 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    2d16:	5b                   	pop    %ebx
    2d17:	5e                   	pop    %esi
    2d18:	5d                   	pop    %ebp
    2d19:	c3                   	ret    
    2d1a:	90                   	nop
    2d1b:	90                   	nop

00002d1c <fork>:
    2d1c:	b8 01 00 00 00       	mov    $0x1,%eax
    2d21:	cd 30                	int    $0x30
    2d23:	c3                   	ret    

00002d24 <exit>:
    2d24:	b8 02 00 00 00       	mov    $0x2,%eax
    2d29:	cd 30                	int    $0x30
    2d2b:	c3                   	ret    

00002d2c <wait>:
    2d2c:	b8 03 00 00 00       	mov    $0x3,%eax
    2d31:	cd 30                	int    $0x30
    2d33:	c3                   	ret    

00002d34 <pipe>:
    2d34:	b8 04 00 00 00       	mov    $0x4,%eax
    2d39:	cd 30                	int    $0x30
    2d3b:	c3                   	ret    

00002d3c <read>:
    2d3c:	b8 06 00 00 00       	mov    $0x6,%eax
    2d41:	cd 30                	int    $0x30
    2d43:	c3                   	ret    

00002d44 <write>:
    2d44:	b8 05 00 00 00       	mov    $0x5,%eax
    2d49:	cd 30                	int    $0x30
    2d4b:	c3                   	ret    

00002d4c <close>:
    2d4c:	b8 07 00 00 00       	mov    $0x7,%eax
    2d51:	cd 30                	int    $0x30
    2d53:	c3                   	ret    

00002d54 <kill>:
    2d54:	b8 08 00 00 00       	mov    $0x8,%eax
    2d59:	cd 30                	int    $0x30
    2d5b:	c3                   	ret    

00002d5c <exec>:
    2d5c:	b8 09 00 00 00       	mov    $0x9,%eax
    2d61:	cd 30                	int    $0x30
    2d63:	c3                   	ret    

00002d64 <open>:
    2d64:	b8 0a 00 00 00       	mov    $0xa,%eax
    2d69:	cd 30                	int    $0x30
    2d6b:	c3                   	ret    

00002d6c <mknod>:
    2d6c:	b8 0b 00 00 00       	mov    $0xb,%eax
    2d71:	cd 30                	int    $0x30
    2d73:	c3                   	ret    

00002d74 <unlink>:
    2d74:	b8 0c 00 00 00       	mov    $0xc,%eax
    2d79:	cd 30                	int    $0x30
    2d7b:	c3                   	ret    

00002d7c <fstat>:
    2d7c:	b8 0d 00 00 00       	mov    $0xd,%eax
    2d81:	cd 30                	int    $0x30
    2d83:	c3                   	ret    

00002d84 <link>:
    2d84:	b8 0e 00 00 00       	mov    $0xe,%eax
    2d89:	cd 30                	int    $0x30
    2d8b:	c3                   	ret    

00002d8c <mkdir>:
    2d8c:	b8 0f 00 00 00       	mov    $0xf,%eax
    2d91:	cd 30                	int    $0x30
    2d93:	c3                   	ret    

00002d94 <chdir>:
    2d94:	b8 10 00 00 00       	mov    $0x10,%eax
    2d99:	cd 30                	int    $0x30
    2d9b:	c3                   	ret    

00002d9c <dup>:
    2d9c:	b8 11 00 00 00       	mov    $0x11,%eax
    2da1:	cd 30                	int    $0x30
    2da3:	c3                   	ret    

00002da4 <getpid>:
    2da4:	b8 12 00 00 00       	mov    $0x12,%eax
    2da9:	cd 30                	int    $0x30
    2dab:	c3                   	ret    

00002dac <sbrk>:
    2dac:	b8 13 00 00 00       	mov    $0x13,%eax
    2db1:	cd 30                	int    $0x30
    2db3:	c3                   	ret    

00002db4 <sleep>:
    2db4:	b8 14 00 00 00       	mov    $0x14,%eax
    2db9:	cd 30                	int    $0x30
    2dbb:	c3                   	ret    
    2dbc:	90                   	nop
    2dbd:	90                   	nop
    2dbe:	90                   	nop
    2dbf:	90                   	nop

00002dc0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    2dc0:	55                   	push   %ebp
    2dc1:	89 e5                	mov    %esp,%ebp
    2dc3:	83 ec 28             	sub    $0x28,%esp
    2dc6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    2dc9:	8d 55 f4             	lea    -0xc(%ebp),%edx
    2dcc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2dd3:	00 
    2dd4:	89 54 24 04          	mov    %edx,0x4(%esp)
    2dd8:	89 04 24             	mov    %eax,(%esp)
    2ddb:	e8 64 ff ff ff       	call   2d44 <write>
}
    2de0:	c9                   	leave  
    2de1:	c3                   	ret    
    2de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002df0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    2df0:	55                   	push   %ebp
    2df1:	89 e5                	mov    %esp,%ebp
    2df3:	57                   	push   %edi
    2df4:	89 c7                	mov    %eax,%edi
    2df6:	56                   	push   %esi
    2df7:	89 ce                	mov    %ecx,%esi
    2df9:	53                   	push   %ebx
    2dfa:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    2dfd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2e00:	85 c9                	test   %ecx,%ecx
    2e02:	74 09                	je     2e0d <printint+0x1d>
    2e04:	89 d0                	mov    %edx,%eax
    2e06:	c1 e8 1f             	shr    $0x1f,%eax
    2e09:	84 c0                	test   %al,%al
    2e0b:	75 53                	jne    2e60 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    2e0d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    2e0f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    2e16:	31 c9                	xor    %ecx,%ecx
    2e18:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    2e1b:	90                   	nop
    2e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    2e20:	31 d2                	xor    %edx,%edx
    2e22:	f7 f6                	div    %esi
    2e24:	0f b6 92 d7 43 00 00 	movzbl 0x43d7(%edx),%edx
    2e2b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    2e2e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    2e31:	85 c0                	test   %eax,%eax
    2e33:	75 eb                	jne    2e20 <printint+0x30>
  if(neg)
    2e35:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2e38:	85 c0                	test   %eax,%eax
    2e3a:	74 08                	je     2e44 <printint+0x54>
    buf[i++] = '-';
    2e3c:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    2e41:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    2e44:	8d 71 ff             	lea    -0x1(%ecx),%esi
    2e47:	90                   	nop
    putc(fd, buf[i]);
    2e48:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
    2e4c:	89 f8                	mov    %edi,%eax
    2e4e:	e8 6d ff ff ff       	call   2dc0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2e53:	83 ee 01             	sub    $0x1,%esi
    2e56:	79 f0                	jns    2e48 <printint+0x58>
    putc(fd, buf[i]);
}
    2e58:	83 c4 2c             	add    $0x2c,%esp
    2e5b:	5b                   	pop    %ebx
    2e5c:	5e                   	pop    %esi
    2e5d:	5f                   	pop    %edi
    2e5e:	5d                   	pop    %ebp
    2e5f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    2e60:	89 d0                	mov    %edx,%eax
    2e62:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    2e64:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    2e6b:	eb a9                	jmp    2e16 <printint+0x26>
    2e6d:	8d 76 00             	lea    0x0(%esi),%esi

00002e70 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2e70:	55                   	push   %ebp
    2e71:	89 e5                	mov    %esp,%ebp
    2e73:	57                   	push   %edi
    2e74:	56                   	push   %esi
    2e75:	53                   	push   %ebx
    2e76:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2e79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    2e7c:	0f b6 0b             	movzbl (%ebx),%ecx
    2e7f:	84 c9                	test   %cl,%cl
    2e81:	0f 84 99 00 00 00    	je     2f20 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    2e87:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    2e8a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
    2e8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2e8f:	eb 26                	jmp    2eb7 <printf+0x47>
    2e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    2e98:	83 f9 25             	cmp    $0x25,%ecx
    2e9b:	0f 84 87 00 00 00    	je     2f28 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
    2ea1:	8b 45 08             	mov    0x8(%ebp),%eax
    2ea4:	0f be d1             	movsbl %cl,%edx
    2ea7:	e8 14 ff ff ff       	call   2dc0 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2eac:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    2eb0:	83 c3 01             	add    $0x1,%ebx
    2eb3:	84 c9                	test   %cl,%cl
    2eb5:	74 69                	je     2f20 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
    2eb7:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    2eb9:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
    2ebc:	74 da                	je     2e98 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    2ebe:	83 fe 25             	cmp    $0x25,%esi
    2ec1:	75 e9                	jne    2eac <printf+0x3c>
      if(c == 'd'){
    2ec3:	83 f9 64             	cmp    $0x64,%ecx
    2ec6:	0f 84 f4 00 00 00    	je     2fc0 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2ecc:	83 f9 70             	cmp    $0x70,%ecx
    2ecf:	90                   	nop
    2ed0:	74 66                	je     2f38 <printf+0xc8>
    2ed2:	83 f9 78             	cmp    $0x78,%ecx
    2ed5:	74 61                	je     2f38 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2ed7:	83 f9 73             	cmp    $0x73,%ecx
    2eda:	0f 84 80 00 00 00    	je     2f60 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2ee0:	83 f9 63             	cmp    $0x63,%ecx
    2ee3:	0f 84 f9 00 00 00    	je     2fe2 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    2ee9:	83 f9 25             	cmp    $0x25,%ecx
    2eec:	0f 84 b6 00 00 00    	je     2fa8 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2ef2:	8b 45 08             	mov    0x8(%ebp),%eax
    2ef5:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
    2efa:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2efc:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    2eff:	e8 bc fe ff ff       	call   2dc0 <putc>
        putc(fd, c);
    2f04:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2f07:	8b 45 08             	mov    0x8(%ebp),%eax
    2f0a:	0f be d1             	movsbl %cl,%edx
    2f0d:	e8 ae fe ff ff       	call   2dc0 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2f12:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    2f16:	83 c3 01             	add    $0x1,%ebx
    2f19:	84 c9                	test   %cl,%cl
    2f1b:	75 9a                	jne    2eb7 <printf+0x47>
    2f1d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2f20:	83 c4 2c             	add    $0x2c,%esp
    2f23:	5b                   	pop    %ebx
    2f24:	5e                   	pop    %esi
    2f25:	5f                   	pop    %edi
    2f26:	5d                   	pop    %ebp
    2f27:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    2f28:	be 25 00 00 00       	mov    $0x25,%esi
    2f2d:	e9 7a ff ff ff       	jmp    2eac <printf+0x3c>
    2f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2f38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f3b:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2f40:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2f42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f49:	8b 10                	mov    (%eax),%edx
    2f4b:	8b 45 08             	mov    0x8(%ebp),%eax
    2f4e:	e8 9d fe ff ff       	call   2df0 <printint>
        ap++;
    2f53:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2f57:	e9 50 ff ff ff       	jmp    2eac <printf+0x3c>
    2f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    2f60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f63:	8b 38                	mov    (%eax),%edi
        ap++;
    2f65:	83 c0 04             	add    $0x4,%eax
    2f68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
    2f6b:	b8 d0 43 00 00       	mov    $0x43d0,%eax
    2f70:	85 ff                	test   %edi,%edi
    2f72:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2f75:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2f77:	0f b6 17             	movzbl (%edi),%edx
    2f7a:	84 d2                	test   %dl,%dl
    2f7c:	0f 84 2a ff ff ff    	je     2eac <printf+0x3c>
    2f82:	89 de                	mov    %ebx,%esi
    2f84:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2f87:	90                   	nop
          putc(fd, *s);
    2f88:	0f be d2             	movsbl %dl,%edx
          s++;
    2f8b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
    2f8e:	89 d8                	mov    %ebx,%eax
    2f90:	e8 2b fe ff ff       	call   2dc0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2f95:	0f b6 17             	movzbl (%edi),%edx
    2f98:	84 d2                	test   %dl,%dl
    2f9a:	75 ec                	jne    2f88 <printf+0x118>
    2f9c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2f9e:	31 f6                	xor    %esi,%esi
    2fa0:	e9 07 ff ff ff       	jmp    2eac <printf+0x3c>
    2fa5:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    2fa8:	8b 45 08             	mov    0x8(%ebp),%eax
    2fab:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2fb0:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    2fb2:	e8 09 fe ff ff       	call   2dc0 <putc>
    2fb7:	e9 f0 fe ff ff       	jmp    2eac <printf+0x3c>
    2fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    2fc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2fc3:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2fc5:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    2fc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fcf:	8b 10                	mov    (%eax),%edx
    2fd1:	8b 45 08             	mov    0x8(%ebp),%eax
    2fd4:	e8 17 fe ff ff       	call   2df0 <printint>
        ap++;
    2fd9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2fdd:	e9 ca fe ff ff       	jmp    2eac <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    2fe2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2fe5:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    2fe7:	0f be 10             	movsbl (%eax),%edx
    2fea:	8b 45 08             	mov    0x8(%ebp),%eax
    2fed:	e8 ce fd ff ff       	call   2dc0 <putc>
        ap++;
    2ff2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2ff6:	e9 b1 fe ff ff       	jmp    2eac <printf+0x3c>
    2ffb:	90                   	nop
    2ffc:	90                   	nop
    2ffd:	90                   	nop
    2ffe:	90                   	nop
    2fff:	90                   	nop

00003000 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3000:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3001:	a1 20 44 00 00       	mov    0x4420,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    3006:	89 e5                	mov    %esp,%ebp
    3008:	57                   	push   %edi
    3009:	56                   	push   %esi
    300a:	53                   	push   %ebx
    300b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    300e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3011:	39 c8                	cmp    %ecx,%eax
    3013:	73 1d                	jae    3032 <free+0x32>
    3015:	8d 76 00             	lea    0x0(%esi),%esi
    3018:	8b 10                	mov    (%eax),%edx
    301a:	39 d1                	cmp    %edx,%ecx
    301c:	72 1a                	jb     3038 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    301e:	39 d0                	cmp    %edx,%eax
    3020:	72 08                	jb     302a <free+0x2a>
    3022:	39 c8                	cmp    %ecx,%eax
    3024:	72 12                	jb     3038 <free+0x38>
    3026:	39 d1                	cmp    %edx,%ecx
    3028:	72 0e                	jb     3038 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
    302a:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    302c:	39 c8                	cmp    %ecx,%eax
    302e:	66 90                	xchg   %ax,%ax
    3030:	72 e6                	jb     3018 <free+0x18>
    3032:	8b 10                	mov    (%eax),%edx
    3034:	eb e8                	jmp    301e <free+0x1e>
    3036:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3038:	8b 71 04             	mov    0x4(%ecx),%esi
    303b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    303e:	39 d7                	cmp    %edx,%edi
    3040:	74 19                	je     305b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3042:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3045:	8b 50 04             	mov    0x4(%eax),%edx
    3048:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    304b:	39 ce                	cmp    %ecx,%esi
    304d:	74 21                	je     3070 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    304f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3051:	a3 20 44 00 00       	mov    %eax,0x4420
}
    3056:	5b                   	pop    %ebx
    3057:	5e                   	pop    %esi
    3058:	5f                   	pop    %edi
    3059:	5d                   	pop    %ebp
    305a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    305b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    305e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3060:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3063:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3066:	8b 50 04             	mov    0x4(%eax),%edx
    3069:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    306c:	39 ce                	cmp    %ecx,%esi
    306e:	75 df                	jne    304f <free+0x4f>
    p->s.size += bp->s.size;
    3070:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    3073:	a3 20 44 00 00       	mov    %eax,0x4420
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3078:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    307b:	8b 53 f8             	mov    -0x8(%ebx),%edx
    307e:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3080:	5b                   	pop    %ebx
    3081:	5e                   	pop    %esi
    3082:	5f                   	pop    %edi
    3083:	5d                   	pop    %ebp
    3084:	c3                   	ret    
    3085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003090 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3090:	55                   	push   %ebp
    3091:	89 e5                	mov    %esp,%ebp
    3093:	57                   	push   %edi
    3094:	56                   	push   %esi
    3095:	53                   	push   %ebx
    3096:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3099:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    309c:	8b 35 20 44 00 00    	mov    0x4420,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    30a2:	83 c3 07             	add    $0x7,%ebx
    30a5:	c1 eb 03             	shr    $0x3,%ebx
    30a8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    30ab:	85 f6                	test   %esi,%esi
    30ad:	0f 84 ab 00 00 00    	je     315e <malloc+0xce>
    30b3:	8b 16                	mov    (%esi),%edx
    30b5:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    30b8:	39 d9                	cmp    %ebx,%ecx
    30ba:	0f 83 c6 00 00 00    	jae    3186 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    30c0:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    30c7:	be 00 80 00 00       	mov    $0x8000,%esi
    30cc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    30cf:	eb 09                	jmp    30da <malloc+0x4a>
    30d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    30d8:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
    30da:	3b 15 20 44 00 00    	cmp    0x4420,%edx
    30e0:	74 2e                	je     3110 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    30e2:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    30e4:	8b 48 04             	mov    0x4(%eax),%ecx
    30e7:	39 cb                	cmp    %ecx,%ebx
    30e9:	77 ed                	ja     30d8 <malloc+0x48>
    30eb:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
    30ed:	39 cb                	cmp    %ecx,%ebx
    30ef:	74 67                	je     3158 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    30f1:	29 d9                	sub    %ebx,%ecx
    30f3:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    30f6:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    30f9:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    30fc:	89 35 20 44 00 00    	mov    %esi,0x4420
      return (void*) (p + 1);
    3102:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3105:	83 c4 2c             	add    $0x2c,%esp
    3108:	5b                   	pop    %ebx
    3109:	5e                   	pop    %esi
    310a:	5f                   	pop    %edi
    310b:	5d                   	pop    %ebp
    310c:	c3                   	ret    
    310d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    3110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3113:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    3119:	bf 00 10 00 00       	mov    $0x1000,%edi
    311e:	0f 47 fb             	cmova  %ebx,%edi
    3121:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    3124:	89 04 24             	mov    %eax,(%esp)
    3127:	e8 80 fc ff ff       	call   2dac <sbrk>
  if(p == (char*) -1)
    312c:	83 f8 ff             	cmp    $0xffffffff,%eax
    312f:	74 18                	je     3149 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3131:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    3134:	83 c0 08             	add    $0x8,%eax
    3137:	89 04 24             	mov    %eax,(%esp)
    313a:	e8 c1 fe ff ff       	call   3000 <free>
  return freep;
    313f:	8b 15 20 44 00 00    	mov    0x4420,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3145:	85 d2                	test   %edx,%edx
    3147:	75 99                	jne    30e2 <malloc+0x52>
        return 0;
  }
}
    3149:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
    314c:	31 c0                	xor    %eax,%eax
  }
}
    314e:	5b                   	pop    %ebx
    314f:	5e                   	pop    %esi
    3150:	5f                   	pop    %edi
    3151:	5d                   	pop    %ebp
    3152:	c3                   	ret    
    3153:	90                   	nop
    3154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3158:	8b 10                	mov    (%eax),%edx
    315a:	89 16                	mov    %edx,(%esi)
    315c:	eb 9e                	jmp    30fc <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    315e:	c7 05 20 44 00 00 24 	movl   $0x4424,0x4420
    3165:	44 00 00 
    base.s.size = 0;
    3168:	ba 24 44 00 00       	mov    $0x4424,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    316d:	c7 05 24 44 00 00 24 	movl   $0x4424,0x4424
    3174:	44 00 00 
    base.s.size = 0;
    3177:	c7 05 28 44 00 00 00 	movl   $0x0,0x4428
    317e:	00 00 00 
    3181:	e9 3a ff ff ff       	jmp    30c0 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3186:	89 d0                	mov    %edx,%eax
    3188:	e9 60 ff ff ff       	jmp    30ed <malloc+0x5d>
