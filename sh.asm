
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
       6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
       9:	8b 5d 08             	mov    0x8(%ebp),%ebx
       c:	89 75 fc             	mov    %esi,-0x4(%ebp)
       f:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
      12:	c7 44 24 04 10 13 00 	movl   $0x1310,0x4(%esp)
      19:	00 
      1a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      21:	e8 ca 0f 00 00       	call   ff0 <printf>
  memset(buf, 0, nbuf);
      26:	89 74 24 08          	mov    %esi,0x8(%esp)
      2a:	89 1c 24             	mov    %ebx,(%esp)
      2d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      34:	00 
      35:	e8 c6 0c 00 00       	call   d00 <memset>
  gets(buf, nbuf);
      3a:	89 74 24 04          	mov    %esi,0x4(%esp)
      3e:	89 1c 24             	mov    %ebx,(%esp)
      41:	e8 2a 0d 00 00       	call   d70 <gets>
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
      46:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
      49:	80 3b 01             	cmpb   $0x1,(%ebx)
  return 0;
}
      4c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
      4f:	19 c0                	sbb    %eax,%eax
  return 0;
}
      51:	89 ec                	mov    %ebp,%esp
      53:	5d                   	pop    %ebp
      54:	c3                   	ret    
      55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <panic>:
  exit();
}

void
panic(char *s)
{
      60:	55                   	push   %ebp
      61:	89 e5                	mov    %esp,%ebp
      63:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
      66:	8b 45 08             	mov    0x8(%ebp),%eax
      69:	c7 44 24 04 ad 13 00 	movl   $0x13ad,0x4(%esp)
      70:	00 
      71:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      78:	89 44 24 08          	mov    %eax,0x8(%esp)
      7c:	e8 6f 0f 00 00       	call   ff0 <printf>
  exit();
      81:	e8 1e 0e 00 00       	call   ea4 <exit>
      86:	8d 76 00             	lea    0x0(%esi),%esi
      89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000090 <fork1>:
}

