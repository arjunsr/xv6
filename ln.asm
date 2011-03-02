
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	53                   	push   %ebx
   7:	83 ec 1c             	sub    $0x1c,%esp
   a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
   d:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  11:	74 1d                	je     30 <main+0x30>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 2d 07 00 	movl   $0x72d,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 e9 03 00 00       	call   410 <printf>
    exit();
  27:	e8 98 02 00 00       	call   2c4 <exit>
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  if(link(argv[1], argv[2]) < 0)
  30:	8b 43 08             	mov    0x8(%ebx),%eax
  33:	89 44 24 04          	mov    %eax,0x4(%esp)
  37:	8b 43 04             	mov    0x4(%ebx),%eax
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	e8 e2 02 00 00       	call   324 <link>
  42:	85 c0                	test   %eax,%eax
  44:	78 0a                	js     50 <main+0x50>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  46:	e8 79 02 00 00       	call   2c4 <exit>
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  50:	8b 43 08             	mov    0x8(%ebx),%eax
  53:	89 44 24 0c          	mov    %eax,0xc(%esp)
  57:	8b 43 04             	mov    0x4(%ebx),%eax
  5a:	c7 44 24 04 40 07 00 	movl   $0x740,0x4(%esp)
  61:	00 
  62:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  69:	89 44 24 08          	mov    %eax,0x8(%esp)
  6d:	e8 9e 03 00 00       	call   410 <printf>
  72:	eb d2                	jmp    46 <main+0x46>
  74:	90                   	nop
  75:	90                   	nop
  76:	90                   	nop
  77:	90                   	nop
  78:	90                   	nop
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop
  7c:	90                   	nop
  7d:	90                   	nop
  7e:	90                   	nop
  7f:	90                   	nop

00000080 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  83:	89 e5                	mov    %esp,%ebp
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	53                   	push   %ebx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c9                	test   %cl,%cl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	eb 0d                	jmp    b0 <strcmp>
  a3:	90                   	nop
  a4:	90                   	nop
  a5:	90                   	nop
  a6:	90                   	nop
  a7:	90                   	nop
  a8:	90                   	nop
  a9:	90                   	nop
  aa:	90                   	nop
  ab:	90                   	nop
  ac:	90                   	nop
  ad:	90                   	nop
  ae:	90                   	nop
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b6:	53                   	push   %ebx
  b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ba:	0f b6 01             	movzbl (%ecx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 14                	jne    d5 <strcmp+0x25>
  c1:	eb 25                	jmp    e8 <strcmp+0x38>
  c3:	90                   	nop
  c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  c8:	83 c1 01             	add    $0x1,%ecx
  cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	0f b6 01             	movzbl (%ecx),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 13                	je     e8 <strcmp+0x38>
  d5:	0f b6 1a             	movzbl (%edx),%ebx
  d8:	38 d8                	cmp    %bl,%al
  da:	74 ec                	je     c8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  dc:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  df:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e2:	29 d8                	sub    %ebx,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e8:	0f b6 1a             	movzbl (%edx),%ebx
  eb:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ed:	0f b6 db             	movzbl %bl,%ebx
  f0:	29 d8                	sub    %ebx,%eax
}
  f2:	5b                   	pop    %ebx
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 101:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 103:	89 e5                	mov    %esp,%ebp
 105:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 108:	80 39 00             	cmpb   $0x0,(%ecx)
 10b:	74 0e                	je     11b <strlen+0x1b>
 10d:	31 d2                	xor    %edx,%edx
 10f:	90                   	nop
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 10             	mov    0x10(%ebp),%ecx
 126:	53                   	push   %ebx
 127:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 12a:	85 c9                	test   %ecx,%ecx
 12c:	74 14                	je     142 <memset+0x22>
 12e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 132:	31 d2                	xor    %edx,%edx
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 138:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 13b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 13e:	39 ca                	cmp    %ecx,%edx
 140:	75 f6                	jne    138 <memset+0x18>
    *d++ = c;
  return dst;
}
 142:	5b                   	pop    %ebx
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 11                	jne    172 <strchr+0x22>
 161:	eb 15                	jmp    178 <strchr+0x28>
 163:	90                   	nop
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 168:	83 c0 01             	add    $0x1,%eax
 16b:	0f b6 10             	movzbl (%eax),%edx
 16e:	84 d2                	test   %dl,%dl
 170:	74 06                	je     178 <strchr+0x28>
    if(*s == c)
 172:	38 ca                	cmp    %cl,%dl
 174:	75 f2                	jne    168 <strchr+0x18>
      return (char*) s;
  return 0;
}
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 178:	31 c0                	xor    %eax,%eax
}
 17a:	5d                   	pop    %ebp
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	c3                   	ret    
 181:	eb 0d                	jmp    190 <gets>
 183:	90                   	nop
 184:	90                   	nop
 185:	90                   	nop
 186:	90                   	nop
 187:	90                   	nop
 188:	90                   	nop
 189:	90                   	nop
 18a:	90                   	nop
 18b:	90                   	nop
 18c:	90                   	nop
 18d:	90                   	nop
 18e:	90                   	nop
 18f:	90                   	nop

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 197:	53                   	push   %ebx
 198:	83 ec 2c             	sub    $0x2c,%esp
 19b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	eb 31                	jmp    1d1 <gets+0x41>
    cc = read(0, &c, 1);
 1a0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1a3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1aa:	00 
 1ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 1af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b6:	e8 21 01 00 00       	call   2dc <read>
    if(cc < 1)
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1a                	jle    1d9 <gets+0x49>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 1c3:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1c5:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 1c9:	74 1d                	je     1e8 <gets+0x58>
 1cb:	3c 0a                	cmp    $0xa,%al
 1cd:	74 19                	je     1e8 <gets+0x58>
 1cf:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	7c c7                	jl     1a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1d9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1dd:	89 f8                	mov    %edi,%eax
 1df:	83 c4 2c             	add    $0x2c,%esp
 1e2:	5b                   	pop    %ebx
 1e3:	5e                   	pop    %esi
 1e4:	5f                   	pop    %edi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1ea:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ec:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1f0:	83 c4 2c             	add    $0x2c,%esp
 1f3:	5b                   	pop    %ebx
 1f4:	5e                   	pop    %esi
 1f5:	5f                   	pop    %edi
 1f6:	5d                   	pop    %ebp
 1f7:	c3                   	ret    
 1f8:	90                   	nop
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <stat>:

int
stat(char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 206:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 209:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 20c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 20f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 214:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 21b:	00 
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 e0 00 00 00       	call   304 <open>
  if(fd < 0)
 224:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 228:	78 19                	js     243 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 1c 24             	mov    %ebx,(%esp)
 230:	89 44 24 04          	mov    %eax,0x4(%esp)
 234:	e8 e3 00 00 00       	call   31c <fstat>
  close(fd);
 239:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 23c:	89 c6                	mov    %eax,%esi
  close(fd);
 23e:	e8 a9 00 00 00       	call   2ec <close>
  return r;
}
 243:	89 f0                	mov    %esi,%eax
 245:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 248:	8b 75 fc             	mov    -0x4(%ebp),%esi
 24b:	89 ec                	mov    %ebp,%esp
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
  int n;

  n = 0;
 251:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 253:	89 e5                	mov    %esp,%ebp
 255:	8b 4d 08             	mov    0x8(%ebp),%ecx
 258:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 259:	0f b6 11             	movzbl (%ecx),%edx
 25c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25f:	80 fb 09             	cmp    $0x9,%bl
 262:	77 1c                	ja     280 <atoi+0x30>
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 268:	0f be d2             	movsbl %dl,%edx
 26b:	83 c1 01             	add    $0x1,%ecx
 26e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 271:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 275:	0f b6 11             	movzbl (%ecx),%edx
 278:	8d 5a d0             	lea    -0x30(%edx),%ebx
 27b:	80 fb 09             	cmp    $0x9,%bl
 27e:	76 e8                	jbe    268 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	53                   	push   %ebx
 298:	8b 5d 10             	mov    0x10(%ebp),%ebx
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b2:	39 da                	cmp    %ebx,%edx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	90                   	nop
 2bb:	90                   	nop

000002bc <fork>:
 2bc:	b8 01 00 00 00       	mov    $0x1,%eax
 2c1:	cd 30                	int    $0x30
 2c3:	c3                   	ret    

