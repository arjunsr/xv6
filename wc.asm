
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
   4:	31 ff                	xor    %edi,%edi

char buf[512];

void
wc(int fd, char *name)
{
   6:	56                   	push   %esi
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   7:	31 f6                	xor    %esi,%esi

char buf[512];

void
wc(int fd, char *name)
{
   9:	53                   	push   %ebx
   a:	83 ec 3c             	sub    $0x3c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  14:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  1b:	90                   	nop
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	8b 45 08             	mov    0x8(%ebp),%eax
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 c0 08 00 	movl   $0x8c0,0x4(%esp)
  32:	00 
  33:	89 04 24             	mov    %eax,(%esp)
  36:	e8 c1 03 00 00       	call   3fc <read>
  3b:	83 f8 00             	cmp    $0x0,%eax
  3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  41:	7e 4f                	jle    92 <wc+0x92>
  43:	31 db                	xor    %ebx,%ebx
  45:	eb 0b                	jmp    52 <wc+0x52>
  47:	90                   	nop
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
  48:	31 ff                	xor    %edi,%edi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  4a:	83 c3 01             	add    $0x1,%ebx
  4d:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  50:	7e 38                	jle    8a <wc+0x8a>
      c++;
      if(buf[i] == '\n')
  52:	0f be 83 c0 08 00 00 	movsbl 0x8c0(%ebx),%eax
        l++;
  59:	31 d2                	xor    %edx,%edx
      if(strchr(" \r\t\n\v", buf[i]))
  5b:	c7 04 24 4d 08 00 00 	movl   $0x84d,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
  62:	3c 0a                	cmp    $0xa,%al
  64:	0f 94 c2             	sete   %dl
  67:	01 d6                	add    %edx,%esi
      if(strchr(" \r\t\n\v", buf[i]))
  69:	89 44 24 04          	mov    %eax,0x4(%esp)
  6d:	e8 fe 01 00 00       	call   270 <strchr>
  72:	85 c0                	test   %eax,%eax
  74:	75 d2                	jne    48 <wc+0x48>
        inword = 0;
      else if(!inword){
  76:	85 ff                	test   %edi,%edi
  78:	75 d0                	jne    4a <wc+0x4a>
        w++;
  7a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7e:	83 c3 01             	add    $0x1,%ebx
  81:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
        inword = 1;
  84:	66 bf 01 00          	mov    $0x1,%di
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  88:	7f c8                	jg     52 <wc+0x52>
  8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8d:	01 45 dc             	add    %eax,-0x24(%ebp)
  90:	eb 8e                	jmp    20 <wc+0x20>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  92:	75 35                	jne    c9 <wc+0xc9>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  94:	8b 45 0c             	mov    0xc(%ebp),%eax
  97:	89 74 24 08          	mov    %esi,0x8(%esp)
  9b:	c7 44 24 04 63 08 00 	movl   $0x863,0x4(%esp)
  a2:	00 
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	89 44 24 14          	mov    %eax,0x14(%esp)
  ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
  b1:	89 44 24 10          	mov    %eax,0x10(%esp)
  b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  b8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  bc:	e8 6f 04 00 00       	call   530 <printf>
}
  c1:	83 c4 3c             	add    $0x3c,%esp
  c4:	5b                   	pop    %ebx
  c5:	5e                   	pop    %esi
  c6:	5f                   	pop    %edi
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
  c9:	c7 44 24 04 53 08 00 	movl   $0x853,0x4(%esp)
  d0:	00 
  d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d8:	e8 53 04 00 00       	call   530 <printf>
    exit();
  dd:	e8 02 03 00 00       	call   3e4 <exit>
  e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	83 e4 f0             	and    $0xfffffff0,%esp
  f6:	57                   	push   %edi
  f7:	56                   	push   %esi
  f8:	53                   	push   %ebx
  f9:	83 ec 24             	sub    $0x24,%esp
  fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
  ff:	83 ff 01             	cmp    $0x1,%edi
 102:	7e 74                	jle    178 <main+0x88>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
 104:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 107:	be 01 00 00 00       	mov    $0x1,%esi
 10c:	83 c3 04             	add    $0x4,%ebx
 10f:	90                   	nop
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 110:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 117:	00 
 118:	8b 03                	mov    (%ebx),%eax
 11a:	89 04 24             	mov    %eax,(%esp)
 11d:	e8 02 03 00 00       	call   424 <open>
 122:	85 c0                	test   %eax,%eax
 124:	78 32                	js     158 <main+0x68>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 126:	8b 13                	mov    (%ebx),%edx
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 128:	83 c6 01             	add    $0x1,%esi
 12b:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 12e:	89 04 24             	mov    %eax,(%esp)
 131:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 135:	89 54 24 04          	mov    %edx,0x4(%esp)
 139:	e8 c2 fe ff ff       	call   0 <wc>
    close(fd);
 13e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 142:	89 04 24             	mov    %eax,(%esp)
 145:	e8 c2 02 00 00       	call   40c <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 14a:	39 f7                	cmp    %esi,%edi
 14c:	7f c2                	jg     110 <main+0x20>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 14e:	e8 91 02 00 00       	call   3e4 <exit>
 153:	90                   	nop
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
 158:	8b 03                	mov    (%ebx),%eax
 15a:	c7 44 24 04 70 08 00 	movl   $0x870,0x4(%esp)
 161:	00 
 162:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 169:	89 44 24 08          	mov    %eax,0x8(%esp)
 16d:	e8 be 03 00 00       	call   530 <printf>
      exit();
 172:	e8 6d 02 00 00       	call   3e4 <exit>
 177:	90                   	nop
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
 178:	c7 44 24 04 62 08 00 	movl   $0x862,0x4(%esp)
 17f:	00 
 180:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 187:	e8 74 fe ff ff       	call   0 <wc>
    exit();
 18c:	e8 53 02 00 00       	call   3e4 <exit>
 191:	90                   	nop
 192:	90                   	nop
 193:	90                   	nop
 194:	90                   	nop
 195:	90                   	nop
 196:	90                   	nop
 197:	90                   	nop
 198:	90                   	nop
 199:	90                   	nop
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

000001a0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 1a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a1:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	53                   	push   %ebx
 1a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 1b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1b7:	83 c2 01             	add    $0x1,%edx
 1ba:	84 c9                	test   %cl,%cl
 1bc:	75 f2                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1be:	5b                   	pop    %ebx
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	eb 0d                	jmp    1d0 <strcmp>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	53                   	push   %ebx
 1d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1da:	0f b6 01             	movzbl (%ecx),%eax
 1dd:	84 c0                	test   %al,%al
 1df:	75 14                	jne    1f5 <strcmp+0x25>
 1e1:	eb 25                	jmp    208 <strcmp+0x38>
 1e3:	90                   	nop
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 1e8:	83 c1 01             	add    $0x1,%ecx
 1eb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ee:	0f b6 01             	movzbl (%ecx),%eax
 1f1:	84 c0                	test   %al,%al
 1f3:	74 13                	je     208 <strcmp+0x38>
 1f5:	0f b6 1a             	movzbl (%edx),%ebx
 1f8:	38 d8                	cmp    %bl,%al
 1fa:	74 ec                	je     1e8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1fc:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ff:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 202:	29 d8                	sub    %ebx,%eax
}
 204:	5b                   	pop    %ebx
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 208:	0f b6 1a             	movzbl (%edx),%ebx
 20b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 20d:	0f b6 db             	movzbl %bl,%ebx
 210:	29 d8                	sub    %ebx,%eax
}
 212:	5b                   	pop    %ebx
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    
 215:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <strlen>:

uint
strlen(char *s)
{
 220:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 221:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 223:	89 e5                	mov    %esp,%ebp
 225:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 228:	80 39 00             	cmpb   $0x0,(%ecx)
 22b:	74 0e                	je     23b <strlen+0x1b>
 22d:	31 d2                	xor    %edx,%edx
 22f:	90                   	nop
 230:	83 c2 01             	add    $0x1,%edx
 233:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 237:	89 d0                	mov    %edx,%eax
 239:	75 f5                	jne    230 <strlen+0x10>
    ;
  return n;
}
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 10             	mov    0x10(%ebp),%ecx
 246:	53                   	push   %ebx
 247:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 24a:	85 c9                	test   %ecx,%ecx
 24c:	74 14                	je     262 <memset+0x22>
 24e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 252:	31 d2                	xor    %edx,%edx
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 258:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 25b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 25e:	39 ca                	cmp    %ecx,%edx
 260:	75 f6                	jne    258 <memset+0x18>
    *d++ = c;
  return dst;
}
 262:	5b                   	pop    %ebx
 263:	5d                   	pop    %ebp
 264:	c3                   	ret    
 265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 11                	jne    292 <strchr+0x22>
 281:	eb 15                	jmp    298 <strchr+0x28>
 283:	90                   	nop
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 288:	83 c0 01             	add    $0x1,%eax
 28b:	0f b6 10             	movzbl (%eax),%edx
 28e:	84 d2                	test   %dl,%dl
 290:	74 06                	je     298 <strchr+0x28>
    if(*s == c)
 292:	38 ca                	cmp    %cl,%dl
 294:	75 f2                	jne    288 <strchr+0x18>
      return (char*) s;
  return 0;
}
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 298:	31 c0                	xor    %eax,%eax
}
 29a:	5d                   	pop    %ebp
 29b:	90                   	nop
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a0:	c3                   	ret    
 2a1:	eb 0d                	jmp    2b0 <gets>
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 2b7:	53                   	push   %ebx
 2b8:	83 ec 2c             	sub    $0x2c,%esp
 2bb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2be:	eb 31                	jmp    2f1 <gets+0x41>
    cc = read(0, &c, 1);
 2c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2ca:	00 
 2cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2d6:	e8 21 01 00 00       	call   3fc <read>
    if(cc < 1)
 2db:	85 c0                	test   %eax,%eax
 2dd:	7e 1a                	jle    2f9 <gets+0x49>
      break;
    buf[i++] = c;
 2df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 2e3:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2e5:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2e9:	74 1d                	je     308 <gets+0x58>
 2eb:	3c 0a                	cmp    $0xa,%al
 2ed:	74 19                	je     308 <gets+0x58>
 2ef:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2f7:	7c c7                	jl     2c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2f9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2fd:	89 f8                	mov    %edi,%eax
 2ff:	83 c4 2c             	add    $0x2c,%esp
 302:	5b                   	pop    %ebx
 303:	5e                   	pop    %esi
 304:	5f                   	pop    %edi
 305:	5d                   	pop    %ebp
 306:	c3                   	ret    
 307:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 308:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 30a:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 30c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 310:	83 c4 2c             	add    $0x2c,%esp
 313:	5b                   	pop    %ebx
 314:	5e                   	pop    %esi
 315:	5f                   	pop    %edi
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    
 318:	90                   	nop
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <stat>:

int
stat(char *n, struct stat *st)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 326:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 329:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 32c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 32f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 334:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 33b:	00 
 33c:	89 04 24             	mov    %eax,(%esp)
 33f:	e8 e0 00 00 00       	call   424 <open>
  if(fd < 0)
 344:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 348:	78 19                	js     363 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	89 1c 24             	mov    %ebx,(%esp)
 350:	89 44 24 04          	mov    %eax,0x4(%esp)
 354:	e8 e3 00 00 00       	call   43c <fstat>
  close(fd);
 359:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 35c:	89 c6                	mov    %eax,%esi
  close(fd);
 35e:	e8 a9 00 00 00       	call   40c <close>
  return r;
}
 363:	89 f0                	mov    %esi,%eax
 365:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 368:	8b 75 fc             	mov    -0x4(%ebp),%esi
 36b:	89 ec                	mov    %ebp,%esp
 36d:	5d                   	pop    %ebp
 36e:	c3                   	ret    
 36f:	90                   	nop

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
  int n;

  n = 0;
 371:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 373:	89 e5                	mov    %esp,%ebp
 375:	8b 4d 08             	mov    0x8(%ebp),%ecx
 378:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 379:	0f b6 11             	movzbl (%ecx),%edx
 37c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 37f:	80 fb 09             	cmp    $0x9,%bl
 382:	77 1c                	ja     3a0 <atoi+0x30>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 388:	0f be d2             	movsbl %dl,%edx
 38b:	83 c1 01             	add    $0x1,%ecx
 38e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 391:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 395:	0f b6 11             	movzbl (%ecx),%edx
 398:	8d 5a d0             	lea    -0x30(%edx),%ebx
 39b:	80 fb 09             	cmp    $0x9,%bl
 39e:	76 e8                	jbe    388 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 3a0:	5b                   	pop    %ebx
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	56                   	push   %esi
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
 3b7:	53                   	push   %ebx
 3b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 db                	test   %ebx,%ebx
 3c0:	7e 14                	jle    3d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 3c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	75 f2                	jne    3c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    
 3da:	90                   	nop
 3db:	90                   	nop