int
fork1(void)
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	83 ec 28             	sub    $0x28,%esp
  int pid;
  
  pid = fork();
      96:	e8 01 0e 00 00       	call   e9c <fork>
  if(pid == -1)
      9b:	83 f8 ff             	cmp    $0xffffffff,%eax
      9e:	74 08                	je     a8 <fork1+0x18>
    panic("fork");
  return pid;
}
      a0:	c9                   	leave  
      a1:	c3                   	ret    
      a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
      a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      ab:	c7 04 24 13 13 00 00 	movl   $0x1313,(%esp)
      b2:	e8 a9 ff ff ff       	call   60 <panic>
      b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return pid;
}
      ba:	c9                   	leave  
      bb:	c3                   	ret    
      bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000c0 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
      c0:	55                   	push   %ebp
      c1:	89 e5                	mov    %esp,%ebp
      c3:	53                   	push   %ebx
      c4:	83 ec 24             	sub    $0x24,%esp
      c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
      ca:	85 db                	test   %ebx,%ebx
      cc:	74 42                	je     110 <runcmd+0x50>
    exit();
  
  switch(cmd->type){
      ce:	83 3b 05             	cmpl   $0x5,(%ebx)
      d1:	76 45                	jbe    118 <runcmd+0x58>
  default:
    panic("runcmd");
      d3:	c7 04 24 18 13 00 00 	movl   $0x1318,(%esp)
      da:	e8 81 ff ff ff       	call   60 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      df:	8b 43 04             	mov    0x4(%ebx),%eax
      e2:	85 c0                	test   %eax,%eax
      e4:	74 2a                	je     110 <runcmd+0x50>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
      e6:	8d 53 04             	lea    0x4(%ebx),%edx
      e9:	89 54 24 04          	mov    %edx,0x4(%esp)
      ed:	89 04 24             	mov    %eax,(%esp)
      f0:	e8 e7 0d 00 00       	call   edc <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      f5:	8b 43 04             	mov    0x4(%ebx),%eax
      f8:	c7 44 24 04 1f 13 00 	movl   $0x131f,0x4(%esp)
      ff:	00 
     100:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     107:	89 44 24 08          	mov    %eax,0x8(%esp)
     10b:	e8 e0 0e 00 00       	call   ff0 <printf>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     110:	e8 8f 0d 00 00       	call   ea4 <exit>
     115:	8d 76 00             	lea    0x0(%esi),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
  
  switch(cmd->type){
     118:	8b 03                	mov    (%ebx),%eax
     11a:	ff 24 85 c8 13 00 00 	jmp    *0x13c8(,%eax,4)
     121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait();
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     128:	e8 63 ff ff ff       	call   90 <fork1>
     12d:	85 c0                	test   %eax,%eax
     12f:	90                   	nop
     130:	0f 84 a7 00 00 00    	je     1dd <runcmd+0x11d>
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     136:	e8 69 0d 00 00       	call   ea4 <exit>
     13b:	90                   	nop
     13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     140:	e8 4b ff ff ff       	call   90 <fork1>
     145:	85 c0                	test   %eax,%eax
     147:	0f 84 a3 00 00 00    	je     1f0 <runcmd+0x130>
     14d:	8d 76 00             	lea    0x0(%esi),%esi
      runcmd(lcmd->left);
    wait();
     150:	e8 57 0d 00 00       	call   eac <wait>
    runcmd(lcmd->right);
     155:	8b 43 08             	mov    0x8(%ebx),%eax
     158:	89 04 24             	mov    %eax,(%esp)
     15b:	e8 60 ff ff ff       	call   c0 <runcmd>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     160:	e8 3f 0d 00 00       	call   ea4 <exit>
     165:	8d 76 00             	lea    0x0(%esi),%esi
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     168:	8d 45 f0             	lea    -0x10(%ebp),%eax
     16b:	89 04 24             	mov    %eax,(%esp)
     16e:	e8 41 0d 00 00       	call   eb4 <pipe>
     173:	85 c0                	test   %eax,%eax
     175:	0f 88 25 01 00 00    	js     2a0 <runcmd+0x1e0>
      panic("pipe");
    if(fork1() == 0){
     17b:	e8 10 ff ff ff       	call   90 <fork1>
     180:	85 c0                	test   %eax,%eax
     182:	0f 84 b8 00 00 00    	je     240 <runcmd+0x180>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     188:	e8 03 ff ff ff       	call   90 <fork1>
     18d:	85 c0                	test   %eax,%eax
     18f:	90                   	nop
     190:	74 6e                	je     200 <runcmd+0x140>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     192:	8b 45 f0             	mov    -0x10(%ebp),%eax
     195:	89 04 24             	mov    %eax,(%esp)
     198:	e8 2f 0d 00 00       	call   ecc <close>
    close(p[1]);
     19d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1a0:	89 04 24             	mov    %eax,(%esp)
     1a3:	e8 24 0d 00 00       	call   ecc <close>
    wait();
     1a8:	e8 ff 0c 00 00       	call   eac <wait>
    wait();
     1ad:	e8 fa 0c 00 00       	call   eac <wait>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     1b2:	e8 ed 0c 00 00       	call   ea4 <exit>
     1b7:	90                   	nop
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     1b8:	8b 43 14             	mov    0x14(%ebx),%eax
     1bb:	89 04 24             	mov    %eax,(%esp)
     1be:	e8 09 0d 00 00       	call   ecc <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1c3:	8b 43 10             	mov    0x10(%ebx),%eax
     1c6:	89 44 24 04          	mov    %eax,0x4(%esp)
     1ca:	8b 43 08             	mov    0x8(%ebx),%eax
     1cd:	89 04 24             	mov    %eax,(%esp)
     1d0:	e8 0f 0d 00 00       	call   ee4 <open>
     1d5:	85 c0                	test   %eax,%eax
     1d7:	0f 88 a3 00 00 00    	js     280 <runcmd+0x1c0>
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     1dd:	8b 43 04             	mov    0x4(%ebx),%eax
     1e0:	89 04 24             	mov    %eax,(%esp)
     1e3:	e8 d8 fe ff ff       	call   c0 <runcmd>
    break;
  }
  exit();
     1e8:	e8 b7 0c 00 00       	call   ea4 <exit>
     1ed:	8d 76 00             	lea    0x0(%esi),%esi
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
     1f0:	8b 43 04             	mov    0x4(%ebx),%eax
     1f3:	89 04 24             	mov    %eax,(%esp)
     1f6:	e8 c5 fe ff ff       	call   c0 <runcmd>
     1fb:	e9 4d ff ff ff       	jmp    14d <runcmd+0x8d>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
     200:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     207:	e8 c0 0c 00 00       	call   ecc <close>
      dup(p[0]);
     20c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     20f:	89 04 24             	mov    %eax,(%esp)
     212:	e8 05 0d 00 00       	call   f1c <dup>
      close(p[0]);
     217:	8b 45 f0             	mov    -0x10(%ebp),%eax
     21a:	89 04 24             	mov    %eax,(%esp)
     21d:	e8 aa 0c 00 00       	call   ecc <close>
      close(p[1]);
     222:	8b 45 f4             	mov    -0xc(%ebp),%eax
     225:	89 04 24             	mov    %eax,(%esp)
     228:	e8 9f 0c 00 00       	call   ecc <close>
      runcmd(pcmd->right);
     22d:	8b 43 08             	mov    0x8(%ebx),%eax
     230:	89 04 24             	mov    %eax,(%esp)
     233:	e8 88 fe ff ff       	call   c0 <runcmd>
     238:	e9 55 ff ff ff       	jmp    192 <runcmd+0xd2>
     23d:	8d 76 00             	lea    0x0(%esi),%esi
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
     240:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     247:	e8 80 0c 00 00       	call   ecc <close>
      dup(p[1]);
     24c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     24f:	89 04 24             	mov    %eax,(%esp)
     252:	e8 c5 0c 00 00       	call   f1c <dup>
      close(p[0]);
     257:	8b 45 f0             	mov    -0x10(%ebp),%eax
     25a:	89 04 24             	mov    %eax,(%esp)
     25d:	e8 6a 0c 00 00       	call   ecc <close>
      close(p[1]);
     262:	8b 45 f4             	mov    -0xc(%ebp),%eax
     265:	89 04 24             	mov    %eax,(%esp)
     268:	e8 5f 0c 00 00       	call   ecc <close>
      runcmd(pcmd->left);
     26d:	8b 43 04             	mov    0x4(%ebx),%eax
     270:	89 04 24             	mov    %eax,(%esp)
     273:	e8 48 fe ff ff       	call   c0 <runcmd>
     278:	e9 0b ff ff ff       	jmp    188 <runcmd+0xc8>
     27d:	8d 76 00             	lea    0x0(%esi),%esi

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     280:	8b 43 08             	mov    0x8(%ebx),%eax
     283:	c7 44 24 04 2f 13 00 	movl   $0x132f,0x4(%esp)
     28a:	00 
     28b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     292:	89 44 24 08          	mov    %eax,0x8(%esp)
     296:	e8 55 0d 00 00       	call   ff0 <printf>
      exit();
     29b:	e8 04 0c 00 00       	call   ea4 <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     2a0:	c7 04 24 3f 13 00 00 	movl   $0x133f,(%esp)
     2a7:	e8 b4 fd ff ff       	call   60 <panic>
     2ac:	e9 ca fe ff ff       	jmp    17b <runcmd+0xbb>
     2b1:	eb 0d                	jmp    2c0 <execcmd>
     2b3:	90                   	nop
     2b4:	90                   	nop
     2b5:	90                   	nop
     2b6:	90                   	nop
     2b7:	90                   	nop
     2b8:	90                   	nop
     2b9:	90                   	nop
     2ba:	90                   	nop
     2bb:	90                   	nop
     2bc:	90                   	nop
     2bd:	90                   	nop
     2be:	90                   	nop
     2bf:	90                   	nop

000002c0 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	53                   	push   %ebx
     2c4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2c7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     2ce:	e8 3d 0f 00 00       	call   1210 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2d3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     2da:	00 
     2db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2e2:	00 
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2e5:	89 04 24             	mov    %eax,(%esp)
     2e8:	e8 13 0a 00 00       	call   d00 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     2ed:	89 d8                	mov    %ebx,%eax
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
     2ef:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     2f5:	83 c4 14             	add    $0x14,%esp
     2f8:	5b                   	pop    %ebx
     2f9:	5d                   	pop    %ebp
     2fa:	c3                   	ret    
     2fb:	90                   	nop
     2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	53                   	push   %ebx
     304:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     307:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     30e:	e8 fd 0e 00 00       	call   1210 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     313:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     31a:	00 
     31b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     322:	00 
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     323:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     325:	89 04 24             	mov    %eax,(%esp)
     328:	e8 d3 09 00 00       	call   d00 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     32d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     330:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     336:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     339:	8b 45 0c             	mov    0xc(%ebp),%eax
     33c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     33f:	8b 45 10             	mov    0x10(%ebp),%eax
     342:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     345:	8b 45 14             	mov    0x14(%ebp),%eax
     348:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     34b:	8b 45 18             	mov    0x18(%ebp),%eax
     34e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     351:	89 d8                	mov    %ebx,%eax
     353:	83 c4 14             	add    $0x14,%esp
     356:	5b                   	pop    %ebx
     357:	5d                   	pop    %ebp
     358:	c3                   	ret    
     359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     36e:	e8 9d 0e 00 00       	call   1210 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     373:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     37a:	00 
     37b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     382:	00 
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     383:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     385:	89 04 24             	mov    %eax,(%esp)
     388:	e8 73 09 00 00       	call   d00 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     38d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     390:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     39f:	89 d8                	mov    %ebx,%eax
     3a1:	83 c4 14             	add    $0x14,%esp
     3a4:	5b                   	pop    %ebx
     3a5:	5d                   	pop    %ebp
     3a6:	c3                   	ret    
     3a7:	89 f6                	mov    %esi,%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	53                   	push   %ebx
     3b4:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     3be:	e8 4d 0e 00 00       	call   1210 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3c3:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     3ca:	00 
     3cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3d2:	00 
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d5:	89 04 24             	mov    %eax,(%esp)
     3d8:	e8 23 09 00 00       	call   d00 <memset>
  cmd->type = LIST;
  cmd->left = left;
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     3e0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     3e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ef:	89 d8                	mov    %ebx,%eax
     3f1:	83 c4 14             	add    $0x14,%esp
     3f4:	5b                   	pop    %ebx
     3f5:	5d                   	pop    %ebp
     3f6:	c3                   	ret    
     3f7:	89 f6                	mov    %esi,%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     40e:	e8 fd 0d 00 00       	call   1210 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     413:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     41a:	00 
     41b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     422:	00 
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     423:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     425:	89 04 24             	mov    %eax,(%esp)
     428:	e8 d3 08 00 00       	call   d00 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     42d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     430:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     436:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     439:	89 d8                	mov    %ebx,%eax
     43b:	83 c4 14             	add    $0x14,%esp
     43e:	5b                   	pop    %ebx
     43f:	5d                   	pop    %ebp
     440:	c3                   	ret    
     441:	eb 0d                	jmp    450 <gettoken>
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

00000450 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	57                   	push   %edi
     454:	56                   	push   %esi
     455:	53                   	push   %ebx
     456:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;
  
  s = *ps;
     459:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     45c:	8b 75 0c             	mov    0xc(%ebp),%esi
     45f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *s;
  int ret;
  
  s = *ps;
     462:	8b 18                	mov    (%eax),%ebx
  while(s < es && strchr(whitespace, *s))
     464:	39 f3                	cmp    %esi,%ebx
     466:	72 0f                	jb     477 <gettoken+0x27>
     468:	eb 24                	jmp    48e <gettoken+0x3e>
     46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     470:	83 c3 01             	add    $0x1,%ebx
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     473:	39 de                	cmp    %ebx,%esi
     475:	76 17                	jbe    48e <gettoken+0x3e>
     477:	0f be 03             	movsbl (%ebx),%eax
     47a:	c7 04 24 10 14 00 00 	movl   $0x1410,(%esp)
     481:	89 44 24 04          	mov    %eax,0x4(%esp)
     485:	e8 a6 08 00 00       	call   d30 <strchr>
     48a:	85 c0                	test   %eax,%eax
     48c:	75 e2                	jne    470 <gettoken+0x20>
    s++;
  if(q)
     48e:	85 ff                	test   %edi,%edi
     490:	74 02                	je     494 <gettoken+0x44>
    *q = s;
     492:	89 1f                	mov    %ebx,(%edi)
  ret = *s;
     494:	0f b6 13             	movzbl (%ebx),%edx
     497:	0f be fa             	movsbl %dl,%edi
  switch(*s){
     49a:	80 fa 3c             	cmp    $0x3c,%dl
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
     49d:	89 f8                	mov    %edi,%eax
  switch(*s){
     49f:	7f 4f                	jg     4f0 <gettoken+0xa0>
     4a1:	80 fa 3b             	cmp    $0x3b,%dl
     4a4:	0f 8c 9e 00 00 00    	jl     548 <gettoken+0xf8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     4aa:	83 c3 01             	add    $0x1,%ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4ad:	8b 45 14             	mov    0x14(%ebp),%eax
     4b0:	85 c0                	test   %eax,%eax
     4b2:	74 05                	je     4b9 <gettoken+0x69>
    *eq = s;
     4b4:	8b 45 14             	mov    0x14(%ebp),%eax
     4b7:	89 18                	mov    %ebx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     4b9:	39 f3                	cmp    %esi,%ebx
     4bb:	72 0a                	jb     4c7 <gettoken+0x77>
     4bd:	eb 1f                	jmp    4de <gettoken+0x8e>
     4bf:	90                   	nop
    s++;
     4c0:	83 c3 01             	add    $0x1,%ebx
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     4c3:	39 de                	cmp    %ebx,%esi
     4c5:	76 17                	jbe    4de <gettoken+0x8e>
     4c7:	0f be 03             	movsbl (%ebx),%eax
     4ca:	c7 04 24 10 14 00 00 	movl   $0x1410,(%esp)
     4d1:	89 44 24 04          	mov    %eax,0x4(%esp)
     4d5:	e8 56 08 00 00       	call   d30 <strchr>
     4da:	85 c0                	test   %eax,%eax
     4dc:	75 e2                	jne    4c0 <gettoken+0x70>
    s++;
  *ps = s;
     4de:	8b 45 08             	mov    0x8(%ebp),%eax
     4e1:	89 18                	mov    %ebx,(%eax)
  return ret;
}
     4e3:	83 c4 1c             	add    $0x1c,%esp
     4e6:	89 f8                	mov    %edi,%eax
     4e8:	5b                   	pop    %ebx
     4e9:	5e                   	pop    %esi
     4ea:	5f                   	pop    %edi
     4eb:	5d                   	pop    %ebp
     4ec:	c3                   	ret    
     4ed:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     4f0:	80 fa 3e             	cmp    $0x3e,%dl
     4f3:	74 73                	je     568 <gettoken+0x118>
     4f5:	80 fa 7c             	cmp    $0x7c,%dl
     4f8:	74 b0                	je     4aa <gettoken+0x5a>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4fa:	39 de                	cmp    %ebx,%esi
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     4fc:	bf 61 00 00 00       	mov    $0x61,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     501:	77 26                	ja     529 <gettoken+0xd9>
     503:	eb a8                	jmp    4ad <gettoken+0x5d>
     505:	8d 76 00             	lea    0x0(%esi),%esi
     508:	0f be 03             	movsbl (%ebx),%eax
     50b:	c7 04 24 16 14 00 00 	movl   $0x1416,(%esp)
     512:	89 44 24 04          	mov    %eax,0x4(%esp)
     516:	e8 15 08 00 00       	call   d30 <strchr>
     51b:	85 c0                	test   %eax,%eax
     51d:	75 1e                	jne    53d <gettoken+0xed>
      s++;
     51f:	83 c3 01             	add    $0x1,%ebx
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     522:	39 de                	cmp    %ebx,%esi
     524:	76 17                	jbe    53d <gettoken+0xed>
     526:	0f be 03             	movsbl (%ebx),%eax
     529:	89 44 24 04          	mov    %eax,0x4(%esp)
     52d:	c7 04 24 10 14 00 00 	movl   $0x1410,(%esp)
     534:	e8 f7 07 00 00       	call   d30 <strchr>
     539:	85 c0                	test   %eax,%eax
     53b:	74 cb                	je     508 <gettoken+0xb8>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     53d:	bf 61 00 00 00       	mov    $0x61,%edi
     542:	e9 66 ff ff ff       	jmp    4ad <gettoken+0x5d>
     547:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     548:	80 fa 29             	cmp    $0x29,%dl
     54b:	7f ad                	jg     4fa <gettoken+0xaa>
     54d:	80 fa 28             	cmp    $0x28,%dl
     550:	0f 8d 54 ff ff ff    	jge    4aa <gettoken+0x5a>
     556:	84 d2                	test   %dl,%dl
     558:	0f 84 4f ff ff ff    	je     4ad <gettoken+0x5d>
     55e:	80 fa 26             	cmp    $0x26,%dl
     561:	75 97                	jne    4fa <gettoken+0xaa>
     563:	e9 42 ff ff ff       	jmp    4aa <gettoken+0x5a>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     568:	83 c3 01             	add    $0x1,%ebx
    if(*s == '>'){
     56b:	80 3b 3e             	cmpb   $0x3e,(%ebx)
     56e:	66 90                	xchg   %ax,%ax
     570:	0f 85 37 ff ff ff    	jne    4ad <gettoken+0x5d>
      ret = '+';
      s++;
     576:	83 c3 01             	add    $0x1,%ebx
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     579:	bf 2b 00 00 00       	mov    $0x2b,%edi
     57e:	e9 2a ff ff ff       	jmp    4ad <gettoken+0x5d>
     583:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000590 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	57                   	push   %edi
     594:	56                   	push   %esi
     595:	53                   	push   %ebx
     596:	83 ec 1c             	sub    $0x1c,%esp
     599:	8b 7d 08             	mov    0x8(%ebp),%edi
     59c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;
  
  s = *ps;
     59f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5a1:	39 f3                	cmp    %esi,%ebx
     5a3:	72 0a                	jb     5af <peek+0x1f>
     5a5:	eb 1f                	jmp    5c6 <peek+0x36>
     5a7:	90                   	nop
    s++;
     5a8:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     5ab:	39 de                	cmp    %ebx,%esi
     5ad:	76 17                	jbe    5c6 <peek+0x36>
     5af:	0f be 03             	movsbl (%ebx),%eax
     5b2:	c7 04 24 10 14 00 00 	movl   $0x1410,(%esp)
     5b9:	89 44 24 04          	mov    %eax,0x4(%esp)
     5bd:	e8 6e 07 00 00       	call   d30 <strchr>
     5c2:	85 c0                	test   %eax,%eax
     5c4:	75 e2                	jne    5a8 <peek+0x18>
    s++;
  *ps = s;
     5c6:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     5c8:	0f b6 13             	movzbl (%ebx),%edx
     5cb:	31 c0                	xor    %eax,%eax
     5cd:	84 d2                	test   %dl,%dl
     5cf:	75 0f                	jne    5e0 <peek+0x50>
}
     5d1:	83 c4 1c             	add    $0x1c,%esp
     5d4:	5b                   	pop    %ebx
     5d5:	5e                   	pop    %esi
     5d6:	5f                   	pop    %edi
     5d7:	5d                   	pop    %ebp
     5d8:	c3                   	ret    
     5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     5e0:	8b 45 10             	mov    0x10(%ebp),%eax
     5e3:	0f be d2             	movsbl %dl,%edx
     5e6:	89 54 24 04          	mov    %edx,0x4(%esp)
     5ea:	89 04 24             	mov    %eax,(%esp)
     5ed:	e8 3e 07 00 00       	call   d30 <strchr>
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
     5f2:	85 c0                	test   %eax,%eax
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     5f4:	0f 95 c0             	setne  %al
}
     5f7:	83 c4 1c             	add    $0x1c,%esp
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     5fa:	0f b6 c0             	movzbl %al,%eax
}
     5fd:	5b                   	pop    %ebx
     5fe:	5e                   	pop    %esi
     5ff:	5f                   	pop    %edi
     600:	5d                   	pop    %ebp
     601:	c3                   	ret    
     602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	56                   	push   %esi
     615:	53                   	push   %ebx
     616:	83 ec 3c             	sub    $0x3c,%esp
     619:	8b 7d 0c             	mov    0xc(%ebp),%edi
     61c:	8b 75 10             	mov    0x10(%ebp),%esi
     61f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     620:	c7 44 24 08 61 13 00 	movl   $0x1361,0x8(%esp)
     627:	00 
     628:	89 74 24 04          	mov    %esi,0x4(%esp)
     62c:	89 3c 24             	mov    %edi,(%esp)
     62f:	e8 5c ff ff ff       	call   590 <peek>
     634:	85 c0                	test   %eax,%eax
     636:	0f 84 a4 00 00 00    	je     6e0 <parseredirs+0xd0>
    tok = gettoken(ps, es, 0, 0);
     63c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     643:	00 
     644:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     64b:	00 
     64c:	89 74 24 04          	mov    %esi,0x4(%esp)
     650:	89 3c 24             	mov    %edi,(%esp)
     653:	e8 f8 fd ff ff       	call   450 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     658:	89 74 24 04          	mov    %esi,0x4(%esp)
     65c:	89 3c 24             	mov    %edi,(%esp)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
     65f:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
     661:	8d 45 e0             	lea    -0x20(%ebp),%eax
     664:	89 44 24 0c          	mov    %eax,0xc(%esp)
     668:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     66b:	89 44 24 08          	mov    %eax,0x8(%esp)
     66f:	e8 dc fd ff ff       	call   450 <gettoken>
     674:	83 f8 61             	cmp    $0x61,%eax
     677:	74 0c                	je     685 <parseredirs+0x75>
      panic("missing file for redirection");
     679:	c7 04 24 44 13 00 00 	movl   $0x1344,(%esp)
     680:	e8 db f9 ff ff       	call   60 <panic>
    switch(tok){
     685:	83 fb 3c             	cmp    $0x3c,%ebx
     688:	74 3e                	je     6c8 <parseredirs+0xb8>
     68a:	83 fb 3e             	cmp    $0x3e,%ebx
     68d:	74 05                	je     694 <parseredirs+0x84>
     68f:	83 fb 2b             	cmp    $0x2b,%ebx
     692:	75 8c                	jne    620 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     694:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     69b:	00 
     69c:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     6a3:	00 
     6a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6a7:	89 44 24 08          	mov    %eax,0x8(%esp)
     6ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b2:	8b 45 08             	mov    0x8(%ebp),%eax
     6b5:	89 04 24             	mov    %eax,(%esp)
     6b8:	e8 43 fc ff ff       	call   300 <redircmd>
     6bd:	89 45 08             	mov    %eax,0x8(%ebp)
     6c0:	e9 5b ff ff ff       	jmp    620 <parseredirs+0x10>
     6c5:	8d 76 00             	lea    0x0(%esi),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c8:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     6cf:	00 
     6d0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6d7:	00 
     6d8:	eb ca                	jmp    6a4 <parseredirs+0x94>
     6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     6e0:	8b 45 08             	mov    0x8(%ebp),%eax
     6e3:	83 c4 3c             	add    $0x3c,%esp
     6e6:	5b                   	pop    %ebx
     6e7:	5e                   	pop    %esi
     6e8:	5f                   	pop    %edi
     6e9:	5d                   	pop    %ebp
     6ea:	c3                   	ret    
     6eb:	90                   	nop
     6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 3c             	sub    $0x3c,%esp
     6f9:	8b 75 08             	mov    0x8(%ebp),%esi
     6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     6ff:	c7 44 24 08 64 13 00 	movl   $0x1364,0x8(%esp)
     706:	00 
     707:	89 34 24             	mov    %esi,(%esp)
     70a:	89 7c 24 04          	mov    %edi,0x4(%esp)
     70e:	e8 7d fe ff ff       	call   590 <peek>
     713:	85 c0                	test   %eax,%eax
     715:	0f 85 cd 00 00 00    	jne    7e8 <parseexec+0xf8>
    return parseblock(ps, es);

  ret = execcmd();
     71b:	e8 a0 fb ff ff       	call   2c0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
     720:	31 db                	xor    %ebx,%ebx
  ret = parseredirs(ret, ps, es);
     722:	89 7c 24 08          	mov    %edi,0x8(%esp)
     726:	89 74 24 04          	mov    %esi,0x4(%esp)
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     72a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     72d:	89 04 24             	mov    %eax,(%esp)
     730:	e8 db fe ff ff       	call   610 <parseredirs>
     735:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     738:	eb 1c                	jmp    756 <parseexec+0x66>
     73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     740:	8b 45 d0             	mov    -0x30(%ebp),%eax
     743:	89 7c 24 08          	mov    %edi,0x8(%esp)
     747:	89 74 24 04          	mov    %esi,0x4(%esp)
     74b:	89 04 24             	mov    %eax,(%esp)
     74e:	e8 bd fe ff ff       	call   610 <parseredirs>
     753:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     756:	c7 44 24 08 7b 13 00 	movl   $0x137b,0x8(%esp)
     75d:	00 
     75e:	89 7c 24 04          	mov    %edi,0x4(%esp)
     762:	89 34 24             	mov    %esi,(%esp)
     765:	e8 26 fe ff ff       	call   590 <peek>
     76a:	85 c0                	test   %eax,%eax
     76c:	75 5a                	jne    7c8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     76e:	8d 45 e0             	lea    -0x20(%ebp),%eax
     771:	8d 55 e4             	lea    -0x1c(%ebp),%edx
     774:	89 44 24 0c          	mov    %eax,0xc(%esp)
     778:	89 54 24 08          	mov    %edx,0x8(%esp)
     77c:	89 7c 24 04          	mov    %edi,0x4(%esp)
     780:	89 34 24             	mov    %esi,(%esp)
     783:	e8 c8 fc ff ff       	call   450 <gettoken>
     788:	85 c0                	test   %eax,%eax
     78a:	74 3c                	je     7c8 <parseexec+0xd8>
      break;
    if(tok != 'a')
     78c:	83 f8 61             	cmp    $0x61,%eax
     78f:	74 0c                	je     79d <parseexec+0xad>
      panic("syntax");
     791:	c7 04 24 66 13 00 00 	movl   $0x1366,(%esp)
     798:	e8 c3 f8 ff ff       	call   60 <panic>
    cmd->argv[argc] = q;
     79d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     7a3:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7aa:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7ae:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     7b1:	83 fb 09             	cmp    $0x9,%ebx
     7b4:	7e 8a                	jle    740 <parseexec+0x50>
      panic("too many args");
     7b6:	c7 04 24 6d 13 00 00 	movl   $0x136d,(%esp)
     7bd:	e8 9e f8 ff ff       	call   60 <panic>
     7c2:	e9 79 ff ff ff       	jmp    740 <parseexec+0x50>
     7c7:	90                   	nop
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     7c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  cmd->eargv[argc] = 0;
  return ret;
}
     7cb:	8b 45 d0             	mov    -0x30(%ebp),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     7ce:	c7 44 9a 04 00 00 00 	movl   $0x0,0x4(%edx,%ebx,4)
     7d5:	00 
  cmd->eargv[argc] = 0;
     7d6:	c7 44 9a 2c 00 00 00 	movl   $0x0,0x2c(%edx,%ebx,4)
     7dd:	00 
  return ret;
}
     7de:	83 c4 3c             	add    $0x3c,%esp
     7e1:	5b                   	pop    %ebx
     7e2:	5e                   	pop    %esi
     7e3:	5f                   	pop    %edi
     7e4:	5d                   	pop    %ebp
     7e5:	c3                   	ret    
     7e6:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);
     7e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7ec:	89 34 24             	mov    %esi,(%esp)
     7ef:	e8 6c 01 00 00       	call   960 <parseblock>
     7f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7f7:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7fa:	83 c4 3c             	add    $0x3c,%esp
     7fd:	5b                   	pop    %ebx
     7fe:	5e                   	pop    %esi
     7ff:	5f                   	pop    %edi
     800:	5d                   	pop    %ebp
     801:	c3                   	ret    
     802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000810 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	83 ec 28             	sub    $0x28,%esp
     816:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     819:	8b 5d 08             	mov    0x8(%ebp),%ebx
     81c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     81f:	8b 75 0c             	mov    0xc(%ebp),%esi
     822:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     825:	89 1c 24             	mov    %ebx,(%esp)
     828:	89 74 24 04          	mov    %esi,0x4(%esp)
     82c:	e8 bf fe ff ff       	call   6f0 <parseexec>
  if(peek(ps, es, "|")){
     831:	c7 44 24 08 80 13 00 	movl   $0x1380,0x8(%esp)
     838:	00 
     839:	89 74 24 04          	mov    %esi,0x4(%esp)
     83d:	89 1c 24             	mov    %ebx,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     840:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     842:	e8 49 fd ff ff       	call   590 <peek>
     847:	85 c0                	test   %eax,%eax
     849:	75 15                	jne    860 <parsepipe+0x50>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     84b:	89 f8                	mov    %edi,%eax
     84d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     850:	8b 75 f8             	mov    -0x8(%ebp),%esi
     853:	8b 7d fc             	mov    -0x4(%ebp),%edi
     856:	89 ec                	mov    %ebp,%esp
     858:	5d                   	pop    %ebp
     859:	c3                   	ret    
     85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     860:	89 74 24 04          	mov    %esi,0x4(%esp)
     864:	89 1c 24             	mov    %ebx,(%esp)
     867:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     86e:	00 
     86f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     876:	00 
     877:	e8 d4 fb ff ff       	call   450 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     87c:	89 74 24 04          	mov    %esi,0x4(%esp)
     880:	89 1c 24             	mov    %ebx,(%esp)
     883:	e8 88 ff ff ff       	call   810 <parsepipe>
  }
  return cmd;
}
     888:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     88b:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     88e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     891:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     894:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     897:	89 ec                	mov    %ebp,%esp
     899:	5d                   	pop    %ebp
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     89a:	e9 c1 fa ff ff       	jmp    360 <pipecmd>
     89f:	90                   	nop

