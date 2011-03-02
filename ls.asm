
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   b:	89 1c 24             	mov    %ebx,(%esp)
   e:	e8 cd 03 00 00       	call   3e0 <strlen>
  13:	01 d8                	add    %ebx,%eax
  15:	73 10                	jae    27 <fmtname+0x27>
  17:	eb 13                	jmp    2c <fmtname+0x2c>
  19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  20:	83 e8 01             	sub    $0x1,%eax
  23:	39 c3                	cmp    %eax,%ebx
  25:	77 05                	ja     2c <fmtname+0x2c>
  27:	80 38 2f             	cmpb   $0x2f,(%eax)
  2a:	75 f4                	jne    20 <fmtname+0x20>
    ;
  p++;
  2c:	8d 58 01             	lea    0x1(%eax),%ebx
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2f:	89 1c 24             	mov    %ebx,(%esp)
  32:	e8 a9 03 00 00       	call   3e0 <strlen>
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	77 53                	ja     8f <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
  3c:	89 1c 24             	mov    %ebx,(%esp)
  3f:	e8 9c 03 00 00       	call   3e0 <strlen>
  44:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  48:	c7 04 24 70 0a 00 00 	movl   $0xa70,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 18 05 00 00       	call   570 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  58:	89 1c 24             	mov    %ebx,(%esp)
  5b:	e8 80 03 00 00       	call   3e0 <strlen>
  60:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  63:	bb 70 0a 00 00       	mov    $0xa70,%ebx
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  68:	89 c6                	mov    %eax,%esi
  6a:	e8 71 03 00 00       	call   3e0 <strlen>
  6f:	ba 0e 00 00 00       	mov    $0xe,%edx
  74:	29 f2                	sub    %esi,%edx
  76:	89 54 24 08          	mov    %edx,0x8(%esp)
  7a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  81:	00 
  82:	05 70 0a 00 00       	add    $0xa70,%eax
  87:	89 04 24             	mov    %eax,(%esp)
  8a:	e8 71 03 00 00       	call   400 <memset>
  return buf;
}
  8f:	83 c4 10             	add    $0x10,%esp
  92:	89 d8                	mov    %ebx,%eax
  94:	5b                   	pop    %ebx
  95:	5e                   	pop    %esi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    
  98:	90                   	nop
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000a0 <ls>:

void
ls(char *path)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  b6:	00 
  b7:	89 3c 24             	mov    %edi,(%esp)
  ba:	e8 25 05 00 00       	call   5e4 <open>
  bf:	85 c0                	test   %eax,%eax
  c1:	89 c3                	mov    %eax,%ebx
  c3:	0f 88 c7 01 00 00    	js     290 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
  c9:	8d 75 c8             	lea    -0x38(%ebp),%esi
  cc:	89 74 24 04          	mov    %esi,0x4(%esp)
  d0:	89 04 24             	mov    %eax,(%esp)
  d3:	e8 24 05 00 00       	call   5fc <fstat>
  d8:	85 c0                	test   %eax,%eax
  da:	0f 88 00 02 00 00    	js     2e0 <ls+0x240>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
  e0:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  e4:	66 83 f8 01          	cmp    $0x1,%ax
  e8:	74 66                	je     150 <ls+0xb0>
  ea:	66 83 f8 02          	cmp    $0x2,%ax
  ee:	74 18                	je     108 <ls+0x68>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
  f0:	89 1c 24             	mov    %ebx,(%esp)
  f3:	e8 d4 04 00 00       	call   5cc <close>
}
  f8:	81 c4 5c 02 00 00    	add    $0x25c,%esp
  fe:	5b                   	pop    %ebx
  ff:	5e                   	pop    %esi
 100:	5f                   	pop    %edi
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	90                   	nop
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  
  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 108:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 10b:	8b 75 cc             	mov    -0x34(%ebp),%esi
 10e:	89 3c 24             	mov    %edi,(%esp)
 111:	89 95 bc fd ff ff    	mov    %edx,-0x244(%ebp)
 117:	e8 e4 fe ff ff       	call   0 <fmtname>
 11c:	8b 95 bc fd ff ff    	mov    -0x244(%ebp),%edx
 122:	89 74 24 10          	mov    %esi,0x10(%esp)
 126:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 12d:	00 
 12e:	c7 44 24 04 35 0a 00 	movl   $0xa35,0x4(%esp)
 135:	00 
 136:	89 54 24 14          	mov    %edx,0x14(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 a6 05 00 00       	call   6f0 <printf>
    break;
 14a:	eb a4                	jmp    f0 <ls+0x50>
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 150:	89 3c 24             	mov    %edi,(%esp)
 153:	e8 88 02 00 00       	call   3e0 <strlen>
 158:	83 c0 10             	add    $0x10,%eax
 15b:	3d 00 02 00 00       	cmp    $0x200,%eax
 160:	0f 87 0a 01 00 00    	ja     270 <ls+0x1d0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 166:	8d 85 c8 fd ff ff    	lea    -0x238(%ebp),%eax
 16c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 170:	8d 7d d8             	lea    -0x28(%ebp),%edi
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 e5 01 00 00       	call   360 <strcpy>
    p = buf+strlen(buf);
 17b:	8d 95 c8 fd ff ff    	lea    -0x238(%ebp),%edx
 181:	89 14 24             	mov    %edx,(%esp)
 184:	e8 57 02 00 00       	call   3e0 <strlen>
 189:	8d 95 c8 fd ff ff    	lea    -0x238(%ebp),%edx
 18f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
 192:	c6 00 2f             	movb   $0x2f,(%eax)
 195:	83 c0 01             	add    $0x1,%eax
 198:	89 85 c4 fd ff ff    	mov    %eax,-0x23c(%ebp)
 19e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1a7:	00 
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	89 1c 24             	mov    %ebx,(%esp)
 1af:	e8 08 04 00 00       	call   5bc <read>
 1b4:	83 f8 10             	cmp    $0x10,%eax
 1b7:	0f 85 33 ff ff ff    	jne    f0 <ls+0x50>
      if(de.inum == 0)
 1bd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
 1c2:	74 dc                	je     1a0 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
 1c4:	8b 95 c4 fd ff ff    	mov    -0x23c(%ebp),%edx
 1ca:	8d 45 da             	lea    -0x26(%ebp),%eax
 1cd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 1d4:	00 
 1d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d9:	89 14 24             	mov    %edx,(%esp)
 1dc:	e8 8f 03 00 00       	call   570 <memmove>
      p[DIRSIZ] = 0;
 1e1:	8b 85 c4 fd ff ff    	mov    -0x23c(%ebp),%eax
      if(stat(buf, &st) < 0){
 1e7:	8d 95 c8 fd ff ff    	lea    -0x238(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 1ed:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
 1f1:	89 74 24 04          	mov    %esi,0x4(%esp)
 1f5:	89 14 24             	mov    %edx,(%esp)
 1f8:	e8 e3 02 00 00       	call   4e0 <stat>
 1fd:	85 c0                	test   %eax,%eax
 1ff:	0f 88 b3 00 00 00    	js     2b8 <ls+0x218>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 205:	0f bf 45 d0          	movswl -0x30(%ebp),%eax
 209:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 20c:	8b 4d cc             	mov    -0x34(%ebp),%ecx
 20f:	89 85 c0 fd ff ff    	mov    %eax,-0x240(%ebp)
 215:	8d 85 c8 fd ff ff    	lea    -0x238(%ebp),%eax
 21b:	89 95 bc fd ff ff    	mov    %edx,-0x244(%ebp)
 221:	89 8d b8 fd ff ff    	mov    %ecx,-0x248(%ebp)
 227:	89 04 24             	mov    %eax,(%esp)
 22a:	e8 d1 fd ff ff       	call   0 <fmtname>
 22f:	8b 95 bc fd ff ff    	mov    -0x244(%ebp),%edx
 235:	8b 8d b8 fd ff ff    	mov    -0x248(%ebp),%ecx
 23b:	c7 44 24 04 35 0a 00 	movl   $0xa35,0x4(%esp)
 242:	00 
 243:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 24a:	89 54 24 14          	mov    %edx,0x14(%esp)
 24e:	8b 95 c0 fd ff ff    	mov    -0x240(%ebp),%edx
 254:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 258:	89 44 24 08          	mov    %eax,0x8(%esp)
 25c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 260:	e8 8b 04 00 00       	call   6f0 <printf>
 265:	e9 36 ff ff ff       	jmp    1a0 <ls+0x100>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 270:	c7 44 24 04 42 0a 00 	movl   $0xa42,0x4(%esp)
 277:	00 
 278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27f:	e8 6c 04 00 00       	call   6f0 <printf>
      break;
 284:	e9 67 fe ff ff       	jmp    f0 <ls+0x50>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 290:	89 7c 24 08          	mov    %edi,0x8(%esp)
 294:	c7 44 24 04 0d 0a 00 	movl   $0xa0d,0x4(%esp)
 29b:	00 
 29c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2a3:	e8 48 04 00 00       	call   6f0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2a8:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 2ae:	5b                   	pop    %ebx
 2af:	5e                   	pop    %esi
 2b0:	5f                   	pop    %edi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2b8:	8d 85 c8 fd ff ff    	lea    -0x238(%ebp),%eax
 2be:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c2:	c7 44 24 04 21 0a 00 	movl   $0xa21,0x4(%esp)
 2c9:	00 
 2ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d1:	e8 1a 04 00 00       	call   6f0 <printf>
        continue;
 2d6:	e9 c5 fe ff ff       	jmp    1a0 <ls+0x100>
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2e4:	c7 44 24 04 21 0a 00 	movl   $0xa21,0x4(%esp)
 2eb:	00 
 2ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f3:	e8 f8 03 00 00       	call   6f0 <printf>
    close(fd);
 2f8:	89 1c 24             	mov    %ebx,(%esp)
 2fb:	e8 cc 02 00 00       	call   5cc <close>
    return;
 300:	e9 f3 fd ff ff       	jmp    f8 <ls+0x58>
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 e4 f0             	and    $0xfffffff0,%esp
 316:	57                   	push   %edi
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
  int i;

  if(argc < 2){
 319:	bb 01 00 00 00       	mov    $0x1,%ebx
  close(fd);
}

int
main(int argc, char *argv[])
{
 31e:	83 ec 14             	sub    $0x14,%esp
 321:	8b 75 08             	mov    0x8(%ebp),%esi
 324:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
 327:	83 fe 01             	cmp    $0x1,%esi
 32a:	7e 1c                	jle    348 <main+0x38>
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 330:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 333:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
 336:	89 04 24             	mov    %eax,(%esp)
 339:	e8 62 fd ff ff       	call   a0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 33e:	39 de                	cmp    %ebx,%esi
 340:	7f ee                	jg     330 <main+0x20>
    ls(argv[i]);
  exit();
 342:	e8 5d 02 00 00       	call   5a4 <exit>
 347:	90                   	nop
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
 348:	c7 04 24 55 0a 00 00 	movl   $0xa55,(%esp)
 34f:	e8 4c fd ff ff       	call   a0 <ls>
    exit();
 354:	e8 4b 02 00 00       	call   5a4 <exit>
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 360:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 361:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 363:	89 e5                	mov    %esp,%ebp
 365:	8b 45 08             	mov    0x8(%ebp),%eax
 368:	53                   	push   %ebx
 369:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 370:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 374:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 377:	83 c2 01             	add    $0x1,%edx
 37a:	84 c9                	test   %cl,%cl
 37c:	75 f2                	jne    370 <strcpy+0x10>
    ;
  return os;
}
 37e:	5b                   	pop    %ebx
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	eb 0d                	jmp    390 <strcmp>
 383:	90                   	nop
 384:	90                   	nop
 385:	90                   	nop
 386:	90                   	nop
 387:	90                   	nop
 388:	90                   	nop
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop
 38c:	90                   	nop
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 08             	mov    0x8(%ebp),%ecx
 396:	53                   	push   %ebx
 397:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 39a:	0f b6 01             	movzbl (%ecx),%eax
 39d:	84 c0                	test   %al,%al
 39f:	75 14                	jne    3b5 <strcmp+0x25>
 3a1:	eb 25                	jmp    3c8 <strcmp+0x38>
 3a3:	90                   	nop
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 3a8:	83 c1 01             	add    $0x1,%ecx
 3ab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3ae:	0f b6 01             	movzbl (%ecx),%eax
 3b1:	84 c0                	test   %al,%al
 3b3:	74 13                	je     3c8 <strcmp+0x38>
 3b5:	0f b6 1a             	movzbl (%edx),%ebx
 3b8:	38 d8                	cmp    %bl,%al
 3ba:	74 ec                	je     3a8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3bc:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3bf:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3c2:	29 d8                	sub    %ebx,%eax
}
 3c4:	5b                   	pop    %ebx
 3c5:	5d                   	pop    %ebp
 3c6:	c3                   	ret    
 3c7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3c8:	0f b6 1a             	movzbl (%edx),%ebx
 3cb:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3cd:	0f b6 db             	movzbl %bl,%ebx
 3d0:	29 d8                	sub    %ebx,%eax
}
 3d2:	5b                   	pop    %ebx
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    
 3d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <strlen>:

uint
strlen(char *s)
{
 3e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3e1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3e3:	89 e5                	mov    %esp,%ebp
 3e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3e8:	80 39 00             	cmpb   $0x0,(%ecx)
 3eb:	74 0e                	je     3fb <strlen+0x1b>
 3ed:	31 d2                	xor    %edx,%edx
 3ef:	90                   	nop
 3f0:	83 c2 01             	add    $0x1,%edx
 3f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3f7:	89 d0                	mov    %edx,%eax
 3f9:	75 f5                	jne    3f0 <strlen+0x10>
    ;
  return n;
}
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi

00000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 4d 10             	mov    0x10(%ebp),%ecx
 406:	53                   	push   %ebx
 407:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 40a:	85 c9                	test   %ecx,%ecx
 40c:	74 14                	je     422 <memset+0x22>
 40e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 412:	31 d2                	xor    %edx,%edx
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 418:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 41b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 41e:	39 ca                	cmp    %ecx,%edx
 420:	75 f6                	jne    418 <memset+0x18>
    *d++ = c;
  return dst;
}
 422:	5b                   	pop    %ebx
 423:	5d                   	pop    %ebp
 424:	c3                   	ret    
 425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <strchr>:

char*
strchr(const char *s, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 43a:	0f b6 10             	movzbl (%eax),%edx
 43d:	84 d2                	test   %dl,%dl
 43f:	75 11                	jne    452 <strchr+0x22>
 441:	eb 15                	jmp    458 <strchr+0x28>
 443:	90                   	nop
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 448:	83 c0 01             	add    $0x1,%eax
 44b:	0f b6 10             	movzbl (%eax),%edx
 44e:	84 d2                	test   %dl,%dl
 450:	74 06                	je     458 <strchr+0x28>
    if(*s == c)
 452:	38 ca                	cmp    %cl,%dl
 454:	75 f2                	jne    448 <strchr+0x18>
      return (char*) s;
  return 0;
}
 456:	5d                   	pop    %ebp
 457:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 458:	31 c0                	xor    %eax,%eax
}
 45a:	5d                   	pop    %ebp
 45b:	90                   	nop
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	c3                   	ret    
 461:	eb 0d                	jmp    470 <gets>
 463:	90                   	nop
 464:	90                   	nop
 465:	90                   	nop
 466:	90                   	nop
 467:	90                   	nop
 468:	90                   	nop
 469:	90                   	nop
 46a:	90                   	nop
 46b:	90                   	nop
 46c:	90                   	nop
 46d:	90                   	nop
 46e:	90                   	nop
 46f:	90                   	nop

