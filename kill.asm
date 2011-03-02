
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	57                   	push   %edi
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	83 ec 14             	sub    $0x14,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;
	
  if(argc < 1){
  12:	85 f6                	test   %esi,%esi
  14:	7e 2a                	jle    40 <main+0x40>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  16:	83 fe 01             	cmp    $0x1,%esi
  19:	bb 01 00 00 00       	mov    $0x1,%ebx
  1e:	74 1a                	je     3a <main+0x3a>
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
	
  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 02 02 00 00       	call   230 <atoi>
  2e:	89 04 24             	mov    %eax,(%esp)
  31:	e8 9e 02 00 00       	call   2d4 <kill>
	
  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  36:	39 de                	cmp    %ebx,%esi
  38:	7f e6                	jg     20 <main+0x20>
    kill(atoi(argv[i]));
  exit();
  3a:	e8 65 02 00 00       	call   2a4 <exit>
  3f:	90                   	nop
main(int argc, char **argv)
{
  int i;
	
  if(argc < 1){
    printf(2, "usage: kill pid...\n");
  40:	c7 44 24 04 0d 07 00 	movl   $0x70d,0x4(%esp)
  47:	00 
  48:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4f:	e8 9c 03 00 00       	call   3f0 <printf>
    exit();
  54:	e8 4b 02 00 00       	call   2a4 <exit>
  59:	90                   	nop
  5a:	90                   	nop
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	90                   	nop
  5e:	90                   	nop
  5f:	90                   	nop

00000060 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  63:	89 e5                	mov    %esp,%ebp
  65:	8b 45 08             	mov    0x8(%ebp),%eax
  68:	53                   	push   %ebx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 c9                	test   %cl,%cl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	5b                   	pop    %ebx
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret    
  81:	eb 0d                	jmp    90 <strcmp>
  83:	90                   	nop
  84:	90                   	nop
  85:	90                   	nop
  86:	90                   	nop
  87:	90                   	nop
  88:	90                   	nop
  89:	90                   	nop
  8a:	90                   	nop
  8b:	90                   	nop
  8c:	90                   	nop
  8d:	90                   	nop
  8e:	90                   	nop
  8f:	90                   	nop

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  96:	53                   	push   %ebx
  97:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9a:	0f b6 01             	movzbl (%ecx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 14                	jne    b5 <strcmp+0x25>
  a1:	eb 25                	jmp    c8 <strcmp+0x38>
  a3:	90                   	nop
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  a8:	83 c1 01             	add    $0x1,%ecx
  ab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ae:	0f b6 01             	movzbl (%ecx),%eax
  b1:	84 c0                	test   %al,%al
  b3:	74 13                	je     c8 <strcmp+0x38>
  b5:	0f b6 1a             	movzbl (%edx),%ebx
  b8:	38 d8                	cmp    %bl,%al
  ba:	74 ec                	je     a8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  bc:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  bf:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c2:	29 d8                	sub    %ebx,%eax
}
  c4:	5b                   	pop    %ebx
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c8:	0f b6 1a             	movzbl (%edx),%ebx
  cb:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  cd:	0f b6 db             	movzbl %bl,%ebx
  d0:	29 d8                	sub    %ebx,%eax
}
  d2:	5b                   	pop    %ebx
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    
  d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  e1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  e3:	89 e5                	mov    %esp,%ebp
  e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e8:	80 39 00             	cmpb   $0x0,(%ecx)
  eb:	74 0e                	je     fb <strlen+0x1b>
  ed:	31 d2                	xor    %edx,%edx
  ef:	90                   	nop
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 10             	mov    0x10(%ebp),%ecx
 106:	53                   	push   %ebx
 107:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 10a:	85 c9                	test   %ecx,%ecx
 10c:	74 14                	je     122 <memset+0x22>
 10e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 112:	31 d2                	xor    %edx,%edx
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 118:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 11b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 11e:	39 ca                	cmp    %ecx,%edx
 120:	75 f6                	jne    118 <memset+0x18>
    *d++ = c;
  return dst;
}
 122:	5b                   	pop    %ebx
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    
 125:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 11                	jne    152 <strchr+0x22>
 141:	eb 15                	jmp    158 <strchr+0x28>
 143:	90                   	nop
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 148:	83 c0 01             	add    $0x1,%eax
 14b:	0f b6 10             	movzbl (%eax),%edx
 14e:	84 d2                	test   %dl,%dl
 150:	74 06                	je     158 <strchr+0x28>
    if(*s == c)
 152:	38 ca                	cmp    %cl,%dl
 154:	75 f2                	jne    148 <strchr+0x18>
      return (char*) s;
  return 0;
}
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 158:	31 c0                	xor    %eax,%eax
}
 15a:	5d                   	pop    %ebp
 15b:	90                   	nop
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	c3                   	ret    
 161:	eb 0d                	jmp    170 <gets>
 163:	90                   	nop
 164:	90                   	nop
 165:	90                   	nop
 166:	90                   	nop
 167:	90                   	nop
 168:	90                   	nop
 169:	90                   	nop
 16a:	90                   	nop
 16b:	90                   	nop
 16c:	90                   	nop
 16d:	90                   	nop
 16e:	90                   	nop
 16f:	90                   	nop

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 177:	53                   	push   %ebx
 178:	83 ec 2c             	sub    $0x2c,%esp
 17b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17e:	eb 31                	jmp    1b1 <gets+0x41>
    cc = read(0, &c, 1);
 180:	8d 45 e7             	lea    -0x19(%ebp),%eax
 183:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 18a:	00 
 18b:	89 44 24 04          	mov    %eax,0x4(%esp)
 18f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 196:	e8 21 01 00 00       	call   2bc <read>
    if(cc < 1)
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1a                	jle    1b9 <gets+0x49>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 1a3:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1a5:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 1a9:	74 1d                	je     1c8 <gets+0x58>
 1ab:	3c 0a                	cmp    $0xa,%al
 1ad:	74 19                	je     1c8 <gets+0x58>
 1af:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	7c c7                	jl     180 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1bd:	89 f8                	mov    %edi,%eax
 1bf:	83 c4 2c             	add    $0x2c,%esp
 1c2:	5b                   	pop    %ebx
 1c3:	5e                   	pop    %esi
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1ca:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1cc:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1d0:	83 c4 2c             	add    $0x2c,%esp
 1d3:	5b                   	pop    %ebx
 1d4:	5e                   	pop    %esi
 1d5:	5f                   	pop    %edi
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
 1d8:	90                   	nop
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fb:	00 
 1fc:	89 04 24             	mov    %eax,(%esp)
 1ff:	e8 e0 00 00 00       	call   2e4 <open>
  if(fd < 0)
 204:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 206:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 208:	78 19                	js     223 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 1c 24             	mov    %ebx,(%esp)
 210:	89 44 24 04          	mov    %eax,0x4(%esp)
 214:	e8 e3 00 00 00       	call   2fc <fstat>
  close(fd);
 219:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 21c:	89 c6                	mov    %eax,%esi
  close(fd);
 21e:	e8 a9 00 00 00       	call   2cc <close>
  return r;
}
 223:	89 f0                	mov    %esi,%eax
 225:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 228:	8b 75 fc             	mov    -0x4(%ebp),%esi
 22b:	89 ec                	mov    %ebp,%esp
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
  int n;

  n = 0;
 231:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 233:	89 e5                	mov    %esp,%ebp
 235:	8b 4d 08             	mov    0x8(%ebp),%ecx
 238:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 239:	0f b6 11             	movzbl (%ecx),%edx
 23c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 23f:	80 fb 09             	cmp    $0x9,%bl
 242:	77 1c                	ja     260 <atoi+0x30>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 248:	0f be d2             	movsbl %dl,%edx
 24b:	83 c1 01             	add    $0x1,%ecx
 24e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 251:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 255:	0f b6 11             	movzbl (%ecx),%edx
 258:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25b:	80 fb 09             	cmp    $0x9,%bl
 25e:	76 e8                	jbe    248 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 260:	5b                   	pop    %ebx
 261:	5d                   	pop    %ebp
 262:	c3                   	ret    
 263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	53                   	push   %ebx
 278:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 14                	jle    296 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 282:	31 d2                	xor    %edx,%edx
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    
 29a:	90                   	nop
 29b:	90                   	nop