000003dc <fork>:
 3dc:	b8 01 00 00 00       	mov    $0x1,%eax
 3e1:	cd 30                	int    $0x30
 3e3:	c3                   	ret    

000003e4 <exit>:
 3e4:	b8 02 00 00 00       	mov    $0x2,%eax
 3e9:	cd 30                	int    $0x30
 3eb:	c3                   	ret    

000003ec <wait>:
 3ec:	b8 03 00 00 00       	mov    $0x3,%eax
 3f1:	cd 30                	int    $0x30
 3f3:	c3                   	ret    

000003f4 <pipe>:
 3f4:	b8 04 00 00 00       	mov    $0x4,%eax
 3f9:	cd 30                	int    $0x30
 3fb:	c3                   	ret    

000003fc <read>:
 3fc:	b8 06 00 00 00       	mov    $0x6,%eax
 401:	cd 30                	int    $0x30
 403:	c3                   	ret    

00000404 <write>:
 404:	b8 05 00 00 00       	mov    $0x5,%eax
 409:	cd 30                	int    $0x30
 40b:	c3                   	ret    

0000040c <close>:
 40c:	b8 07 00 00 00       	mov    $0x7,%eax
 411:	cd 30                	int    $0x30
 413:	c3                   	ret    

00000414 <kill>:
 414:	b8 08 00 00 00       	mov    $0x8,%eax
 419:	cd 30                	int    $0x30
 41b:	c3                   	ret    

0000041c <exec>:
 41c:	b8 09 00 00 00       	mov    $0x9,%eax
 421:	cd 30                	int    $0x30
 423:	c3                   	ret    

00000424 <open>:
 424:	b8 0a 00 00 00       	mov    $0xa,%eax
 429:	cd 30                	int    $0x30
 42b:	c3                   	ret    

0000042c <mknod>:
 42c:	b8 0b 00 00 00       	mov    $0xb,%eax
 431:	cd 30                	int    $0x30
 433:	c3                   	ret    

00000434 <unlink>:
 434:	b8 0c 00 00 00       	mov    $0xc,%eax
 439:	cd 30                	int    $0x30
 43b:	c3                   	ret    

0000043c <fstat>:
 43c:	b8 0d 00 00 00       	mov    $0xd,%eax
 441:	cd 30                	int    $0x30
 443:	c3                   	ret    

00000444 <link>:
 444:	b8 0e 00 00 00       	mov    $0xe,%eax
 449:	cd 30                	int    $0x30
 44b:	c3                   	ret    

0000044c <mkdir>:
 44c:	b8 0f 00 00 00       	mov    $0xf,%eax
 451:	cd 30                	int    $0x30
 453:	c3                   	ret    

00000454 <chdir>:
 454:	b8 10 00 00 00       	mov    $0x10,%eax
 459:	cd 30                	int    $0x30
 45b:	c3                   	ret    

0000045c <dup>:
 45c:	b8 11 00 00 00       	mov    $0x11,%eax
 461:	cd 30                	int    $0x30
 463:	c3                   	ret    

00000464 <getpid>:
 464:	b8 12 00 00 00       	mov    $0x12,%eax
 469:	cd 30                	int    $0x30
 46b:	c3                   	ret    

0000046c <sbrk>:
 46c:	b8 13 00 00 00       	mov    $0x13,%eax
 471:	cd 30                	int    $0x30
 473:	c3                   	ret    