000008a0 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	57                   	push   %edi
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	83 ec 1c             	sub    $0x1c,%esp
     8a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     8af:	89 1c 24             	mov    %ebx,(%esp)
     8b2:	89 74 24 04          	mov    %esi,0x4(%esp)
     8b6:	e8 55 ff ff ff       	call   810 <parsepipe>
     8bb:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8bd:	eb 27                	jmp    8e6 <parseline+0x46>
     8bf:	90                   	nop
    gettoken(ps, es, 0, 0);
     8c0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8c7:	00 
     8c8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8cf:	00 
     8d0:	89 74 24 04          	mov    %esi,0x4(%esp)
     8d4:	89 1c 24             	mov    %ebx,(%esp)
     8d7:	e8 74 fb ff ff       	call   450 <gettoken>
    cmd = backcmd(cmd);
     8dc:	89 3c 24             	mov    %edi,(%esp)
     8df:	e8 1c fb ff ff       	call   400 <backcmd>
     8e4:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     8e6:	c7 44 24 08 82 13 00 	movl   $0x1382,0x8(%esp)
     8ed:	00 
     8ee:	89 74 24 04          	mov    %esi,0x4(%esp)
     8f2:	89 1c 24             	mov    %ebx,(%esp)
     8f5:	e8 96 fc ff ff       	call   590 <peek>
     8fa:	85 c0                	test   %eax,%eax
     8fc:	75 c2                	jne    8c0 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     8fe:	c7 44 24 08 7e 13 00 	movl   $0x137e,0x8(%esp)
     905:	00 
     906:	89 74 24 04          	mov    %esi,0x4(%esp)
     90a:	89 1c 24             	mov    %ebx,(%esp)
     90d:	e8 7e fc ff ff       	call   590 <peek>
     912:	85 c0                	test   %eax,%eax
     914:	75 0a                	jne    920 <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     916:	83 c4 1c             	add    $0x1c,%esp
     919:	89 f8                	mov    %edi,%eax
     91b:	5b                   	pop    %ebx
     91c:	5e                   	pop    %esi
     91d:	5f                   	pop    %edi
     91e:	5d                   	pop    %ebp
     91f:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     920:	89 74 24 04          	mov    %esi,0x4(%esp)
     924:	89 1c 24             	mov    %ebx,(%esp)
     927:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     92e:	00 
     92f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     936:	00 
     937:	e8 14 fb ff ff       	call   450 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     93c:	89 74 24 04          	mov    %esi,0x4(%esp)
     940:	89 1c 24             	mov    %ebx,(%esp)
     943:	e8 58 ff ff ff       	call   8a0 <parseline>
     948:	89 7d 08             	mov    %edi,0x8(%ebp)
     94b:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     94e:	83 c4 1c             	add    $0x1c,%esp
     951:	5b                   	pop    %ebx
     952:	5e                   	pop    %esi
     953:	5f                   	pop    %edi
     954:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     955:	e9 56 fa ff ff       	jmp    3b0 <listcmd>
     95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000960 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	83 ec 28             	sub    $0x28,%esp
     966:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     969:	8b 5d 08             	mov    0x8(%ebp),%ebx
     96c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     96f:	8b 75 0c             	mov    0xc(%ebp),%esi
     972:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     975:	c7 44 24 08 64 13 00 	movl   $0x1364,0x8(%esp)
     97c:	00 
     97d:	89 1c 24             	mov    %ebx,(%esp)
     980:	89 74 24 04          	mov    %esi,0x4(%esp)
     984:	e8 07 fc ff ff       	call   590 <peek>
     989:	85 c0                	test   %eax,%eax
     98b:	0f 84 87 00 00 00    	je     a18 <parseblock+0xb8>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     991:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     998:	00 
     999:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9a0:	00 
     9a1:	89 74 24 04          	mov    %esi,0x4(%esp)
     9a5:	89 1c 24             	mov    %ebx,(%esp)
     9a8:	e8 a3 fa ff ff       	call   450 <gettoken>
  cmd = parseline(ps, es);
     9ad:	89 74 24 04          	mov    %esi,0x4(%esp)
     9b1:	89 1c 24             	mov    %ebx,(%esp)
     9b4:	e8 e7 fe ff ff       	call   8a0 <parseline>
  if(!peek(ps, es, ")"))
     9b9:	c7 44 24 08 a0 13 00 	movl   $0x13a0,0x8(%esp)
     9c0:	00 
     9c1:	89 74 24 04          	mov    %esi,0x4(%esp)
     9c5:	89 1c 24             	mov    %ebx,(%esp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     9c8:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9ca:	e8 c1 fb ff ff       	call   590 <peek>
     9cf:	85 c0                	test   %eax,%eax
     9d1:	75 0c                	jne    9df <parseblock+0x7f>
    panic("syntax - missing )");
     9d3:	c7 04 24 8f 13 00 00 	movl   $0x138f,(%esp)
     9da:	e8 81 f6 ff ff       	call   60 <panic>
  gettoken(ps, es, 0, 0);
     9df:	89 74 24 04          	mov    %esi,0x4(%esp)
     9e3:	89 1c 24             	mov    %ebx,(%esp)
     9e6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9ed:	00 
     9ee:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9f5:	00 
     9f6:	e8 55 fa ff ff       	call   450 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9fb:	89 74 24 08          	mov    %esi,0x8(%esp)
     9ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a03:	89 3c 24             	mov    %edi,(%esp)
     a06:	e8 05 fc ff ff       	call   610 <parseredirs>
  return cmd;
}
     a0b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     a0e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     a11:	8b 7d fc             	mov    -0x4(%ebp),%edi
     a14:	89 ec                	mov    %ebp,%esp
     a16:	5d                   	pop    %ebp
     a17:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     a18:	c7 04 24 84 13 00 00 	movl   $0x1384,(%esp)
     a1f:	e8 3c f6 ff ff       	call   60 <panic>
     a24:	e9 68 ff ff ff       	jmp    991 <parseblock+0x31>
     a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a30 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	83 ec 14             	sub    $0x14,%esp
     a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a3a:	85 db                	test   %ebx,%ebx
     a3c:	74 05                	je     a43 <nulterminate+0x13>
    return 0;
  
  switch(cmd->type){
     a3e:	83 3b 05             	cmpl   $0x5,(%ebx)
     a41:	76 0d                	jbe    a50 <nulterminate+0x20>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a43:	89 d8                	mov    %ebx,%eax
     a45:	83 c4 14             	add    $0x14,%esp
     a48:	5b                   	pop    %ebx
     a49:	5d                   	pop    %ebp
     a4a:	c3                   	ret    
     a4b:	90                   	nop
     a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
  
  switch(cmd->type){
     a50:	8b 03                	mov    (%ebx),%eax
     a52:	ff 24 85 e0 13 00 00 	jmp    *0x13e0(,%eax,4)
     a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a60:	8b 43 04             	mov    0x4(%ebx),%eax
     a63:	89 04 24             	mov    %eax,(%esp)
     a66:	e8 c5 ff ff ff       	call   a30 <nulterminate>
    nulterminate(lcmd->right);
     a6b:	8b 43 08             	mov    0x8(%ebx),%eax
     a6e:	89 04 24             	mov    %eax,(%esp)
     a71:	e8 ba ff ff ff       	call   a30 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a76:	89 d8                	mov    %ebx,%eax
     a78:	83 c4 14             	add    $0x14,%esp
     a7b:	5b                   	pop    %ebx
     a7c:	5d                   	pop    %ebp
     a7d:	c3                   	ret    
     a7e:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a80:	8b 43 04             	mov    0x4(%ebx),%eax
     a83:	89 04 24             	mov    %eax,(%esp)
     a86:	e8 a5 ff ff ff       	call   a30 <nulterminate>
    break;
  }
  return cmd;
}
     a8b:	89 d8                	mov    %ebx,%eax
     a8d:	83 c4 14             	add    $0x14,%esp
     a90:	5b                   	pop    %ebx
     a91:	5d                   	pop    %ebp
     a92:	c3                   	ret    
     a93:	90                   	nop
     a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     a98:	8b 43 04             	mov    0x4(%ebx),%eax
     a9b:	89 04 24             	mov    %eax,(%esp)
     a9e:	e8 8d ff ff ff       	call   a30 <nulterminate>
    *rcmd->efile = 0;
     aa3:	8b 43 0c             	mov    0xc(%ebx),%eax
     aa6:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     aa9:	89 d8                	mov    %ebx,%eax
     aab:	83 c4 14             	add    $0x14,%esp
     aae:	5b                   	pop    %ebx
     aaf:	5d                   	pop    %ebp
     ab0:	c3                   	ret    
     ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     ab8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     abb:	85 c9                	test   %ecx,%ecx
     abd:	74 84                	je     a43 <nulterminate+0x13>
     abf:	89 d8                	mov    %ebx,%eax
     ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
     ac8:	8b 48 2c             	mov    0x2c(%eax),%ecx
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
     acb:	89 c2                	mov    %eax,%edx
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
     acd:	83 c0 04             	add    $0x4,%eax
     ad0:	c6 01 00             	movb   $0x0,(%ecx)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     ad3:	8b 52 08             	mov    0x8(%edx),%edx
     ad6:	85 d2                	test   %edx,%edx
     ad8:	75 ee                	jne    ac8 <nulterminate+0x98>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     ada:	89 d8                	mov    %ebx,%eax
     adc:	83 c4 14             	add    $0x14,%esp
     adf:	5b                   	pop    %ebx
     ae0:	5d                   	pop    %ebp
     ae1:	c3                   	ret    
     ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000af0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	56                   	push   %esi
     af4:	53                   	push   %ebx
     af5:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     af8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     afb:	89 1c 24             	mov    %ebx,(%esp)
     afe:	e8 dd 01 00 00       	call   ce0 <strlen>
     b03:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b05:	8d 45 08             	lea    0x8(%ebp),%eax
     b08:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b0c:	89 04 24             	mov    %eax,(%esp)
     b0f:	e8 8c fd ff ff       	call   8a0 <parseline>
  peek(&s, es, "");
     b14:	c7 44 24 08 2e 13 00 	movl   $0x132e,0x8(%esp)
     b1b:	00 
     b1c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
  cmd = parseline(&s, es);
     b20:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     b22:	8d 45 08             	lea    0x8(%ebp),%eax
     b25:	89 04 24             	mov    %eax,(%esp)
     b28:	e8 63 fa ff ff       	call   590 <peek>
  if(s != es){
     b2d:	8b 45 08             	mov    0x8(%ebp),%eax
     b30:	39 d8                	cmp    %ebx,%eax
     b32:	74 24                	je     b58 <parsecmd+0x68>
    printf(2, "leftovers: %s\n", s);
     b34:	89 44 24 08          	mov    %eax,0x8(%esp)
     b38:	c7 44 24 04 a2 13 00 	movl   $0x13a2,0x4(%esp)
     b3f:	00 
     b40:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     b47:	e8 a4 04 00 00       	call   ff0 <printf>
    panic("syntax");
     b4c:	c7 04 24 66 13 00 00 	movl   $0x1366,(%esp)
     b53:	e8 08 f5 ff ff       	call   60 <panic>
  }
  nulterminate(cmd);
     b58:	89 34 24             	mov    %esi,(%esp)
     b5b:	e8 d0 fe ff ff       	call   a30 <nulterminate>
  return cmd;
}
     b60:	83 c4 10             	add    $0x10,%esp
     b63:	89 f0                	mov    %esi,%eax
     b65:	5b                   	pop    %ebx
     b66:	5e                   	pop    %esi
     b67:	5d                   	pop    %ebp
     b68:	c3                   	ret    
     b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b70 <main>:
  return 0;
}