0000029c <fork>:
 29c:	b8 01 00 00 00       	mov    $0x1,%eax
 2a1:	cd 30                	int    $0x30
 2a3:	c3                   	ret    

000002a4 <exit>:
 2a4:	b8 02 00 00 00       	mov    $0x2,%eax
 2a9:	cd 30                	int    $0x30
 2ab:	c3                   	ret    

000002ac <wait>:
 2ac:	b8 03 00 00 00       	mov    $0x3,%eax
 2b1:	cd 30                	int    $0x30
 2b3:	c3                   	ret    

000002b4 <pipe>:
 2b4:	b8 04 00 00 00       	mov    $0x4,%eax
 2b9:	cd 30                	int    $0x30
 2bb:	c3                   	ret    

000002bc <read>:
 2bc:	b8 06 00 00 00       	mov    $0x6,%eax
 2c1:	cd 30                	int    $0x30
 2c3:	c3                   	ret    

000002c4 <write>:
 2c4:	b8 05 00 00 00       	mov    $0x5,%eax
 2c9:	cd 30                	int    $0x30
 2cb:	c3                   	ret    

000002cc <close>:
 2cc:	b8 07 00 00 00       	mov    $0x7,%eax
 2d1:	cd 30                	int    $0x30
 2d3:	c3                   	ret    