00000470 <gets>:

char*
gets(char *buf, int max)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 475:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 477:	53                   	push   %ebx
 478:	83 ec 2c             	sub    $0x2c,%esp
 47b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 47e:	eb 31                	jmp    4b1 <gets+0x41>
    cc = read(0, &c, 1);
 480:	8d 45 e7             	lea    -0x19(%ebp),%eax
 483:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48a:	00 
 48b:	89 44 24 04          	mov    %eax,0x4(%esp)
 48f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 496:	e8 21 01 00 00       	call   5bc <read>
    if(cc < 1)
 49b:	85 c0                	test   %eax,%eax
 49d:	7e 1a                	jle    4b9 <gets+0x49>
      break;
    buf[i++] = c;
 49f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 4a3:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 4a5:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 4a9:	74 1d                	je     4c8 <gets+0x58>
 4ab:	3c 0a                	cmp    $0xa,%al
 4ad:	74 19                	je     4c8 <gets+0x58>
 4af:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b1:	8d 5e 01             	lea    0x1(%esi),%ebx
 4b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4b7:	7c c7                	jl     480 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4b9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4bd:	89 f8                	mov    %edi,%eax
 4bf:	83 c4 2c             	add    $0x2c,%esp
 4c2:	5b                   	pop    %ebx
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret    
 4c7:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 4ca:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4cc:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4d0:	83 c4 2c             	add    $0x2c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
 4d8:	90                   	nop
 4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004e0 <stat>:

int
stat(char *n, struct stat *st)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4fb:	00 
 4fc:	89 04 24             	mov    %eax,(%esp)
 4ff:	e8 e0 00 00 00       	call   5e4 <open>
  if(fd < 0)
 504:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 506:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 508:	78 19                	js     523 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
 50d:	89 1c 24             	mov    %ebx,(%esp)
 510:	89 44 24 04          	mov    %eax,0x4(%esp)
 514:	e8 e3 00 00 00       	call   5fc <fstat>
  close(fd);
 519:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 51c:	89 c6                	mov    %eax,%esi
  close(fd);
 51e:	e8 a9 00 00 00       	call   5cc <close>
  return r;
}
 523:	89 f0                	mov    %esi,%eax
 525:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 528:	8b 75 fc             	mov    -0x4(%ebp),%esi
 52b:	89 ec                	mov    %ebp,%esp
 52d:	5d                   	pop    %ebp
 52e:	c3                   	ret    
 52f:	90                   	nop

00000530 <atoi>:

int
atoi(const char *s)
{
 530:	55                   	push   %ebp
  int n;

  n = 0;
 531:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 533:	89 e5                	mov    %esp,%ebp
 535:	8b 4d 08             	mov    0x8(%ebp),%ecx
 538:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 539:	0f b6 11             	movzbl (%ecx),%edx
 53c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 53f:	80 fb 09             	cmp    $0x9,%bl
 542:	77 1c                	ja     560 <atoi+0x30>
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 548:	0f be d2             	movsbl %dl,%edx
 54b:	83 c1 01             	add    $0x1,%ecx
 54e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 551:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 555:	0f b6 11             	movzbl (%ecx),%edx
 558:	8d 5a d0             	lea    -0x30(%edx),%ebx
 55b:	80 fb 09             	cmp    $0x9,%bl
 55e:	76 e8                	jbe    548 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 560:	5b                   	pop    %ebx
 561:	5d                   	pop    %ebp
 562:	c3                   	ret    
 563:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000570 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	56                   	push   %esi
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	53                   	push   %ebx
 578:	8b 5d 10             	mov    0x10(%ebp),%ebx
 57b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 57e:	85 db                	test   %ebx,%ebx
 580:	7e 14                	jle    596 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 582:	31 d2                	xor    %edx,%edx
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 588:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 58c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 58f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 592:	39 da                	cmp    %ebx,%edx
 594:	75 f2                	jne    588 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 596:	5b                   	pop    %ebx
 597:	5e                   	pop    %esi
 598:	5d                   	pop    %ebp
 599:	c3                   	ret    
 59a:	90                   	nop
 59b:	90                   	nop

0000059c <fork>:
 59c:	b8 01 00 00 00       	mov    $0x1,%eax
 5a1:	cd 30                	int    $0x30
 5a3:	c3                   	ret    

000005a4 <exit>:
 5a4:	b8 02 00 00 00       	mov    $0x2,%eax
 5a9:	cd 30                	int    $0x30
 5ab:	c3                   	ret    

000005ac <wait>:
 5ac:	b8 03 00 00 00       	mov    $0x3,%eax
 5b1:	cd 30                	int    $0x30
 5b3:	c3                   	ret    

000005b4 <pipe>:
 5b4:	b8 04 00 00 00       	mov    $0x4,%eax
 5b9:	cd 30                	int    $0x30
 5bb:	c3                   	ret    

000005bc <read>:
 5bc:	b8 06 00 00 00       	mov    $0x6,%eax
 5c1:	cd 30                	int    $0x30
 5c3:	c3                   	ret    

000005c4 <write>:
 5c4:	b8 05 00 00 00       	mov    $0x5,%eax
 5c9:	cd 30                	int    $0x30
 5cb:	c3                   	ret    

000005cc <close>:
 5cc:	b8 07 00 00 00       	mov    $0x7,%eax
 5d1:	cd 30                	int    $0x30
 5d3:	c3                   	ret    

000005d4 <kill>:
 5d4:	b8 08 00 00 00       	mov    $0x8,%eax
 5d9:	cd 30                	int    $0x30
 5db:	c3                   	ret    

000005dc <exec>:
 5dc:	b8 09 00 00 00       	mov    $0x9,%eax
 5e1:	cd 30                	int    $0x30
 5e3:	c3                   	ret    

000005e4 <open>:
 5e4:	b8 0a 00 00 00       	mov    $0xa,%eax
 5e9:	cd 30                	int    $0x30
 5eb:	c3                   	ret    

000005ec <mknod>:
 5ec:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f1:	cd 30                	int    $0x30
 5f3:	c3                   	ret    

000005f4 <unlink>:
 5f4:	b8 0c 00 00 00       	mov    $0xc,%eax
 5f9:	cd 30                	int    $0x30
 5fb:	c3                   	ret    

000005fc <fstat>:
 5fc:	b8 0d 00 00 00       	mov    $0xd,%eax
 601:	cd 30                	int    $0x30
 603:	c3                   	ret    

00000604 <link>:
 604:	b8 0e 00 00 00       	mov    $0xe,%eax
 609:	cd 30                	int    $0x30
 60b:	c3                   	ret    

0000060c <mkdir>:
 60c:	b8 0f 00 00 00       	mov    $0xf,%eax
 611:	cd 30                	int    $0x30
 613:	c3                   	ret    

00000614 <chdir>:
 614:	b8 10 00 00 00       	mov    $0x10,%eax
 619:	cd 30                	int    $0x30
 61b:	c3                   	ret    

0000061c <dup>:
 61c:	b8 11 00 00 00       	mov    $0x11,%eax
 621:	cd 30                	int    $0x30
 623:	c3                   	ret    

00000624 <getpid>:
 624:	b8 12 00 00 00       	mov    $0x12,%eax
 629:	cd 30                	int    $0x30
 62b:	c3                   	ret    

0000062c <sbrk>:
 62c:	b8 13 00 00 00       	mov    $0x13,%eax
 631:	cd 30                	int    $0x30
 633:	c3                   	ret    

00000634 <sleep>:
 634:	b8 14 00 00 00       	mov    $0x14,%eax
 639:	cd 30                	int    $0x30
 63b:	c3                   	ret    
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop

00000640 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	83 ec 28             	sub    $0x28,%esp
 646:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 649:	8d 55 f4             	lea    -0xc(%ebp),%edx
 64c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 653:	00 
 654:	89 54 24 04          	mov    %edx,0x4(%esp)
 658:	89 04 24             	mov    %eax,(%esp)
 65b:	e8 64 ff ff ff       	call   5c4 <write>
}
 660:	c9                   	leave  
 661:	c3                   	ret    
 662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	89 c7                	mov    %eax,%edi
 676:	56                   	push   %esi
 677:	89 ce                	mov    %ecx,%esi
 679:	53                   	push   %ebx
 67a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 67d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 680:	85 c9                	test   %ecx,%ecx
 682:	74 09                	je     68d <printint+0x1d>
 684:	89 d0                	mov    %edx,%eax
 686:	c1 e8 1f             	shr    $0x1f,%eax
 689:	84 c0                	test   %al,%al
 68b:	75 53                	jne    6e0 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 68d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 68f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 696:	31 c9                	xor    %ecx,%ecx
 698:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 69b:	90                   	nop
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 6a0:	31 d2                	xor    %edx,%edx
 6a2:	f7 f6                	div    %esi
 6a4:	0f b6 92 5e 0a 00 00 	movzbl 0xa5e(%edx),%edx
 6ab:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 6ae:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 6b1:	85 c0                	test   %eax,%eax
 6b3:	75 eb                	jne    6a0 <printint+0x30>
  if(neg)
 6b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6b8:	85 c0                	test   %eax,%eax
 6ba:	74 08                	je     6c4 <printint+0x54>
    buf[i++] = '-';
 6bc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6c1:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 6c4:	8d 71 ff             	lea    -0x1(%ecx),%esi
 6c7:	90                   	nop
    putc(fd, buf[i]);
 6c8:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 6cc:	89 f8                	mov    %edi,%eax
 6ce:	e8 6d ff ff ff       	call   640 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6d3:	83 ee 01             	sub    $0x1,%esi
 6d6:	79 f0                	jns    6c8 <printint+0x58>
    putc(fd, buf[i]);
}
 6d8:	83 c4 2c             	add    $0x2c,%esp
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6e0:	89 d0                	mov    %edx,%eax
 6e2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 6e4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 6eb:	eb a9                	jmp    696 <printint+0x26>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi

000006f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6fc:	0f b6 0b             	movzbl (%ebx),%ecx
 6ff:	84 c9                	test   %cl,%cl
 701:	0f 84 99 00 00 00    	je     7a0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 707:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 70a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 70c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 70f:	eb 26                	jmp    737 <printf+0x47>
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 718:	83 f9 25             	cmp    $0x25,%ecx
 71b:	0f 84 87 00 00 00    	je     7a8 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 721:	8b 45 08             	mov    0x8(%ebp),%eax
 724:	0f be d1             	movsbl %cl,%edx
 727:	e8 14 ff ff ff       	call   640 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 730:	83 c3 01             	add    $0x1,%ebx
 733:	84 c9                	test   %cl,%cl
 735:	74 69                	je     7a0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 737:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 739:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 73c:	74 da                	je     718 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 73e:	83 fe 25             	cmp    $0x25,%esi
 741:	75 e9                	jne    72c <printf+0x3c>
      if(c == 'd'){
 743:	83 f9 64             	cmp    $0x64,%ecx
 746:	0f 84 f4 00 00 00    	je     840 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 74c:	83 f9 70             	cmp    $0x70,%ecx
 74f:	90                   	nop
 750:	74 66                	je     7b8 <printf+0xc8>
 752:	83 f9 78             	cmp    $0x78,%ecx
 755:	74 61                	je     7b8 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 757:	83 f9 73             	cmp    $0x73,%ecx
 75a:	0f 84 80 00 00 00    	je     7e0 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 760:	83 f9 63             	cmp    $0x63,%ecx
 763:	0f 84 f9 00 00 00    	je     862 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 769:	83 f9 25             	cmp    $0x25,%ecx
 76c:	0f 84 b6 00 00 00    	je     828 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 772:	8b 45 08             	mov    0x8(%ebp),%eax
 775:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 77a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 77c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 77f:	e8 bc fe ff ff       	call   640 <putc>
        putc(fd, c);
 784:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 787:	8b 45 08             	mov    0x8(%ebp),%eax
 78a:	0f be d1             	movsbl %cl,%edx
 78d:	e8 ae fe ff ff       	call   640 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 792:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 796:	83 c3 01             	add    $0x1,%ebx
 799:	84 c9                	test   %cl,%cl
 79b:	75 9a                	jne    737 <printf+0x47>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a0:	83 c4 2c             	add    $0x2c,%esp
 7a3:	5b                   	pop    %ebx
 7a4:	5e                   	pop    %esi
 7a5:	5f                   	pop    %edi
 7a6:	5d                   	pop    %ebp
 7a7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 7a8:	be 25 00 00 00       	mov    $0x25,%esi
 7ad:	e9 7a ff ff ff       	jmp    72c <printf+0x3c>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bb:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c0:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7c9:	8b 10                	mov    (%eax),%edx
 7cb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ce:	e8 9d fe ff ff       	call   670 <printint>
        ap++;
 7d3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 7d7:	e9 50 ff ff ff       	jmp    72c <printf+0x3c>
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e3:	8b 38                	mov    (%eax),%edi
        ap++;
 7e5:	83 c0 04             	add    $0x4,%eax
 7e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 7eb:	b8 57 0a 00 00       	mov    $0xa57,%eax
 7f0:	85 ff                	test   %edi,%edi
 7f2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7f7:	0f b6 17             	movzbl (%edi),%edx
 7fa:	84 d2                	test   %dl,%dl
 7fc:	0f 84 2a ff ff ff    	je     72c <printf+0x3c>
 802:	89 de                	mov    %ebx,%esi
 804:	8b 5d 08             	mov    0x8(%ebp),%ebx
 807:	90                   	nop
          putc(fd, *s);
 808:	0f be d2             	movsbl %dl,%edx
          s++;
 80b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 80e:	89 d8                	mov    %ebx,%eax
 810:	e8 2b fe ff ff       	call   640 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 815:	0f b6 17             	movzbl (%edi),%edx
 818:	84 d2                	test   %dl,%dl
 81a:	75 ec                	jne    808 <printf+0x118>
 81c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 81e:	31 f6                	xor    %esi,%esi
 820:	e9 07 ff ff ff       	jmp    72c <printf+0x3c>
 825:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 830:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 832:	e8 09 fe ff ff       	call   640 <putc>
 837:	e9 f0 fe ff ff       	jmp    72c <printf+0x3c>
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 840:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 843:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 845:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 848:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 84f:	8b 10                	mov    (%eax),%edx
 851:	8b 45 08             	mov    0x8(%ebp),%eax
 854:	e8 17 fe ff ff       	call   670 <printint>
        ap++;
 859:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 85d:	e9 ca fe ff ff       	jmp    72c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 862:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 865:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 867:	0f be 10             	movsbl (%eax),%edx
 86a:	8b 45 08             	mov    0x8(%ebp),%eax
 86d:	e8 ce fd ff ff       	call   640 <putc>
        ap++;
 872:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 876:	e9 b1 fe ff ff       	jmp    72c <printf+0x3c>
 87b:	90                   	nop
 87c:	90                   	nop
 87d:	90                   	nop
 87e:	90                   	nop
 87f:	90                   	nop

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	a1 80 0a 00 00       	mov    0xa80,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 886:	89 e5                	mov    %esp,%ebp
 888:	57                   	push   %edi
 889:	56                   	push   %esi
 88a:	53                   	push   %ebx
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 88e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	39 c8                	cmp    %ecx,%eax
 893:	73 1d                	jae    8b2 <free+0x32>
 895:	8d 76 00             	lea    0x0(%esi),%esi
 898:	8b 10                	mov    (%eax),%edx
 89a:	39 d1                	cmp    %edx,%ecx
 89c:	72 1a                	jb     8b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89e:	39 d0                	cmp    %edx,%eax
 8a0:	72 08                	jb     8aa <free+0x2a>
 8a2:	39 c8                	cmp    %ecx,%eax
 8a4:	72 12                	jb     8b8 <free+0x38>
 8a6:	39 d1                	cmp    %edx,%ecx
 8a8:	72 0e                	jb     8b8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 8aa:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ac:	39 c8                	cmp    %ecx,%eax
 8ae:	66 90                	xchg   %ax,%ax
 8b0:	72 e6                	jb     898 <free+0x18>
 8b2:	8b 10                	mov    (%eax),%edx
 8b4:	eb e8                	jmp    89e <free+0x1e>
 8b6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b8:	8b 71 04             	mov    0x4(%ecx),%esi
 8bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8be:	39 d7                	cmp    %edx,%edi
 8c0:	74 19                	je     8db <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8c5:	8b 50 04             	mov    0x4(%eax),%edx
 8c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8cb:	39 ce                	cmp    %ecx,%esi
 8cd:	74 21                	je     8f0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8d1:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 8d6:	5b                   	pop    %ebx
 8d7:	5e                   	pop    %esi
 8d8:	5f                   	pop    %edi
 8d9:	5d                   	pop    %ebp
 8da:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8db:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 8de:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8e6:	8b 50 04             	mov    0x4(%eax),%edx
 8e9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8ec:	39 ce                	cmp    %ecx,%esi
 8ee:	75 df                	jne    8cf <free+0x4f>
    p->s.size += bp->s.size;
 8f0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8f3:	a3 80 0a 00 00       	mov    %eax,0xa80
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8fb:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8fe:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 900:	5b                   	pop    %ebx
 901:	5e                   	pop    %esi
 902:	5f                   	pop    %edi
 903:	5d                   	pop    %ebp
 904:	c3                   	ret    
 905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 919:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 91c:	8b 35 80 0a 00 00    	mov    0xa80,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	83 c3 07             	add    $0x7,%ebx
 925:	c1 eb 03             	shr    $0x3,%ebx
 928:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 92b:	85 f6                	test   %esi,%esi
 92d:	0f 84 ab 00 00 00    	je     9de <malloc+0xce>
 933:	8b 16                	mov    (%esi),%edx
 935:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 938:	39 d9                	cmp    %ebx,%ecx
 93a:	0f 83 c6 00 00 00    	jae    a06 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 940:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 947:	be 00 80 00 00       	mov    $0x8000,%esi
 94c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 94f:	eb 09                	jmp    95a <malloc+0x4a>
 951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 958:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 95a:	3b 15 80 0a 00 00    	cmp    0xa80,%edx
 960:	74 2e                	je     990 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 962:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 964:	8b 48 04             	mov    0x4(%eax),%ecx
 967:	39 cb                	cmp    %ecx,%ebx
 969:	77 ed                	ja     958 <malloc+0x48>
 96b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 96d:	39 cb                	cmp    %ecx,%ebx
 96f:	74 67                	je     9d8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 971:	29 d9                	sub    %ebx,%ecx
 973:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 976:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 979:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 97c:	89 35 80 0a 00 00    	mov    %esi,0xa80
      return (void*) (p + 1);
 982:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 985:	83 c4 2c             	add    $0x2c,%esp
 988:	5b                   	pop    %ebx
 989:	5e                   	pop    %esi
 98a:	5f                   	pop    %edi
 98b:	5d                   	pop    %ebp
 98c:	c3                   	ret    
 98d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 990:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 993:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 999:	bf 00 10 00 00       	mov    $0x1000,%edi
 99e:	0f 47 fb             	cmova  %ebx,%edi
 9a1:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 9a4:	89 04 24             	mov    %eax,(%esp)
 9a7:	e8 80 fc ff ff       	call   62c <sbrk>
  if(p == (char*) -1)
 9ac:	83 f8 ff             	cmp    $0xffffffff,%eax
 9af:	74 18                	je     9c9 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9b1:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9b4:	83 c0 08             	add    $0x8,%eax
 9b7:	89 04 24             	mov    %eax,(%esp)
 9ba:	e8 c1 fe ff ff       	call   880 <free>
  return freep;
 9bf:	8b 15 80 0a 00 00    	mov    0xa80,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9c5:	85 d2                	test   %edx,%edx
 9c7:	75 99                	jne    962 <malloc+0x52>
        return 0;
  }
}
 9c9:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 9cc:	31 c0                	xor    %eax,%eax
  }
}
 9ce:	5b                   	pop    %ebx
 9cf:	5e                   	pop    %esi
 9d0:	5f                   	pop    %edi
 9d1:	5d                   	pop    %ebp
 9d2:	c3                   	ret    
 9d3:	90                   	nop
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9d8:	8b 10                	mov    (%eax),%edx
 9da:	89 16                	mov    %edx,(%esi)
 9dc:	eb 9e                	jmp    97c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9de:	c7 05 80 0a 00 00 84 	movl   $0xa84,0xa80
 9e5:	0a 00 00 
    base.s.size = 0;
 9e8:	ba 84 0a 00 00       	mov    $0xa84,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9ed:	c7 05 84 0a 00 00 84 	movl   $0xa84,0xa84
 9f4:	0a 00 00 
    base.s.size = 0;
 9f7:	c7 05 88 0a 00 00 00 	movl   $0x0,0xa88
 9fe:	00 00 00 
 a01:	e9 3a ff ff ff       	jmp    940 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a06:	89 d0                	mov    %edx,%eax
 a08:	e9 60 ff ff ff       	jmp    96d <malloc+0x5d>
