
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 1c             	sub    $0x1c,%esp
   9:	8b 75 08             	mov    0x8(%ebp),%esi
   c:	8b 7d 0c             	mov    0xc(%ebp),%edi
   f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  12:	eb 1a                	jmp    2e <matchstar+0x2e>
  14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  18:	0f b6 03             	movzbl (%ebx),%eax
  1b:	84 c0                	test   %al,%al
  1d:	74 31                	je     50 <matchstar+0x50>
  1f:	0f be c0             	movsbl %al,%eax
  22:	39 f0                	cmp    %esi,%eax
  24:	74 05                	je     2b <matchstar+0x2b>
  26:	83 fe 2e             	cmp    $0x2e,%esi
  29:	75 25                	jne    50 <matchstar+0x50>
  2b:	83 c3 01             	add    $0x1,%ebx

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  2e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  32:	89 3c 24             	mov    %edi,(%esp)
  35:	e8 26 00 00 00       	call   60 <matchhere>
  3a:	85 c0                	test   %eax,%eax
  3c:	74 da                	je     18 <matchstar+0x18>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  3e:	83 c4 1c             	add    $0x1c,%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  41:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  46:	5b                   	pop    %ebx
  47:	5e                   	pop    %esi
  48:	5f                   	pop    %edi
  49:	5d                   	pop    %ebp
  4a:	c3                   	ret    
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	83 c4 1c             	add    $0x1c,%esp
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
  53:	31 c0                	xor    %eax,%eax
}
  55:	5b                   	pop    %ebx
  56:	5e                   	pop    %esi
  57:	5f                   	pop    %edi
  58:	5d                   	pop    %ebp
  59:	c3                   	ret    
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000060 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	83 ec 10             	sub    $0x10,%esp
  68:	8b 75 08             	mov    0x8(%ebp),%esi
  6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
  6e:	0f b6 06             	movzbl (%esi),%eax
  71:	84 c0                	test   %al,%al
  73:	74 63                	je     d8 <matchhere+0x78>
    return 1;
  if(re[1] == '*')
  75:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  79:	8d 56 01             	lea    0x1(%esi),%edx
  7c:	80 fb 2a             	cmp    $0x2a,%bl
  7f:	75 2e                	jne    af <matchhere+0x4f>
  81:	eb 61                	jmp    e4 <matchhere+0x84>
  83:	90                   	nop
  84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  88:	0f b6 19             	movzbl (%ecx),%ebx
  8b:	84 db                	test   %bl,%bl
  8d:	74 39                	je     c8 <matchhere+0x68>
  8f:	3c 2e                	cmp    $0x2e,%al
  91:	74 04                	je     97 <matchhere+0x37>
  93:	38 d8                	cmp    %bl,%al
  95:	75 31                	jne    c8 <matchhere+0x68>
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
  97:	0f b6 02             	movzbl (%edx),%eax
  9a:	84 c0                	test   %al,%al
  9c:	74 3a                	je     d8 <matchhere+0x78>
    return 1;
  if(re[1] == '*')
  9e:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  a2:	83 c1 01             	add    $0x1,%ecx
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
  a5:	8d 72 01             	lea    0x1(%edx),%esi
  a8:	80 fb 2a             	cmp    $0x2a,%bl
  ab:	74 3b                	je     e8 <matchhere+0x88>
  ad:	89 f2                	mov    %esi,%edx
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
  af:	3c 24                	cmp    $0x24,%al
  b1:	75 d5                	jne    88 <matchhere+0x28>
  b3:	84 db                	test   %bl,%bl
  b5:	75 d1                	jne    88 <matchhere+0x28>
    return *text == '\0';
  b7:	31 c0                	xor    %eax,%eax
  b9:	80 39 00             	cmpb   $0x0,(%ecx)
  bc:	0f 94 c0             	sete   %al
  bf:	eb 09                	jmp    ca <matchhere+0x6a>
  c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
  c8:	31 c0                	xor    %eax,%eax
}
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	5b                   	pop    %ebx
  ce:	5e                   	pop    %esi
  cf:	5d                   	pop    %ebp
  d0:	c3                   	ret    
  d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d8:	83 c4 10             	add    $0x10,%esp

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  db:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
  e0:	5b                   	pop    %ebx
  e1:	5e                   	pop    %esi
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
  e4:	89 f2                	mov    %esi,%edx
  e6:	66 90                	xchg   %ax,%ax
    return matchstar(re[0], re+2, text);
  e8:	83 c2 02             	add    $0x2,%edx
  eb:	0f be c0             	movsbl %al,%eax
  ee:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  f2:	89 54 24 04          	mov    %edx,0x4(%esp)
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 02 ff ff ff       	call   0 <matchstar>
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
  fe:	83 c4 10             	add    $0x10,%esp
 101:	5b                   	pop    %ebx
 102:	5e                   	pop    %esi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	56                   	push   %esi
 114:	53                   	push   %ebx
 115:	83 ec 10             	sub    $0x10,%esp
 118:	8b 75 08             	mov    0x8(%ebp),%esi
 11b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 11e:	80 3e 5e             	cmpb   $0x5e,(%esi)
 121:	75 08                	jne    12b <match+0x1b>
 123:	eb 37                	jmp    15c <match+0x4c>
 125:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 128:	83 c3 01             	add    $0x1,%ebx
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 12b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 12f:	89 34 24             	mov    %esi,(%esp)
 132:	e8 29 ff ff ff       	call   60 <matchhere>
 137:	85 c0                	test   %eax,%eax
 139:	75 15                	jne    150 <match+0x40>
      return 1;
  }while(*text++ != '\0');
 13b:	80 3b 00             	cmpb   $0x0,(%ebx)
 13e:	75 e8                	jne    128 <match+0x18>
  return 0;
}
 140:	83 c4 10             	add    $0x10,%esp
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
 143:	31 c0                	xor    %eax,%eax
}
 145:	5b                   	pop    %ebx
 146:	5e                   	pop    %esi
 147:	5d                   	pop    %ebp
 148:	c3                   	ret    
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c4 10             	add    $0x10,%esp
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
 153:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 158:	5b                   	pop    %ebx
 159:	5e                   	pop    %esi
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 15c:	83 c6 01             	add    $0x1,%esi
 15f:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 162:	83 c4 10             	add    $0x10,%esp
 165:	5b                   	pop    %ebx
 166:	5e                   	pop    %esi
 167:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 168:	e9 f3 fe ff ff       	jmp    60 <matchhere>
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
 176:	83 ec 2c             	sub    $0x2c,%esp
 179:	8b 7d 08             	mov    0x8(%ebp),%edi
  int n, m;
  char *p, *q;
  
  m = 0;
 17c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
 188:	b8 00 04 00 00       	mov    $0x400,%eax
 18d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
 190:	89 44 24 08          	mov    %eax,0x8(%esp)
 194:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 197:	05 60 0a 00 00       	add    $0xa60,%eax
 19c:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a3:	89 04 24             	mov    %eax,(%esp)
 1a6:	e8 f1 03 00 00       	call   59c <read>
 1ab:	85 c0                	test   %eax,%eax
 1ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
 1b0:	0f 8e ae 00 00 00    	jle    264 <grep+0xf4>
 1b6:	be 60 0a 00 00       	mov    $0xa60,%esi
 1bb:	90                   	nop
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 1c0:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
 1c7:	00 
 1c8:	89 34 24             	mov    %esi,(%esp)
 1cb:	e8 40 02 00 00       	call   410 <strchr>
 1d0:	85 c0                	test   %eax,%eax
 1d2:	89 c3                	mov    %eax,%ebx
 1d4:	74 42                	je     218 <grep+0xa8>
      *q = 0;
 1d6:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 1d9:	89 74 24 04          	mov    %esi,0x4(%esp)
 1dd:	89 3c 24             	mov    %edi,(%esp)
 1e0:	e8 2b ff ff ff       	call   110 <match>
 1e5:	85 c0                	test   %eax,%eax
 1e7:	75 07                	jne    1f0 <grep+0x80>
 1e9:	8d 73 01             	lea    0x1(%ebx),%esi
 1ec:	eb d2                	jmp    1c0 <grep+0x50>
 1ee:	66 90                	xchg   %ax,%ax
        *q = '\n';
 1f0:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 1f3:	83 c3 01             	add    $0x1,%ebx
 1f6:	89 d8                	mov    %ebx,%eax
 1f8:	29 f0                	sub    %esi,%eax
 1fa:	89 74 24 04          	mov    %esi,0x4(%esp)
 1fe:	89 de                	mov    %ebx,%esi
 200:	89 44 24 08          	mov    %eax,0x8(%esp)
 204:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 20b:	e8 94 03 00 00       	call   5a4 <write>
 210:	eb ae                	jmp    1c0 <grep+0x50>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 218:	81 fe 60 0a 00 00    	cmp    $0xa60,%esi
 21e:	74 38                	je     258 <grep+0xe8>
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
 220:	8b 45 e0             	mov    -0x20(%ebp),%eax
 223:	01 45 e4             	add    %eax,-0x1c(%ebp)
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
 226:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 229:	85 c0                	test   %eax,%eax
 22b:	0f 8e 57 ff ff ff    	jle    188 <grep+0x18>
      m -= p - buf;
 231:	81 45 e4 60 0a 00 00 	addl   $0xa60,-0x1c(%ebp)
 238:	29 75 e4             	sub    %esi,-0x1c(%ebp)
      memmove(buf, p, m);
 23b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 23e:	89 74 24 04          	mov    %esi,0x4(%esp)
 242:	c7 04 24 60 0a 00 00 	movl   $0xa60,(%esp)
 249:	89 44 24 08          	mov    %eax,0x8(%esp)
 24d:	e8 fe 02 00 00       	call   550 <memmove>
 252:	e9 31 ff ff ff       	jmp    188 <grep+0x18>
 257:	90                   	nop
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 258:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 25f:	e9 24 ff ff ff       	jmp    188 <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 264:	83 c4 2c             	add    $0x2c,%esp
 267:	5b                   	pop    %ebx
 268:	5e                   	pop    %esi
 269:	5f                   	pop    %edi
 26a:	5d                   	pop    %ebp
 26b:	c3                   	ret    
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <main>:

int
main(int argc, char *argv[])
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 e4 f0             	and    $0xfffffff0,%esp
 276:	57                   	push   %edi
 277:	56                   	push   %esi
 278:	53                   	push   %ebx
 279:	83 ec 24             	sub    $0x24,%esp
 27c:	8b 7d 08             	mov    0x8(%ebp),%edi
 27f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 282:	83 ff 01             	cmp    $0x1,%edi
 285:	0f 8e 95 00 00 00    	jle    320 <main+0xb0>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
 28b:	8b 43 04             	mov    0x4(%ebx),%eax
  
  if(argc <= 2){
 28e:	83 ff 02             	cmp    $0x2,%edi
  
  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
 291:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  
  if(argc <= 2){
 295:	74 71                	je     308 <main+0x98>
    }
  }
}

int
main(int argc, char *argv[])
 297:	83 c3 08             	add    $0x8,%ebx
 29a:	be 02 00 00 00       	mov    $0x2,%esi
 29f:	90                   	nop
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 2a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a7:	00 
 2a8:	8b 03                	mov    (%ebx),%eax
 2aa:	89 04 24             	mov    %eax,(%esp)
 2ad:	e8 12 03 00 00       	call   5c4 <open>
 2b2:	85 c0                	test   %eax,%eax
 2b4:	78 32                	js     2e8 <main+0x78>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
 2b6:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 2ba:	83 c6 01             	add    $0x1,%esi
 2bd:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
 2c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c4:	89 44 24 18          	mov    %eax,0x18(%esp)
 2c8:	89 14 24             	mov    %edx,(%esp)
 2cb:	e8 a0 fe ff ff       	call   170 <grep>
    close(fd);
 2d0:	8b 44 24 18          	mov    0x18(%esp),%eax
 2d4:	89 04 24             	mov    %eax,(%esp)
 2d7:	e8 d0 02 00 00       	call   5ac <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 2dc:	39 f7                	cmp    %esi,%edi
 2de:	7f c0                	jg     2a0 <main+0x30>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 2e0:	e8 9f 02 00 00       	call   584 <exit>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
 2e8:	8b 03                	mov    (%ebx),%eax
 2ea:	c7 44 24 04 10 0a 00 	movl   $0xa10,0x4(%esp)
 2f1:	00 
 2f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f9:	89 44 24 08          	mov    %eax,0x8(%esp)
 2fd:	e8 ce 03 00 00       	call   6d0 <printf>
      exit();
 302:	e8 7d 02 00 00       	call   584 <exit>
 307:	90                   	nop
    exit();
  }
  pattern = argv[1];
  
  if(argc <= 2){
    grep(pattern, 0);
 308:	89 04 24             	mov    %eax,(%esp)
 30b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 312:	00 
 313:	e8 58 fe ff ff       	call   170 <grep>
    exit();
 318:	e8 67 02 00 00       	call   584 <exit>
 31d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
 320:	c7 44 24 04 f0 09 00 	movl   $0x9f0,0x4(%esp)
 327:	00 
 328:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 32f:	e8 9c 03 00 00       	call   6d0 <printf>
    exit();
 334:	e8 4b 02 00 00       	call   584 <exit>
 339:	90                   	nop
 33a:	90                   	nop
 33b:	90                   	nop
 33c:	90                   	nop
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 340:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 341:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 343:	89 e5                	mov    %esp,%ebp
 345:	8b 45 08             	mov    0x8(%ebp),%eax
 348:	53                   	push   %ebx
 349:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 350:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 354:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 357:	83 c2 01             	add    $0x1,%edx
 35a:	84 c9                	test   %cl,%cl
 35c:	75 f2                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 35e:	5b                   	pop    %ebx
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	eb 0d                	jmp    370 <strcmp>
 363:	90                   	nop
 364:	90                   	nop
 365:	90                   	nop
 366:	90                   	nop
 367:	90                   	nop
 368:	90                   	nop
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop
 36c:	90                   	nop
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 08             	mov    0x8(%ebp),%ecx
 376:	53                   	push   %ebx
 377:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 37a:	0f b6 01             	movzbl (%ecx),%eax
 37d:	84 c0                	test   %al,%al
 37f:	75 14                	jne    395 <strcmp+0x25>
 381:	eb 25                	jmp    3a8 <strcmp+0x38>
 383:	90                   	nop
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 388:	83 c1 01             	add    $0x1,%ecx
 38b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 38e:	0f b6 01             	movzbl (%ecx),%eax
 391:	84 c0                	test   %al,%al
 393:	74 13                	je     3a8 <strcmp+0x38>
 395:	0f b6 1a             	movzbl (%edx),%ebx
 398:	38 d8                	cmp    %bl,%al
 39a:	74 ec                	je     388 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 39c:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 39f:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a8:	0f b6 1a             	movzbl (%edx),%ebx
 3ab:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3ad:	0f b6 db             	movzbl %bl,%ebx
 3b0:	29 d8                	sub    %ebx,%eax
}
 3b2:	5b                   	pop    %ebx
 3b3:	5d                   	pop    %ebp
 3b4:	c3                   	ret    
 3b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3c3:	89 e5                	mov    %esp,%ebp
 3c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c8:	80 39 00             	cmpb   $0x0,(%ecx)
 3cb:	74 0e                	je     3db <strlen+0x1b>
 3cd:	31 d2                	xor    %edx,%edx
 3cf:	90                   	nop
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3d7:	89 d0                	mov    %edx,%eax
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3e6:	53                   	push   %ebx
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 3ea:	85 c9                	test   %ecx,%ecx
 3ec:	74 14                	je     402 <memset+0x22>
 3ee:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 3f8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 3fb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 3fe:	39 ca                	cmp    %ecx,%edx
 400:	75 f6                	jne    3f8 <memset+0x18>
    *d++ = c;
  return dst;
}
 402:	5b                   	pop    %ebx
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
 405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 11                	jne    432 <strchr+0x22>
 421:	eb 15                	jmp    438 <strchr+0x28>
 423:	90                   	nop
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 428:	83 c0 01             	add    $0x1,%eax
 42b:	0f b6 10             	movzbl (%eax),%edx
 42e:	84 d2                	test   %dl,%dl
 430:	74 06                	je     438 <strchr+0x28>
    if(*s == c)
 432:	38 ca                	cmp    %cl,%dl
 434:	75 f2                	jne    428 <strchr+0x18>
      return (char*) s;
  return 0;
}
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
 438:	31 c0                	xor    %eax,%eax
}
 43a:	5d                   	pop    %ebp
 43b:	90                   	nop
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 440:	c3                   	ret    
 441:	eb 0d                	jmp    450 <gets>
 443:	90                   	nop
 444:	90                   	nop
 445:	90                   	nop
 446:	90                   	nop
 447:	90                   	nop
 448:	90                   	nop
 449:	90                   	nop
 44a:	90                   	nop
 44b:	90                   	nop
 44c:	90                   	nop
 44d:	90                   	nop
 44e:	90                   	nop
 44f:	90                   	nop

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 455:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 457:	53                   	push   %ebx
 458:	83 ec 2c             	sub    $0x2c,%esp
 45b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 45e:	eb 31                	jmp    491 <gets+0x41>
    cc = read(0, &c, 1);
 460:	8d 45 e7             	lea    -0x19(%ebp),%eax
 463:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 46a:	00 
 46b:	89 44 24 04          	mov    %eax,0x4(%esp)
 46f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 476:	e8 21 01 00 00       	call   59c <read>
    if(cc < 1)
 47b:	85 c0                	test   %eax,%eax
 47d:	7e 1a                	jle    499 <gets+0x49>
      break;
    buf[i++] = c;
 47f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 483:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 485:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 489:	74 1d                	je     4a8 <gets+0x58>
 48b:	3c 0a                	cmp    $0xa,%al
 48d:	74 19                	je     4a8 <gets+0x58>
 48f:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 491:	8d 5e 01             	lea    0x1(%esi),%ebx
 494:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 497:	7c c7                	jl     460 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 499:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 49d:	89 f8                	mov    %edi,%eax
 49f:	83 c4 2c             	add    $0x2c,%esp
 4a2:	5b                   	pop    %ebx
 4a3:	5e                   	pop    %esi
 4a4:	5f                   	pop    %edi
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    
 4a7:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 4aa:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4ac:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 4b0:	83 c4 2c             	add    $0x2c,%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004c0 <stat>:

int
stat(char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4db:	00 
 4dc:	89 04 24             	mov    %eax,(%esp)
 4df:	e8 e0 00 00 00       	call   5c4 <open>
  if(fd < 0)
 4e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4e8:	78 19                	js     503 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ed:	89 1c 24             	mov    %ebx,(%esp)
 4f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f4:	e8 e3 00 00 00       	call   5dc <fstat>
  close(fd);
 4f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4fc:	89 c6                	mov    %eax,%esi
  close(fd);
 4fe:	e8 a9 00 00 00       	call   5ac <close>
  return r;
}
 503:	89 f0                	mov    %esi,%eax
 505:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 508:	8b 75 fc             	mov    -0x4(%ebp),%esi
 50b:	89 ec                	mov    %ebp,%esp
 50d:	5d                   	pop    %ebp
 50e:	c3                   	ret    
 50f:	90                   	nop

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
  int n;

  n = 0;
 511:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 513:	89 e5                	mov    %esp,%ebp
 515:	8b 4d 08             	mov    0x8(%ebp),%ecx
 518:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 519:	0f b6 11             	movzbl (%ecx),%edx
 51c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 51f:	80 fb 09             	cmp    $0x9,%bl
 522:	77 1c                	ja     540 <atoi+0x30>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 528:	0f be d2             	movsbl %dl,%edx
 52b:	83 c1 01             	add    $0x1,%ecx
 52e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 531:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 535:	0f b6 11             	movzbl (%ecx),%edx
 538:	8d 5a d0             	lea    -0x30(%edx),%ebx
 53b:	80 fb 09             	cmp    $0x9,%bl
 53e:	76 e8                	jbe    528 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 540:	5b                   	pop    %ebx
 541:	5d                   	pop    %ebp
 542:	c3                   	ret    
 543:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	8b 45 08             	mov    0x8(%ebp),%eax
 557:	53                   	push   %ebx
 558:	8b 5d 10             	mov    0x10(%ebp),%ebx
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 572:	39 da                	cmp    %ebx,%edx
 574:	75 f2                	jne    568 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    
 57a:	90                   	nop
 57b:	90                   	nop

