
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   a:	eb 1c                	jmp    28 <cat+0x28>
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    write(1, buf, n);
  10:	89 44 24 08          	mov    %eax,0x8(%esp)
  14:	c7 44 24 04 20 08 00 	movl   $0x820,0x4(%esp)
  1b:	00 
  1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  23:	e8 4c 03 00 00       	call   374 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  28:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2f:	00 
  30:	c7 44 24 04 20 08 00 	movl   $0x820,0x4(%esp)
  37:	00 
  38:	89 1c 24             	mov    %ebx,(%esp)
  3b:	e8 2c 03 00 00       	call   36c <read>
  40:	83 f8 00             	cmp    $0x0,%eax
  43:	7f cb                	jg     10 <cat+0x10>
    write(1, buf, n);
  if(n < 0){
  45:	75 06                	jne    4d <cat+0x4d>
    printf(1, "cat: read error\n");
    exit();
  }
}
  47:	83 c4 14             	add    $0x14,%esp
  4a:	5b                   	pop    %ebx
  4b:	5d                   	pop    %ebp
  4c:	c3                   	ret    
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 bd 07 00 	movl   $0x7bd,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 3f 04 00 00       	call   4a0 <printf>
    exit();
  61:	e8 ee 02 00 00       	call   354 <exit>
  66:	8d 76 00             	lea    0x0(%esi),%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000070 <main>:
  }
}

int
main(int argc, char *argv[])
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 e4 f0             	and    $0xfffffff0,%esp
  76:	57                   	push   %edi
  77:	56                   	push   %esi
  78:	53                   	push   %ebx
  79:	83 ec 24             	sub    $0x24,%esp
  7c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
  7f:	83 ff 01             	cmp    $0x1,%edi
  82:	7e 6c                	jle    f0 <main+0x80>
    exit();
  }
}

int
main(int argc, char *argv[])
  84:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  87:	be 01 00 00 00       	mov    $0x1,%esi
  8c:	83 c3 04             	add    $0x4,%ebx
  8f:	90                   	nop
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  90:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  97:	00 
  98:	8b 03                	mov    (%ebx),%eax
  9a:	89 04 24             	mov    %eax,(%esp)
  9d:	e8 f2 02 00 00       	call   394 <open>
  a2:	85 c0                	test   %eax,%eax
  a4:	78 2a                	js     d0 <main+0x60>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  a6:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  a9:	83 c6 01             	add    $0x1,%esi
  ac:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  af:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  b3:	e8 48 ff ff ff       	call   0 <cat>
    close(fd);
  b8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  bc:	89 04 24             	mov    %eax,(%esp)
  bf:	e8 b8 02 00 00       	call   37c <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  c4:	39 f7                	cmp    %esi,%edi
  c6:	7f c8                	jg     90 <main+0x20>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  c8:	e8 87 02 00 00       	call   354 <exit>
  cd:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  d0:	8b 03                	mov    (%ebx),%eax
  d2:	c7 44 24 04 ce 07 00 	movl   $0x7ce,0x4(%esp)
  d9:	00 
  da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e1:	89 44 24 08          	mov    %eax,0x8(%esp)
  e5:	e8 b6 03 00 00       	call   4a0 <printf>
      exit();
  ea:	e8 65 02 00 00       	call   354 <exit>
  ef:	90                   	nop
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f7:	e8 04 ff ff ff       	call   0 <cat>
    exit();
  fc:	e8 53 02 00 00       	call   354 <exit>
 101:	90                   	nop
 102:	90                   	nop
 103:	90                   	nop
 104:	90                   	nop
 105:	90                   	nop
 106:	90                   	nop
 107:	90                   	nop
 108:	90                   	nop
 109:	90                   	nop
 10a:	90                   	nop
 10b:	90                   	nop
 10c:	90                   	nop
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