int
main(void)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	83 e4 f0             	and    $0xfffffff0,%esp
     b76:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     b79:	eb 0e                	jmp    b89 <main+0x19>
     b7b:	90                   	nop
     b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
     b80:	83 f8 02             	cmp    $0x2,%eax
     b83:	0f 8f c7 00 00 00    	jg     c50 <main+0xe0>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     b89:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     b90:	00 
     b91:	c7 04 24 b1 13 00 00 	movl   $0x13b1,(%esp)
     b98:	e8 47 03 00 00       	call   ee4 <open>
     b9d:	85 c0                	test   %eax,%eax
     b9f:	79 df                	jns    b80 <main+0x10>
     ba1:	eb 19                	jmp    bbc <main+0x4c>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
     ba3:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     baa:	e8 41 ff ff ff       	call   af0 <parsecmd>
     baf:	89 04 24             	mov    %eax,(%esp)
     bb2:	e8 09 f5 ff ff       	call   c0 <runcmd>
    wait();
     bb7:	e8 f0 02 00 00       	call   eac <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     bbc:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     bc3:	00 
     bc4:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     bcb:	e8 30 f4 ff ff       	call   0 <getcmd>
     bd0:	85 c0                	test   %eax,%eax
     bd2:	78 74                	js     c48 <main+0xd8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     bd4:	80 3d 20 14 00 00 63 	cmpb   $0x63,0x1420
     bdb:	75 09                	jne    be6 <main+0x76>
     bdd:	80 3d 21 14 00 00 64 	cmpb   $0x64,0x1421
     be4:	74 12                	je     bf8 <main+0x88>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
     be6:	e8 a5 f4 ff ff       	call   90 <fork1>
     beb:	85 c0                	test   %eax,%eax
     bed:	75 c8                	jne    bb7 <main+0x47>
     bef:	90                   	nop
     bf0:	eb b1                	jmp    ba3 <main+0x33>
     bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     bf8:	80 3d 22 14 00 00 20 	cmpb   $0x20,0x1422
     bff:	90                   	nop
     c00:	75 e4                	jne    be6 <main+0x76>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c02:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     c09:	e8 d2 00 00 00       	call   ce0 <strlen>
      if(chdir(buf+3) < 0)
     c0e:	c7 04 24 23 14 00 00 	movl   $0x1423,(%esp)
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c15:	c6 80 1f 14 00 00 00 	movb   $0x0,0x141f(%eax)
      if(chdir(buf+3) < 0)
     c1c:	e8 f3 02 00 00       	call   f14 <chdir>
     c21:	85 c0                	test   %eax,%eax
     c23:	79 97                	jns    bbc <main+0x4c>
        printf(2, "cannot cd %s\n", buf+3);
     c25:	c7 44 24 08 23 14 00 	movl   $0x1423,0x8(%esp)
     c2c:	00 
     c2d:	c7 44 24 04 b9 13 00 	movl   $0x13b9,0x4(%esp)
     c34:	00 
     c35:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c3c:	e8 af 03 00 00       	call   ff0 <printf>
     c41:	e9 76 ff ff ff       	jmp    bbc <main+0x4c>
     c46:	66 90                	xchg   %ax,%ax
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     c48:	e8 57 02 00 00       	call   ea4 <exit>
     c4d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
     c50:	89 04 24             	mov    %eax,(%esp)
     c53:	e8 74 02 00 00       	call   ecc <close>
      break;
     c58:	e9 5f ff ff ff       	jmp    bbc <main+0x4c>
     c5d:	90                   	nop
     c5e:	90                   	nop
     c5f:	90                   	nop

