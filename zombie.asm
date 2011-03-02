
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 5e 02 00 00       	call   26c <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 e6 02 00 00       	call   304 <sleep>
  exit();
  1e:	e8 51 02 00 00       	call   274 <exit>
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
  2a:	90                   	nop
  2b:	90                   	nop
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop

00000030 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  33:	89 e5                	mov    %esp,%ebp
  35:	8b 45 08             	mov    0x8(%ebp),%eax
  38:	53                   	push   %ebx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 c9                	test   %cl,%cl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	5b                   	pop    %ebx
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    
  51:	eb 0d                	jmp    60 <strcmp>
  53:	90                   	nop
  54:	90                   	nop
  55:	90                   	nop
  56:	90                   	nop
  57:	90                   	nop
  58:	90                   	nop
  59:	90                   	nop
  5a:	90                   	nop
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	90                   	nop
  5e:	90                   	nop
  5f:	90                   	nop

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  66:	53                   	push   %ebx
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6a:	0f b6 01             	movzbl (%ecx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 14                	jne    85 <strcmp+0x25>
  71:	eb 25                	jmp    98 <strcmp+0x38>
  73:	90                   	nop
  74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  78:	83 c1 01             	add    $0x1,%ecx
  7b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7e:	0f b6 01             	movzbl (%ecx),%eax
  81:	84 c0                	test   %al,%al
  83:	74 13                	je     98 <strcmp+0x38>
  85:	0f b6 1a             	movzbl (%edx),%ebx
  88:	38 d8                	cmp    %bl,%al
  8a:	74 ec                	je     78 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  8c:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8f:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  92:	29 d8                	sub    %ebx,%eax
}
  94:	5b                   	pop    %ebx
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  97:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  98:	0f b6 1a             	movzbl (%edx),%ebx
  9b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  9d:	0f b6 db             	movzbl %bl,%ebx
  a0:	29 d8                	sub    %ebx,%eax
}
  a2:	5b                   	pop    %ebx
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    
  a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  b1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b3:	89 e5                	mov    %esp,%ebp
  b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b8:	80 39 00             	cmpb   $0x0,(%ecx)
  bb:	74 0e                	je     cb <strlen+0x1b>
  bd:	31 d2                	xor    %edx,%edx
  bf:	90                   	nop
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d6:	53                   	push   %ebx
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
  da:	85 c9                	test   %ecx,%ecx
  dc:	74 14                	je     f2 <memset+0x22>
  de:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
  e2:	31 d2                	xor    %edx,%edx
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  e8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  eb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
  ee:	39 ca                	cmp    %ecx,%edx
  f0:	75 f6                	jne    e8 <memset+0x18>
    *d++ = c;
  return dst;
}
  f2:	5b                   	pop    %ebx
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 11                	jne    122 <strchr+0x22>
 111:	eb 15                	jmp    128 <strchr+0x28>
 113:	90                   	nop
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 118:	83 c0 01             	add    $0x1,%eax
 11b:	0f b6 10             	movzbl (%eax),%edx
 11e:	84 d2                	test   %dl,%dl
 120:	74 06                	je     128 <strchr+0x28>
    if(*s == c)
 122:	38 ca                	cmp    %cl,%dl
 124:	75 f2                	jne    118 <strchr+0x18>
      return (char*) s;
  return 0;
}
 126:	5d                   	pop    %ebp
 127:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 128:	31 c0                	xor    %eax,%eax
}
 12a:	5d                   	pop    %ebp
 12b:	90                   	nop
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	c3                   	ret    
 131:	eb 0d                	jmp    140 <gets>
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

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 147:	53                   	push   %ebx
 148:	83 ec 2c             	sub    $0x2c,%esp
 14b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14e:	eb 31                	jmp    181 <gets+0x41>
    cc = read(0, &c, 1);
 150:	8d 45 e7             	lea    -0x19(%ebp),%eax
 153:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 15a:	00 
 15b:	89 44 24 04          	mov    %eax,0x4(%esp)
 15f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 166:	e8 21 01 00 00       	call   28c <read>
    if(cc < 1)
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1a                	jle    189 <gets+0x49>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 173:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 175:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 179:	74 1d                	je     198 <gets+0x58>
 17b:	3c 0a                	cmp    $0xa,%al
 17d:	74 19                	je     198 <gets+0x58>
 17f:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 181:	8d 5e 01             	lea    0x1(%esi),%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	7c c7                	jl     150 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 189:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 18d:	89 f8                	mov    %edi,%eax
 18f:	83 c4 2c             	add    $0x2c,%esp
 192:	5b                   	pop    %ebx
 193:	5e                   	pop    %esi
 194:	5f                   	pop    %edi
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    
 197:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 198:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 19a:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1a0:	83 c4 2c             	add    $0x2c,%esp
 1a3:	5b                   	pop    %ebx
 1a4:	5e                   	pop    %esi
 1a5:	5f                   	pop    %edi
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    
 1a8:	90                   	nop
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <stat>:

int
stat(char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1cb:	00 
 1cc:	89 04 24             	mov    %eax,(%esp)
 1cf:	e8 e0 00 00 00       	call   2b4 <open>
  if(fd < 0)
 1d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1d8:	78 19                	js     1f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 1c 24             	mov    %ebx,(%esp)
 1e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e4:	e8 e3 00 00 00       	call   2cc <fstat>
  close(fd);
 1e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1ec:	89 c6                	mov    %eax,%esi
  close(fd);
 1ee:	e8 a9 00 00 00       	call   29c <close>
  return r;
}
 1f3:	89 f0                	mov    %esi,%eax
 1f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1fb:	89 ec                	mov    %ebp,%esp
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
  int n;

  n = 0;
 201:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 203:	89 e5                	mov    %esp,%ebp
 205:	8b 4d 08             	mov    0x8(%ebp),%ecx
 208:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 209:	0f b6 11             	movzbl (%ecx),%edx
 20c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 20f:	80 fb 09             	cmp    $0x9,%bl
 212:	77 1c                	ja     230 <atoi+0x30>
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 218:	0f be d2             	movsbl %dl,%edx
 21b:	83 c1 01             	add    $0x1,%ecx
 21e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 221:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 225:	0f b6 11             	movzbl (%ecx),%edx
 228:	8d 5a d0             	lea    -0x30(%edx),%ebx
 22b:	80 fb 09             	cmp    $0x9,%bl
 22e:	76 e8                	jbe    218 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 230:	5b                   	pop    %ebx
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	53                   	push   %ebx
 248:	8b 5d 10             	mov    0x10(%ebp),%ebx
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 db                	test   %ebx,%ebx
 250:	7e 14                	jle    266 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 252:	31 d2                	xor    %edx,%edx
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 258:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 25c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 25f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 262:	39 da                	cmp    %ebx,%edx
 264:	75 f2                	jne    258 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 266:	5b                   	pop    %ebx
 267:	5e                   	pop    %esi
 268:	5d                   	pop    %ebp
 269:	c3                   	ret    
 26a:	90                   	nop
 26b:	90                   	nop

0000026c <fork>:
 26c:	b8 01 00 00 00       	mov    $0x1,%eax
 271:	cd 30                	int    $0x30
 273:	c3                   	ret    

00000274 <exit>:
 274:	b8 02 00 00 00       	mov    $0x2,%eax
 279:	cd 30                	int    $0x30
 27b:	c3                   	ret    

0000027c <wait>:
 27c:	b8 03 00 00 00       	mov    $0x3,%eax
 281:	cd 30                	int    $0x30
 283:	c3                   	ret    

00000284 <pipe>:
 284:	b8 04 00 00 00       	mov    $0x4,%eax
 289:	cd 30                	int    $0x30
 28b:	c3                   	ret    

0000028c <read>:
 28c:	b8 06 00 00 00       	mov    $0x6,%eax
 291:	cd 30                	int    $0x30
 293:	c3                   	ret    