0000057c <fork>:
 57c:	b8 01 00 00 00       	mov    $0x1,%eax
 581:	cd 30                	int    $0x30
 583:	c3                   	ret    

00000584 <exit>:
 584:	b8 02 00 00 00       	mov    $0x2,%eax
 589:	cd 30                	int    $0x30
 58b:	c3                   	ret    

0000058c <wait>:
 58c:	b8 03 00 00 00       	mov    $0x3,%eax
 591:	cd 30                	int    $0x30
 593:	c3                   	ret    

00000594 <pipe>:
 594:	b8 04 00 00 00       	mov    $0x4,%eax
 599:	cd 30                	int    $0x30
 59b:	c3                   	ret    

0000059c <read>:
 59c:	b8 06 00 00 00       	mov    $0x6,%eax
 5a1:	cd 30                	int    $0x30
 5a3:	c3                   	ret    

000005a4 <write>:
 5a4:	b8 05 00 00 00       	mov    $0x5,%eax
 5a9:	cd 30                	int    $0x30
 5ab:	c3                   	ret    

000005ac <close>:
 5ac:	b8 07 00 00 00       	mov    $0x7,%eax
 5b1:	cd 30                	int    $0x30
 5b3:	c3                   	ret    

000005b4 <kill>:
 5b4:	b8 08 00 00 00       	mov    $0x8,%eax
 5b9:	cd 30                	int    $0x30
 5bb:	c3                   	ret    