00000474 <sleep>:
 474:	b8 14 00 00 00       	mov    $0x14,%eax
 479:	cd 30                	int    $0x30
 47b:	c3                   	ret    
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	83 ec 28             	sub    $0x28,%esp
 486:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 489:	8d 55 f4             	lea    -0xc(%ebp),%edx
 48c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 493:	00 
 494:	89 54 24 04          	mov    %edx,0x4(%esp)
 498:	89 04 24             	mov    %eax,(%esp)
 49b:	e8 64 ff ff ff       	call   404 <write>
}
 4a0:	c9                   	leave  
 4a1:	c3                   	ret    
 4a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	89 c7                	mov    %eax,%edi
 4b6:	56                   	push   %esi
 4b7:	89 ce                	mov    %ecx,%esi
 4b9:	53                   	push   %ebx
 4ba:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4c0:	85 c9                	test   %ecx,%ecx
 4c2:	74 09                	je     4cd <printint+0x1d>
 4c4:	89 d0                	mov    %edx,%eax
 4c6:	c1 e8 1f             	shr    $0x1f,%eax
 4c9:	84 c0                	test   %al,%al
 4cb:	75 53                	jne    520 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4cd:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4cf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4d6:	31 c9                	xor    %ecx,%ecx
 4d8:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4e0:	31 d2                	xor    %edx,%edx
 4e2:	f7 f6                	div    %esi
 4e4:	0f b6 92 8c 08 00 00 	movzbl 0x88c(%edx),%edx
 4eb:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 4ee:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 4f1:	85 c0                	test   %eax,%eax
 4f3:	75 eb                	jne    4e0 <printint+0x30>
  if(neg)
 4f5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f8:	85 c0                	test   %eax,%eax
 4fa:	74 08                	je     504 <printint+0x54>
    buf[i++] = '-';
 4fc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 501:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 504:	8d 71 ff             	lea    -0x1(%ecx),%esi
 507:	90                   	nop
    putc(fd, buf[i]);
 508:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 50c:	89 f8                	mov    %edi,%eax
 50e:	e8 6d ff ff ff       	call   480 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 513:	83 ee 01             	sub    $0x1,%esi
 516:	79 f0                	jns    508 <printint+0x58>
    putc(fd, buf[i]);
}
 518:	83 c4 2c             	add    $0x2c,%esp
 51b:	5b                   	pop    %ebx
 51c:	5e                   	pop    %esi
 51d:	5f                   	pop    %edi
 51e:	5d                   	pop    %ebp
 51f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 520:	89 d0                	mov    %edx,%eax
 522:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 524:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 52b:	eb a9                	jmp    4d6 <printint+0x26>
 52d:	8d 76 00             	lea    0x0(%esi),%esi