00000294 <write>:
 294:	b8 05 00 00 00       	mov    $0x5,%eax
 299:	cd 30                	int    $0x30
 29b:	c3                   	ret    

0000029c <close>:
 29c:	b8 07 00 00 00       	mov    $0x7,%eax
 2a1:	cd 30                	int    $0x30
 2a3:	c3                   	ret    

000002a4 <kill>:
 2a4:	b8 08 00 00 00       	mov    $0x8,%eax
 2a9:	cd 30                	int    $0x30
 2ab:	c3                   	ret    

000002ac <exec>:
 2ac:	b8 09 00 00 00       	mov    $0x9,%eax
 2b1:	cd 30                	int    $0x30
 2b3:	c3                   	ret    

000002b4 <open>:
 2b4:	b8 0a 00 00 00       	mov    $0xa,%eax
 2b9:	cd 30                	int    $0x30
 2bb:	c3                   	ret    

000002bc <mknod>:
 2bc:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c1:	cd 30                	int    $0x30
 2c3:	c3                   	ret    

000002c4 <unlink>:
 2c4:	b8 0c 00 00 00       	mov    $0xc,%eax
 2c9:	cd 30                	int    $0x30
 2cb:	c3                   	ret    

000002cc <fstat>:
 2cc:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d1:	cd 30                	int    $0x30
 2d3:	c3                   	ret    

000002d4 <link>:
 2d4:	b8 0e 00 00 00       	mov    $0xe,%eax
 2d9:	cd 30                	int    $0x30
 2db:	c3                   	ret    

000002dc <mkdir>:
 2dc:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e1:	cd 30                	int    $0x30
 2e3:	c3                   	ret    

000002e4 <chdir>:
 2e4:	b8 10 00 00 00       	mov    $0x10,%eax
 2e9:	cd 30                	int    $0x30
 2eb:	c3                   	ret    

000002ec <dup>:
 2ec:	b8 11 00 00 00       	mov    $0x11,%eax
 2f1:	cd 30                	int    $0x30
 2f3:	c3                   	ret    

000002f4 <getpid>:
 2f4:	b8 12 00 00 00       	mov    $0x12,%eax
 2f9:	cd 30                	int    $0x30
 2fb:	c3                   	ret    

000002fc <sbrk>:
 2fc:	b8 13 00 00 00       	mov    $0x13,%eax
 301:	cd 30                	int    $0x30
 303:	c3                   	ret    

00000304 <sleep>:
 304:	b8 14 00 00 00       	mov    $0x14,%eax
 309:	cd 30                	int    $0x30
 30b:	c3                   	ret    
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 28             	sub    $0x28,%esp
 316:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 319:	8d 55 f4             	lea    -0xc(%ebp),%edx
 31c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 323:	00 
 324:	89 54 24 04          	mov    %edx,0x4(%esp)
 328:	89 04 24             	mov    %eax,(%esp)
 32b:	e8 64 ff ff ff       	call   294 <write>
}
 330:	c9                   	leave  
 331:	c3                   	ret    
 332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	89 c7                	mov    %eax,%edi
 346:	56                   	push   %esi
 347:	89 ce                	mov    %ecx,%esi
 349:	53                   	push   %ebx
 34a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 350:	85 c9                	test   %ecx,%ecx
 352:	74 09                	je     35d <printint+0x1d>
 354:	89 d0                	mov    %edx,%eax
 356:	c1 e8 1f             	shr    $0x1f,%eax
 359:	84 c0                	test   %al,%al
 35b:	75 53                	jne    3b0 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 35d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 35f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 366:	31 c9                	xor    %ecx,%ecx
 368:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 36b:	90                   	nop
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 370:	31 d2                	xor    %edx,%edx
 372:	f7 f6                	div    %esi
 374:	0f b6 92 e4 06 00 00 	movzbl 0x6e4(%edx),%edx
 37b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 37e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 381:	85 c0                	test   %eax,%eax
 383:	75 eb                	jne    370 <printint+0x30>
  if(neg)
 385:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 388:	85 c0                	test   %eax,%eax
 38a:	74 08                	je     394 <printint+0x54>
    buf[i++] = '-';
 38c:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 391:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 394:	8d 71 ff             	lea    -0x1(%ecx),%esi
 397:	90                   	nop
    putc(fd, buf[i]);
 398:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 39c:	89 f8                	mov    %edi,%eax
 39e:	e8 6d ff ff ff       	call   310 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3a3:	83 ee 01             	sub    $0x1,%esi
 3a6:	79 f0                	jns    398 <printint+0x58>
    putc(fd, buf[i]);
}
 3a8:	83 c4 2c             	add    $0x2c,%esp
 3ab:	5b                   	pop    %ebx
 3ac:	5e                   	pop    %esi
 3ad:	5f                   	pop    %edi
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3b0:	89 d0                	mov    %edx,%eax
 3b2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3b4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 3bb:	eb a9                	jmp    366 <printint+0x26>
 3bd:	8d 76 00             	lea    0x0(%esi),%esi