000005bc <exec>:
 5bc:	b8 09 00 00 00       	mov    $0x9,%eax
 5c1:	cd 30                	int    $0x30
 5c3:	c3                   	ret    

000005c4 <open>:
 5c4:	b8 0a 00 00 00       	mov    $0xa,%eax
 5c9:	cd 30                	int    $0x30
 5cb:	c3                   	ret    

000005cc <mknod>:
 5cc:	b8 0b 00 00 00       	mov    $0xb,%eax
 5d1:	cd 30                	int    $0x30
 5d3:	c3                   	ret    

000005d4 <unlink>:
 5d4:	b8 0c 00 00 00       	mov    $0xc,%eax
 5d9:	cd 30                	int    $0x30
 5db:	c3                   	ret    

000005dc <fstat>:
 5dc:	b8 0d 00 00 00       	mov    $0xd,%eax
 5e1:	cd 30                	int    $0x30
 5e3:	c3                   	ret    

000005e4 <link>:
 5e4:	b8 0e 00 00 00       	mov    $0xe,%eax
 5e9:	cd 30                	int    $0x30
 5eb:	c3                   	ret    

000005ec <mkdir>:
 5ec:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f1:	cd 30                	int    $0x30
 5f3:	c3                   	ret    

000005f4 <chdir>:
 5f4:	b8 10 00 00 00       	mov    $0x10,%eax
 5f9:	cd 30                	int    $0x30
 5fb:	c3                   	ret    

000005fc <dup>:
 5fc:	b8 11 00 00 00       	mov    $0x11,%eax
 601:	cd 30                	int    $0x30
 603:	c3                   	ret    