000002d4 <kill>:
 2d4:	b8 08 00 00 00       	mov    $0x8,%eax
 2d9:	cd 30                	int    $0x30
 2db:	c3                   	ret    

000002dc <exec>:
 2dc:	b8 09 00 00 00       	mov    $0x9,%eax
 2e1:	cd 30                	int    $0x30
 2e3:	c3                   	ret    

000002e4 <open>:
 2e4:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e9:	cd 30                	int    $0x30
 2eb:	c3                   	ret    

000002ec <mknod>:
 2ec:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f1:	cd 30                	int    $0x30
 2f3:	c3                   	ret    

000002f4 <unlink>:
 2f4:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f9:	cd 30                	int    $0x30
 2fb:	c3                   	ret    

000002fc <fstat>:
 2fc:	b8 0d 00 00 00       	mov    $0xd,%eax
 301:	cd 30                	int    $0x30
 303:	c3                   	ret    

00000304 <link>:
 304:	b8 0e 00 00 00       	mov    $0xe,%eax
 309:	cd 30                	int    $0x30
 30b:	c3                   	ret    

0000030c <mkdir>:
 30c:	b8 0f 00 00 00       	mov    $0xf,%eax
 311:	cd 30                	int    $0x30
 313:	c3                   	ret    

00000314 <chdir>:
 314:	b8 10 00 00 00       	mov    $0x10,%eax
 319:	cd 30                	int    $0x30
 31b:	c3                   	ret    

0000031c <dup>:
 31c:	b8 11 00 00 00       	mov    $0x11,%eax
 321:	cd 30                	int    $0x30
 323:	c3                   	ret    

00000324 <getpid>:
 324:	b8 12 00 00 00       	mov    $0x12,%eax
 329:	cd 30                	int    $0x30
 32b:	c3                   	ret    

0000032c <sbrk>:
 32c:	b8 13 00 00 00       	mov    $0x13,%eax
 331:	cd 30                	int    $0x30
 333:	c3                   	ret    