000003c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3cc:	0f b6 0b             	movzbl (%ebx),%ecx
 3cf:	84 c9                	test   %cl,%cl
 3d1:	0f 84 99 00 00 00    	je     470 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3d7:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3da:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 3dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 3df:	eb 26                	jmp    407 <printf+0x47>
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3e8:	83 f9 25             	cmp    $0x25,%ecx
 3eb:	0f 84 87 00 00 00    	je     478 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	0f be d1             	movsbl %cl,%edx
 3f7:	e8 14 ff ff ff       	call   310 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3fc:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 400:	83 c3 01             	add    $0x1,%ebx
 403:	84 c9                	test   %cl,%cl
 405:	74 69                	je     470 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 407:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 409:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 40c:	74 da                	je     3e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 40e:	83 fe 25             	cmp    $0x25,%esi
 411:	75 e9                	jne    3fc <printf+0x3c>
      if(c == 'd'){
 413:	83 f9 64             	cmp    $0x64,%ecx
 416:	0f 84 f4 00 00 00    	je     510 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 41c:	83 f9 70             	cmp    $0x70,%ecx
 41f:	90                   	nop
 420:	74 66                	je     488 <printf+0xc8>
 422:	83 f9 78             	cmp    $0x78,%ecx
 425:	74 61                	je     488 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 427:	83 f9 73             	cmp    $0x73,%ecx
 42a:	0f 84 80 00 00 00    	je     4b0 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 430:	83 f9 63             	cmp    $0x63,%ecx
 433:	0f 84 f9 00 00 00    	je     532 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 439:	83 f9 25             	cmp    $0x25,%ecx
 43c:	0f 84 b6 00 00 00    	je     4f8 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 442:	8b 45 08             	mov    0x8(%ebp),%eax
 445:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 44a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 44c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 44f:	e8 bc fe ff ff       	call   310 <putc>
        putc(fd, c);
 454:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 457:	8b 45 08             	mov    0x8(%ebp),%eax
 45a:	0f be d1             	movsbl %cl,%edx
 45d:	e8 ae fe ff ff       	call   310 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 462:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 466:	83 c3 01             	add    $0x1,%ebx
 469:	84 c9                	test   %cl,%cl
 46b:	75 9a                	jne    407 <printf+0x47>
 46d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 470:	83 c4 2c             	add    $0x2c,%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 478:	be 25 00 00 00       	mov    $0x25,%esi
 47d:	e9 7a ff ff ff       	jmp    3fc <printf+0x3c>
 482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 488:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 48b:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 490:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 492:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 499:	8b 10                	mov    (%eax),%edx
 49b:	8b 45 08             	mov    0x8(%ebp),%eax
 49e:	e8 9d fe ff ff       	call   340 <printint>
        ap++;
 4a3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 4a7:	e9 50 ff ff ff       	jmp    3fc <printf+0x3c>
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b3:	8b 38                	mov    (%eax),%edi
        ap++;
 4b5:	83 c0 04             	add    $0x4,%eax
 4b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 4bb:	b8 dd 06 00 00       	mov    $0x6dd,%eax
 4c0:	85 ff                	test   %edi,%edi
 4c2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4c7:	0f b6 17             	movzbl (%edi),%edx
 4ca:	84 d2                	test   %dl,%dl
 4cc:	0f 84 2a ff ff ff    	je     3fc <printf+0x3c>
 4d2:	89 de                	mov    %ebx,%esi
 4d4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4d7:	90                   	nop
          putc(fd, *s);
 4d8:	0f be d2             	movsbl %dl,%edx
          s++;
 4db:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 4de:	89 d8                	mov    %ebx,%eax
 4e0:	e8 2b fe ff ff       	call   310 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4e5:	0f b6 17             	movzbl (%edi),%edx
 4e8:	84 d2                	test   %dl,%dl
 4ea:	75 ec                	jne    4d8 <printf+0x118>
 4ec:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ee:	31 f6                	xor    %esi,%esi
 4f0:	e9 07 ff ff ff       	jmp    3fc <printf+0x3c>
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 500:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 502:	e8 09 fe ff ff       	call   310 <putc>
 507:	e9 f0 fe ff ff       	jmp    3fc <printf+0x3c>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 510:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 513:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 515:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 518:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 51f:	8b 10                	mov    (%eax),%edx
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	e8 17 fe ff ff       	call   340 <printint>
        ap++;
 529:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 52d:	e9 ca fe ff ff       	jmp    3fc <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 532:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 535:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 537:	0f be 10             	movsbl (%eax),%edx
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	e8 ce fd ff ff       	call   310 <putc>
        ap++;
 542:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 546:	e9 b1 fe ff ff       	jmp    3fc <printf+0x3c>
 54b:	90                   	nop
 54c:	90                   	nop
 54d:	90                   	nop
 54e:	90                   	nop
 54f:	90                   	nop

00000550 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 550:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 551:	a1 f8 06 00 00       	mov    0x6f8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 556:	89 e5                	mov    %esp,%ebp
 558:	57                   	push   %edi
 559:	56                   	push   %esi
 55a:	53                   	push   %ebx
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 55e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	39 c8                	cmp    %ecx,%eax
 563:	73 1d                	jae    582 <free+0x32>
 565:	8d 76 00             	lea    0x0(%esi),%esi
 568:	8b 10                	mov    (%eax),%edx
 56a:	39 d1                	cmp    %edx,%ecx
 56c:	72 1a                	jb     588 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56e:	39 d0                	cmp    %edx,%eax
 570:	72 08                	jb     57a <free+0x2a>
 572:	39 c8                	cmp    %ecx,%eax
 574:	72 12                	jb     588 <free+0x38>
 576:	39 d1                	cmp    %edx,%ecx
 578:	72 0e                	jb     588 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 57a:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 57c:	39 c8                	cmp    %ecx,%eax
 57e:	66 90                	xchg   %ax,%ax
 580:	72 e6                	jb     568 <free+0x18>
 582:	8b 10                	mov    (%eax),%edx
 584:	eb e8                	jmp    56e <free+0x1e>
 586:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 588:	8b 71 04             	mov    0x4(%ecx),%esi
 58b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 58e:	39 d7                	cmp    %edx,%edi
 590:	74 19                	je     5ab <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 592:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 595:	8b 50 04             	mov    0x4(%eax),%edx
 598:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 59b:	39 ce                	cmp    %ecx,%esi
 59d:	74 21                	je     5c0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 59f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5a1:	a3 f8 06 00 00       	mov    %eax,0x6f8
}
 5a6:	5b                   	pop    %ebx
 5a7:	5e                   	pop    %esi
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5ab:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5ae:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5b0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5b3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5b6:	8b 50 04             	mov    0x4(%eax),%edx
 5b9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5bc:	39 ce                	cmp    %ecx,%esi
 5be:	75 df                	jne    59f <free+0x4f>
    p->s.size += bp->s.size;
 5c0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5c3:	a3 f8 06 00 00       	mov    %eax,0x6f8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 5c8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5cb:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5ce:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5d0:	5b                   	pop    %ebx
 5d1:	5e                   	pop    %esi
 5d2:	5f                   	pop    %edi
 5d3:	5d                   	pop    %ebp
 5d4:	c3                   	ret    
 5d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 5ec:	8b 35 f8 06 00 00    	mov    0x6f8,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f2:	83 c3 07             	add    $0x7,%ebx
 5f5:	c1 eb 03             	shr    $0x3,%ebx
 5f8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5fb:	85 f6                	test   %esi,%esi
 5fd:	0f 84 ab 00 00 00    	je     6ae <malloc+0xce>
 603:	8b 16                	mov    (%esi),%edx
 605:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 608:	39 d9                	cmp    %ebx,%ecx
 60a:	0f 83 c6 00 00 00    	jae    6d6 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 610:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 617:	be 00 80 00 00       	mov    $0x8000,%esi
 61c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 61f:	eb 09                	jmp    62a <malloc+0x4a>
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 628:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 62a:	3b 15 f8 06 00 00    	cmp    0x6f8,%edx
 630:	74 2e                	je     660 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 632:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 634:	8b 48 04             	mov    0x4(%eax),%ecx
 637:	39 cb                	cmp    %ecx,%ebx
 639:	77 ed                	ja     628 <malloc+0x48>
 63b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 63d:	39 cb                	cmp    %ecx,%ebx
 63f:	74 67                	je     6a8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 641:	29 d9                	sub    %ebx,%ecx
 643:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 646:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 649:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 64c:	89 35 f8 06 00 00    	mov    %esi,0x6f8
      return (void*) (p + 1);
 652:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 655:	83 c4 2c             	add    $0x2c,%esp
 658:	5b                   	pop    %ebx
 659:	5e                   	pop    %esi
 65a:	5f                   	pop    %edi
 65b:	5d                   	pop    %ebp
 65c:	c3                   	ret    
 65d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 660:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 663:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 669:	bf 00 10 00 00       	mov    $0x1000,%edi
 66e:	0f 47 fb             	cmova  %ebx,%edi
 671:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 674:	89 04 24             	mov    %eax,(%esp)
 677:	e8 80 fc ff ff       	call   2fc <sbrk>
  if(p == (char*) -1)
 67c:	83 f8 ff             	cmp    $0xffffffff,%eax
 67f:	74 18                	je     699 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 681:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 684:	83 c0 08             	add    $0x8,%eax
 687:	89 04 24             	mov    %eax,(%esp)
 68a:	e8 c1 fe ff ff       	call   550 <free>
  return freep;
 68f:	8b 15 f8 06 00 00    	mov    0x6f8,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 695:	85 d2                	test   %edx,%edx
 697:	75 99                	jne    632 <malloc+0x52>
        return 0;
  }
}
 699:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 69c:	31 c0                	xor    %eax,%eax
  }
}
 69e:	5b                   	pop    %ebx
 69f:	5e                   	pop    %esi
 6a0:	5f                   	pop    %edi
 6a1:	5d                   	pop    %ebp
 6a2:	c3                   	ret    
 6a3:	90                   	nop
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6a8:	8b 10                	mov    (%eax),%edx
 6aa:	89 16                	mov    %edx,(%esi)
 6ac:	eb 9e                	jmp    64c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6ae:	c7 05 f8 06 00 00 fc 	movl   $0x6fc,0x6f8
 6b5:	06 00 00 
    base.s.size = 0;
 6b8:	ba fc 06 00 00       	mov    $0x6fc,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6bd:	c7 05 fc 06 00 00 fc 	movl   $0x6fc,0x6fc
 6c4:	06 00 00 
    base.s.size = 0;
 6c7:	c7 05 00 07 00 00 00 	movl   $0x0,0x700
 6ce:	00 00 00 
 6d1:	e9 3a ff ff ff       	jmp    610 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6d6:	89 d0                	mov    %edx,%eax
 6d8:	e9 60 ff ff ff       	jmp    63d <malloc+0x5d>