00000110 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 111:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 113:	89 e5                	mov    %esp,%ebp
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	53                   	push   %ebx
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 120:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 124:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 c9                	test   %cl,%cl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	5b                   	pop    %ebx
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	eb 0d                	jmp    140 <strcmp>
 133:	90                   	nop
 134:	90                   	nop
 135:	90                   	nop
 136:	90                   	nop
 137:	90                   	nop
 138:	90                   	nop
 139:	90                   	nop
 13a:	90                   	nop
 13b:	90                   	nop
 13c:	90                   	nop
 13d:	90                   	nop
 13e:	90                   	nop
 13f:	90                   	nop

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
 146:	53                   	push   %ebx
 147:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 14a:	0f b6 01             	movzbl (%ecx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 14                	jne    165 <strcmp+0x25>
 151:	eb 25                	jmp    178 <strcmp+0x38>
 153:	90                   	nop
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 158:	83 c1 01             	add    $0x1,%ecx
 15b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15e:	0f b6 01             	movzbl (%ecx),%eax
 161:	84 c0                	test   %al,%al
 163:	74 13                	je     178 <strcmp+0x38>
 165:	0f b6 1a             	movzbl (%edx),%ebx
 168:	38 d8                	cmp    %bl,%al
 16a:	74 ec                	je     158 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 16c:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 16f:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 172:	29 d8                	sub    %ebx,%eax
}
 174:	5b                   	pop    %ebx
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 178:	0f b6 1a             	movzbl (%edx),%ebx
 17b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17d:	0f b6 db             	movzbl %bl,%ebx
 180:	29 d8                	sub    %ebx,%eax
}
 182:	5b                   	pop    %ebx
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    
 185:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 191:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 193:	89 e5                	mov    %esp,%ebp
 195:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 198:	80 39 00             	cmpb   $0x0,(%ecx)
 19b:	74 0e                	je     1ab <strlen+0x1b>
 19d:	31 d2                	xor    %edx,%edx
 19f:	90                   	nop
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1b6:	53                   	push   %ebx
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ba:	85 c9                	test   %ecx,%ecx
 1bc:	74 14                	je     1d2 <memset+0x22>
 1be:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 1c2:	31 d2                	xor    %edx,%edx
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 1c8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 1cb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ce:	39 ca                	cmp    %ecx,%edx
 1d0:	75 f6                	jne    1c8 <memset+0x18>
    *d++ = c;
  return dst;
}
 1d2:	5b                   	pop    %ebx
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 11                	jne    202 <strchr+0x22>
 1f1:	eb 15                	jmp    208 <strchr+0x28>
 1f3:	90                   	nop
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	0f b6 10             	movzbl (%eax),%edx
 1fe:	84 d2                	test   %dl,%dl
 200:	74 06                	je     208 <strchr+0x28>
    if(*s == c)
 202:	38 ca                	cmp    %cl,%dl
 204:	75 f2                	jne    1f8 <strchr+0x18>
      return (char*) s;
  return 0;
}
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 208:	31 c0                	xor    %eax,%eax
}
 20a:	5d                   	pop    %ebp
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	c3                   	ret    
 211:	eb 0d                	jmp    220 <gets>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 225:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 227:	53                   	push   %ebx
 228:	83 ec 2c             	sub    $0x2c,%esp
 22b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22e:	eb 31                	jmp    261 <gets+0x41>
    cc = read(0, &c, 1);
 230:	8d 45 e7             	lea    -0x19(%ebp),%eax
 233:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 23a:	00 
 23b:	89 44 24 04          	mov    %eax,0x4(%esp)
 23f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 246:	e8 21 01 00 00       	call   36c <read>
    if(cc < 1)
 24b:	85 c0                	test   %eax,%eax
 24d:	7e 1a                	jle    269 <gets+0x49>
      break;
    buf[i++] = c;
 24f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 253:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 255:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 259:	74 1d                	je     278 <gets+0x58>
 25b:	3c 0a                	cmp    $0xa,%al
 25d:	74 19                	je     278 <gets+0x58>
 25f:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	8d 5e 01             	lea    0x1(%esi),%ebx
 264:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 267:	7c c7                	jl     230 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 269:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 26d:	89 f8                	mov    %edi,%eax
 26f:	83 c4 2c             	add    $0x2c,%esp
 272:	5b                   	pop    %ebx
 273:	5e                   	pop    %esi
 274:	5f                   	pop    %edi
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    
 277:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 278:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 27a:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 27c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 280:	83 c4 2c             	add    $0x2c,%esp
 283:	5b                   	pop    %ebx
 284:	5e                   	pop    %esi
 285:	5f                   	pop    %edi
 286:	5d                   	pop    %ebp
 287:	c3                   	ret    
 288:	90                   	nop
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <stat>:

int
stat(char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 296:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 299:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 29c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 29f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2ab:	00 
 2ac:	89 04 24             	mov    %eax,(%esp)
 2af:	e8 e0 00 00 00       	call   394 <open>
  if(fd < 0)
 2b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2b8:	78 19                	js     2d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 1c 24             	mov    %ebx,(%esp)
 2c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c4:	e8 e3 00 00 00       	call   3ac <fstat>
  close(fd);
 2c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2cc:	89 c6                	mov    %eax,%esi
  close(fd);
 2ce:	e8 a9 00 00 00       	call   37c <close>
  return r;
}
 2d3:	89 f0                	mov    %esi,%eax
 2d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2db:	89 ec                	mov    %ebp,%esp
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
  int n;

  n = 0;
 2e1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 2e3:	89 e5                	mov    %esp,%ebp
 2e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e9:	0f b6 11             	movzbl (%ecx),%edx
 2ec:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2ef:	80 fb 09             	cmp    $0x9,%bl
 2f2:	77 1c                	ja     310 <atoi+0x30>
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2f8:	0f be d2             	movsbl %dl,%edx
 2fb:	83 c1 01             	add    $0x1,%ecx
 2fe:	8d 04 80             	lea    (%eax,%eax,4),%eax
 301:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 305:	0f b6 11             	movzbl (%ecx),%edx
 308:	8d 5a d0             	lea    -0x30(%edx),%ebx
 30b:	80 fb 09             	cmp    $0x9,%bl
 30e:	76 e8                	jbe    2f8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 310:	5b                   	pop    %ebx
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
 313:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	53                   	push   %ebx
 328:	8b 5d 10             	mov    0x10(%ebp),%ebx
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 db                	test   %ebx,%ebx
 330:	7e 14                	jle    346 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 332:	31 d2                	xor    %edx,%edx
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 338:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 33c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 342:	39 da                	cmp    %ebx,%edx
 344:	75 f2                	jne    338 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5d                   	pop    %ebp
 349:	c3                   	ret    
 34a:	90                   	nop
 34b:	90                   	nop

0000034c <fork>:
 34c:	b8 01 00 00 00       	mov    $0x1,%eax
 351:	cd 30                	int    $0x30
 353:	c3                   	ret    

00000354 <exit>:
 354:	b8 02 00 00 00       	mov    $0x2,%eax
 359:	cd 30                	int    $0x30
 35b:	c3                   	ret    

0000035c <wait>:
 35c:	b8 03 00 00 00       	mov    $0x3,%eax
 361:	cd 30                	int    $0x30
 363:	c3                   	ret    

00000364 <pipe>:
 364:	b8 04 00 00 00       	mov    $0x4,%eax
 369:	cd 30                	int    $0x30
 36b:	c3                   	ret    

0000036c <read>:
 36c:	b8 06 00 00 00       	mov    $0x6,%eax
 371:	cd 30                	int    $0x30
 373:	c3                   	ret    

00000374 <write>:
 374:	b8 05 00 00 00       	mov    $0x5,%eax
 379:	cd 30                	int    $0x30
 37b:	c3                   	ret    

0000037c <close>:
 37c:	b8 07 00 00 00       	mov    $0x7,%eax
 381:	cd 30                	int    $0x30
 383:	c3                   	ret    