00000530 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 53c:	0f b6 0b             	movzbl (%ebx),%ecx
 53f:	84 c9                	test   %cl,%cl
 541:	0f 84 99 00 00 00    	je     5e0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 547:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 54c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 54f:	eb 26                	jmp    577 <printf+0x47>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 558:	83 f9 25             	cmp    $0x25,%ecx
 55b:	0f 84 87 00 00 00    	je     5e8 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 561:	8b 45 08             	mov    0x8(%ebp),%eax
 564:	0f be d1             	movsbl %cl,%edx
 567:	e8 14 ff ff ff       	call   480 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 570:	83 c3 01             	add    $0x1,%ebx
 573:	84 c9                	test   %cl,%cl
 575:	74 69                	je     5e0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 577:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 579:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 57c:	74 da                	je     558 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 57e:	83 fe 25             	cmp    $0x25,%esi
 581:	75 e9                	jne    56c <printf+0x3c>
      if(c == 'd'){
 583:	83 f9 64             	cmp    $0x64,%ecx
 586:	0f 84 f4 00 00 00    	je     680 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 58c:	83 f9 70             	cmp    $0x70,%ecx
 58f:	90                   	nop
 590:	74 66                	je     5f8 <printf+0xc8>
 592:	83 f9 78             	cmp    $0x78,%ecx
 595:	74 61                	je     5f8 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 597:	83 f9 73             	cmp    $0x73,%ecx
 59a:	0f 84 80 00 00 00    	je     620 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a0:	83 f9 63             	cmp    $0x63,%ecx
 5a3:	0f 84 f9 00 00 00    	je     6a2 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a9:	83 f9 25             	cmp    $0x25,%ecx
 5ac:	0f 84 b6 00 00 00    	je     668 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b2:	8b 45 08             	mov    0x8(%ebp),%eax
 5b5:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 5ba:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5bc:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 5bf:	e8 bc fe ff ff       	call   480 <putc>
        putc(fd, c);
 5c4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 5c7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ca:	0f be d1             	movsbl %cl,%edx
 5cd:	e8 ae fe ff ff       	call   480 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d2:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 5d6:	83 c3 01             	add    $0x1,%ebx
 5d9:	84 c9                	test   %cl,%cl
 5db:	75 9a                	jne    577 <printf+0x47>
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5e0:	83 c4 2c             	add    $0x2c,%esp
 5e3:	5b                   	pop    %ebx
 5e4:	5e                   	pop    %esi
 5e5:	5f                   	pop    %edi
 5e6:	5d                   	pop    %ebp
 5e7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5e8:	be 25 00 00 00       	mov    $0x25,%esi
 5ed:	e9 7a ff ff ff       	jmp    56c <printf+0x3c>
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fb:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 600:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 602:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 609:	8b 10                	mov    (%eax),%edx
 60b:	8b 45 08             	mov    0x8(%ebp),%eax
 60e:	e8 9d fe ff ff       	call   4b0 <printint>
        ap++;
 613:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 617:	e9 50 ff ff ff       	jmp    56c <printf+0x3c>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 623:	8b 38                	mov    (%eax),%edi
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 62b:	b8 85 08 00 00       	mov    $0x885,%eax
 630:	85 ff                	test   %edi,%edi
 632:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 635:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 637:	0f b6 17             	movzbl (%edi),%edx
 63a:	84 d2                	test   %dl,%dl
 63c:	0f 84 2a ff ff ff    	je     56c <printf+0x3c>
 642:	89 de                	mov    %ebx,%esi
 644:	8b 5d 08             	mov    0x8(%ebp),%ebx
 647:	90                   	nop
          putc(fd, *s);
 648:	0f be d2             	movsbl %dl,%edx
          s++;
 64b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 64e:	89 d8                	mov    %ebx,%eax
 650:	e8 2b fe ff ff       	call   480 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 655:	0f b6 17             	movzbl (%edi),%edx
 658:	84 d2                	test   %dl,%dl
 65a:	75 ec                	jne    648 <printf+0x118>
 65c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65e:	31 f6                	xor    %esi,%esi
 660:	e9 07 ff ff ff       	jmp    56c <printf+0x3c>
 665:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 668:	8b 45 08             	mov    0x8(%ebp),%eax
 66b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 670:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 672:	e8 09 fe ff ff       	call   480 <putc>
 677:	e9 f0 fe ff ff       	jmp    56c <printf+0x3c>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 680:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 683:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 685:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 688:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 68f:	8b 10                	mov    (%eax),%edx
 691:	8b 45 08             	mov    0x8(%ebp),%eax
 694:	e8 17 fe ff ff       	call   4b0 <printint>
        ap++;
 699:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 69d:	e9 ca fe ff ff       	jmp    56c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6a5:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a7:	0f be 10             	movsbl (%eax),%edx
 6aa:	8b 45 08             	mov    0x8(%ebp),%eax
 6ad:	e8 ce fd ff ff       	call   480 <putc>
        ap++;
 6b2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 6b6:	e9 b1 fe ff ff       	jmp    56c <printf+0x3c>
 6bb:	90                   	nop
 6bc:	90                   	nop
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 a0 08 00 00       	mov    0x8a0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	39 c8                	cmp    %ecx,%eax
 6d3:	73 1d                	jae    6f2 <free+0x32>
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
 6d8:	8b 10                	mov    (%eax),%edx
 6da:	39 d1                	cmp    %edx,%ecx
 6dc:	72 1a                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	39 d0                	cmp    %edx,%eax
 6e0:	72 08                	jb     6ea <free+0x2a>
 6e2:	39 c8                	cmp    %ecx,%eax
 6e4:	72 12                	jb     6f8 <free+0x38>
 6e6:	39 d1                	cmp    %edx,%ecx
 6e8:	72 0e                	jb     6f8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ea:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ec:	39 c8                	cmp    %ecx,%eax
 6ee:	66 90                	xchg   %ax,%ax
 6f0:	72 e6                	jb     6d8 <free+0x18>
 6f2:	8b 10                	mov    (%eax),%edx
 6f4:	eb e8                	jmp    6de <free+0x1e>
 6f6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 71 04             	mov    0x4(%ecx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 d7                	cmp    %edx,%edi
 700:	74 19                	je     71b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 ce                	cmp    %ecx,%esi
 70d:	74 21                	je     730 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 711:	a3 a0 08 00 00       	mov    %eax,0x8a0
}
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 71e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 720:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 723:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 726:	8b 50 04             	mov    0x4(%eax),%edx
 729:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72c:	39 ce                	cmp    %ecx,%esi
 72e:	75 df                	jne    70f <free+0x4f>
    p->s.size += bp->s.size;
 730:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 733:	a3 a0 08 00 00       	mov    %eax,0x8a0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 738:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 73b:	8b 53 f8             	mov    -0x8(%ebx),%edx
 73e:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 740:	5b                   	pop    %ebx
 741:	5e                   	pop    %esi
 742:	5f                   	pop    %edi
 743:	5d                   	pop    %ebp
 744:	c3                   	ret    
 745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 75c:	8b 35 a0 08 00 00    	mov    0x8a0,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	83 c3 07             	add    $0x7,%ebx
 765:	c1 eb 03             	shr    $0x3,%ebx
 768:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 76b:	85 f6                	test   %esi,%esi
 76d:	0f 84 ab 00 00 00    	je     81e <malloc+0xce>
 773:	8b 16                	mov    (%esi),%edx
 775:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 778:	39 d9                	cmp    %ebx,%ecx
 77a:	0f 83 c6 00 00 00    	jae    846 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 780:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 787:	be 00 80 00 00       	mov    $0x8000,%esi
 78c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 78f:	eb 09                	jmp    79a <malloc+0x4a>
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 798:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 79a:	3b 15 a0 08 00 00    	cmp    0x8a0,%edx
 7a0:	74 2e                	je     7d0 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a2:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a4:	8b 48 04             	mov    0x4(%eax),%ecx
 7a7:	39 cb                	cmp    %ecx,%ebx
 7a9:	77 ed                	ja     798 <malloc+0x48>
 7ab:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 7ad:	39 cb                	cmp    %ecx,%ebx
 7af:	74 67                	je     818 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7b1:	29 d9                	sub    %ebx,%ecx
 7b3:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b6:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7b9:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7bc:	89 35 a0 08 00 00    	mov    %esi,0x8a0
      return (void*) (p + 1);
 7c2:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7c5:	83 c4 2c             	add    $0x2c,%esp
 7c8:	5b                   	pop    %ebx
 7c9:	5e                   	pop    %esi
 7ca:	5f                   	pop    %edi
 7cb:	5d                   	pop    %ebp
 7cc:	c3                   	ret    
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 7d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7d3:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 7d9:	bf 00 10 00 00       	mov    $0x1000,%edi
 7de:	0f 47 fb             	cmova  %ebx,%edi
 7e1:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 7e4:	89 04 24             	mov    %eax,(%esp)
 7e7:	e8 80 fc ff ff       	call   46c <sbrk>
  if(p == (char*) -1)
 7ec:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ef:	74 18                	je     809 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7f1:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7f4:	83 c0 08             	add    $0x8,%eax
 7f7:	89 04 24             	mov    %eax,(%esp)
 7fa:	e8 c1 fe ff ff       	call   6c0 <free>
  return freep;
 7ff:	8b 15 a0 08 00 00    	mov    0x8a0,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 805:	85 d2                	test   %edx,%edx
 807:	75 99                	jne    7a2 <malloc+0x52>
        return 0;
  }
}
 809:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 80c:	31 c0                	xor    %eax,%eax
  }
}
 80e:	5b                   	pop    %ebx
 80f:	5e                   	pop    %esi
 810:	5f                   	pop    %edi
 811:	5d                   	pop    %ebp
 812:	c3                   	ret    
 813:	90                   	nop
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 818:	8b 10                	mov    (%eax),%edx
 81a:	89 16                	mov    %edx,(%esi)
 81c:	eb 9e                	jmp    7bc <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 81e:	c7 05 a0 08 00 00 a4 	movl   $0x8a4,0x8a0
 825:	08 00 00 
    base.s.size = 0;
 828:	ba a4 08 00 00       	mov    $0x8a4,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 82d:	c7 05 a4 08 00 00 a4 	movl   $0x8a4,0x8a4
 834:	08 00 00 
    base.s.size = 0;
 837:	c7 05 a8 08 00 00 00 	movl   $0x0,0x8a8
 83e:	00 00 00 
 841:	e9 3a ff ff ff       	jmp    780 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 846:	89 d0                	mov    %edx,%eax
 848:	e9 60 ff ff ff       	jmp    7ad <malloc+0x5d>