00000604 <getpid>:
 604:	b8 12 00 00 00       	mov    $0x12,%eax
 609:	cd 30                	int    $0x30
 60b:	c3                   	ret    

0000060c <sbrk>:
 60c:	b8 13 00 00 00       	mov    $0x13,%eax
 611:	cd 30                	int    $0x30
 613:	c3                   	ret    

00000614 <sleep>:
 614:	b8 14 00 00 00       	mov    $0x14,%eax
 619:	cd 30                	int    $0x30
 61b:	c3                   	ret    
 61c:	90                   	nop
 61d:	90                   	nop
 61e:	90                   	nop
 61f:	90                   	nop

00000620 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	83 ec 28             	sub    $0x28,%esp
 626:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 629:	8d 55 f4             	lea    -0xc(%ebp),%edx
 62c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 633:	00 
 634:	89 54 24 04          	mov    %edx,0x4(%esp)
 638:	89 04 24             	mov    %eax,(%esp)
 63b:	e8 64 ff ff ff       	call   5a4 <write>
}
 640:	c9                   	leave  
 641:	c3                   	ret    
 642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	89 c7                	mov    %eax,%edi
 656:	56                   	push   %esi
 657:	89 ce                	mov    %ecx,%esi
 659:	53                   	push   %ebx
 65a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 65d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 660:	85 c9                	test   %ecx,%ecx
 662:	74 09                	je     66d <printint+0x1d>
 664:	89 d0                	mov    %edx,%eax
 666:	c1 e8 1f             	shr    $0x1f,%eax
 669:	84 c0                	test   %al,%al
 66b:	75 53                	jne    6c0 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 66d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 66f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 676:	31 c9                	xor    %ecx,%ecx
 678:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 67b:	90                   	nop
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 680:	31 d2                	xor    %edx,%edx
 682:	f7 f6                	div    %esi
 684:	0f b6 92 2d 0a 00 00 	movzbl 0xa2d(%edx),%edx
 68b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 68e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 691:	85 c0                	test   %eax,%eax
 693:	75 eb                	jne    680 <printint+0x30>
  if(neg)
 695:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 698:	85 c0                	test   %eax,%eax
 69a:	74 08                	je     6a4 <printint+0x54>
    buf[i++] = '-';
 69c:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 6a1:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 6a4:	8d 71 ff             	lea    -0x1(%ecx),%esi
 6a7:	90                   	nop
    putc(fd, buf[i]);
 6a8:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
 6ac:	89 f8                	mov    %edi,%eax
 6ae:	e8 6d ff ff ff       	call   620 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6b3:	83 ee 01             	sub    $0x1,%esi
 6b6:	79 f0                	jns    6a8 <printint+0x58>
    putc(fd, buf[i]);
}
 6b8:	83 c4 2c             	add    $0x2c,%esp
 6bb:	5b                   	pop    %ebx
 6bc:	5e                   	pop    %esi
 6bd:	5f                   	pop    %edi
 6be:	5d                   	pop    %ebp
 6bf:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6c0:	89 d0                	mov    %edx,%eax
 6c2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 6c4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 6cb:	eb a9                	jmp    676 <printint+0x26>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi

000006d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6dc:	0f b6 0b             	movzbl (%ebx),%ecx
 6df:	84 c9                	test   %cl,%cl
 6e1:	0f 84 99 00 00 00    	je     780 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6e7:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6ea:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 6ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6ef:	eb 26                	jmp    717 <printf+0x47>
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6f8:	83 f9 25             	cmp    $0x25,%ecx
 6fb:	0f 84 87 00 00 00    	je     788 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
 701:	8b 45 08             	mov    0x8(%ebp),%eax
 704:	0f be d1             	movsbl %cl,%edx
 707:	e8 14 ff ff ff       	call   620 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 70c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 710:	83 c3 01             	add    $0x1,%ebx
 713:	84 c9                	test   %cl,%cl
 715:	74 69                	je     780 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 717:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 719:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 71c:	74 da                	je     6f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 71e:	83 fe 25             	cmp    $0x25,%esi
 721:	75 e9                	jne    70c <printf+0x3c>
      if(c == 'd'){
 723:	83 f9 64             	cmp    $0x64,%ecx
 726:	0f 84 f4 00 00 00    	je     820 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 72c:	83 f9 70             	cmp    $0x70,%ecx
 72f:	90                   	nop
 730:	74 66                	je     798 <printf+0xc8>
 732:	83 f9 78             	cmp    $0x78,%ecx
 735:	74 61                	je     798 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 737:	83 f9 73             	cmp    $0x73,%ecx
 73a:	0f 84 80 00 00 00    	je     7c0 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 740:	83 f9 63             	cmp    $0x63,%ecx
 743:	0f 84 f9 00 00 00    	je     842 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 749:	83 f9 25             	cmp    $0x25,%ecx
 74c:	0f 84 b6 00 00 00    	je     808 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 752:	8b 45 08             	mov    0x8(%ebp),%eax
 755:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
 75a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 75f:	e8 bc fe ff ff       	call   620 <putc>
        putc(fd, c);
 764:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 767:	8b 45 08             	mov    0x8(%ebp),%eax
 76a:	0f be d1             	movsbl %cl,%edx
 76d:	e8 ae fe ff ff       	call   620 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 772:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 776:	83 c3 01             	add    $0x1,%ebx
 779:	84 c9                	test   %cl,%cl
 77b:	75 9a                	jne    717 <printf+0x47>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 780:	83 c4 2c             	add    $0x2c,%esp
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 788:	be 25 00 00 00       	mov    $0x25,%esi
 78d:	e9 7a ff ff ff       	jmp    70c <printf+0x3c>
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 798:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 79b:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7a0:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	8b 45 08             	mov    0x8(%ebp),%eax
 7ae:	e8 9d fe ff ff       	call   650 <printint>
        ap++;
 7b3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 7b7:	e9 50 ff ff ff       	jmp    70c <printf+0x3c>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7c3:	8b 38                	mov    (%eax),%edi
        ap++;
 7c5:	83 c0 04             	add    $0x4,%eax
 7c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 7cb:	b8 26 0a 00 00       	mov    $0xa26,%eax
 7d0:	85 ff                	test   %edi,%edi
 7d2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7d5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7d7:	0f b6 17             	movzbl (%edi),%edx
 7da:	84 d2                	test   %dl,%dl
 7dc:	0f 84 2a ff ff ff    	je     70c <printf+0x3c>
 7e2:	89 de                	mov    %ebx,%esi
 7e4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7e7:	90                   	nop
          putc(fd, *s);
 7e8:	0f be d2             	movsbl %dl,%edx
          s++;
 7eb:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 7ee:	89 d8                	mov    %ebx,%eax
 7f0:	e8 2b fe ff ff       	call   620 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7f5:	0f b6 17             	movzbl (%edi),%edx
 7f8:	84 d2                	test   %dl,%dl
 7fa:	75 ec                	jne    7e8 <printf+0x118>
 7fc:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7fe:	31 f6                	xor    %esi,%esi
 800:	e9 07 ff ff ff       	jmp    70c <printf+0x3c>
 805:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 808:	8b 45 08             	mov    0x8(%ebp),%eax
 80b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 810:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 812:	e8 09 fe ff ff       	call   620 <putc>
 817:	e9 f0 fe ff ff       	jmp    70c <printf+0x3c>
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 820:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 823:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 825:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 828:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 82f:	8b 10                	mov    (%eax),%edx
 831:	8b 45 08             	mov    0x8(%ebp),%eax
 834:	e8 17 fe ff ff       	call   650 <printint>
        ap++;
 839:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 83d:	e9 ca fe ff ff       	jmp    70c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 842:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 845:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 847:	0f be 10             	movsbl (%eax),%edx
 84a:	8b 45 08             	mov    0x8(%ebp),%eax
 84d:	e8 ce fd ff ff       	call   620 <putc>
        ap++;
 852:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 856:	e9 b1 fe ff ff       	jmp    70c <printf+0x3c>
 85b:	90                   	nop
 85c:	90                   	nop
 85d:	90                   	nop
 85e:	90                   	nop
 85f:	90                   	nop

00000860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 860:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 861:	a1 40 0a 00 00       	mov    0xa40,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 866:	89 e5                	mov    %esp,%ebp
 868:	57                   	push   %edi
 869:	56                   	push   %esi
 86a:	53                   	push   %ebx
 86b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 86e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 871:	39 c8                	cmp    %ecx,%eax
 873:	73 1d                	jae    892 <free+0x32>
 875:	8d 76 00             	lea    0x0(%esi),%esi
 878:	8b 10                	mov    (%eax),%edx
 87a:	39 d1                	cmp    %edx,%ecx
 87c:	72 1a                	jb     898 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87e:	39 d0                	cmp    %edx,%eax
 880:	72 08                	jb     88a <free+0x2a>
 882:	39 c8                	cmp    %ecx,%eax
 884:	72 12                	jb     898 <free+0x38>
 886:	39 d1                	cmp    %edx,%ecx
 888:	72 0e                	jb     898 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 88a:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	39 c8                	cmp    %ecx,%eax
 88e:	66 90                	xchg   %ax,%ax
 890:	72 e6                	jb     878 <free+0x18>
 892:	8b 10                	mov    (%eax),%edx
 894:	eb e8                	jmp    87e <free+0x1e>
 896:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 898:	8b 71 04             	mov    0x4(%ecx),%esi
 89b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 89e:	39 d7                	cmp    %edx,%edi
 8a0:	74 19                	je     8bb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8a2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8a5:	8b 50 04             	mov    0x4(%eax),%edx
 8a8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8ab:	39 ce                	cmp    %ecx,%esi
 8ad:	74 21                	je     8d0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8af:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8b1:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 8b6:	5b                   	pop    %ebx
 8b7:	5e                   	pop    %esi
 8b8:	5f                   	pop    %edi
 8b9:	5d                   	pop    %ebp
 8ba:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8bb:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 8be:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8c0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8c6:	8b 50 04             	mov    0x4(%eax),%edx
 8c9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8cc:	39 ce                	cmp    %ecx,%esi
 8ce:	75 df                	jne    8af <free+0x4f>
    p->s.size += bp->s.size;
 8d0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8d3:	a3 40 0a 00 00       	mov    %eax,0xa40
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8d8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8db:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8de:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8e0:	5b                   	pop    %ebx
 8e1:	5e                   	pop    %esi
 8e2:	5f                   	pop    %edi
 8e3:	5d                   	pop    %ebp
 8e4:	c3                   	ret    
 8e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 8fc:	8b 35 40 0a 00 00    	mov    0xa40,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 902:	83 c3 07             	add    $0x7,%ebx
 905:	c1 eb 03             	shr    $0x3,%ebx
 908:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 90b:	85 f6                	test   %esi,%esi
 90d:	0f 84 ab 00 00 00    	je     9be <malloc+0xce>
 913:	8b 16                	mov    (%esi),%edx
 915:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 918:	39 d9                	cmp    %ebx,%ecx
 91a:	0f 83 c6 00 00 00    	jae    9e6 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 920:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 927:	be 00 80 00 00       	mov    $0x8000,%esi
 92c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 92f:	eb 09                	jmp    93a <malloc+0x4a>
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 938:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 93a:	3b 15 40 0a 00 00    	cmp    0xa40,%edx
 940:	74 2e                	je     970 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 942:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 944:	8b 48 04             	mov    0x4(%eax),%ecx
 947:	39 cb                	cmp    %ecx,%ebx
 949:	77 ed                	ja     938 <malloc+0x48>
 94b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
 94d:	39 cb                	cmp    %ecx,%ebx
 94f:	74 67                	je     9b8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 951:	29 d9                	sub    %ebx,%ecx
 953:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 956:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 959:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 95c:	89 35 40 0a 00 00    	mov    %esi,0xa40
      return (void*) (p + 1);
 962:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 965:	83 c4 2c             	add    $0x2c,%esp
 968:	5b                   	pop    %ebx
 969:	5e                   	pop    %esi
 96a:	5f                   	pop    %edi
 96b:	5d                   	pop    %ebp
 96c:	c3                   	ret    
 96d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 970:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 973:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 979:	bf 00 10 00 00       	mov    $0x1000,%edi
 97e:	0f 47 fb             	cmova  %ebx,%edi
 981:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 984:	89 04 24             	mov    %eax,(%esp)
 987:	e8 80 fc ff ff       	call   60c <sbrk>
  if(p == (char*) -1)
 98c:	83 f8 ff             	cmp    $0xffffffff,%eax
 98f:	74 18                	je     9a9 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 991:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 994:	83 c0 08             	add    $0x8,%eax
 997:	89 04 24             	mov    %eax,(%esp)
 99a:	e8 c1 fe ff ff       	call   860 <free>
  return freep;
 99f:	8b 15 40 0a 00 00    	mov    0xa40,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9a5:	85 d2                	test   %edx,%edx
 9a7:	75 99                	jne    942 <malloc+0x52>
        return 0;
  }
}
 9a9:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 9ac:	31 c0                	xor    %eax,%eax
  }
}
 9ae:	5b                   	pop    %ebx
 9af:	5e                   	pop    %esi
 9b0:	5f                   	pop    %edi
 9b1:	5d                   	pop    %ebp
 9b2:	c3                   	ret    
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9b8:	8b 10                	mov    (%eax),%edx
 9ba:	89 16                	mov    %edx,(%esi)
 9bc:	eb 9e                	jmp    95c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9be:	c7 05 40 0a 00 00 44 	movl   $0xa44,0xa40
 9c5:	0a 00 00 
    base.s.size = 0;
 9c8:	ba 44 0a 00 00       	mov    $0xa44,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9cd:	c7 05 44 0a 00 00 44 	movl   $0xa44,0xa44
 9d4:	0a 00 00 
    base.s.size = 0;
 9d7:	c7 05 48 0a 00 00 00 	movl   $0x0,0xa48
 9de:	00 00 00 
 9e1:	e9 3a ff ff ff       	jmp    920 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9e6:	89 d0                	mov    %edx,%eax
 9e8:	e9 60 ff ff ff       	jmp    94d <malloc+0x5d>