00000334 <sleep>:
 334:	b8 14 00 00 00       	mov    $0x14,%eax
 339:	cd 30                	int    $0x30
 33b:	c3                   	ret    
 33c:	90                   	nop
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 28             	sub    $0x28,%esp
 346:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 349:	8d 55 f4             	lea    -0xc(%ebp),%edx
 34c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 353:	00 
 354:	89 54 24 04          	mov    %edx,0x4(%esp)
 358:	89 04 24             	mov    %eax,(%esp)
 35b:	e8 64 ff ff ff       	call   2c4 <write>
}
 360:	c9                   	leave  
 361:	c3                   	ret    
 362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	89 c7                	mov    %eax,%edi
 376:	56                   	push   %esi
 377:	89 ce                	mov    %ecx,%esi
 379:	53                   	push   %ebx
 37a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 380:	85 c9                	test   %ecx,%ecx
 382:	74 09                	je     38d <printint+0x1d>
 384:	89 d0                	mov    %edx,%eax
 386:	c1 e8 1f             	shr    $0x1f,%eax
 389:	84 c0                	test   %al,%al
 38b:	75 53                	jne    3e0 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 38d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 38f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 396:	31 c9                	xor    %ecx,%ecx
 398:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 39b:	90                   	nop
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	31 d2                	xor    %edx,%edx
 3a2:	f7 f6                	div    %esi
 3a4:	0f b6 92 28 07 00 00 	movzbl 0x728(%edx),%edx
 3ab:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 3ae:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 3b1:	85 c0                	test   %eax,%eax
 3b3:	75 eb                	jne    3a0 <printint+0x30>
  if(neg)
 3b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3b8:	85 c0                	test   %eax,%eax
 3ba:	74 08                	je     3c4 <printint+0x54>
    buf[i++] = '-';
 3bc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3c1:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 3c4:	8d 71 ff             	lea    -0x1(%ecx),%esi
 3c7:	90                   	nop
    putc(fd, buf[i]);
 3c8:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 3cc:	89 f8                	mov    %edi,%eax
 3ce:	e8 6d ff ff ff       	call   340 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3d3:	83 ee 01             	sub    $0x1,%esi
 3d6:	79 f0                	jns    3c8 <printint+0x58>
    putc(fd, buf[i]);
}
 3d8:	83 c4 2c             	add    $0x2c,%esp
 3db:	5b                   	pop    %ebx
 3dc:	5e                   	pop    %esi
 3dd:	5f                   	pop    %edi
 3de:	5d                   	pop    %ebp
 3df:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3e0:	89 d0                	mov    %edx,%eax
 3e2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3e4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 3eb:	eb a9                	jmp    396 <printint+0x26>
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3fc:	0f b6 0b             	movzbl (%ebx),%ecx
 3ff:	84 c9                	test   %cl,%cl
 401:	0f 84 99 00 00 00    	je     4a0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 407:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 40a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 40c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 40f:	eb 26                	jmp    437 <printf+0x47>
 411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 418:	83 f9 25             	cmp    $0x25,%ecx
 41b:	0f 84 87 00 00 00    	je     4a8 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 421:	8b 45 08             	mov    0x8(%ebp),%eax
 424:	0f be d1             	movsbl %cl,%edx
 427:	e8 14 ff ff ff       	call   340 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 430:	83 c3 01             	add    $0x1,%ebx
 433:	84 c9                	test   %cl,%cl
 435:	74 69                	je     4a0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 437:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 439:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 43c:	74 da                	je     418 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 43e:	83 fe 25             	cmp    $0x25,%esi
 441:	75 e9                	jne    42c <printf+0x3c>
      if(c == 'd'){
 443:	83 f9 64             	cmp    $0x64,%ecx
 446:	0f 84 f4 00 00 00    	je     540 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 44c:	83 f9 70             	cmp    $0x70,%ecx
 44f:	90                   	nop
 450:	74 66                	je     4b8 <printf+0xc8>
 452:	83 f9 78             	cmp    $0x78,%ecx
 455:	74 61                	je     4b8 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 457:	83 f9 73             	cmp    $0x73,%ecx
 45a:	0f 84 80 00 00 00    	je     4e0 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 460:	83 f9 63             	cmp    $0x63,%ecx
 463:	0f 84 f9 00 00 00    	je     562 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 469:	83 f9 25             	cmp    $0x25,%ecx
 46c:	0f 84 b6 00 00 00    	je     528 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 472:	8b 45 08             	mov    0x8(%ebp),%eax
 475:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 47a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 47c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 47f:	e8 bc fe ff ff       	call   340 <putc>
        putc(fd, c);
 484:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 487:	8b 45 08             	mov    0x8(%ebp),%eax
 48a:	0f be d1             	movsbl %cl,%edx
 48d:	e8 ae fe ff ff       	call   340 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 492:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 496:	83 c3 01             	add    $0x1,%ebx
 499:	84 c9                	test   %cl,%cl
 49b:	75 9a                	jne    437 <printf+0x47>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4a0:	83 c4 2c             	add    $0x2c,%esp
 4a3:	5b                   	pop    %ebx
 4a4:	5e                   	pop    %esi
 4a5:	5f                   	pop    %edi
 4a6:	5d                   	pop    %ebp
 4a7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4a8:	be 25 00 00 00       	mov    $0x25,%esi
 4ad:	e9 7a ff ff ff       	jmp    42c <printf+0x3c>
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bb:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c0:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4c9:	8b 10                	mov    (%eax),%edx
 4cb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ce:	e8 9d fe ff ff       	call   370 <printint>
        ap++;
 4d3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 4d7:	e9 50 ff ff ff       	jmp    42c <printf+0x3c>
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4e3:	8b 38                	mov    (%eax),%edi
        ap++;
 4e5:	83 c0 04             	add    $0x4,%eax
 4e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 4eb:	b8 21 07 00 00       	mov    $0x721,%eax
 4f0:	85 ff                	test   %edi,%edi
 4f2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f7:	0f b6 17             	movzbl (%edi),%edx
 4fa:	84 d2                	test   %dl,%dl
 4fc:	0f 84 2a ff ff ff    	je     42c <printf+0x3c>
 502:	89 de                	mov    %ebx,%esi
 504:	8b 5d 08             	mov    0x8(%ebp),%ebx
 507:	90                   	nop
          putc(fd, *s);
 508:	0f be d2             	movsbl %dl,%edx
          s++;
 50b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 50e:	89 d8                	mov    %ebx,%eax
 510:	e8 2b fe ff ff       	call   340 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 515:	0f b6 17             	movzbl (%edi),%edx
 518:	84 d2                	test   %dl,%dl
 51a:	75 ec                	jne    508 <printf+0x118>
 51c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51e:	31 f6                	xor    %esi,%esi
 520:	e9 07 ff ff ff       	jmp    42c <printf+0x3c>
 525:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 528:	8b 45 08             	mov    0x8(%ebp),%eax
 52b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 530:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 532:	e8 09 fe ff ff       	call   340 <putc>
 537:	e9 f0 fe ff ff       	jmp    42c <printf+0x3c>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 543:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 545:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 548:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 54f:	8b 10                	mov    (%eax),%edx
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	e8 17 fe ff ff       	call   370 <printint>
        ap++;
 559:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 55d:	e9 ca fe ff ff       	jmp    42c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 562:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 565:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 567:	0f be 10             	movsbl (%eax),%edx
 56a:	8b 45 08             	mov    0x8(%ebp),%eax
 56d:	e8 ce fd ff ff       	call   340 <putc>
        ap++;
 572:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 576:	e9 b1 fe ff ff       	jmp    42c <printf+0x3c>
 57b:	90                   	nop
 57c:	90                   	nop
 57d:	90                   	nop
 57e:	90                   	nop
 57f:	90                   	nop

00000580 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 580:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	a1 3c 07 00 00       	mov    0x73c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 586:	89 e5                	mov    %esp,%ebp
 588:	57                   	push   %edi
 589:	56                   	push   %esi
 58a:	53                   	push   %ebx
 58b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 58e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	39 c8                	cmp    %ecx,%eax
 593:	73 1d                	jae    5b2 <free+0x32>
 595:	8d 76 00             	lea    0x0(%esi),%esi
 598:	8b 10                	mov    (%eax),%edx
 59a:	39 d1                	cmp    %edx,%ecx
 59c:	72 1a                	jb     5b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59e:	39 d0                	cmp    %edx,%eax
 5a0:	72 08                	jb     5aa <free+0x2a>
 5a2:	39 c8                	cmp    %ecx,%eax
 5a4:	72 12                	jb     5b8 <free+0x38>
 5a6:	39 d1                	cmp    %edx,%ecx
 5a8:	72 0e                	jb     5b8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5aa:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ac:	39 c8                	cmp    %ecx,%eax
 5ae:	66 90                	xchg   %ax,%ax
 5b0:	72 e6                	jb     598 <free+0x18>
 5b2:	8b 10                	mov    (%eax),%edx
 5b4:	eb e8                	jmp    59e <free+0x1e>
 5b6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b8:	8b 71 04             	mov    0x4(%ecx),%esi
 5bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5be:	39 d7                	cmp    %edx,%edi
 5c0:	74 19                	je     5db <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5c5:	8b 50 04             	mov    0x4(%eax),%edx
 5c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5cb:	39 ce                	cmp    %ecx,%esi
 5cd:	74 21                	je     5f0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5d1:	a3 3c 07 00 00       	mov    %eax,0x73c
}
 5d6:	5b                   	pop    %ebx
 5d7:	5e                   	pop    %esi
 5d8:	5f                   	pop    %edi
 5d9:	5d                   	pop    %ebp
 5da:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5db:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5de:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5e0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5e6:	8b 50 04             	mov    0x4(%eax),%edx
 5e9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5ec:	39 ce                	cmp    %ecx,%esi
 5ee:	75 df                	jne    5cf <free+0x4f>
    p->s.size += bp->s.size;
 5f0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5f3:	a3 3c 07 00 00       	mov    %eax,0x73c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 5f8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5fb:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5fe:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 600:	5b                   	pop    %ebx
 601:	5e                   	pop    %esi
 602:	5f                   	pop    %edi
 603:	5d                   	pop    %ebp
 604:	c3                   	ret    
 605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
 616:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 619:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 61c:	8b 35 3c 07 00 00    	mov    0x73c,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 622:	83 c3 07             	add    $0x7,%ebx
 625:	c1 eb 03             	shr    $0x3,%ebx
 628:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 62b:	85 f6                	test   %esi,%esi
 62d:	0f 84 ab 00 00 00    	je     6de <malloc+0xce>
 633:	8b 16                	mov    (%esi),%edx
 635:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 638:	39 d9                	cmp    %ebx,%ecx
 63a:	0f 83 c6 00 00 00    	jae    706 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 640:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 647:	be 00 80 00 00       	mov    $0x8000,%esi
 64c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 64f:	eb 09                	jmp    65a <malloc+0x4a>
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 658:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 65a:	3b 15 3c 07 00 00    	cmp    0x73c,%edx
 660:	74 2e                	je     690 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 662:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 664:	8b 48 04             	mov    0x4(%eax),%ecx
 667:	39 cb                	cmp    %ecx,%ebx
 669:	77 ed                	ja     658 <malloc+0x48>
 66b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 66d:	39 cb                	cmp    %ecx,%ebx
 66f:	74 67                	je     6d8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 671:	29 d9                	sub    %ebx,%ecx
 673:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 676:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 679:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 67c:	89 35 3c 07 00 00    	mov    %esi,0x73c
      return (void*) (p + 1);
 682:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 685:	83 c4 2c             	add    $0x2c,%esp
 688:	5b                   	pop    %ebx
 689:	5e                   	pop    %esi
 68a:	5f                   	pop    %edi
 68b:	5d                   	pop    %ebp
 68c:	c3                   	ret    
 68d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 690:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 693:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 699:	bf 00 10 00 00       	mov    $0x1000,%edi
 69e:	0f 47 fb             	cmova  %ebx,%edi
 6a1:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 6a4:	89 04 24             	mov    %eax,(%esp)
 6a7:	e8 80 fc ff ff       	call   32c <sbrk>
  if(p == (char*) -1)
 6ac:	83 f8 ff             	cmp    $0xffffffff,%eax
 6af:	74 18                	je     6c9 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6b1:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6b4:	83 c0 08             	add    $0x8,%eax
 6b7:	89 04 24             	mov    %eax,(%esp)
 6ba:	e8 c1 fe ff ff       	call   580 <free>
  return freep;
 6bf:	8b 15 3c 07 00 00    	mov    0x73c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6c5:	85 d2                	test   %edx,%edx
 6c7:	75 99                	jne    662 <malloc+0x52>
        return 0;
  }
}
 6c9:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 6cc:	31 c0                	xor    %eax,%eax
  }
}
 6ce:	5b                   	pop    %ebx
 6cf:	5e                   	pop    %esi
 6d0:	5f                   	pop    %edi
 6d1:	5d                   	pop    %ebp
 6d2:	c3                   	ret    
 6d3:	90                   	nop
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6d8:	8b 10                	mov    (%eax),%edx
 6da:	89 16                	mov    %edx,(%esi)
 6dc:	eb 9e                	jmp    67c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6de:	c7 05 3c 07 00 00 40 	movl   $0x740,0x73c
 6e5:	07 00 00 
    base.s.size = 0;
 6e8:	ba 40 07 00 00       	mov    $0x740,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6ed:	c7 05 40 07 00 00 40 	movl   $0x740,0x740
 6f4:	07 00 00 
    base.s.size = 0;
 6f7:	c7 05 44 07 00 00 00 	movl   $0x0,0x744
 6fe:	00 00 00 
 701:	e9 3a ff ff ff       	jmp    640 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 706:	89 d0                	mov    %edx,%eax
 708:	e9 60 ff ff ff       	jmp    66d <malloc+0x5d>