00000c60 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     c60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c61:	31 d2                	xor    %edx,%edx
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     c63:	89 e5                	mov    %esp,%ebp
     c65:	8b 45 08             	mov    0x8(%ebp),%eax
     c68:	53                   	push   %ebx
     c69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
     c74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     c77:	83 c2 01             	add    $0x1,%edx
     c7a:	84 c9                	test   %cl,%cl
     c7c:	75 f2                	jne    c70 <strcpy+0x10>
    ;
  return os;
}
     c7e:	5b                   	pop    %ebx
     c7f:	5d                   	pop    %ebp
     c80:	c3                   	ret    
     c81:	eb 0d                	jmp    c90 <strcmp>
     c83:	90                   	nop
     c84:	90                   	nop
     c85:	90                   	nop
     c86:	90                   	nop
     c87:	90                   	nop
     c88:	90                   	nop
     c89:	90                   	nop
     c8a:	90                   	nop
     c8b:	90                   	nop
     c8c:	90                   	nop
     c8d:	90                   	nop
     c8e:	90                   	nop
     c8f:	90                   	nop

00000c90 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c96:	53                   	push   %ebx
     c97:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     c9a:	0f b6 01             	movzbl (%ecx),%eax
     c9d:	84 c0                	test   %al,%al
     c9f:	75 14                	jne    cb5 <strcmp+0x25>
     ca1:	eb 25                	jmp    cc8 <strcmp+0x38>
     ca3:	90                   	nop
     ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
     ca8:	83 c1 01             	add    $0x1,%ecx
     cab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cae:	0f b6 01             	movzbl (%ecx),%eax
     cb1:	84 c0                	test   %al,%al
     cb3:	74 13                	je     cc8 <strcmp+0x38>
     cb5:	0f b6 1a             	movzbl (%edx),%ebx
     cb8:	38 d8                	cmp    %bl,%al
     cba:	74 ec                	je     ca8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     cbc:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cbf:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     cc2:	29 d8                	sub    %ebx,%eax
}
     cc4:	5b                   	pop    %ebx
     cc5:	5d                   	pop    %ebp
     cc6:	c3                   	ret    
     cc7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cc8:	0f b6 1a             	movzbl (%edx),%ebx
     ccb:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     ccd:	0f b6 db             	movzbl %bl,%ebx
     cd0:	29 d8                	sub    %ebx,%eax
}
     cd2:	5b                   	pop    %ebx
     cd3:	5d                   	pop    %ebp
     cd4:	c3                   	ret    
     cd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ce0 <strlen>:

uint
strlen(char *s)
{
     ce0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
     ce1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     ce3:	89 e5                	mov    %esp,%ebp
     ce5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ce8:	80 39 00             	cmpb   $0x0,(%ecx)
     ceb:	74 0e                	je     cfb <strlen+0x1b>
     ced:	31 d2                	xor    %edx,%edx
     cef:	90                   	nop
     cf0:	83 c2 01             	add    $0x1,%edx
     cf3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     cf7:	89 d0                	mov    %edx,%eax
     cf9:	75 f5                	jne    cf0 <strlen+0x10>
    ;
  return n;
}
     cfb:	5d                   	pop    %ebp
     cfc:	c3                   	ret    
     cfd:	8d 76 00             	lea    0x0(%esi),%esi

00000d00 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	8b 4d 10             	mov    0x10(%ebp),%ecx
     d06:	53                   	push   %ebx
     d07:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
     d0a:	85 c9                	test   %ecx,%ecx
     d0c:	74 14                	je     d22 <memset+0x22>
     d0e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
     d12:	31 d2                	xor    %edx,%edx
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
     d18:	88 1c 10             	mov    %bl,(%eax,%edx,1)
     d1b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
     d1e:	39 ca                	cmp    %ecx,%edx
     d20:	75 f6                	jne    d18 <memset+0x18>
    *d++ = c;
  return dst;
}
     d22:	5b                   	pop    %ebx
     d23:	5d                   	pop    %ebp
     d24:	c3                   	ret    
     d25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d30 <strchr>:

char*
strchr(const char *s, char c)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	8b 45 08             	mov    0x8(%ebp),%eax
     d36:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d3a:	0f b6 10             	movzbl (%eax),%edx
     d3d:	84 d2                	test   %dl,%dl
     d3f:	75 11                	jne    d52 <strchr+0x22>
     d41:	eb 15                	jmp    d58 <strchr+0x28>
     d43:	90                   	nop
     d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d48:	83 c0 01             	add    $0x1,%eax
     d4b:	0f b6 10             	movzbl (%eax),%edx
     d4e:	84 d2                	test   %dl,%dl
     d50:	74 06                	je     d58 <strchr+0x28>
    if(*s == c)
     d52:	38 ca                	cmp    %cl,%dl
     d54:	75 f2                	jne    d48 <strchr+0x18>
      return (char*) s;
  return 0;
}
     d56:	5d                   	pop    %ebp
     d57:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*) s;
  return 0;
     d58:	31 c0                	xor    %eax,%eax
}
     d5a:	5d                   	pop    %ebp
     d5b:	90                   	nop
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d60:	c3                   	ret    
     d61:	eb 0d                	jmp    d70 <gets>
     d63:	90                   	nop
     d64:	90                   	nop
     d65:	90                   	nop
     d66:	90                   	nop
     d67:	90                   	nop
     d68:	90                   	nop
     d69:	90                   	nop
     d6a:	90                   	nop
     d6b:	90                   	nop
     d6c:	90                   	nop
     d6d:	90                   	nop
     d6e:	90                   	nop
     d6f:	90                   	nop

00000d70 <gets>:

char*
gets(char *buf, int max)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	57                   	push   %edi
     d74:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d75:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
     d77:	53                   	push   %ebx
     d78:	83 ec 2c             	sub    $0x2c,%esp
     d7b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d7e:	eb 31                	jmp    db1 <gets+0x41>
    cc = read(0, &c, 1);
     d80:	8d 45 e7             	lea    -0x19(%ebp),%eax
     d83:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     d8a:	00 
     d8b:	89 44 24 04          	mov    %eax,0x4(%esp)
     d8f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d96:	e8 21 01 00 00       	call   ebc <read>
    if(cc < 1)
     d9b:	85 c0                	test   %eax,%eax
     d9d:	7e 1a                	jle    db9 <gets+0x49>
      break;
    buf[i++] = c;
     d9f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
     da3:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     da5:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
     da9:	74 1d                	je     dc8 <gets+0x58>
     dab:	3c 0a                	cmp    $0xa,%al
     dad:	74 19                	je     dc8 <gets+0x58>
     daf:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     db1:	8d 5e 01             	lea    0x1(%esi),%ebx
     db4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     db7:	7c c7                	jl     d80 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     db9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
     dbd:	89 f8                	mov    %edi,%eax
     dbf:	83 c4 2c             	add    $0x2c,%esp
     dc2:	5b                   	pop    %ebx
     dc3:	5e                   	pop    %esi
     dc4:	5f                   	pop    %edi
     dc5:	5d                   	pop    %ebp
     dc6:	c3                   	ret    
     dc7:	90                   	nop
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     dc8:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
     dca:	89 f8                	mov    %edi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     dcc:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
     dd0:	83 c4 2c             	add    $0x2c,%esp
     dd3:	5b                   	pop    %ebx
     dd4:	5e                   	pop    %esi
     dd5:	5f                   	pop    %edi
     dd6:	5d                   	pop    %ebp
     dd7:	c3                   	ret    
     dd8:	90                   	nop
     dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000de0 <stat>:

int
stat(char *n, struct stat *st)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
     de9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     dec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     def:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     df4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     dfb:	00 
     dfc:	89 04 24             	mov    %eax,(%esp)
     dff:	e8 e0 00 00 00       	call   ee4 <open>
  if(fd < 0)
     e04:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e06:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     e08:	78 19                	js     e23 <stat+0x43>
    return -1;
  r = fstat(fd, st);
     e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0d:	89 1c 24             	mov    %ebx,(%esp)
     e10:	89 44 24 04          	mov    %eax,0x4(%esp)
     e14:	e8 e3 00 00 00       	call   efc <fstat>
  close(fd);
     e19:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
     e1c:	89 c6                	mov    %eax,%esi
  close(fd);
     e1e:	e8 a9 00 00 00       	call   ecc <close>
  return r;
}
     e23:	89 f0                	mov    %esi,%eax
     e25:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     e28:	8b 75 fc             	mov    -0x4(%ebp),%esi
     e2b:	89 ec                	mov    %ebp,%esp
     e2d:	5d                   	pop    %ebp
     e2e:	c3                   	ret    
     e2f:	90                   	nop

00000e30 <atoi>:

int
atoi(const char *s)
{
     e30:	55                   	push   %ebp
  int n;

  n = 0;
     e31:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
     e33:	89 e5                	mov    %esp,%ebp
     e35:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e38:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e39:	0f b6 11             	movzbl (%ecx),%edx
     e3c:	8d 5a d0             	lea    -0x30(%edx),%ebx
     e3f:	80 fb 09             	cmp    $0x9,%bl
     e42:	77 1c                	ja     e60 <atoi+0x30>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     e48:	0f be d2             	movsbl %dl,%edx
     e4b:	83 c1 01             	add    $0x1,%ecx
     e4e:	8d 04 80             	lea    (%eax,%eax,4),%eax
     e51:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e55:	0f b6 11             	movzbl (%ecx),%edx
     e58:	8d 5a d0             	lea    -0x30(%edx),%ebx
     e5b:	80 fb 09             	cmp    $0x9,%bl
     e5e:	76 e8                	jbe    e48 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     e60:	5b                   	pop    %ebx
     e61:	5d                   	pop    %ebp
     e62:	c3                   	ret    
     e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e70 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	56                   	push   %esi
     e74:	8b 45 08             	mov    0x8(%ebp),%eax
     e77:	53                   	push   %ebx
     e78:	8b 5d 10             	mov    0x10(%ebp),%ebx
     e7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e7e:	85 db                	test   %ebx,%ebx
     e80:	7e 14                	jle    e96 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
     e82:	31 d2                	xor    %edx,%edx
     e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
     e88:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     e8c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     e8f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e92:	39 da                	cmp    %ebx,%edx
     e94:	75 f2                	jne    e88 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     e96:	5b                   	pop    %ebx
     e97:	5e                   	pop    %esi
     e98:	5d                   	pop    %ebp
     e99:	c3                   	ret    
     e9a:	90                   	nop
     e9b:	90                   	nop

00000e9c <fork>:
     e9c:	b8 01 00 00 00       	mov    $0x1,%eax
     ea1:	cd 30                	int    $0x30
     ea3:	c3                   	ret    

00000ea4 <exit>:
     ea4:	b8 02 00 00 00       	mov    $0x2,%eax
     ea9:	cd 30                	int    $0x30
     eab:	c3                   	ret    

00000eac <wait>:
     eac:	b8 03 00 00 00       	mov    $0x3,%eax
     eb1:	cd 30                	int    $0x30
     eb3:	c3                   	ret    

00000eb4 <pipe>:
     eb4:	b8 04 00 00 00       	mov    $0x4,%eax
     eb9:	cd 30                	int    $0x30
     ebb:	c3                   	ret    

00000ebc <read>:
     ebc:	b8 06 00 00 00       	mov    $0x6,%eax
     ec1:	cd 30                	int    $0x30
     ec3:	c3                   	ret    

00000ec4 <write>:
     ec4:	b8 05 00 00 00       	mov    $0x5,%eax
     ec9:	cd 30                	int    $0x30
     ecb:	c3                   	ret    

00000ecc <close>:
     ecc:	b8 07 00 00 00       	mov    $0x7,%eax
     ed1:	cd 30                	int    $0x30
     ed3:	c3                   	ret    

00000ed4 <kill>:
     ed4:	b8 08 00 00 00       	mov    $0x8,%eax
     ed9:	cd 30                	int    $0x30
     edb:	c3                   	ret    

00000edc <exec>:
     edc:	b8 09 00 00 00       	mov    $0x9,%eax
     ee1:	cd 30                	int    $0x30
     ee3:	c3                   	ret    

00000ee4 <open>:
     ee4:	b8 0a 00 00 00       	mov    $0xa,%eax
     ee9:	cd 30                	int    $0x30
     eeb:	c3                   	ret    

00000eec <mknod>:
     eec:	b8 0b 00 00 00       	mov    $0xb,%eax
     ef1:	cd 30                	int    $0x30
     ef3:	c3                   	ret    

00000ef4 <unlink>:
     ef4:	b8 0c 00 00 00       	mov    $0xc,%eax
     ef9:	cd 30                	int    $0x30
     efb:	c3                   	ret    

00000efc <fstat>:
     efc:	b8 0d 00 00 00       	mov    $0xd,%eax
     f01:	cd 30                	int    $0x30
     f03:	c3                   	ret    

00000f04 <link>:
     f04:	b8 0e 00 00 00       	mov    $0xe,%eax
     f09:	cd 30                	int    $0x30
     f0b:	c3                   	ret    

00000f0c <mkdir>:
     f0c:	b8 0f 00 00 00       	mov    $0xf,%eax
     f11:	cd 30                	int    $0x30
     f13:	c3                   	ret    

00000f14 <chdir>:
     f14:	b8 10 00 00 00       	mov    $0x10,%eax
     f19:	cd 30                	int    $0x30
     f1b:	c3                   	ret    

00000f1c <dup>:
     f1c:	b8 11 00 00 00       	mov    $0x11,%eax
     f21:	cd 30                	int    $0x30
     f23:	c3                   	ret    

00000f24 <getpid>:
     f24:	b8 12 00 00 00       	mov    $0x12,%eax
     f29:	cd 30                	int    $0x30
     f2b:	c3                   	ret    

00000f2c <sbrk>:
     f2c:	b8 13 00 00 00       	mov    $0x13,%eax
     f31:	cd 30                	int    $0x30
     f33:	c3                   	ret    

00000f34 <sleep>:
     f34:	b8 14 00 00 00       	mov    $0x14,%eax
     f39:	cd 30                	int    $0x30
     f3b:	c3                   	ret    
     f3c:	90                   	nop
     f3d:	90                   	nop
     f3e:	90                   	nop
     f3f:	90                   	nop

00000f40 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	83 ec 28             	sub    $0x28,%esp
     f46:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
     f49:	8d 55 f4             	lea    -0xc(%ebp),%edx
     f4c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f53:	00 
     f54:	89 54 24 04          	mov    %edx,0x4(%esp)
     f58:	89 04 24             	mov    %eax,(%esp)
     f5b:	e8 64 ff ff ff       	call   ec4 <write>
}
     f60:	c9                   	leave  
     f61:	c3                   	ret    
     f62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f70 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	57                   	push   %edi
     f74:	89 c7                	mov    %eax,%edi
     f76:	56                   	push   %esi
     f77:	89 ce                	mov    %ecx,%esi
     f79:	53                   	push   %ebx
     f7a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f7d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f80:	85 c9                	test   %ecx,%ecx
     f82:	74 09                	je     f8d <printint+0x1d>
     f84:	89 d0                	mov    %edx,%eax
     f86:	c1 e8 1f             	shr    $0x1f,%eax
     f89:	84 c0                	test   %al,%al
     f8b:	75 53                	jne    fe0 <printint+0x70>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f8d:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f8f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     f96:	31 c9                	xor    %ecx,%ecx
     f98:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     f9b:	90                   	nop
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     fa0:	31 d2                	xor    %edx,%edx
     fa2:	f7 f6                	div    %esi
     fa4:	0f b6 92 ff 13 00 00 	movzbl 0x13ff(%edx),%edx
     fab:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
     fae:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
     fb1:	85 c0                	test   %eax,%eax
     fb3:	75 eb                	jne    fa0 <printint+0x30>
  if(neg)
     fb5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fb8:	85 c0                	test   %eax,%eax
     fba:	74 08                	je     fc4 <printint+0x54>
    buf[i++] = '-';
     fbc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     fc1:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
     fc4:	8d 71 ff             	lea    -0x1(%ecx),%esi
     fc7:	90                   	nop
    putc(fd, buf[i]);
     fc8:	0f be 14 33          	movsbl (%ebx,%esi,1),%edx
     fcc:	89 f8                	mov    %edi,%eax
     fce:	e8 6d ff ff ff       	call   f40 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     fd3:	83 ee 01             	sub    $0x1,%esi
     fd6:	79 f0                	jns    fc8 <printint+0x58>
    putc(fd, buf[i]);
}
     fd8:	83 c4 2c             	add    $0x2c,%esp
     fdb:	5b                   	pop    %ebx
     fdc:	5e                   	pop    %esi
     fdd:	5f                   	pop    %edi
     fde:	5d                   	pop    %ebp
     fdf:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     fe0:	89 d0                	mov    %edx,%eax
     fe2:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     fe4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     feb:	eb a9                	jmp    f96 <printint+0x26>
     fed:	8d 76 00             	lea    0x0(%esi),%esi