000002c4 <exit>:
 2c4:	b8 02 00 00 00       	mov    $0x2,%eax
 2c9:	cd 30                	int    $0x30
 2cb:	c3                   	ret    

000002cc <wait>:
 2cc:	b8 03 00 00 00       	mov    $0x3,%eax
 2d1:	cd 30                	int    $0x30
 2d3:	c3                   	ret    

000002d4 <pipe>:
 2d4:	b8 04 00 00 00       	mov    $0x4,%eax
 2d9:	cd 30                	int    $0x30
 2db:	c3                   	ret    

000002dc <read>:
 2dc:	b8 06 00 00 00       	mov    $0x6,%eax
 2e1:	cd 30                	int    $0x30
 2e3:	c3                   	ret    

000002e4 <write>:
 2e4:	b8 05 00 00 00       	mov    $0x5,%eax
 2e9:	cd 30                	int    $0x30
 2eb:	c3                   	ret    

000002ec <close>:
 2ec:	b8 07 00 00 00       	mov    $0x7,%eax
 2f1:	cd 30                	int    $0x30
 2f3:	c3                   	ret    

000002f4 <kill>:
 2f4:	b8 08 00 00 00       	mov    $0x8,%eax
 2f9:	cd 30                	int    $0x30
 2fb:	c3                   	ret    

000002fc <exec>:
 2fc:	b8 09 00 00 00       	mov    $0x9,%eax
 301:	cd 30                	int    $0x30
 303:	c3                   	ret    

00000304 <open>:
 304:	b8 0a 00 00 00       	mov    $0xa,%eax
 309:	cd 30                	int    $0x30
 30b:	c3                   	ret    

0000030c <mknod>:
 30c:	b8 0b 00 00 00       	mov    $0xb,%eax
 311:	cd 30                	int    $0x30
 313:	c3                   	ret    

00000314 <unlink>:
 314:	b8 0c 00 00 00       	mov    $0xc,%eax
 319:	cd 30                	int    $0x30
 31b:	c3                   	ret    

0000031c <fstat>:
 31c:	b8 0d 00 00 00       	mov    $0xd,%eax
 321:	cd 30                	int    $0x30
 323:	c3                   	ret    

00000324 <link>:
 324:	b8 0e 00 00 00       	mov    $0xe,%eax
 329:	cd 30                	int    $0x30
 32b:	c3                   	ret    

0000032c <mkdir>:
 32c:	b8 0f 00 00 00       	mov    $0xf,%eax
 331:	cd 30                	int    $0x30
 333:	c3                   	ret    

00000334 <chdir>:
 334:	b8 10 00 00 00       	mov    $0x10,%eax
 339:	cd 30                	int    $0x30
 33b:	c3                   	ret    

0000033c <dup>:
 33c:	b8 11 00 00 00       	mov    $0x11,%eax
 341:	cd 30                	int    $0x30
 343:	c3                   	ret    

00000344 <getpid>:
 344:	b8 12 00 00 00       	mov    $0x12,%eax
 349:	cd 30                	int    $0x30
 34b:	c3                   	ret    

0000034c <sbrk>:
 34c:	b8 13 00 00 00       	mov    $0x13,%eax
 351:	cd 30                	int    $0x30
 353:	c3                   	ret    