00000384 <kill>:
 384:	b8 08 00 00 00       	mov    $0x8,%eax
 389:	cd 30                	int    $0x30
 38b:	c3                   	ret    

0000038c <exec>:
 38c:	b8 09 00 00 00       	mov    $0x9,%eax
 391:	cd 30                	int    $0x30
 393:	c3                   	ret    

00000394 <open>:
 394:	b8 0a 00 00 00       	mov    $0xa,%eax
 399:	cd 30                	int    $0x30
 39b:	c3                   	ret    

0000039c <mknod>:
 39c:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a1:	cd 30                	int    $0x30
 3a3:	c3                   	ret    

000003a4 <unlink>:
 3a4:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a9:	cd 30                	int    $0x30
 3ab:	c3                   	ret    

000003ac <fstat>:
 3ac:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b1:	cd 30                	int    $0x30
 3b3:	c3                   	ret    

000003b4 <link>:
 3b4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b9:	cd 30                	int    $0x30
 3bb:	c3                   	ret    

000003bc <mkdir>:
 3bc:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c1:	cd 30                	int    $0x30
 3c3:	c3                   	ret    

000003c4 <chdir>:
 3c4:	b8 10 00 00 00       	mov    $0x10,%eax
 3c9:	cd 30                	int    $0x30
 3cb:	c3                   	ret    

000003cc <dup>:
 3cc:	b8 11 00 00 00       	mov    $0x11,%eax
 3d1:	cd 30                	int    $0x30
 3d3:	c3                   	ret    

000003d4 <getpid>:
 3d4:	b8 12 00 00 00       	mov    $0x12,%eax
 3d9:	cd 30                	int    $0x30
 3db:	c3                   	ret    

000003dc <sbrk>:
 3dc:	b8 13 00 00 00       	mov    $0x13,%eax
 3e1:	cd 30                	int    $0x30
 3e3:	c3                   	ret    

000003e4 <sleep>:
 3e4:	b8 14 00 00 00       	mov    $0x14,%eax
 3e9:	cd 30                	int    $0x30
 3eb:	c3                   	ret    
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 28             	sub    $0x28,%esp
 3f6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3f9:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 403:	00 
 404:	89 54 24 04          	mov    %edx,0x4(%esp)
 408:	89 04 24             	mov    %eax,(%esp)
 40b:	e8 64 ff ff ff       	call   374 <write>
}
 410:	c9                   	leave  
 411:	c3                   	ret    
 412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	89 c7                	mov    %eax,%edi
 426:	56                   	push   %esi
 427:	89 ce                	mov    %ecx,%esi
 429:	53                   	push   %ebx
 42a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 430:	85 c9                	test   %ecx,%ecx
 432:	74 09                	je     43d <printint+0x1d>
 434:	89 d0                	mov    %edx,%eax
 436:	c1 e8 1f             	shr    $0x1f,%eax
 439:	84 c0                	test   %al,%al
 43b:	75 53                	jne    490 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 43d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 43f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 446:	31 c9                	xor    %ecx,%ecx
 448:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 44b:	90                   	nop
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 450:	31 d2                	xor    %edx,%edx
 452:	f7 f6                	div    %esi
 454:	0f b6 92 ea 07 00 00 	movzbl 0x7ea(%edx),%edx
 45b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 45e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 461:	85 c0                	test   %eax,%eax
 463:	75 eb                	jne    450 <printint+0x30>
  if(neg)
 465:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 468:	85 c0                	test   %eax,%eax
 46a:	74 08                	je     474 <printint+0x54>
    buf[i++] = '-';
 46c:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 471:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 474:	8d 71 ff             	lea    -0x1(%ecx),%esi
 477:	90                   	nop
    putc(fd, buf[i]);
 478:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 47c:	89 f8                	mov    %edi,%eax
 47e:	e8 6d ff ff ff       	call   3f0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 483:	83 ee 01             	sub    $0x1,%esi
 486:	79 f0                	jns    478 <printint+0x58>
    putc(fd, buf[i]);
}
 488:	83 c4 2c             	add    $0x2c,%esp
 48b:	5b                   	pop    %ebx
 48c:	5e                   	pop    %esi
 48d:	5f                   	pop    %edi
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 490:	89 d0                	mov    %edx,%eax
 492:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 494:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 49b:	eb a9                	jmp    446 <printint+0x26>
 49d:	8d 76 00             	lea    0x0(%esi),%esi