00000ff0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	57                   	push   %edi
     ff4:	56                   	push   %esi
     ff5:	53                   	push   %ebx
     ff6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ff9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     ffc:	0f b6 0b             	movzbl (%ebx),%ecx
     fff:	84 c9                	test   %cl,%cl
    1001:	0f 84 99 00 00 00    	je     10a0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1007:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    100a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
    100c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    100f:	eb 26                	jmp    1037 <printf+0x47>
    1011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1018:	83 f9 25             	cmp    $0x25,%ecx
    101b:	0f 84 87 00 00 00    	je     10a8 <printf+0xb8>
        state = '%';
      } else {
        putc(fd, c);
    1021:	8b 45 08             	mov    0x8(%ebp),%eax
    1024:	0f be d1             	movsbl %cl,%edx
    1027:	e8 14 ff ff ff       	call   f40 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    102c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    1030:	83 c3 01             	add    $0x1,%ebx
    1033:	84 c9                	test   %cl,%cl
    1035:	74 69                	je     10a0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
    1037:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1039:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
    103c:	74 da                	je     1018 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    103e:	83 fe 25             	cmp    $0x25,%esi
    1041:	75 e9                	jne    102c <printf+0x3c>
      if(c == 'd'){
    1043:	83 f9 64             	cmp    $0x64,%ecx
    1046:	0f 84 f4 00 00 00    	je     1140 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    104c:	83 f9 70             	cmp    $0x70,%ecx
    104f:	90                   	nop
    1050:	74 66                	je     10b8 <printf+0xc8>
    1052:	83 f9 78             	cmp    $0x78,%ecx
    1055:	74 61                	je     10b8 <printf+0xc8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1057:	83 f9 73             	cmp    $0x73,%ecx
    105a:	0f 84 80 00 00 00    	je     10e0 <printf+0xf0>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1060:	83 f9 63             	cmp    $0x63,%ecx
    1063:	0f 84 f9 00 00 00    	je     1162 <printf+0x172>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1069:	83 f9 25             	cmp    $0x25,%ecx
    106c:	0f 84 b6 00 00 00    	je     1128 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1072:	8b 45 08             	mov    0x8(%ebp),%eax
    1075:	ba 25 00 00 00       	mov    $0x25,%edx
        putc(fd, c);
      }
      state = 0;
    107a:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    107c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    107f:	e8 bc fe ff ff       	call   f40 <putc>
        putc(fd, c);
    1084:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1087:	8b 45 08             	mov    0x8(%ebp),%eax
    108a:	0f be d1             	movsbl %cl,%edx
    108d:	e8 ae fe ff ff       	call   f40 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1092:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    1096:	83 c3 01             	add    $0x1,%ebx
    1099:	84 c9                	test   %cl,%cl
    109b:	75 9a                	jne    1037 <printf+0x47>
    109d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    10a0:	83 c4 2c             	add    $0x2c,%esp
    10a3:	5b                   	pop    %ebx
    10a4:	5e                   	pop    %esi
    10a5:	5f                   	pop    %edi
    10a6:	5d                   	pop    %ebp
    10a7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    10a8:	be 25 00 00 00       	mov    $0x25,%esi
    10ad:	e9 7a ff ff ff       	jmp    102c <printf+0x3c>
    10b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    10b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10bb:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10c0:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    10c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10c9:	8b 10                	mov    (%eax),%edx
    10cb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ce:	e8 9d fe ff ff       	call   f70 <printint>
        ap++;
    10d3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    10d7:	e9 50 ff ff ff       	jmp    102c <printf+0x3c>
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    10e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10e3:	8b 38                	mov    (%eax),%edi
        ap++;
    10e5:	83 c0 04             	add    $0x4,%eax
    10e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
    10eb:	b8 f8 13 00 00       	mov    $0x13f8,%eax
    10f0:	85 ff                	test   %edi,%edi
    10f2:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10f5:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    10f7:	0f b6 17             	movzbl (%edi),%edx
    10fa:	84 d2                	test   %dl,%dl
    10fc:	0f 84 2a ff ff ff    	je     102c <printf+0x3c>
    1102:	89 de                	mov    %ebx,%esi
    1104:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1107:	90                   	nop
          putc(fd, *s);
    1108:	0f be d2             	movsbl %dl,%edx
          s++;
    110b:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
    110e:	89 d8                	mov    %ebx,%eax
    1110:	e8 2b fe ff ff       	call   f40 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1115:	0f b6 17             	movzbl (%edi),%edx
    1118:	84 d2                	test   %dl,%dl
    111a:	75 ec                	jne    1108 <printf+0x118>
    111c:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    111e:	31 f6                	xor    %esi,%esi
    1120:	e9 07 ff ff ff       	jmp    102c <printf+0x3c>
    1125:	8d 76 00             	lea    0x0(%esi),%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    1128:	8b 45 08             	mov    0x8(%ebp),%eax
    112b:	ba 25 00 00 00       	mov    $0x25,%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1130:	31 f6                	xor    %esi,%esi
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    1132:	e8 09 fe ff ff       	call   f40 <putc>
    1137:	e9 f0 fe ff ff       	jmp    102c <printf+0x3c>
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1143:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1145:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1148:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    114f:	8b 10                	mov    (%eax),%edx
    1151:	8b 45 08             	mov    0x8(%ebp),%eax
    1154:	e8 17 fe ff ff       	call   f70 <printint>
        ap++;
    1159:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    115d:	e9 ca fe ff ff       	jmp    102c <printf+0x3c>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1162:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1165:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1167:	0f be 10             	movsbl (%eax),%edx
    116a:	8b 45 08             	mov    0x8(%ebp),%eax
    116d:	e8 ce fd ff ff       	call   f40 <putc>
        ap++;
    1172:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1176:	e9 b1 fe ff ff       	jmp    102c <printf+0x3c>
    117b:	90                   	nop
    117c:	90                   	nop
    117d:	90                   	nop
    117e:	90                   	nop
    117f:	90                   	nop

00001180 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1180:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1181:	a1 84 14 00 00       	mov    0x1484,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1186:	89 e5                	mov    %esp,%ebp
    1188:	57                   	push   %edi
    1189:	56                   	push   %esi
    118a:	53                   	push   %ebx
    118b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    118e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1191:	39 c8                	cmp    %ecx,%eax
    1193:	73 1d                	jae    11b2 <free+0x32>
    1195:	8d 76 00             	lea    0x0(%esi),%esi
    1198:	8b 10                	mov    (%eax),%edx
    119a:	39 d1                	cmp    %edx,%ecx
    119c:	72 1a                	jb     11b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    119e:	39 d0                	cmp    %edx,%eax
    11a0:	72 08                	jb     11aa <free+0x2a>
    11a2:	39 c8                	cmp    %ecx,%eax
    11a4:	72 12                	jb     11b8 <free+0x38>
    11a6:	39 d1                	cmp    %edx,%ecx
    11a8:	72 0e                	jb     11b8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
    11aa:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11ac:	39 c8                	cmp    %ecx,%eax
    11ae:	66 90                	xchg   %ax,%ax
    11b0:	72 e6                	jb     1198 <free+0x18>
    11b2:	8b 10                	mov    (%eax),%edx
    11b4:	eb e8                	jmp    119e <free+0x1e>
    11b6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    11b8:	8b 71 04             	mov    0x4(%ecx),%esi
    11bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    11be:	39 d7                	cmp    %edx,%edi
    11c0:	74 19                	je     11db <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    11c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11c5:	8b 50 04             	mov    0x4(%eax),%edx
    11c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11cb:	39 ce                	cmp    %ecx,%esi
    11cd:	74 21                	je     11f0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    11cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
    11d1:	a3 84 14 00 00       	mov    %eax,0x1484
}
    11d6:	5b                   	pop    %ebx
    11d7:	5e                   	pop    %esi
    11d8:	5f                   	pop    %edi
    11d9:	5d                   	pop    %ebp
    11da:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11db:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    11de:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11e0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    11e3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    11e6:	8b 50 04             	mov    0x4(%eax),%edx
    11e9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11ec:	39 ce                	cmp    %ecx,%esi
    11ee:	75 df                	jne    11cf <free+0x4f>
    p->s.size += bp->s.size;
    11f0:	03 51 04             	add    0x4(%ecx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    11f3:	a3 84 14 00 00       	mov    %eax,0x1484
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    11f8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    11fb:	8b 53 f8             	mov    -0x8(%ebx),%edx
    11fe:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1200:	5b                   	pop    %ebx
    1201:	5e                   	pop    %esi
    1202:	5f                   	pop    %edi
    1203:	5d                   	pop    %ebp
    1204:	c3                   	ret    
    1205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	57                   	push   %edi
    1214:	56                   	push   %esi
    1215:	53                   	push   %ebx
    1216:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1219:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    121c:	8b 35 84 14 00 00    	mov    0x1484,%esi
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1222:	83 c3 07             	add    $0x7,%ebx
    1225:	c1 eb 03             	shr    $0x3,%ebx
    1228:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    122b:	85 f6                	test   %esi,%esi
    122d:	0f 84 ab 00 00 00    	je     12de <malloc+0xce>
    1233:	8b 16                	mov    (%esi),%edx
    1235:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1238:	39 d9                	cmp    %ebx,%ecx
    123a:	0f 83 c6 00 00 00    	jae    1306 <malloc+0xf6>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    1240:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    1247:	be 00 80 00 00       	mov    $0x8000,%esi
    124c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    124f:	eb 09                	jmp    125a <malloc+0x4a>
    1251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1258:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
    125a:	3b 15 84 14 00 00    	cmp    0x1484,%edx
    1260:	74 2e                	je     1290 <malloc+0x80>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1262:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1264:	8b 48 04             	mov    0x4(%eax),%ecx
    1267:	39 cb                	cmp    %ecx,%ebx
    1269:	77 ed                	ja     1258 <malloc+0x48>
    126b:	89 d6                	mov    %edx,%esi
      if(p->s.size == nunits)
    126d:	39 cb                	cmp    %ecx,%ebx
    126f:	74 67                	je     12d8 <malloc+0xc8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1271:	29 d9                	sub    %ebx,%ecx
    1273:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1276:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1279:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    127c:	89 35 84 14 00 00    	mov    %esi,0x1484
      return (void*) (p + 1);
    1282:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1285:	83 c4 2c             	add    $0x2c,%esp
    1288:	5b                   	pop    %ebx
    1289:	5e                   	pop    %esi
    128a:	5f                   	pop    %edi
    128b:	5d                   	pop    %ebp
    128c:	c3                   	ret    
    128d:	8d 76 00             	lea    0x0(%esi),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    1290:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1293:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    1299:	bf 00 10 00 00       	mov    $0x1000,%edi
    129e:	0f 47 fb             	cmova  %ebx,%edi
    12a1:	0f 46 c6             	cmovbe %esi,%eax
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    12a4:	89 04 24             	mov    %eax,(%esp)
    12a7:	e8 80 fc ff ff       	call   f2c <sbrk>
  if(p == (char*) -1)
    12ac:	83 f8 ff             	cmp    $0xffffffff,%eax
    12af:	74 18                	je     12c9 <malloc+0xb9>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    12b1:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    12b4:	83 c0 08             	add    $0x8,%eax
    12b7:	89 04 24             	mov    %eax,(%esp)
    12ba:	e8 c1 fe ff ff       	call   1180 <free>
  return freep;
    12bf:	8b 15 84 14 00 00    	mov    0x1484,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    12c5:	85 d2                	test   %edx,%edx
    12c7:	75 99                	jne    1262 <malloc+0x52>
        return 0;
  }
}
    12c9:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
    12cc:	31 c0                	xor    %eax,%eax
  }
}
    12ce:	5b                   	pop    %ebx
    12cf:	5e                   	pop    %esi
    12d0:	5f                   	pop    %edi
    12d1:	5d                   	pop    %ebp
    12d2:	c3                   	ret    
    12d3:	90                   	nop
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    12d8:	8b 10                	mov    (%eax),%edx
    12da:	89 16                	mov    %edx,(%esi)
    12dc:	eb 9e                	jmp    127c <malloc+0x6c>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    12de:	c7 05 84 14 00 00 88 	movl   $0x1488,0x1484
    12e5:	14 00 00 
    base.s.size = 0;
    12e8:	ba 88 14 00 00       	mov    $0x1488,%edx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    12ed:	c7 05 88 14 00 00 88 	movl   $0x1488,0x1488
    12f4:	14 00 00 
    base.s.size = 0;
    12f7:	c7 05 8c 14 00 00 00 	movl   $0x0,0x148c
    12fe:	00 00 00 
    1301:	e9 3a ff ff ff       	jmp    1240 <malloc+0x30>
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1306:	89 d0                	mov    %edx,%eax
    1308:	e9 60 ff ff ff       	jmp    126d <malloc+0x5d>