00000354 <sleep>:
 354:	b8 14 00 00 00       	mov    $0x14,%eax
 359:	cd 30                	int    $0x30
 35b:	c3                   	ret    
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 28             	sub    $0x28,%esp
 366:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 369:	8d 55 f4             	lea    -0xc(%ebp),%edx
 36c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 373:	00 
 374:	89 54 24 04          	mov    %edx,0x4(%esp)
 378:	89 04 24             	mov    %eax,(%esp)
 37b:	e8 64 ff ff ff       	call   2e4 <write>
}
 380:	c9                   	leave  
 381:	c3                   	ret    
 382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	89 c7                	mov    %eax,%edi
 396:	56                   	push   %esi
 397:	89 ce                	mov    %ecx,%esi
 399:	53                   	push   %ebx
 39a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a0:	85 c9                	test   %ecx,%ecx
 3a2:	74 09                	je     3ad <printint+0x1d>
 3a4:	89 d0                	mov    %edx,%eax
 3a6:	c1 e8 1f             	shr    $0x1f,%eax
 3a9:	84 c0                	test   %al,%al
 3ab:	75 53                	jne    400 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ad:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3af:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3b6:	31 c9                	xor    %ecx,%ecx
 3b8:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3bb:	90                   	nop
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	31 d2                	xor    %edx,%edx
 3c2:	f7 f6                	div    %esi
 3c4:	0f b6 92 5b 07 00 00 	movzbl 0x75b(%edx),%edx
 3cb:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 3ce:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 3d1:	85 c0                	test   %eax,%eax
 3d3:	75 eb                	jne    3c0 <printint+0x30>
  if(neg)
 3d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3d8:	85 c0                	test   %eax,%eax
 3da:	74 08                	je     3e4 <printint+0x54>
    buf[i++] = '-';
 3dc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3e1:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 3e4:	8d 71 ff             	lea    -0x1(%ecx),%esi
 3e7:	90                   	nop
    putc(fd, buf[i]);
 3e8:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 3ec:	89 f8                	mov    %edi,%eax
 3ee:	e8 6d ff ff ff       	call   360 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f3:	83 ee 01             	sub    $0x1,%esi
 3f6:	79 f0                	jns    3e8 <printint+0x58>
    putc(fd, buf[i]);
}
 3f8:	83 c4 2c             	add    $0x2c,%esp
 3fb:	5b                   	pop    %ebx
 3fc:	5e                   	pop    %esi
 3fd:	5f                   	pop    %edi
 3fe:	5d                   	pop    %ebp
 3ff:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 400:	89 d0                	mov    %edx,%eax
 402:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 404:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 40b:	eb a9                	jmp    3b6 <printint+0x26>
 40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 41c:	0f b6 0b             	movzbl (%ebx),%ecx
 41f:	84 c9                	test   %cl,%cl
 421:	0f 84 99 00 00 00    	je     4c0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 427:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 42c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 42f:	eb 26                	jmp    457 <printf+0x47>
 431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 f9 25             	cmp    $0x25,%ecx
 43b:	0f 84 87 00 00 00    	je     4c8 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	0f be d1             	movsbl %cl,%edx
 447:	e8 14 ff ff ff       	call   360 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 450:	83 c3 01             	add    $0x1,%ebx
 453:	84 c9                	test   %cl,%cl
 455:	74 69                	je     4c0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 457:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 459:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 45c:	74 da                	je     438 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 45e:	83 fe 25             	cmp    $0x25,%esi
 461:	75 e9                	jne    44c <printf+0x3c>
      if(c == 'd'){
 463:	83 f9 64             	cmp    $0x64,%ecx
 466:	0f 84 f4 00 00 00    	je     560 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 46c:	83 f9 70             	cmp    $0x70,%ecx
 46f:	90                   	nop
 470:	74 66                	je     4d8 <printf+0xc8>
 472:	83 f9 78             	cmp    $0x78,%ecx
 475:	74 61                	je     4d8 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 477:	83 f9 73             	cmp    $0x73,%ecx
 47a:	0f 84 80 00 00 00    	je     500 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 480:	83 f9 63             	cmp    $0x63,%ecx
 483:	0f 84 f9 00 00 00    	je     582 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 489:	83 f9 25             	cmp    $0x25,%ecx
 48c:	0f 84 b6 00 00 00    	je     548 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 49a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 49c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 49f:	e8 bc fe ff ff       	call   360 <putc>
        putc(fd, c);
 4a4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 4a7:	8b 45 08             	mov    0x8(%ebp),%eax
 4aa:	0f be d1             	movsbl %cl,%edx
 4ad:	e8 ae fe ff ff       	call   360 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b2:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 4b6:	83 c3 01             	add    $0x1,%ebx
 4b9:	84 c9                	test   %cl,%cl
 4bb:	75 9a                	jne    457 <printf+0x47>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c0:	83 c4 2c             	add    $0x2c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c8:	be 25 00 00 00       	mov    $0x25,%esi
 4cd:	e9 7a ff ff ff       	jmp    44c <printf+0x3c>
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4db:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e0:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4e9:	8b 10                	mov    (%eax),%edx
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	e8 9d fe ff ff       	call   390 <printint>
        ap++;
 4f3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 4f7:	e9 50 ff ff ff       	jmp    44c <printf+0x3c>
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 500:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 503:	8b 38                	mov    (%eax),%edi
        ap++;
 505:	83 c0 04             	add    $0x4,%eax
 508:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 50b:	b8 54 07 00 00       	mov    $0x754,%eax
 510:	85 ff                	test   %edi,%edi
 512:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 515:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 517:	0f b6 17             	movzbl (%edi),%edx
 51a:	84 d2                	test   %dl,%dl
 51c:	0f 84 2a ff ff ff    	je     44c <printf+0x3c>
 522:	89 de                	mov    %ebx,%esi
 524:	8b 5d 08             	mov    0x8(%ebp),%ebx
 527:	90                   	nop
          putc(fd, *s);
 528:	0f be d2             	movsbl %dl,%edx
          s++;
 52b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 52e:	89 d8                	mov    %ebx,%eax
 530:	e8 2b fe ff ff       	call   360 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 535:	0f b6 17             	movzbl (%edi),%edx
 538:	84 d2                	test   %dl,%dl
 53a:	75 ec                	jne    528 <printf+0x118>
 53c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53e:	31 f6                	xor    %esi,%esi
 540:	e9 07 ff ff ff       	jmp    44c <printf+0x3c>
 545:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 550:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 552:	e8 09 fe ff ff       	call   360 <putc>
 557:	e9 f0 fe ff ff       	jmp    44c <printf+0x3c>
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 560:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 563:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 565:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 568:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 56f:	8b 10                	mov    (%eax),%edx
 571:	8b 45 08             	mov    0x8(%ebp),%eax
 574:	e8 17 fe ff ff       	call   390 <printint>
        ap++;
 579:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 57d:	e9 ca fe ff ff       	jmp    44c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 582:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 585:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 587:	0f be 10             	movsbl (%eax),%edx
 58a:	8b 45 08             	mov    0x8(%ebp),%eax
 58d:	e8 ce fd ff ff       	call   360 <putc>
        ap++;
 592:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 596:	e9 b1 fe ff ff       	jmp    44c <printf+0x3c>
 59b:	90                   	nop
 59c:	90                   	nop
 59d:	90                   	nop
 59e:	90                   	nop
 59f:	90                   	nop

000005a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a1:	a1 6c 07 00 00       	mov    0x76c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a6:	89 e5                	mov    %esp,%ebp
 5a8:	57                   	push   %edi
 5a9:	56                   	push   %esi
 5aa:	53                   	push   %ebx
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	39 c8                	cmp    %ecx,%eax
 5b3:	73 1d                	jae    5d2 <free+0x32>
 5b5:	8d 76 00             	lea    0x0(%esi),%esi
 5b8:	8b 10                	mov    (%eax),%edx
 5ba:	39 d1                	cmp    %edx,%ecx
 5bc:	72 1a                	jb     5d8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5be:	39 d0                	cmp    %edx,%eax
 5c0:	72 08                	jb     5ca <free+0x2a>
 5c2:	39 c8                	cmp    %ecx,%eax
 5c4:	72 12                	jb     5d8 <free+0x38>
 5c6:	39 d1                	cmp    %edx,%ecx
 5c8:	72 0e                	jb     5d8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ca:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5cc:	39 c8                	cmp    %ecx,%eax
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	72 e6                	jb     5b8 <free+0x18>
 5d2:	8b 10                	mov    (%eax),%edx
 5d4:	eb e8                	jmp    5be <free+0x1e>
 5d6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d8:	8b 71 04             	mov    0x4(%ecx),%esi
 5db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5de:	39 d7                	cmp    %edx,%edi
 5e0:	74 19                	je     5fb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5e2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5e5:	8b 50 04             	mov    0x4(%eax),%edx
 5e8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5eb:	39 ce                	cmp    %ecx,%esi
 5ed:	74 21                	je     610 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5ef:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5f1:	a3 6c 07 00 00       	mov    %eax,0x76c
}
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5fb:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5fe:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 600:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 603:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 606:	8b 50 04             	mov    0x4(%eax),%edx
 609:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 60c:	39 ce                	cmp    %ecx,%esi
 60e:	75 df                	jne    5ef <free+0x4f>
    p->s.size += bp->s.size;
 610:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 613:	a3 6c 07 00 00       	mov    %eax,0x76c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 618:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 61b:	8b 53 f8             	mov    -0x8(%ebx),%edx
 61e:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 620:	5b                   	pop    %ebx
 621:	5e                   	pop    %esi
 622:	5f                   	pop    %edi
 623:	5d                   	pop    %ebp
 624:	c3                   	ret    
 625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 639:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 63c:	8b 35 6c 07 00 00    	mov    0x76c,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 642:	83 c3 07             	add    $0x7,%ebx
 645:	c1 eb 03             	shr    $0x3,%ebx
 648:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 64b:	85 f6                	test   %esi,%esi
 64d:	0f 84 ab 00 00 00    	je     6fe <malloc+0xce>
 653:	8b 16                	mov    (%esi),%edx
 655:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 658:	39 d9                	cmp    %ebx,%ecx
 65a:	0f 83 c6 00 00 00    	jae    726 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 660:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 667:	be 00 80 00 00       	mov    $0x8000,%esi
 66c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 66f:	eb 09                	jmp    67a <malloc+0x4a>
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 678:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 67a:	3b 15 6c 07 00 00    	cmp    0x76c,%edx
 680:	74 2e                	je     6b0 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 682:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 684:	8b 48 04             	mov    0x4(%eax),%ecx
 687:	39 cb                	cmp    %ecx,%ebx
 689:	77 ed                	ja     678 <malloc+0x48>
 68b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 68d:	39 cb                	cmp    %ecx,%ebx
 68f:	74 67                	je     6f8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 691:	29 d9                	sub    %ebx,%ecx
 693:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 696:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 699:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 69c:	89 35 6c 07 00 00    	mov    %esi,0x76c
      return (void*) (p + 1);
 6a2:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6a5:	83 c4 2c             	add    $0x2c,%esp
 6a8:	5b                   	pop    %ebx
 6a9:	5e                   	pop    %esi
 6aa:	5f                   	pop    %edi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret    
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 6b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b3:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6b9:	bf 00 10 00 00       	mov    $0x1000,%edi
 6be:	0f 47 fb             	cmova  %ebx,%edi
 6c1:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 6c4:	89 04 24             	mov    %eax,(%esp)
 6c7:	e8 80 fc ff ff       	call   34c <sbrk>
  if(p == (char*) -1)
 6cc:	83 f8 ff             	cmp    $0xffffffff,%eax
 6cf:	74 18                	je     6e9 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6d1:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6d4:	83 c0 08             	add    $0x8,%eax
 6d7:	89 04 24             	mov    %eax,(%esp)
 6da:	e8 c1 fe ff ff       	call   5a0 <free>
  return freep;
 6df:	8b 15 6c 07 00 00    	mov    0x76c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6e5:	85 d2                	test   %edx,%edx
 6e7:	75 99                	jne    682 <malloc+0x52>
        return 0;
  }
}
 6e9:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 6ec:	31 c0                	xor    %eax,%eax
  }
}
 6ee:	5b                   	pop    %ebx
 6ef:	5e                   	pop    %esi
 6f0:	5f                   	pop    %edi
 6f1:	5d                   	pop    %ebp
 6f2:	c3                   	ret    
 6f3:	90                   	nop
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6f8:	8b 10                	mov    (%eax),%edx
 6fa:	89 16                	mov    %edx,(%esi)
 6fc:	eb 9e                	jmp    69c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6fe:	c7 05 6c 07 00 00 70 	movl   $0x770,0x76c
 705:	07 00 00 
    base.s.size = 0;
 708:	ba 70 07 00 00       	mov    $0x770,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 70d:	c7 05 70 07 00 00 70 	movl   $0x770,0x770
 714:	07 00 00 
    base.s.size = 0;
 717:	c7 05 74 07 00 00 00 	movl   $0x0,0x774
 71e:	00 00 00 
 721:	e9 3a ff ff ff       	jmp    660 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 726:	89 d0                	mov    %edx,%eax
 728:	e9 60 ff ff ff       	jmp    68d <malloc+0x5d>