000004a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ac:	0f b6 0b             	movzbl (%ebx),%ecx
 4af:	84 c9                	test   %cl,%cl
 4b1:	0f 84 99 00 00 00    	je     550 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4b7:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ba:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 4bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4bf:	eb 26                	jmp    4e7 <printf+0x47>
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c8:	83 f9 25             	cmp    $0x25,%ecx
 4cb:	0f 84 87 00 00 00    	je     558 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 4d1:	8b 45 08             	mov    0x8(%ebp),%eax
 4d4:	0f be d1             	movsbl %cl,%edx
 4d7:	e8 14 ff ff ff       	call   3f0 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4dc:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 4e0:	83 c3 01             	add    $0x1,%ebx
 4e3:	84 c9                	test   %cl,%cl
 4e5:	74 69                	je     550 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 4e7:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4e9:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 4ec:	74 da                	je     4c8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ee:	83 fe 25             	cmp    $0x25,%esi
 4f1:	75 e9                	jne    4dc <printf+0x3c>
      if(c == 'd'){
 4f3:	83 f9 64             	cmp    $0x64,%ecx
 4f6:	0f 84 f4 00 00 00    	je     5f0 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4fc:	83 f9 70             	cmp    $0x70,%ecx
 4ff:	90                   	nop
 500:	74 66                	je     568 <printf+0xc8>
 502:	83 f9 78             	cmp    $0x78,%ecx
 505:	74 61                	je     568 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 507:	83 f9 73             	cmp    $0x73,%ecx
 50a:	0f 84 80 00 00 00    	je     590 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 510:	83 f9 63             	cmp    $0x63,%ecx
 513:	0f 84 f9 00 00 00    	je     612 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 519:	83 f9 25             	cmp    $0x25,%ecx
 51c:	0f 84 b6 00 00 00    	je     5d8 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 522:	8b 45 08             	mov    0x8(%ebp),%eax
 525:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 52a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 52c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 52f:	e8 bc fe ff ff       	call   3f0 <putc>
        putc(fd, c);
 534:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 537:	8b 45 08             	mov    0x8(%ebp),%eax
 53a:	0f be d1             	movsbl %cl,%edx
 53d:	e8 ae fe ff ff       	call   3f0 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 542:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 546:	83 c3 01             	add    $0x1,%ebx
 549:	84 c9                	test   %cl,%cl
 54b:	75 9a                	jne    4e7 <printf+0x47>
 54d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 550:	83 c4 2c             	add    $0x2c,%esp
 553:	5b                   	pop    %ebx
 554:	5e                   	pop    %esi
 555:	5f                   	pop    %edi
 556:	5d                   	pop    %ebp
 557:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 558:	be 25 00 00 00       	mov    $0x25,%esi
 55d:	e9 7a ff ff ff       	jmp    4dc <printf+0x3c>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56b:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 570:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 572:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 579:	8b 10                	mov    (%eax),%edx
 57b:	8b 45 08             	mov    0x8(%ebp),%eax
 57e:	e8 9d fe ff ff       	call   420 <printint>
        ap++;
 583:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 587:	e9 50 ff ff ff       	jmp    4dc <printf+0x3c>
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 590:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 593:	8b 38                	mov    (%eax),%edi
        ap++;
 595:	83 c0 04             	add    $0x4,%eax
 598:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 59b:	b8 e3 07 00 00       	mov    $0x7e3,%eax
 5a0:	85 ff                	test   %edi,%edi
 5a2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a7:	0f b6 17             	movzbl (%edi),%edx
 5aa:	84 d2                	test   %dl,%dl
 5ac:	0f 84 2a ff ff ff    	je     4dc <printf+0x3c>
 5b2:	89 de                	mov    %ebx,%esi
 5b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5b7:	90                   	nop
          putc(fd, *s);
 5b8:	0f be d2             	movsbl %dl,%edx
          s++;
 5bb:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 5be:	89 d8                	mov    %ebx,%eax
 5c0:	e8 2b fe ff ff       	call   3f0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c5:	0f b6 17             	movzbl (%edi),%edx
 5c8:	84 d2                	test   %dl,%dl
 5ca:	75 ec                	jne    5b8 <printf+0x118>
 5cc:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ce:	31 f6                	xor    %esi,%esi
 5d0:	e9 07 ff ff ff       	jmp    4dc <printf+0x3c>
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e0:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5e2:	e8 09 fe ff ff       	call   3f0 <putc>
 5e7:	e9 f0 fe ff ff       	jmp    4dc <printf+0x3c>
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f3:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5f5:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5ff:	8b 10                	mov    (%eax),%edx
 601:	8b 45 08             	mov    0x8(%ebp),%eax
 604:	e8 17 fe ff ff       	call   420 <printint>
        ap++;
 609:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 60d:	e9 ca fe ff ff       	jmp    4dc <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 612:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 615:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 617:	0f be 10             	movsbl (%eax),%edx
 61a:	8b 45 08             	mov    0x8(%ebp),%eax
 61d:	e8 ce fd ff ff       	call   3f0 <putc>
        ap++;
 622:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 626:	e9 b1 fe ff ff       	jmp    4dc <printf+0x3c>
 62b:	90                   	nop
 62c:	90                   	nop
 62d:	90                   	nop
 62e:	90                   	nop
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 00 08 00 00       	mov    0x800,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	39 c8                	cmp    %ecx,%eax
 643:	73 1d                	jae    662 <free+0x32>
 645:	8d 76 00             	lea    0x0(%esi),%esi
 648:	8b 10                	mov    (%eax),%edx
 64a:	39 d1                	cmp    %edx,%ecx
 64c:	72 1a                	jb     668 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64e:	39 d0                	cmp    %edx,%eax
 650:	72 08                	jb     65a <free+0x2a>
 652:	39 c8                	cmp    %ecx,%eax
 654:	72 12                	jb     668 <free+0x38>
 656:	39 d1                	cmp    %edx,%ecx
 658:	72 0e                	jb     668 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 65a:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65c:	39 c8                	cmp    %ecx,%eax
 65e:	66 90                	xchg   %ax,%ax
 660:	72 e6                	jb     648 <free+0x18>
 662:	8b 10                	mov    (%eax),%edx
 664:	eb e8                	jmp    64e <free+0x1e>
 666:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 668:	8b 71 04             	mov    0x4(%ecx),%esi
 66b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 66e:	39 d7                	cmp    %edx,%edi
 670:	74 19                	je     68b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 672:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 675:	8b 50 04             	mov    0x4(%eax),%edx
 678:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 67b:	39 ce                	cmp    %ecx,%esi
 67d:	74 21                	je     6a0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 67f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 681:	a3 00 08 00 00       	mov    %eax,0x800
}
 686:	5b                   	pop    %ebx
 687:	5e                   	pop    %esi
 688:	5f                   	pop    %edi
 689:	5d                   	pop    %ebp
 68a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 68b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 68e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 690:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 693:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 696:	8b 50 04             	mov    0x4(%eax),%edx
 699:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69c:	39 ce                	cmp    %ecx,%esi
 69e:	75 df                	jne    67f <free+0x4f>
    p->s.size += bp->s.size;
 6a0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6a3:	a3 00 08 00 00       	mov    %eax,0x800
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6a8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ab:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6ae:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6b0:	5b                   	pop    %ebx
 6b1:	5e                   	pop    %esi
 6b2:	5f                   	pop    %edi
 6b3:	5d                   	pop    %ebp
 6b4:	c3                   	ret    
 6b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 6cc:	8b 35 00 08 00 00    	mov    0x800,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	83 c3 07             	add    $0x7,%ebx
 6d5:	c1 eb 03             	shr    $0x3,%ebx
 6d8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6db:	85 f6                	test   %esi,%esi
 6dd:	0f 84 ab 00 00 00    	je     78e <malloc+0xce>
 6e3:	8b 16                	mov    (%esi),%edx
 6e5:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 d9                	cmp    %ebx,%ecx
 6ea:	0f 83 c6 00 00 00    	jae    7b6 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 6f0:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 6f7:	be 00 80 00 00       	mov    $0x8000,%esi
 6fc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 6ff:	eb 09                	jmp    70a <malloc+0x4a>
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 708:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 70a:	3b 15 00 08 00 00    	cmp    0x800,%edx
 710:	74 2e                	je     740 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 712:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 714:	8b 48 04             	mov    0x4(%eax),%ecx
 717:	39 cb                	cmp    %ecx,%ebx
 719:	77 ed                	ja     708 <malloc+0x48>
 71b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 71d:	39 cb                	cmp    %ecx,%ebx
 71f:	74 67                	je     788 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 721:	29 d9                	sub    %ebx,%ecx
 723:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 726:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 729:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 72c:	89 35 00 08 00 00    	mov    %esi,0x800
      return (void*) (p + 1);
 732:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 735:	83 c4 2c             	add    $0x2c,%esp
 738:	5b                   	pop    %ebx
 739:	5e                   	pop    %esi
 73a:	5f                   	pop    %edi
 73b:	5d                   	pop    %ebp
 73c:	c3                   	ret    
 73d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 743:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 749:	bf 00 10 00 00       	mov    $0x1000,%edi
 74e:	0f 47 fb             	cmova  %ebx,%edi
 751:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 754:	89 04 24             	mov    %eax,(%esp)
 757:	e8 80 fc ff ff       	call   3dc <sbrk>
  if(p == (char*) -1)
 75c:	83 f8 ff             	cmp    $0xffffffff,%eax
 75f:	74 18                	je     779 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 761:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 764:	83 c0 08             	add    $0x8,%eax
 767:	89 04 24             	mov    %eax,(%esp)
 76a:	e8 c1 fe ff ff       	call   630 <free>
  return freep;
 76f:	8b 15 00 08 00 00    	mov    0x800,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 775:	85 d2                	test   %edx,%edx
 777:	75 99                	jne    712 <malloc+0x52>
        return 0;
  }
}
 779:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 77c:	31 c0                	xor    %eax,%eax
  }
}
 77e:	5b                   	pop    %ebx
 77f:	5e                   	pop    %esi
 780:	5f                   	pop    %edi
 781:	5d                   	pop    %ebp
 782:	c3                   	ret    
 783:	90                   	nop
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 788:	8b 10                	mov    (%eax),%edx
 78a:	89 16                	mov    %edx,(%esi)
 78c:	eb 9e                	jmp    72c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 78e:	c7 05 00 08 00 00 04 	movl   $0x804,0x800
 795:	08 00 00 
    base.s.size = 0;
 798:	ba 04 08 00 00       	mov    $0x804,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 79d:	c7 05 04 08 00 00 04 	movl   $0x804,0x804
 7a4:	08 00 00 
    base.s.size = 0;
 7a7:	c7 05 08 08 00 00 00 	movl   $0x0,0x808
 7ae:	00 00 00 
 7b1:	e9 3a ff ff ff       	jmp    6f0 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b6:	89 d0                	mov    %edx,%eax
 7b8:	e9 60 ff ff ff       	jmp    71d <malloc+0x5d>
