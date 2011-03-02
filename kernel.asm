
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <binit>:
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
{
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");
  100006:	c7 44 24 04 20 60 10 	movl   $0x106020,0x4(%esp)
  10000d:	00 
  10000e:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100015:	e8 d6 3d 00 00       	call   103df0 <initlock>
// bufhead->next is most recently used.
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
  10001a:	ba 80 78 10 00       	mov    $0x107880,%edx
  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  10001f:	b8 a0 7a 10 00       	mov    $0x107aa0,%eax
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  100024:	c7 05 8c 78 10 00 80 	movl   $0x107880,0x10788c
  10002b:	78 10 00 
  10002e:	eb 04                	jmp    100034 <binit+0x34>
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  100030:	89 c2                	mov    %eax,%edx
  100032:	89 c8                	mov    %ecx,%eax
  100034:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
  10003a:	81 f9 90 8f 10 00    	cmp    $0x108f90,%ecx
    b->next = bufhead.next;
    b->prev = &bufhead;
  100040:	c7 40 0c 80 78 10 00 	movl   $0x107880,0xc(%eax)

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
    b->next = bufhead.next;
  100047:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bufhead;
    bufhead.next->prev = b;
  10004a:	89 42 0c             	mov    %eax,0xc(%edx)
  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  10004d:	75 e1                	jne    100030 <binit+0x30>
  10004f:	c7 05 90 78 10 00 78 	movl   $0x108d78,0x107890
  100056:	8d 10 00 
    b->next = bufhead.next;
    b->prev = &bufhead;
    bufhead.next->prev = b;
    bufhead.next = b;
  }
}
  100059:	c9                   	leave  
  10005a:	c3                   	ret    
  10005b:	90                   	nop
  10005c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100060 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  100060:	55                   	push   %ebp
  100061:	89 e5                	mov    %esp,%ebp
  100063:	57                   	push   %edi
  100064:	56                   	push   %esi
  100065:	53                   	push   %ebx
  100066:	83 ec 1c             	sub    $0x1c,%esp
  100069:	8b 75 08             	mov    0x8(%ebp),%esi
  10006c:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&buf_table_lock);
  10006f:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100076:	e8 75 3e 00 00       	call   103ef0 <acquire>

 loop:
  // Try for cached block.
  for(b = bufhead.next; b != &bufhead; b = b->next){
  10007b:	8b 1d 90 78 10 00    	mov    0x107890,%ebx
  100081:	81 fb 80 78 10 00    	cmp    $0x107880,%ebx
  100087:	75 12                	jne    10009b <bread+0x3b>
  100089:	eb 3d                	jmp    1000c8 <bread+0x68>
  10008b:	90                   	nop
  10008c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100090:	8b 5b 10             	mov    0x10(%ebx),%ebx
  100093:	81 fb 80 78 10 00    	cmp    $0x107880,%ebx
  100099:	74 2d                	je     1000c8 <bread+0x68>
    if((b->flags & (B_BUSY|B_VALID)) &&
  10009b:	8b 03                	mov    (%ebx),%eax
  10009d:	a8 03                	test   $0x3,%al
  10009f:	74 ef                	je     100090 <bread+0x30>
  1000a1:	3b 73 04             	cmp    0x4(%ebx),%esi
  1000a4:	75 ea                	jne    100090 <bread+0x30>
       b->dev == dev && b->sector == sector){
  1000a6:	3b 7b 08             	cmp    0x8(%ebx),%edi
  1000a9:	75 e5                	jne    100090 <bread+0x30>
      if(b->flags & B_BUSY){
  1000ab:	a8 01                	test   $0x1,%al
  1000ad:	8d 76 00             	lea    0x0(%esi),%esi
  1000b0:	74 71                	je     100123 <bread+0xc3>
        sleep(buf, &buf_table_lock);
  1000b2:	c7 44 24 04 a0 8f 10 	movl   $0x108fa0,0x4(%esp)
  1000b9:	00 
  1000ba:	c7 04 24 a0 7a 10 00 	movl   $0x107aa0,(%esp)
  1000c1:	e8 1a 38 00 00       	call   1038e0 <sleep>
  1000c6:	eb b3                	jmp    10007b <bread+0x1b>
      return b;
    }
  }

  // Allocate fresh block.
  for(b = bufhead.prev; b != &bufhead; b = b->prev){
  1000c8:	8b 1d 8c 78 10 00    	mov    0x10788c,%ebx
  1000ce:	81 fb 80 78 10 00    	cmp    $0x107880,%ebx
  1000d4:	75 0d                	jne    1000e3 <bread+0x83>
  1000d6:	eb 3f                	jmp    100117 <bread+0xb7>
  1000d8:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  1000db:	81 fb 80 78 10 00    	cmp    $0x107880,%ebx
  1000e1:	74 34                	je     100117 <bread+0xb7>
    if((b->flags & B_BUSY) == 0){
  1000e3:	f6 03 01             	testb  $0x1,(%ebx)
  1000e6:	75 f0                	jne    1000d8 <bread+0x78>
      b->flags = B_BUSY;
  1000e8:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      b->dev = dev;
  1000ee:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  1000f1:	89 7b 08             	mov    %edi,0x8(%ebx)
      release(&buf_table_lock);
  1000f4:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  1000fb:	e8 e0 3e 00 00       	call   103fe0 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  100100:	f6 03 02             	testb  $0x2,(%ebx)
  100103:	75 08                	jne    10010d <bread+0xad>
    ide_rw(b);
  100105:	89 1c 24             	mov    %ebx,(%esp)
  100108:	e8 63 20 00 00       	call   102170 <ide_rw>
  return b;
}
  10010d:	83 c4 1c             	add    $0x1c,%esp
  100110:	89 d8                	mov    %ebx,%eax
  100112:	5b                   	pop    %ebx
  100113:	5e                   	pop    %esi
  100114:	5f                   	pop    %edi
  100115:	5d                   	pop    %ebp
  100116:	c3                   	ret    
      b->sector = sector;
      release(&buf_table_lock);
      return b;
    }
  }
  panic("bget: no buffers");
  100117:	c7 04 24 2a 60 10 00 	movl   $0x10602a,(%esp)
  10011e:	e8 dd 07 00 00       	call   100900 <panic>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
        sleep(buf, &buf_table_lock);
        goto loop;
      }
      b->flags |= B_BUSY;
  100123:	83 c8 01             	or     $0x1,%eax
  100126:	89 03                	mov    %eax,(%ebx)
      release(&buf_table_lock);
  100128:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  10012f:	e8 ac 3e 00 00       	call   103fe0 <release>
  100134:	eb ca                	jmp    100100 <bread+0xa0>
  100136:	8d 76 00             	lea    0x0(%esi),%esi
  100139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100140 <bwrite>:
}

// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  100140:	55                   	push   %ebp
  100141:	89 e5                	mov    %esp,%ebp
  100143:	83 ec 18             	sub    $0x18,%esp
  100146:	8b 45 08             	mov    0x8(%ebp),%eax
  if((b->flags & B_BUSY) == 0)
  100149:	8b 10                	mov    (%eax),%edx
  10014b:	f6 c2 01             	test   $0x1,%dl
  10014e:	74 0e                	je     10015e <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
  100150:	83 ca 04             	or     $0x4,%edx
  100153:	89 10                	mov    %edx,(%eax)
  ide_rw(b);
  100155:	89 45 08             	mov    %eax,0x8(%ebp)
}
  100158:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  ide_rw(b);
  100159:	e9 12 20 00 00       	jmp    102170 <ide_rw>
// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10015e:	c7 04 24 3b 60 10 00 	movl   $0x10603b,(%esp)
  100165:	e8 96 07 00 00       	call   100900 <panic>
  10016a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100170 <brelse>:
}

// Release the buffer buf.
void
brelse(struct buf *b)
{
  100170:	55                   	push   %ebp
  100171:	89 e5                	mov    %esp,%ebp
  100173:	53                   	push   %ebx
  100174:	83 ec 14             	sub    $0x14,%esp
  100177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
  10017a:	f6 03 01             	testb  $0x1,(%ebx)
  10017d:	74 58                	je     1001d7 <brelse+0x67>
    panic("brelse");

  acquire(&buf_table_lock);
  10017f:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100186:	e8 65 3d 00 00       	call   103ef0 <acquire>

  b->next->prev = b->prev;
  10018b:	8b 43 10             	mov    0x10(%ebx),%eax
  10018e:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  100191:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  if((b->flags & B_BUSY) == 0)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  100194:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  100197:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  10019a:	c7 43 0c 80 78 10 00 	movl   $0x107880,0xc(%ebx)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  1001a1:	89 42 10             	mov    %eax,0x10(%edx)
  b->next = bufhead.next;
  1001a4:	a1 90 78 10 00       	mov    0x107890,%eax
  1001a9:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bufhead;
  bufhead.next->prev = b;
  1001ac:	a1 90 78 10 00       	mov    0x107890,%eax
  bufhead.next = b;
  1001b1:	89 1d 90 78 10 00    	mov    %ebx,0x107890

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  1001b7:	89 58 0c             	mov    %ebx,0xc(%eax)
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);
  1001ba:	c7 04 24 a0 7a 10 00 	movl   $0x107aa0,(%esp)
  1001c1:	e8 ea 37 00 00       	call   1039b0 <wakeup>

  release(&buf_table_lock);
  1001c6:	c7 45 08 a0 8f 10 00 	movl   $0x108fa0,0x8(%ebp)
}
  1001cd:	83 c4 14             	add    $0x14,%esp
  1001d0:	5b                   	pop    %ebx
  1001d1:	5d                   	pop    %ebp
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);

  release(&buf_table_lock);
  1001d2:	e9 09 3e 00 00       	jmp    103fe0 <release>
// Release the buffer buf.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  1001d7:	c7 04 24 42 60 10 00 	movl   $0x106042,(%esp)
  1001de:	e8 1d 07 00 00       	call   100900 <panic>
  1001e3:	90                   	nop
  1001e4:	90                   	nop
  1001e5:	90                   	nop
  1001e6:	90                   	nop
  1001e7:	90                   	nop
  1001e8:	90                   	nop
  1001e9:	90                   	nop
  1001ea:	90                   	nop
  1001eb:	90                   	nop
  1001ec:	90                   	nop
  1001ed:	90                   	nop
  1001ee:	90                   	nop
  1001ef:	90                   	nop

001001f0 <console_read>:
  release(&input.lock);
}

int
console_read(struct inode *ip, char *dst, int n)
{
  1001f0:	55                   	push   %ebp
  1001f1:	89 e5                	mov    %esp,%ebp
  1001f3:	57                   	push   %edi
  1001f4:	56                   	push   %esi
  1001f5:	53                   	push   %ebx
  1001f6:	83 ec 2c             	sub    $0x2c,%esp
  1001f9:	8b 5d 10             	mov    0x10(%ebp),%ebx
  1001fc:	8b 75 08             	mov    0x8(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
  1001ff:	89 34 24             	mov    %esi,(%esp)
  100202:	e8 09 14 00 00       	call   101610 <iunlock>
  target = n;
  100207:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&input.lock);
  10020a:	c7 04 24 e0 8f 10 00 	movl   $0x108fe0,(%esp)
  100211:	e8 da 3c 00 00       	call   103ef0 <acquire>
  while(n > 0){
  100216:	85 db                	test   %ebx,%ebx
  100218:	7f 26                	jg     100240 <console_read+0x50>
  10021a:	e9 c3 00 00 00       	jmp    1002e2 <console_read+0xf2>
  10021f:	90                   	nop
    while(input.r == input.w){
      if(cp->killed){
  100220:	e8 eb 33 00 00       	call   103610 <curproc>
  100225:	8b 40 1c             	mov    0x1c(%eax),%eax
  100228:	85 c0                	test   %eax,%eax
  10022a:	75 64                	jne    100290 <console_read+0xa0>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  10022c:	c7 44 24 04 e0 8f 10 	movl   $0x108fe0,0x4(%esp)
  100233:	00 
  100234:	c7 04 24 94 90 10 00 	movl   $0x109094,(%esp)
  10023b:	e8 a0 36 00 00       	call   1038e0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100240:	a1 94 90 10 00       	mov    0x109094,%eax
  100245:	3b 05 98 90 10 00    	cmp    0x109098,%eax
  10024b:	74 d3                	je     100220 <console_read+0x30>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  10024d:	89 c1                	mov    %eax,%ecx
  10024f:	c1 f9 1f             	sar    $0x1f,%ecx
  100252:	c1 e9 19             	shr    $0x19,%ecx
  100255:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100258:	83 e2 7f             	and    $0x7f,%edx
  10025b:	29 ca                	sub    %ecx,%edx
  10025d:	0f b6 8a 14 90 10 00 	movzbl 0x109014(%edx),%ecx
  100264:	8d 78 01             	lea    0x1(%eax),%edi
  100267:	89 3d 94 90 10 00    	mov    %edi,0x109094
  10026d:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
  100270:	83 fa 04             	cmp    $0x4,%edx
  100273:	74 3c                	je     1002b1 <console_read+0xc1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100275:	8b 45 0c             	mov    0xc(%ebp),%eax
    --n;
  100278:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  10027b:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  10027e:	88 08                	mov    %cl,(%eax)
    --n;
    if(c == '\n')
  100280:	74 39                	je     1002bb <console_read+0xcb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  100282:	85 db                	test   %ebx,%ebx
  100284:	7e 35                	jle    1002bb <console_read+0xcb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100286:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  10028a:	eb b4                	jmp    100240 <console_read+0x50>
  10028c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100290:	c7 04 24 e0 8f 10 00 	movl   $0x108fe0,(%esp)
  100297:	e8 44 3d 00 00       	call   103fe0 <release>
        ilock(ip);
  10029c:	89 34 24             	mov    %esi,(%esp)
  10029f:	e8 5c 12 00 00       	call   101500 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1002a4:	83 c4 2c             	add    $0x2c,%esp
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
  1002a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1002ac:	5b                   	pop    %ebx
  1002ad:	5e                   	pop    %esi
  1002ae:	5f                   	pop    %edi
  1002af:	5d                   	pop    %ebp
  1002b0:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  1002b1:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  1002b4:	76 05                	jbe    1002bb <console_read+0xcb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  1002b6:	a3 94 90 10 00       	mov    %eax,0x109094
  1002bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1002be:	29 d8                	sub    %ebx,%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  1002c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1002c3:	c7 04 24 e0 8f 10 00 	movl   $0x108fe0,(%esp)
  1002ca:	e8 11 3d 00 00       	call   103fe0 <release>
  ilock(ip);
  1002cf:	89 34 24             	mov    %esi,(%esp)
  1002d2:	e8 29 12 00 00       	call   101500 <ilock>
  1002d7:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
  1002da:	83 c4 2c             	add    $0x2c,%esp
  1002dd:	5b                   	pop    %ebx
  1002de:	5e                   	pop    %esi
  1002df:	5f                   	pop    %edi
  1002e0:	5d                   	pop    %ebp
  1002e1:	c3                   	ret    
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  1002e2:	31 c0                	xor    %eax,%eax
  1002e4:	eb da                	jmp    1002c0 <console_read+0xd0>
  1002e6:	8d 76 00             	lea    0x0(%esi),%esi
  1002e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002f0 <cons_putc>:
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  1002f0:	55                   	push   %ebp
  1002f1:	89 e5                	mov    %esp,%ebp
  1002f3:	57                   	push   %edi
  1002f4:	56                   	push   %esi
  1002f5:	53                   	push   %ebx
  1002f6:	83 ec 1c             	sub    $0x1c,%esp
  1002f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(panicked){
  1002fc:	83 3d a0 77 10 00 00 	cmpl   $0x0,0x1077a0
  100303:	0f 85 d3 00 00 00    	jne    1003dc <cons_putc+0xec>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100309:	b8 79 03 00 00       	mov    $0x379,%eax
  10030e:	89 c2                	mov    %eax,%edx
  100310:	ec                   	in     (%dx),%al
static void
lpt_putc(int c)
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
  100311:	84 c0                	test   %al,%al
  100313:	bb 00 32 00 00       	mov    $0x3200,%ebx
  100318:	79 0b                	jns    100325 <cons_putc+0x35>
  10031a:	eb 0e                	jmp    10032a <cons_putc+0x3a>
  10031c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100320:	83 eb 01             	sub    $0x1,%ebx
  100323:	74 05                	je     10032a <cons_putc+0x3a>
  100325:	ec                   	in     (%dx),%al
  100326:	84 c0                	test   %al,%al
  100328:	79 f6                	jns    100320 <cons_putc+0x30>
    ;
  if(c == BACKSPACE)
  10032a:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  100330:	b8 08 00 00 00       	mov    $0x8,%eax
  100335:	0f 45 c1             	cmovne %ecx,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100338:	ba 78 03 00 00       	mov    $0x378,%edx
  10033d:	ee                   	out    %al,(%dx)
  10033e:	b8 0d 00 00 00       	mov    $0xd,%eax
  100343:	b2 7a                	mov    $0x7a,%dl
  100345:	ee                   	out    %al,(%dx)
  100346:	b8 08 00 00 00       	mov    $0x8,%eax
  10034b:	ee                   	out    %al,(%dx)
  10034c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100351:	b8 0e 00 00 00       	mov    $0xe,%eax
  100356:	89 f2                	mov    %esi,%edx
  100358:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100359:	bf d5 03 00 00       	mov    $0x3d5,%edi
  10035e:	89 fa                	mov    %edi,%edx
  100360:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  100361:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100364:	89 f2                	mov    %esi,%edx
  100366:	c1 e3 08             	shl    $0x8,%ebx
  100369:	b8 0f 00 00 00       	mov    $0xf,%eax
  10036e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10036f:	89 fa                	mov    %edi,%edx
  100371:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  100372:	0f b6 c0             	movzbl %al,%eax
  100375:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  100377:	83 f9 0a             	cmp    $0xa,%ecx
  10037a:	74 63                	je     1003df <cons_putc+0xef>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  10037c:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  100382:	0f 84 b1 00 00 00    	je     100439 <cons_putc+0x149>
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  100388:	66 81 e1 ff 00       	and    $0xff,%cx
  10038d:	80 cd 07             	or     $0x7,%ch
  100390:	66 89 8c 1b 00 80 0b 	mov    %cx,0xb8000(%ebx,%ebx,1)
  100397:	00 
  100398:	83 c3 01             	add    $0x1,%ebx
  
  if((pos/80) >= 24){  // Scroll up.
  10039b:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  1003a1:	7f 4e                	jg     1003f1 <cons_putc+0x101>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1003a3:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  1003a8:	b8 0e 00 00 00       	mov    $0xe,%eax
  1003ad:	89 ca                	mov    %ecx,%edx
  1003af:	ee                   	out    %al,(%dx)
  1003b0:	be d5 03 00 00       	mov    $0x3d5,%esi
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  1003b5:	89 d8                	mov    %ebx,%eax
  1003b7:	c1 f8 08             	sar    $0x8,%eax
  1003ba:	89 f2                	mov    %esi,%edx
  1003bc:	ee                   	out    %al,(%dx)
  1003bd:	b8 0f 00 00 00       	mov    $0xf,%eax
  1003c2:	89 ca                	mov    %ecx,%edx
  1003c4:	ee                   	out    %al,(%dx)
  1003c5:	89 d8                	mov    %ebx,%eax
  1003c7:	89 f2                	mov    %esi,%edx
  1003c9:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  1003ca:	66 c7 84 1b 00 80 0b 	movw   $0x720,0xb8000(%ebx,%ebx,1)
  1003d1:	00 20 07 
      ;
  }

  lpt_putc(c);
  cga_putc(c);
}
  1003d4:	83 c4 1c             	add    $0x1c,%esp
  1003d7:	5b                   	pop    %ebx
  1003d8:	5e                   	pop    %esi
  1003d9:	5f                   	pop    %edi
  1003da:	5d                   	pop    %ebp
  1003db:	c3                   	ret    
}

static inline void
cli(void)
{
  asm volatile("cli");
  1003dc:	fa                   	cli    
  1003dd:	eb fe                	jmp    1003dd <cons_putc+0xed>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  1003df:	89 da                	mov    %ebx,%edx
  1003e1:	89 d8                	mov    %ebx,%eax
  1003e3:	b1 50                	mov    $0x50,%cl
  1003e5:	83 c3 50             	add    $0x50,%ebx
  1003e8:	c1 fa 1f             	sar    $0x1f,%edx
  1003eb:	f7 f9                	idiv   %ecx
  1003ed:	29 d3                	sub    %edx,%ebx
  1003ef:	eb aa                	jmp    10039b <cons_putc+0xab>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  1003f1:	83 eb 50             	sub    $0x50,%ebx
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1003f4:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  1003fb:	00 
  1003fc:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  100403:	00 
  100404:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  10040b:	e8 a0 3c 00 00       	call   1040b0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100410:	b8 80 07 00 00       	mov    $0x780,%eax
  100415:	29 d8                	sub    %ebx,%eax
  100417:	01 c0                	add    %eax,%eax
  100419:	89 44 24 08          	mov    %eax,0x8(%esp)
  10041d:	8d 84 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%eax
  100424:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10042b:	00 
  10042c:	89 04 24             	mov    %eax,(%esp)
  10042f:	e8 ec 3b 00 00       	call   104020 <memset>
  100434:	e9 6a ff ff ff       	jmp    1003a3 <cons_putc+0xb3>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  100439:	85 db                	test   %ebx,%ebx
  10043b:	0f 8e 62 ff ff ff    	jle    1003a3 <cons_putc+0xb3>
      crt[--pos] = ' ' | 0x0700;
  100441:	83 eb 01             	sub    $0x1,%ebx
  100444:	66 c7 84 1b 00 80 0b 	movw   $0x720,0xb8000(%ebx,%ebx,1)
  10044b:	00 20 07 
  10044e:	e9 48 ff ff ff       	jmp    10039b <cons_putc+0xab>
  100453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100460 <console_write>:
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  100460:	55                   	push   %ebp
  100461:	89 e5                	mov    %esp,%ebp
  100463:	57                   	push   %edi
  100464:	56                   	push   %esi
  100465:	53                   	push   %ebx
  100466:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
  100469:	8b 45 08             	mov    0x8(%ebp),%eax
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  10046c:	8b 75 10             	mov    0x10(%ebp),%esi
  10046f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
  100472:	89 04 24             	mov    %eax,(%esp)
  100475:	e8 96 11 00 00       	call   101610 <iunlock>
  acquire(&console_lock);
  10047a:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100481:	e8 6a 3a 00 00       	call   103ef0 <acquire>
  for(i = 0; i < n; i++)
  100486:	85 f6                	test   %esi,%esi
  100488:	7e 19                	jle    1004a3 <console_write+0x43>
  10048a:	31 db                	xor    %ebx,%ebx
  10048c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cons_putc(buf[i] & 0xff);
  100490:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  100494:	83 c3 01             	add    $0x1,%ebx
    cons_putc(buf[i] & 0xff);
  100497:	89 14 24             	mov    %edx,(%esp)
  10049a:	e8 51 fe ff ff       	call   1002f0 <cons_putc>
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  10049f:	39 de                	cmp    %ebx,%esi
  1004a1:	7f ed                	jg     100490 <console_write+0x30>
    cons_putc(buf[i] & 0xff);
  release(&console_lock);
  1004a3:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1004aa:	e8 31 3b 00 00       	call   103fe0 <release>
  ilock(ip);
  1004af:	8b 45 08             	mov    0x8(%ebp),%eax
  1004b2:	89 04 24             	mov    %eax,(%esp)
  1004b5:	e8 46 10 00 00       	call   101500 <ilock>

  return n;
}
  1004ba:	83 c4 1c             	add    $0x1c,%esp
  1004bd:	89 f0                	mov    %esi,%eax
  1004bf:	5b                   	pop    %ebx
  1004c0:	5e                   	pop    %esi
  1004c1:	5f                   	pop    %edi
  1004c2:	5d                   	pop    %ebp
  1004c3:	c3                   	ret    
  1004c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1004ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001004d0 <printint>:
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  1004d0:	55                   	push   %ebp
  1004d1:	89 e5                	mov    %esp,%ebp
  1004d3:	57                   	push   %edi
  1004d4:	56                   	push   %esi
  1004d5:	53                   	push   %ebx
  1004d6:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  1004d9:	8b 55 10             	mov    0x10(%ebp),%edx
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  1004dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1004df:	8b 75 0c             	mov    0xc(%ebp),%esi
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  1004e2:	85 d2                	test   %edx,%edx
  1004e4:	74 09                	je     1004ef <printint+0x1f>
  1004e6:	89 c2                	mov    %eax,%edx
  1004e8:	c1 ea 1f             	shr    $0x1f,%edx
  1004eb:	84 d2                	test   %dl,%dl
  1004ed:	75 51                	jne    100540 <printint+0x70>
void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  1004ef:	31 ff                	xor    %edi,%edi
  1004f1:	31 c9                	xor    %ecx,%ecx
  1004f3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
  1004f6:	66 90                	xchg   %ax,%ax
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  1004f8:	31 d2                	xor    %edx,%edx
  1004fa:	f7 f6                	div    %esi
  1004fc:	0f b6 92 79 60 10 00 	movzbl 0x106079(%edx),%edx
  100503:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  100506:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
  100509:	85 c0                	test   %eax,%eax
  10050b:	75 eb                	jne    1004f8 <printint+0x28>
  if(neg)
  10050d:	85 ff                	test   %edi,%edi
  10050f:	74 08                	je     100519 <printint+0x49>
    buf[i++] = '-';
  100511:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
  100516:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
  100519:	8d 71 ff             	lea    -0x1(%ecx),%esi
  10051c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cons_putc(buf[i]);
  100520:	0f be 04 33          	movsbl (%ebx,%esi,1),%eax
  100524:	89 04 24             	mov    %eax,(%esp)
  100527:	e8 c4 fd ff ff       	call   1002f0 <cons_putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  10052c:	83 ee 01             	sub    $0x1,%esi
  10052f:	79 ef                	jns    100520 <printint+0x50>
    cons_putc(buf[i]);
}
  100531:	83 c4 2c             	add    $0x2c,%esp
  100534:	5b                   	pop    %ebx
  100535:	5e                   	pop    %esi
  100536:	5f                   	pop    %edi
  100537:	5d                   	pop    %ebp
  100538:	c3                   	ret    
  100539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = 0 - xx;
  100540:	f7 d8                	neg    %eax
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
  100542:	bf 01 00 00 00       	mov    $0x1,%edi
  100547:	eb a8                	jmp    1004f1 <printint+0x21>
  100549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100550 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  100550:	55                   	push   %ebp
  100551:	89 e5                	mov    %esp,%ebp
  100553:	57                   	push   %edi
  100554:	56                   	push   %esi
  100555:	53                   	push   %ebx
  100556:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  100559:	a1 a4 77 10 00       	mov    0x1077a4,%eax
  if(locking)
  10055e:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  100560:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
  100563:	0f 85 77 01 00 00    	jne    1006e0 <cprintf+0x190>
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100569:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10056c:	0f b6 03             	movzbl (%ebx),%eax
  10056f:	84 c0                	test   %al,%al
  100571:	74 7d                	je     1005f0 <cprintf+0xa0>

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  100573:	8d 55 0c             	lea    0xc(%ebp),%edx
  state = 0;
  100576:	31 ff                	xor    %edi,%edi

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  100578:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10057b:	eb 26                	jmp    1005a3 <cprintf+0x53>
  10057d:	8d 76 00             	lea    0x0(%esi),%esi
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  100580:	83 fe 25             	cmp    $0x25,%esi
  100583:	0f 84 87 00 00 00    	je     100610 <cprintf+0xc0>
        state = '%';
      else
        cons_putc(c);
  100589:	89 34 24             	mov    %esi,(%esp)
  10058c:	e8 5f fd ff ff       	call   1002f0 <cons_putc>
  100591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100598:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  10059c:	83 c3 01             	add    $0x1,%ebx
  10059f:	84 c0                	test   %al,%al
  1005a1:	74 4d                	je     1005f0 <cprintf+0xa0>
    c = fmt[i] & 0xff;
    switch(state){
  1005a3:	85 ff                	test   %edi,%edi
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
  1005a5:	0f b6 f0             	movzbl %al,%esi
    switch(state){
  1005a8:	74 d6                	je     100580 <cprintf+0x30>
  1005aa:	83 ff 25             	cmp    $0x25,%edi
  1005ad:	75 e9                	jne    100598 <cprintf+0x48>
      else
        cons_putc(c);
      break;
    
    case '%':
      switch(c){
  1005af:	83 fe 70             	cmp    $0x70,%esi
  1005b2:	74 6e                	je     100622 <cprintf+0xd2>
  1005b4:	7f 62                	jg     100618 <cprintf+0xc8>
  1005b6:	83 fe 25             	cmp    $0x25,%esi
  1005b9:	0f 84 09 01 00 00    	je     1006c8 <cprintf+0x178>
  1005bf:	83 fe 64             	cmp    $0x64,%esi
  1005c2:	0f 84 d0 00 00 00    	je     100698 <cprintf+0x148>
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  1005c8:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
        cons_putc(c);
        break;
      }
      state = 0;
  1005cf:	31 ff                	xor    %edi,%edi
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  1005d1:	e8 1a fd ff ff       	call   1002f0 <cons_putc>
        cons_putc(c);
  1005d6:	89 34 24             	mov    %esi,(%esp)
  1005d9:	e8 12 fd ff ff       	call   1002f0 <cons_putc>
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1005de:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  1005e2:	83 c3 01             	add    $0x1,%ebx
  1005e5:	84 c0                	test   %al,%al
  1005e7:	75 ba                	jne    1005a3 <cprintf+0x53>
  1005e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      state = 0;
      break;
    }
  }

  if(locking)
  1005f0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  1005f3:	85 c9                	test   %ecx,%ecx
  1005f5:	74 0c                	je     100603 <cprintf+0xb3>
    release(&console_lock);
  1005f7:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1005fe:	e8 dd 39 00 00       	call   103fe0 <release>
}
  100603:	83 c4 2c             	add    $0x2c,%esp
  100606:	5b                   	pop    %ebx
  100607:	5e                   	pop    %esi
  100608:	5f                   	pop    %edi
  100609:	5d                   	pop    %ebp
  10060a:	c3                   	ret    
  10060b:	90                   	nop
  10060c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
  100610:	bf 25 00 00 00       	mov    $0x25,%edi
  100615:	eb 81                	jmp    100598 <cprintf+0x48>
  100617:	90                   	nop
      else
        cons_putc(c);
      break;
    
    case '%':
      switch(c){
  100618:	83 fe 73             	cmp    $0x73,%esi
  10061b:	74 33                	je     100650 <cprintf+0x100>
  10061d:	83 fe 78             	cmp    $0x78,%esi
  100620:	75 a6                	jne    1005c8 <cprintf+0x78>
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100622:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  100625:	31 ff                	xor    %edi,%edi
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100627:	8b 02                	mov    (%edx),%eax
  100629:	83 c2 04             	add    $0x4,%edx
  10062c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10062f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100636:	00 
  100637:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  10063e:	00 
  10063f:	89 04 24             	mov    %eax,(%esp)
  100642:	e8 89 fe ff ff       	call   1004d0 <printint>
        break;
  100647:	e9 4c ff ff ff       	jmp    100598 <cprintf+0x48>
  10064c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      case 's':
        s = (char*)*argp++;
  100650:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        if(s == 0)
          s = "(null)";
  100653:	ba 49 60 10 00       	mov    $0x106049,%edx
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
  100658:	8b 30                	mov    (%eax),%esi
  10065a:	83 c0 04             	add    $0x4,%eax
  10065d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
  100660:	85 f6                	test   %esi,%esi
  100662:	0f 44 f2             	cmove  %edx,%esi
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  100665:	31 ff                	xor    %edi,%edi
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  100667:	0f b6 06             	movzbl (%esi),%eax
  10066a:	84 c0                	test   %al,%al
  10066c:	0f 84 26 ff ff ff    	je     100598 <cprintf+0x48>
  100672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          cons_putc(*s);
  100678:	0f be c0             	movsbl %al,%eax
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  10067b:	83 c6 01             	add    $0x1,%esi
          cons_putc(*s);
  10067e:	89 04 24             	mov    %eax,(%esp)
  100681:	e8 6a fc ff ff       	call   1002f0 <cons_putc>
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  100686:	0f b6 06             	movzbl (%esi),%eax
  100689:	84 c0                	test   %al,%al
  10068b:	75 eb                	jne    100678 <cprintf+0x128>
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  10068d:	31 ff                	xor    %edi,%edi
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
        break;
  10068f:	e9 04 ff ff ff       	jmp    100598 <cprintf+0x48>
  100694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    
    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  100698:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  10069b:	31 ff                	xor    %edi,%edi
      break;
    
    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  10069d:	8b 02                	mov    (%edx),%eax
  10069f:	83 c2 04             	add    $0x4,%edx
  1006a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1006a5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  1006ac:	00 
  1006ad:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  1006b4:	00 
  1006b5:	89 04 24             	mov    %eax,(%esp)
  1006b8:	e8 13 fe ff ff       	call   1004d0 <printint>
        break;
  1006bd:	e9 d6 fe ff ff       	jmp    100598 <cprintf+0x48>
  1006c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  1006c8:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  1006cf:	31 ff                	xor    %edi,%edi
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  1006d1:	e8 1a fc ff ff       	call   1002f0 <cons_putc>
  1006d6:	e9 bd fe ff ff       	jmp    100598 <cprintf+0x48>
  1006db:	90                   	nop
  1006dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *argp;
  char *s;

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);
  1006e0:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1006e7:	e8 04 38 00 00       	call   103ef0 <acquire>
  1006ec:	e9 78 fe ff ff       	jmp    100569 <cprintf+0x19>
  1006f1:	eb 0d                	jmp    100700 <console_intr>
  1006f3:	90                   	nop
  1006f4:	90                   	nop
  1006f5:	90                   	nop
  1006f6:	90                   	nop
  1006f7:	90                   	nop
  1006f8:	90                   	nop
  1006f9:	90                   	nop
  1006fa:	90                   	nop
  1006fb:	90                   	nop
  1006fc:	90                   	nop
  1006fd:	90                   	nop
  1006fe:	90                   	nop
  1006ff:	90                   	nop

00100700 <console_intr>:

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  100700:	55                   	push   %ebp
  100701:	89 e5                	mov    %esp,%ebp
  100703:	56                   	push   %esi
  100704:	53                   	push   %ebx
  100705:	83 ec 20             	sub    $0x20,%esp
  100708:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c;

  acquire(&input.lock);
  10070b:	c7 04 24 e0 8f 10 00 	movl   $0x108fe0,(%esp)
  100712:	e8 d9 37 00 00       	call   103ef0 <acquire>
  100717:	90                   	nop
  while((c = getc()) >= 0){
  100718:	ff d3                	call   *%ebx
  10071a:	85 c0                	test   %eax,%eax
  10071c:	0f 88 96 00 00 00    	js     1007b8 <console_intr+0xb8>
    switch(c){
  100722:	83 f8 10             	cmp    $0x10,%eax
  100725:	0f 84 a5 00 00 00    	je     1007d0 <console_intr+0xd0>
  10072b:	83 f8 15             	cmp    $0x15,%eax
  10072e:	66 90                	xchg   %ax,%ax
  100730:	0f 84 da 00 00 00    	je     100810 <console_intr+0x110>
  100736:	83 f8 08             	cmp    $0x8,%eax
  100739:	0f 84 a1 00 00 00    	je     1007e0 <console_intr+0xe0>
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
  10073f:	85 c0                	test   %eax,%eax
  100741:	74 d5                	je     100718 <console_intr+0x18>
  100743:	8b 0d 94 90 10 00    	mov    0x109094,%ecx
  100749:	8b 15 9c 90 10 00    	mov    0x10909c,%edx
  10074f:	83 c1 7f             	add    $0x7f,%ecx
  100752:	39 d1                	cmp    %edx,%ecx
  100754:	7c c2                	jl     100718 <console_intr+0x18>
        input.buf[input.e++ % INPUT_BUF] = c;
  100756:	89 d6                	mov    %edx,%esi
  100758:	c1 fe 1f             	sar    $0x1f,%esi
  10075b:	c1 ee 19             	shr    $0x19,%esi
  10075e:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
  100761:	83 c2 01             	add    $0x1,%edx
  100764:	83 e1 7f             	and    $0x7f,%ecx
  100767:	29 f1                	sub    %esi,%ecx
  100769:	88 81 14 90 10 00    	mov    %al,0x109014(%ecx)
        cons_putc(c);
  10076f:	89 04 24             	mov    %eax,(%esp)
  100772:	89 45 f4             	mov    %eax,-0xc(%ebp)
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  100775:	89 15 9c 90 10 00    	mov    %edx,0x10909c
        cons_putc(c);
  10077b:	e8 70 fb ff ff       	call   1002f0 <cons_putc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100780:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100783:	83 f8 04             	cmp    $0x4,%eax
  100786:	0f 84 e1 00 00 00    	je     10086d <console_intr+0x16d>
  10078c:	83 f8 0a             	cmp    $0xa,%eax
  10078f:	0f 84 d8 00 00 00    	je     10086d <console_intr+0x16d>
  100795:	8b 15 94 90 10 00    	mov    0x109094,%edx
  10079b:	a1 9c 90 10 00       	mov    0x10909c,%eax
  1007a0:	83 ea 80             	sub    $0xffffff80,%edx
  1007a3:	39 d0                	cmp    %edx,%eax
  1007a5:	0f 84 c7 00 00 00    	je     100872 <console_intr+0x172>
console_intr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  1007ab:	ff d3                	call   *%ebx
  1007ad:	85 c0                	test   %eax,%eax
  1007af:	0f 89 6d ff ff ff    	jns    100722 <console_intr+0x22>
  1007b5:	8d 76 00             	lea    0x0(%esi),%esi
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007b8:	c7 45 08 e0 8f 10 00 	movl   $0x108fe0,0x8(%ebp)
}
  1007bf:	83 c4 20             	add    $0x20,%esp
  1007c2:	5b                   	pop    %ebx
  1007c3:	5e                   	pop    %esi
  1007c4:	5d                   	pop    %ebp
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007c5:	e9 16 38 00 00       	jmp    103fe0 <release>
  1007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  1007d0:	e8 3b 35 00 00       	call   103d10 <procdump>
      break;
  1007d5:	e9 3e ff ff ff       	jmp    100718 <console_intr+0x18>
  1007da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e > input.w){
  1007e0:	a1 9c 90 10 00       	mov    0x10909c,%eax
  1007e5:	3b 05 98 90 10 00    	cmp    0x109098,%eax
  1007eb:	0f 8e 27 ff ff ff    	jle    100718 <console_intr+0x18>
        input.e--;
  1007f1:	83 e8 01             	sub    $0x1,%eax
  1007f4:	a3 9c 90 10 00       	mov    %eax,0x10909c
        cons_putc(BACKSPACE);
  1007f9:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  100800:	e8 eb fa ff ff       	call   1002f0 <cons_putc>
  100805:	e9 0e ff ff ff       	jmp    100718 <console_intr+0x18>
  10080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  100810:	8b 0d 9c 90 10 00    	mov    0x10909c,%ecx
  100816:	39 0d 98 90 10 00    	cmp    %ecx,0x109098
  10081c:	7c 2e                	jl     10084c <console_intr+0x14c>
  10081e:	e9 f5 fe ff ff       	jmp    100718 <console_intr+0x18>
  100823:	90                   	nop
  100824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  100828:	89 0d 9c 90 10 00    	mov    %ecx,0x10909c
        cons_putc(BACKSPACE);
  10082e:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  100835:	e8 b6 fa ff ff       	call   1002f0 <cons_putc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  10083a:	8b 0d 9c 90 10 00    	mov    0x10909c,%ecx
  100840:	3b 0d 98 90 10 00    	cmp    0x109098,%ecx
  100846:	0f 8e cc fe ff ff    	jle    100718 <console_intr+0x18>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  10084c:	83 e9 01             	sub    $0x1,%ecx
  10084f:	89 ca                	mov    %ecx,%edx
  100851:	c1 fa 1f             	sar    $0x1f,%edx
  100854:	c1 ea 19             	shr    $0x19,%edx
  100857:	8d 04 11             	lea    (%ecx,%edx,1),%eax
  10085a:	83 e0 7f             	and    $0x7f,%eax
  10085d:	29 d0                	sub    %edx,%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  10085f:	80 b8 14 90 10 00 0a 	cmpb   $0xa,0x109014(%eax)
  100866:	75 c0                	jne    100828 <console_intr+0x128>
  100868:	e9 ab fe ff ff       	jmp    100718 <console_intr+0x18>
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  10086d:	a1 9c 90 10 00       	mov    0x10909c,%eax
          input.w = input.e;
  100872:	a3 98 90 10 00       	mov    %eax,0x109098
          wakeup(&input.r);
  100877:	c7 04 24 94 90 10 00 	movl   $0x109094,(%esp)
  10087e:	e8 2d 31 00 00       	call   1039b0 <wakeup>
  100883:	e9 90 fe ff ff       	jmp    100718 <console_intr+0x18>
  100888:	90                   	nop
  100889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100890 <console_init>:
  return target - n;
}

void
console_init(void)
{
  100890:	55                   	push   %ebp
  100891:	89 e5                	mov    %esp,%ebp
  100893:	83 ec 18             	sub    $0x18,%esp
  initlock(&console_lock, "console");
  100896:	c7 44 24 04 50 60 10 	movl   $0x106050,0x4(%esp)
  10089d:	00 
  10089e:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1008a5:	e8 46 35 00 00       	call   103df0 <initlock>
  initlock(&input.lock, "console input");
  1008aa:	c7 44 24 04 58 60 10 	movl   $0x106058,0x4(%esp)
  1008b1:	00 
  1008b2:	c7 04 24 e0 8f 10 00 	movl   $0x108fe0,(%esp)
  1008b9:	e8 32 35 00 00       	call   103df0 <initlock>

  devsw[CONSOLE].write = console_write;
  devsw[CONSOLE].read = console_read;
  use_console_lock = 1;

  pic_enable(IRQ_KBD);
  1008be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
console_init(void)
{
  initlock(&console_lock, "console");
  initlock(&input.lock, "console input");

  devsw[CONSOLE].write = console_write;
  1008c5:	c7 05 4c 9a 10 00 60 	movl   $0x100460,0x109a4c
  1008cc:	04 10 00 
  devsw[CONSOLE].read = console_read;
  1008cf:	c7 05 48 9a 10 00 f0 	movl   $0x1001f0,0x109a48
  1008d6:	01 10 00 
  use_console_lock = 1;
  1008d9:	c7 05 a4 77 10 00 01 	movl   $0x1,0x1077a4
  1008e0:	00 00 00 

  pic_enable(IRQ_KBD);
  1008e3:	e8 28 24 00 00       	call   102d10 <pic_enable>
  ioapic_enable(IRQ_KBD, 0);
  1008e8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1008ef:	00 
  1008f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1008f7:	e8 f4 19 00 00       	call   1022f0 <ioapic_enable>
}
  1008fc:	c9                   	leave  
  1008fd:	c3                   	ret    
  1008fe:	66 90                	xchg   %ax,%ax

00100900 <panic>:

void
panic(char *s)
{
  100900:	55                   	push   %ebp
  100901:	89 e5                	mov    %esp,%ebp
  100903:	56                   	push   %esi
  100904:	53                   	push   %ebx
  100905:	83 ec 40             	sub    $0x40,%esp
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  100908:	c7 05 a4 77 10 00 00 	movl   $0x0,0x1077a4
  10090f:	00 00 00 
panic(char *s)
{
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  100912:	fa                   	cli    
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100913:	e8 68 1e 00 00       	call   102780 <cpu>
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  100918:	8d 75 d0             	lea    -0x30(%ebp),%esi
  for(i=0; i<10; i++)
  10091b:	31 db                	xor    %ebx,%ebx
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  10091d:	c7 04 24 66 60 10 00 	movl   $0x106066,(%esp)
  100924:	89 44 24 04          	mov    %eax,0x4(%esp)
  100928:	e8 23 fc ff ff       	call   100550 <cprintf>
  cprintf(s, 0);
  10092d:	8b 45 08             	mov    0x8(%ebp),%eax
  100930:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100937:	00 
  100938:	89 04 24             	mov    %eax,(%esp)
  10093b:	e8 10 fc ff ff       	call   100550 <cprintf>
  cprintf("\n", 0);
  100940:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100947:	00 
  100948:	c7 04 24 b3 64 10 00 	movl   $0x1064b3,(%esp)
  10094f:	e8 fc fb ff ff       	call   100550 <cprintf>
  getcallerpcs(&s, pcs);
  100954:	8d 45 08             	lea    0x8(%ebp),%eax
  100957:	89 74 24 04          	mov    %esi,0x4(%esp)
  10095b:	89 04 24             	mov    %eax,(%esp)
  10095e:	e8 ad 34 00 00       	call   103e10 <getcallerpcs>
  100963:	90                   	nop
  100964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100968:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10096b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" %p", pcs[i]);
  10096e:	c7 04 24 75 60 10 00 	movl   $0x106075,(%esp)
  100975:	89 44 24 04          	mov    %eax,0x4(%esp)
  100979:	e8 d2 fb ff ff       	call   100550 <cprintf>
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10097e:	83 fb 0a             	cmp    $0xa,%ebx
  100981:	75 e5                	jne    100968 <panic+0x68>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  100983:	c7 05 a0 77 10 00 01 	movl   $0x1,0x1077a0
  10098a:	00 00 00 
  10098d:	eb fe                	jmp    10098d <panic+0x8d>
  10098f:	90                   	nop

00100990 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  100990:	55                   	push   %ebp
  100991:	89 e5                	mov    %esp,%ebp
  100993:	57                   	push   %edi
  100994:	56                   	push   %esi
  100995:	53                   	push   %ebx
  100996:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  10099c:	8b 45 08             	mov    0x8(%ebp),%eax
  10099f:	89 04 24             	mov    %eax,(%esp)
  1009a2:	e8 99 15 00 00       	call   101f40 <namei>
  1009a7:	89 c3                	mov    %eax,%ebx
    return -1;
  1009a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  1009ae:	85 db                	test   %ebx,%ebx
  1009b0:	0f 84 55 03 00 00    	je     100d0b <exec+0x37b>
    return -1;
  ilock(ip);
  1009b6:	89 1c 24             	mov    %ebx,(%esp)
  1009b9:	e8 42 0b 00 00       	call   101500 <ilock>
  // Compute memory size of new process.
  mem = 0;
  sz = 0;

  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  1009be:	8d 45 94             	lea    -0x6c(%ebp),%eax
  1009c1:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  1009c8:	00 
  1009c9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1009d0:	00 
  1009d1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d5:	89 1c 24             	mov    %ebx,(%esp)
  1009d8:	e8 73 0f 00 00       	call   101950 <readi>
  1009dd:	83 f8 33             	cmp    $0x33,%eax
  1009e0:	0f 86 44 03 00 00    	jbe    100d2a <exec+0x39a>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  1009e6:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
  1009ed:	0f 85 37 03 00 00    	jne    100d2a <exec+0x39a>
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  1009f3:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
  1009f8:	8b 7d b0             	mov    -0x50(%ebp),%edi
  1009fb:	0f 84 69 03 00 00    	je     100d6a <exec+0x3da>
    return -1;
  ilock(ip);

  // Compute memory size of new process.
  mem = 0;
  sz = 0;
  100a01:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a08:	31 f6                	xor    %esi,%esi
  100a0a:	eb 12                	jmp    100a1e <exec+0x8e>
  100a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100a10:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100a14:	83 c6 01             	add    $0x1,%esi
  100a17:	39 f0                	cmp    %esi,%eax
  100a19:	7e 47                	jle    100a62 <exec+0xd2>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  100a1b:	83 c7 20             	add    $0x20,%edi
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100a1e:	8d 55 c8             	lea    -0x38(%ebp),%edx
  100a21:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100a28:	00 
  100a29:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100a2d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a31:	89 1c 24             	mov    %ebx,(%esp)
  100a34:	e8 17 0f 00 00       	call   101950 <readi>
  100a39:	83 f8 20             	cmp    $0x20,%eax
  100a3c:	0f 85 e8 02 00 00    	jne    100d2a <exec+0x39a>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100a42:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
  100a46:	75 c8                	jne    100a10 <exec+0x80>
      continue;
    if(ph.memsz < ph.filesz)
  100a48:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a4b:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  100a4e:	0f 82 d6 02 00 00    	jb     100d2a <exec+0x39a>
      goto bad;
    sz += ph.memsz;
  100a54:	01 45 84             	add    %eax,-0x7c(%ebp)
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a57:	83 c6 01             	add    $0x1,%esi
  100a5a:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100a5e:	39 f0                	cmp    %esi,%eax
  100a60:	7f b9                	jg     100a1b <exec+0x8b>
  100a62:	8b 7d 84             	mov    -0x7c(%ebp),%edi
  100a65:	81 c7 ff 1f 00 00    	add    $0x1fff,%edi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100a6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100a6e:	8b 11                	mov    (%ecx),%edx
  100a70:	85 d2                	test   %edx,%edx
  100a72:	0f 84 ca 02 00 00    	je     100d42 <exec+0x3b2>
  100a78:	89 7d 84             	mov    %edi,-0x7c(%ebp)
  100a7b:	31 f6                	xor    %esi,%esi
  100a7d:	89 cf                	mov    %ecx,%edi
  100a7f:	89 5d 80             	mov    %ebx,-0x80(%ebp)
  100a82:	31 db                	xor    %ebx,%ebx
  100a84:	c7 85 7c ff ff ff 00 	movl   $0x0,-0x84(%ebp)
  100a8b:	00 00 00 
  100a8e:	66 90                	xchg   %ax,%ax
    arglen += strlen(argv[argc]) + 1;
  100a90:	89 14 24             	mov    %edx,(%esp)
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100a93:	83 c3 01             	add    $0x1,%ebx
    arglen += strlen(argv[argc]) + 1;
  100a96:	e8 75 37 00 00       	call   104210 <strlen>
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100a9b:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
  100a9e:	89 d9                	mov    %ebx,%ecx
    arglen += strlen(argv[argc]) + 1;
  100aa0:	01 f0                	add    %esi,%eax
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100aa2:	85 d2                	test   %edx,%edx
    arglen += strlen(argv[argc]) + 1;
  100aa4:	8d 70 01             	lea    0x1(%eax),%esi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100aa7:	75 e7                	jne    100a90 <exec+0x100>
  100aa9:	89 9d 7c ff ff ff    	mov    %ebx,-0x84(%ebp)
  100aaf:	8b 7d 84             	mov    -0x7c(%ebp),%edi
  100ab2:	83 c0 04             	add    $0x4,%eax
  100ab5:	8b 5d 80             	mov    -0x80(%ebp),%ebx
  100ab8:	83 e0 fc             	and    $0xfffffffc,%eax
  100abb:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  100ac1:	8d 44 88 04          	lea    0x4(%eax,%ecx,4),%eax
  100ac5:	89 8d 74 ff ff ff    	mov    %ecx,-0x8c(%ebp)

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100acb:	01 f8                	add    %edi,%eax
  100acd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  100ad2:	89 45 80             	mov    %eax,-0x80(%ebp)
  mem = kalloc(sz);
  100ad5:	89 04 24             	mov    %eax,(%esp)
  100ad8:	e8 b3 19 00 00       	call   102490 <kalloc>
  if(mem == 0)
  100add:	85 c0                	test   %eax,%eax
  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  mem = kalloc(sz);
  100adf:	89 45 84             	mov    %eax,-0x7c(%ebp)
  if(mem == 0)
  100ae2:	0f 84 42 02 00 00    	je     100d2a <exec+0x39a>
    goto bad;
  memset(mem, 0, sz);
  100ae8:	8b 4d 80             	mov    -0x80(%ebp),%ecx
  100aeb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100af2:	00 
  100af3:	89 04 24             	mov    %eax,(%esp)
  100af6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100afa:	e8 21 35 00 00       	call   104020 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100aff:	8b 7d b0             	mov    -0x50(%ebp),%edi
  100b02:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
  100b07:	0f 84 ac 00 00 00    	je     100bb9 <exec+0x229>
  100b0d:	31 f6                	xor    %esi,%esi
  100b0f:	eb 19                	jmp    100b2a <exec+0x19a>
  100b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100b18:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100b1c:	83 c6 01             	add    $0x1,%esi
  100b1f:	39 f0                	cmp    %esi,%eax
  100b21:	0f 8e 92 00 00 00    	jle    100bb9 <exec+0x229>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  100b27:	83 c7 20             	add    $0x20,%edi
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100b2a:	8d 45 c8             	lea    -0x38(%ebp),%eax
  100b2d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100b34:	00 
  100b35:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100b39:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b3d:	89 1c 24             	mov    %ebx,(%esp)
  100b40:	e8 0b 0e 00 00       	call   101950 <readi>
  100b45:	83 f8 20             	cmp    $0x20,%eax
  100b48:	0f 85 ca 01 00 00    	jne    100d18 <exec+0x388>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100b4e:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
  100b52:	75 c4                	jne    100b18 <exec+0x188>
      continue;
    if(ph.va + ph.memsz > sz)
  100b54:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100b57:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100b5a:	01 c2                	add    %eax,%edx
  100b5c:	39 55 80             	cmp    %edx,-0x80(%ebp)
  100b5f:	0f 82 b3 01 00 00    	jb     100d18 <exec+0x388>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  100b65:	8b 55 d8             	mov    -0x28(%ebp),%edx
  100b68:	03 45 84             	add    -0x7c(%ebp),%eax
  100b6b:	89 1c 24             	mov    %ebx,(%esp)
  100b6e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100b72:	8b 55 cc             	mov    -0x34(%ebp),%edx
  100b75:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b79:	89 54 24 08          	mov    %edx,0x8(%esp)
  100b7d:	e8 ce 0d 00 00       	call   101950 <readi>
  100b82:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  100b85:	0f 85 8d 01 00 00    	jne    100d18 <exec+0x388>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100b8b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100b8e:	83 c6 01             	add    $0x1,%esi
      continue;
    if(ph.va + ph.memsz > sz)
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100b91:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100b98:	00 
  100b99:	29 c2                	sub    %eax,%edx
  100b9b:	03 45 d0             	add    -0x30(%ebp),%eax
  100b9e:	03 45 84             	add    -0x7c(%ebp),%eax
  100ba1:	89 54 24 08          	mov    %edx,0x8(%esp)
  100ba5:	89 04 24             	mov    %eax,(%esp)
  100ba8:	e8 73 34 00 00       	call   104020 <memset>
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100bad:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100bb1:	39 f0                	cmp    %esi,%eax
  100bb3:	0f 8f 6e ff ff ff    	jg     100b27 <exec+0x197>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  }
  iunlockput(ip);
  100bb9:	89 1c 24             	mov    %ebx,(%esp)
  100bbc:	e8 3f 0d 00 00       	call   101900 <iunlockput>
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100bc1:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  100bc7:	8b 55 80             	mov    -0x80(%ebp),%edx
  100bca:	2b 95 78 ff ff ff    	sub    -0x88(%ebp),%edx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100bd0:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100bd3:	f7 d0                	not    %eax
  100bd5:	8d 04 82             	lea    (%edx,%eax,4),%eax

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100bd8:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100bde:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100be4:	89 d3                	mov    %edx,%ebx
  100be6:	83 eb 01             	sub    $0x1,%ebx
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100be9:	8d 04 90             	lea    (%eax,%edx,4),%eax
  for(i=argc-1; i>=0; i--){
  100bec:	83 fb ff             	cmp    $0xffffffff,%ebx
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100bef:	c7 04 01 00 00 00 00 	movl   $0x0,(%ecx,%eax,1)
  for(i=argc-1; i>=0; i--){
  100bf6:	74 51                	je     100c49 <exec+0x2b9>
  100bf8:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  100bfe:	8b 75 80             	mov    -0x80(%ebp),%esi
  100c01:	8d 3c 01             	lea    (%ecx,%eax,1),%edi
  100c04:	89 bd 7c ff ff ff    	mov    %edi,-0x84(%ebp)
  100c0a:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100c0d:	8d 76 00             	lea    0x0(%esi),%esi
    len = strlen(argv[i]) + 1;
  100c10:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  100c13:	89 04 24             	mov    %eax,(%esp)
  100c16:	e8 f5 35 00 00       	call   104210 <strlen>
  100c1b:	83 c0 01             	add    $0x1,%eax
    sp -= len;
  100c1e:	29 c6                	sub    %eax,%esi
    memmove(mem+sp, argv[i], len);
  100c20:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c24:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  100c27:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c2b:	8b 45 84             	mov    -0x7c(%ebp),%eax
  100c2e:	01 f0                	add    %esi,%eax
  100c30:	89 04 24             	mov    %eax,(%esp)
  100c33:	e8 78 34 00 00       	call   1040b0 <memmove>
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  100c38:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  100c3e:	89 34 9a             	mov    %esi,(%edx,%ebx,4)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100c41:	83 eb 01             	sub    $0x1,%ebx
  100c44:	83 fb ff             	cmp    $0xffffffff,%ebx
  100c47:	75 c7                	jne    100c10 <exec+0x280>
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100c49:	8b 8d 78 ff ff ff    	mov    -0x88(%ebp),%ecx
  100c4f:	8b 45 84             	mov    -0x7c(%ebp),%eax
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100c52:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  sp -= 4;
  100c58:	89 cb                	mov    %ecx,%ebx
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100c5a:	89 4c 08 fc          	mov    %ecx,-0x4(%eax,%ecx,1)
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  100c5e:	83 eb 0c             	sub    $0xc,%ebx
  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100c61:	89 54 08 f8          	mov    %edx,-0x8(%eax,%ecx,1)
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  100c65:	c7 44 08 f4 ff ff ff 	movl   $0xffffffff,-0xc(%eax,%ecx,1)
  100c6c:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100c6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100c70:	0f b6 01             	movzbl (%ecx),%eax
  100c73:	89 ce                	mov    %ecx,%esi
  100c75:	84 c0                	test   %al,%al
  100c77:	74 16                	je     100c8f <exec+0x2ff>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  100c79:	8d 51 01             	lea    0x1(%ecx),%edx
  100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
  100c80:	3c 2f                	cmp    $0x2f,%al
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100c82:	0f b6 02             	movzbl (%edx),%eax
    if(*s == '/')
  100c85:	0f 44 f2             	cmove  %edx,%esi
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100c88:	83 c2 01             	add    $0x1,%edx
  100c8b:	84 c0                	test   %al,%al
  100c8d:	75 f1                	jne    100c80 <exec+0x2f0>
    if(*s == '/')
      last = s+1;
  safestrcpy(cp->name, last, sizeof(cp->name));
  100c8f:	e8 7c 29 00 00       	call   103610 <curproc>
  100c94:	89 74 24 04          	mov    %esi,0x4(%esp)
  100c98:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100c9f:	00 
  100ca0:	05 88 00 00 00       	add    $0x88,%eax
  100ca5:	89 04 24             	mov    %eax,(%esp)
  100ca8:	e8 23 35 00 00       	call   1041d0 <safestrcpy>

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  100cad:	e8 5e 29 00 00       	call   103610 <curproc>
  100cb2:	8b 70 04             	mov    0x4(%eax),%esi
  100cb5:	e8 56 29 00 00       	call   103610 <curproc>
  100cba:	89 74 24 04          	mov    %esi,0x4(%esp)
  100cbe:	8b 00                	mov    (%eax),%eax
  100cc0:	89 04 24             	mov    %eax,(%esp)
  100cc3:	e8 68 16 00 00       	call   102330 <kfree>
  cp->mem = mem;
  100cc8:	e8 43 29 00 00       	call   103610 <curproc>
  100ccd:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100cd0:	89 10                	mov    %edx,(%eax)
  cp->sz = sz;
  100cd2:	e8 39 29 00 00       	call   103610 <curproc>
  100cd7:	8b 4d 80             	mov    -0x80(%ebp),%ecx
  100cda:	89 48 04             	mov    %ecx,0x4(%eax)
  cp->tf->eip = elf.entry;  // main
  100cdd:	e8 2e 29 00 00       	call   103610 <curproc>
  100ce2:	8b 55 ac             	mov    -0x54(%ebp),%edx
  100ce5:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  100ceb:	89 50 30             	mov    %edx,0x30(%eax)
  cp->tf->esp = sp;
  100cee:	e8 1d 29 00 00       	call   103610 <curproc>
  100cf3:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  100cf9:	89 58 3c             	mov    %ebx,0x3c(%eax)
  setupsegs(cp);
  100cfc:	e8 0f 29 00 00       	call   103610 <curproc>
  100d01:	89 04 24             	mov    %eax,(%esp)
  100d04:	e8 67 24 00 00       	call   103170 <setupsegs>
  return 0;
  100d09:	31 c0                	xor    %eax,%eax
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  100d0b:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  100d11:	5b                   	pop    %ebx
  100d12:	5e                   	pop    %esi
  100d13:	5f                   	pop    %edi
  100d14:	5d                   	pop    %ebp
  100d15:	c3                   	ret    
  100d16:	66 90                	xchg   %ax,%ax
  setupsegs(cp);
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  100d18:	8b 45 80             	mov    -0x80(%ebp),%eax
  100d1b:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100d1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d22:	89 14 24             	mov    %edx,(%esp)
  100d25:	e8 06 16 00 00       	call   102330 <kfree>
  iunlockput(ip);
  100d2a:	89 1c 24             	mov    %ebx,(%esp)
  100d2d:	e8 ce 0b 00 00       	call   101900 <iunlockput>
  return -1;
}
  100d32:	81 c4 9c 00 00 00    	add    $0x9c,%esp

 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
  100d38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100d3d:	5b                   	pop    %ebx
  100d3e:	5e                   	pop    %esi
  100d3f:	5f                   	pop    %edi
  100d40:	5d                   	pop    %ebp
  100d41:	c3                   	ret    
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100d42:	b8 04 00 00 00       	mov    $0x4,%eax
  100d47:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
  100d4e:	00 00 00 
  100d51:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
  100d58:	00 00 00 
  100d5b:	c7 85 7c ff ff ff 00 	movl   $0x0,-0x84(%ebp)
  100d62:	00 00 00 
  100d65:	e9 61 fd ff ff       	jmp    100acb <exec+0x13b>
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100d6a:	bf ff 1f 00 00       	mov    $0x1fff,%edi
  100d6f:	e9 f7 fc ff ff       	jmp    100a6b <exec+0xdb>
  100d74:	90                   	nop
  100d75:	90                   	nop
  100d76:	90                   	nop
  100d77:	90                   	nop
  100d78:	90                   	nop
  100d79:	90                   	nop
  100d7a:	90                   	nop
  100d7b:	90                   	nop
  100d7c:	90                   	nop
  100d7d:	90                   	nop
  100d7e:	90                   	nop
  100d7f:	90                   	nop

00100d80 <fileinit>:
struct spinlock file_table_lock;
struct file file[NFILE];

void
fileinit(void)
{
  100d80:	55                   	push   %ebp
  100d81:	89 e5                	mov    %esp,%ebp
  100d83:	83 ec 18             	sub    $0x18,%esp
  initlock(&file_table_lock, "file_table");
  100d86:	c7 44 24 04 8a 60 10 	movl   $0x10608a,0x4(%esp)
  100d8d:	00 
  100d8e:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100d95:	e8 56 30 00 00       	call   103df0 <initlock>
}
  100d9a:	c9                   	leave  
  100d9b:	c3                   	ret    
  100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100da0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
  100da0:	55                   	push   %ebp
  100da1:	89 e5                	mov    %esp,%ebp
  100da3:	53                   	push   %ebx
  100da4:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&file_table_lock);
  100da7:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100dae:	e8 3d 31 00 00       	call   103ef0 <acquire>
  100db3:	ba a0 90 10 00       	mov    $0x1090a0,%edx
  for(i = 0; i < NFILE; i++){
  100db8:	31 c0                	xor    %eax,%eax
  100dba:	eb 0f                	jmp    100dcb <filealloc+0x2b>
  100dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100dc0:	83 c0 01             	add    $0x1,%eax
  100dc3:	83 c2 18             	add    $0x18,%edx
  100dc6:	83 f8 64             	cmp    $0x64,%eax
  100dc9:	74 3d                	je     100e08 <filealloc+0x68>
    if(file[i].type == FD_CLOSED){
  100dcb:	8b 0a                	mov    (%edx),%ecx
  100dcd:	85 c9                	test   %ecx,%ecx
  100dcf:	75 ef                	jne    100dc0 <filealloc+0x20>
      file[i].type = FD_NONE;
  100dd1:	8d 04 40             	lea    (%eax,%eax,2),%eax
  100dd4:	c1 e0 03             	shl    $0x3,%eax
  100dd7:	8d 98 a0 90 10 00    	lea    0x1090a0(%eax),%ebx
  100ddd:	c7 80 a0 90 10 00 01 	movl   $0x1,0x1090a0(%eax)
  100de4:	00 00 00 
      file[i].ref = 1;
  100de7:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&file_table_lock);
  100dee:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100df5:	e8 e6 31 00 00       	call   103fe0 <release>
      return file + i;
  100dfa:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&file_table_lock);
  return 0;
}
  100dfc:	83 c4 14             	add    $0x14,%esp
  100dff:	5b                   	pop    %ebx
  100e00:	5d                   	pop    %ebp
  100e01:	c3                   	ret    
  100e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  100e08:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100e0f:	e8 cc 31 00 00       	call   103fe0 <release>
  return 0;
}
  100e14:	83 c4 14             	add    $0x14,%esp
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  return 0;
  100e17:	31 c0                	xor    %eax,%eax
}
  100e19:	5b                   	pop    %ebx
  100e1a:	5d                   	pop    %ebp
  100e1b:	c3                   	ret    
  100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100e20 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100e20:	55                   	push   %ebp
  100e21:	89 e5                	mov    %esp,%ebp
  100e23:	53                   	push   %ebx
  100e24:	83 ec 14             	sub    $0x14,%esp
  100e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&file_table_lock);
  100e2a:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100e31:	e8 ba 30 00 00       	call   103ef0 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  100e36:	8b 43 04             	mov    0x4(%ebx),%eax
  100e39:	85 c0                	test   %eax,%eax
  100e3b:	7e 20                	jle    100e5d <filedup+0x3d>
  100e3d:	8b 13                	mov    (%ebx),%edx
  100e3f:	85 d2                	test   %edx,%edx
  100e41:	74 1a                	je     100e5d <filedup+0x3d>
    panic("filedup");
  f->ref++;
  100e43:	83 c0 01             	add    $0x1,%eax
  100e46:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&file_table_lock);
  100e49:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100e50:	e8 8b 31 00 00       	call   103fe0 <release>
  return f;
}
  100e55:	89 d8                	mov    %ebx,%eax
  100e57:	83 c4 14             	add    $0x14,%esp
  100e5a:	5b                   	pop    %ebx
  100e5b:	5d                   	pop    %ebp
  100e5c:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("filedup");
  100e5d:	c7 04 24 95 60 10 00 	movl   $0x106095,(%esp)
  100e64:	e8 97 fa ff ff       	call   100900 <panic>
  100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100e70 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100e70:	55                   	push   %ebp
  100e71:	89 e5                	mov    %esp,%ebp
  100e73:	83 ec 38             	sub    $0x38,%esp
  100e76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100e79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100e7c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100e7f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&file_table_lock);
  100e82:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)
  100e89:	e8 62 30 00 00       	call   103ef0 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  100e8e:	8b 43 04             	mov    0x4(%ebx),%eax
  100e91:	85 c0                	test   %eax,%eax
  100e93:	0f 8e 97 00 00 00    	jle    100f30 <fileclose+0xc0>
  100e99:	8b 33                	mov    (%ebx),%esi
  100e9b:	85 f6                	test   %esi,%esi
  100e9d:	0f 84 8d 00 00 00    	je     100f30 <fileclose+0xc0>
    panic("fileclose");
  if(--f->ref > 0){
  100ea3:	83 e8 01             	sub    $0x1,%eax
  100ea6:	85 c0                	test   %eax,%eax
  100ea8:	89 43 04             	mov    %eax,0x4(%ebx)
  100eab:	74 1b                	je     100ec8 <fileclose+0x58>
    release(&file_table_lock);
  100ead:	c7 45 08 00 9a 10 00 	movl   $0x109a00,0x8(%ebp)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  100eb4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100eb7:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100eba:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100ebd:	89 ec                	mov    %ebp,%esp
  100ebf:	5d                   	pop    %ebp

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  100ec0:	e9 1b 31 00 00       	jmp    103fe0 <release>
  100ec5:	8d 76 00             	lea    0x0(%esi),%esi
  100ec8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
    return;
  }
  ff = *f;
  f->ref = 0;
  100ecc:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  100ed3:	8b 7b 10             	mov    0x10(%ebx),%edi
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_CLOSED;
  100ed6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  100edc:	88 45 e7             	mov    %al,-0x19(%ebp)
  100edf:	8b 43 0c             	mov    0xc(%ebx),%eax
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  100ee2:	c7 04 24 00 9a 10 00 	movl   $0x109a00,(%esp)

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  100ee9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  100eec:	e8 ef 30 00 00       	call   103fe0 <release>
  
  if(ff.type == FD_PIPE)
  100ef1:	83 fe 02             	cmp    $0x2,%esi
  100ef4:	74 1a                	je     100f10 <fileclose+0xa0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  100ef6:	83 fe 03             	cmp    $0x3,%esi
  100ef9:	75 35                	jne    100f30 <fileclose+0xc0>
    iput(ff.ip);
  100efb:	89 7d 08             	mov    %edi,0x8(%ebp)
  else
    panic("fileclose");
}
  100efe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f01:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f04:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f07:	89 ec                	mov    %ebp,%esp
  100f09:	5d                   	pop    %ebp
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f0a:	e9 b1 08 00 00       	jmp    1017c0 <iput>
  100f0f:	90                   	nop
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  100f10:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  100f14:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100f1b:	89 04 24             	mov    %eax,(%esp)
  100f1e:	e8 ad 1f 00 00       	call   102ed0 <pipeclose>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  100f23:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f26:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f29:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f2c:	89 ec                	mov    %ebp,%esp
  100f2e:	5d                   	pop    %ebp
  100f2f:	c3                   	ret    
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
  100f30:	c7 04 24 9d 60 10 00 	movl   $0x10609d,(%esp)
  100f37:	e8 c4 f9 ff ff       	call   100900 <panic>
  100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100f40 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f40:	55                   	push   %ebp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
  100f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f46:	89 e5                	mov    %esp,%ebp
  100f48:	53                   	push   %ebx
  100f49:	83 ec 14             	sub    $0x14,%esp
  100f4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100f4f:	83 3b 03             	cmpl   $0x3,(%ebx)
  100f52:	74 0c                	je     100f60 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100f54:	83 c4 14             	add    $0x14,%esp
  100f57:	5b                   	pop    %ebx
  100f58:	5d                   	pop    %ebp
  100f59:	c3                   	ret    
  100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100f60:	8b 43 10             	mov    0x10(%ebx),%eax
  100f63:	89 04 24             	mov    %eax,(%esp)
  100f66:	e8 95 05 00 00       	call   101500 <ilock>
    stati(f->ip, st);
  100f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f6e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f72:	8b 43 10             	mov    0x10(%ebx),%eax
  100f75:	89 04 24             	mov    %eax,(%esp)
  100f78:	e8 a3 09 00 00       	call   101920 <stati>
    iunlock(f->ip);
  100f7d:	8b 43 10             	mov    0x10(%ebx),%eax
  100f80:	89 04 24             	mov    %eax,(%esp)
  100f83:	e8 88 06 00 00       	call   101610 <iunlock>
    return 0;
  }
  return -1;
}
  100f88:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  100f8b:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
  100f8d:	5b                   	pop    %ebx
  100f8e:	5d                   	pop    %ebp
  100f8f:	c3                   	ret    

00100f90 <fileread>:

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100f90:	55                   	push   %ebp
  100f91:	89 e5                	mov    %esp,%ebp
  100f93:	83 ec 38             	sub    $0x38,%esp
  100f96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100f9c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100f9f:	8b 75 0c             	mov    0xc(%ebp),%esi
  100fa2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100fa5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
  100fa8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100fac:	74 5a                	je     101008 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100fae:	8b 03                	mov    (%ebx),%eax
  100fb0:	83 f8 02             	cmp    $0x2,%eax
  100fb3:	74 6b                	je     101020 <fileread+0x90>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100fb5:	83 f8 03             	cmp    $0x3,%eax
  100fb8:	75 7d                	jne    101037 <fileread+0xa7>
    ilock(f->ip);
  100fba:	8b 43 10             	mov    0x10(%ebx),%eax
  100fbd:	89 04 24             	mov    %eax,(%esp)
  100fc0:	e8 3b 05 00 00       	call   101500 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100fc5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100fc9:	8b 43 14             	mov    0x14(%ebx),%eax
  100fcc:	89 74 24 04          	mov    %esi,0x4(%esp)
  100fd0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100fd4:	8b 43 10             	mov    0x10(%ebx),%eax
  100fd7:	89 04 24             	mov    %eax,(%esp)
  100fda:	e8 71 09 00 00       	call   101950 <readi>
  100fdf:	85 c0                	test   %eax,%eax
  100fe1:	7e 03                	jle    100fe6 <fileread+0x56>
      f->off += r;
  100fe3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100fe6:	8b 53 10             	mov    0x10(%ebx),%edx
  100fe9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100fec:	89 14 24             	mov    %edx,(%esp)
  100fef:	e8 1c 06 00 00       	call   101610 <iunlock>
    return r;
  100ff4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
  100ff7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100ffa:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100ffd:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101000:	89 ec                	mov    %ebp,%esp
  101002:	5d                   	pop    %ebp
  101003:	c3                   	ret    
  101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101008:	8b 5d f4             	mov    -0xc(%ebp),%ebx
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
  10100b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  101010:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101013:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101016:	89 ec                	mov    %ebp,%esp
  101018:	5d                   	pop    %ebp
  101019:	c3                   	ret    
  10101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  101020:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  101023:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101026:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101029:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  10102c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  10102f:	89 ec                	mov    %ebp,%esp
  101031:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  101032:	e9 39 20 00 00       	jmp    103070 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  101037:	c7 04 24 a7 60 10 00 	movl   $0x1060a7,(%esp)
  10103e:	e8 bd f8 ff ff       	call   100900 <panic>
  101043:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101050 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  101050:	55                   	push   %ebp
  101051:	89 e5                	mov    %esp,%ebp
  101053:	83 ec 38             	sub    $0x38,%esp
  101056:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101059:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10105c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10105f:	8b 75 0c             	mov    0xc(%ebp),%esi
  101062:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101065:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->writable == 0)
  101068:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  10106c:	74 5a                	je     1010c8 <filewrite+0x78>
    return -1;
  if(f->type == FD_PIPE)
  10106e:	8b 03                	mov    (%ebx),%eax
  101070:	83 f8 02             	cmp    $0x2,%eax
  101073:	74 6b                	je     1010e0 <filewrite+0x90>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  101075:	83 f8 03             	cmp    $0x3,%eax
  101078:	75 7d                	jne    1010f7 <filewrite+0xa7>
    ilock(f->ip);
  10107a:	8b 43 10             	mov    0x10(%ebx),%eax
  10107d:	89 04 24             	mov    %eax,(%esp)
  101080:	e8 7b 04 00 00       	call   101500 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  101085:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  101089:	8b 43 14             	mov    0x14(%ebx),%eax
  10108c:	89 74 24 04          	mov    %esi,0x4(%esp)
  101090:	89 44 24 08          	mov    %eax,0x8(%esp)
  101094:	8b 43 10             	mov    0x10(%ebx),%eax
  101097:	89 04 24             	mov    %eax,(%esp)
  10109a:	e8 d1 09 00 00       	call   101a70 <writei>
  10109f:	85 c0                	test   %eax,%eax
  1010a1:	7e 03                	jle    1010a6 <filewrite+0x56>
      f->off += r;
  1010a3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  1010a6:	8b 53 10             	mov    0x10(%ebx),%edx
  1010a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1010ac:	89 14 24             	mov    %edx,(%esp)
  1010af:	e8 5c 05 00 00       	call   101610 <iunlock>
    return r;
  1010b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("filewrite");
}
  1010b7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1010ba:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1010bd:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1010c0:	89 ec                	mov    %ebp,%esp
  1010c2:	5d                   	pop    %ebp
  1010c3:	c3                   	ret    
  1010c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1010c8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
  1010cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  1010d0:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1010d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1010d6:	89 ec                	mov    %ebp,%esp
  1010d8:	5d                   	pop    %ebp
  1010d9:	c3                   	ret    
  1010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1010e0:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  1010e3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1010e6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1010e9:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1010ec:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  1010ef:	89 ec                	mov    %ebp,%esp
  1010f1:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1010f2:	e9 69 1e 00 00       	jmp    102f60 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  1010f7:	c7 04 24 b0 60 10 00 	movl   $0x1060b0,(%esp)
  1010fe:	e8 fd f7 ff ff       	call   100900 <panic>
  101103:	90                   	nop
  101104:	90                   	nop
  101105:	90                   	nop
  101106:	90                   	nop
  101107:	90                   	nop
  101108:	90                   	nop
  101109:	90                   	nop
  10110a:	90                   	nop
  10110b:	90                   	nop
  10110c:	90                   	nop
  10110d:	90                   	nop
  10110e:	90                   	nop
  10110f:	90                   	nop

00101110 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101110:	55                   	push   %ebp
  101111:	89 e5                	mov    %esp,%ebp
  101113:	57                   	push   %edi
  101114:	89 d7                	mov    %edx,%edi
  101116:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  101117:	31 f6                	xor    %esi,%esi

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101119:	53                   	push   %ebx
  10111a:	89 c3                	mov    %eax,%ebx
  10111c:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
  10111f:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  101126:	e8 c5 2d 00 00       	call   103ef0 <acquire>

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10112b:	b8 d4 9a 10 00       	mov    $0x109ad4,%eax
  101130:	eb 14                	jmp    101146 <iget+0x36>
  101132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101138:	85 f6                	test   %esi,%esi
  10113a:	74 3c                	je     101178 <iget+0x68>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10113c:	83 c0 50             	add    $0x50,%eax
  10113f:	3d 74 aa 10 00       	cmp    $0x10aa74,%eax
  101144:	74 42                	je     101188 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  101146:	8b 48 08             	mov    0x8(%eax),%ecx
  101149:	85 c9                	test   %ecx,%ecx
  10114b:	7e eb                	jle    101138 <iget+0x28>
  10114d:	39 18                	cmp    %ebx,(%eax)
  10114f:	75 e7                	jne    101138 <iget+0x28>
  101151:	39 78 04             	cmp    %edi,0x4(%eax)
  101154:	75 e2                	jne    101138 <iget+0x28>
      ip->ref++;
  101156:	83 c1 01             	add    $0x1,%ecx
  101159:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
  10115c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10115f:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  101166:	e8 75 2e 00 00       	call   103fe0 <release>
      return ip;
  10116b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  10116e:	83 c4 2c             	add    $0x2c,%esp
  101171:	5b                   	pop    %ebx
  101172:	5e                   	pop    %esi
  101173:	5f                   	pop    %edi
  101174:	5d                   	pop    %ebp
  101175:	c3                   	ret    
  101176:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101178:	85 c9                	test   %ecx,%ecx
  10117a:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10117d:	83 c0 50             	add    $0x50,%eax
  101180:	3d 74 aa 10 00       	cmp    $0x10aa74,%eax
  101185:	75 bf                	jne    101146 <iget+0x36>
  101187:	90                   	nop
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101188:	85 f6                	test   %esi,%esi
  10118a:	74 29                	je     1011b5 <iget+0xa5>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  10118c:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
  10118e:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
  101191:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  101198:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  10119f:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  1011a6:	e8 35 2e 00 00       	call   103fe0 <release>

  return ip;
}
  1011ab:	83 c4 2c             	add    $0x2c,%esp
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
  1011ae:	89 f0                	mov    %esi,%eax
}
  1011b0:	5b                   	pop    %ebx
  1011b1:	5e                   	pop    %esi
  1011b2:	5f                   	pop    %edi
  1011b3:	5d                   	pop    %ebp
  1011b4:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  1011b5:	c7 04 24 ba 60 10 00 	movl   $0x1060ba,(%esp)
  1011bc:	e8 3f f7 ff ff       	call   100900 <panic>
  1011c1:	eb 0d                	jmp    1011d0 <readsb>
  1011c3:	90                   	nop
  1011c4:	90                   	nop
  1011c5:	90                   	nop
  1011c6:	90                   	nop
  1011c7:	90                   	nop
  1011c8:	90                   	nop
  1011c9:	90                   	nop
  1011ca:	90                   	nop
  1011cb:	90                   	nop
  1011cc:	90                   	nop
  1011cd:	90                   	nop
  1011ce:	90                   	nop
  1011cf:	90                   	nop

001011d0 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1011d0:	55                   	push   %ebp
  1011d1:	89 e5                	mov    %esp,%ebp
  1011d3:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  1011d6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1011dd:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1011de:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1011e1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  1011e4:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  1011e6:	89 04 24             	mov    %eax,(%esp)
  1011e9:	e8 72 ee ff ff       	call   100060 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  1011ee:	89 34 24             	mov    %esi,(%esp)
  1011f1:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  1011f8:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  1011f9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  1011fb:	8d 40 18             	lea    0x18(%eax),%eax
  1011fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  101202:	e8 a9 2e 00 00       	call   1040b0 <memmove>
  brelse(bp);
  101207:	89 1c 24             	mov    %ebx,(%esp)
  10120a:	e8 61 ef ff ff       	call   100170 <brelse>
}
  10120f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  101212:	8b 75 fc             	mov    -0x4(%ebp),%esi
  101215:	89 ec                	mov    %ebp,%esp
  101217:	5d                   	pop    %ebp
  101218:	c3                   	ret    
  101219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101220 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  101220:	55                   	push   %ebp
  101221:	89 e5                	mov    %esp,%ebp
  101223:	57                   	push   %edi
  101224:	56                   	push   %esi
  101225:	53                   	push   %ebx
  101226:	83 ec 3c             	sub    $0x3c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  101229:	8d 55 dc             	lea    -0x24(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  10122c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  10122f:	e8 9c ff ff ff       	call   1011d0 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  101234:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101237:	85 c0                	test   %eax,%eax
  101239:	0f 84 9c 00 00 00    	je     1012db <balloc+0xbb>
  10123f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  101246:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for(bi = 0; bi < BPB; bi++){
  101249:	31 db                	xor    %ebx,%ebx
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  10124b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10124e:	c1 e8 03             	shr    $0x3,%eax
  101251:	c1 fa 0c             	sar    $0xc,%edx
  101254:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101258:	89 44 24 04          	mov    %eax,0x4(%esp)
  10125c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10125f:	89 04 24             	mov    %eax,(%esp)
  101262:	e8 f9 ed ff ff       	call   100060 <bread>
  101267:	89 c6                	mov    %eax,%esi
  101269:	eb 10                	jmp    10127b <balloc+0x5b>
  10126b:	90                   	nop
  10126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB; bi++){
  101270:	83 c3 01             	add    $0x1,%ebx
  101273:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  101279:	74 45                	je     1012c0 <balloc+0xa0>
      m = 1 << (bi % 8);
  10127b:	89 d9                	mov    %ebx,%ecx
  10127d:	b8 01 00 00 00       	mov    $0x1,%eax
  101282:	83 e1 07             	and    $0x7,%ecx
  101285:	d3 e0                	shl    %cl,%eax
  101287:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101289:	89 d8                	mov    %ebx,%eax
  10128b:	c1 f8 03             	sar    $0x3,%eax
  10128e:	0f b6 54 06 18       	movzbl 0x18(%esi,%eax,1),%edx
  101293:	0f b6 fa             	movzbl %dl,%edi
  101296:	85 cf                	test   %ecx,%edi
  101298:	75 d6                	jne    101270 <balloc+0x50>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  10129a:	09 d1                	or     %edx,%ecx
  10129c:	88 4c 06 18          	mov    %cl,0x18(%esi,%eax,1)
        bwrite(bp);
  1012a0:	89 34 24             	mov    %esi,(%esp)
  1012a3:	e8 98 ee ff ff       	call   100140 <bwrite>
        brelse(bp);
  1012a8:	89 34 24             	mov    %esi,(%esp)
  1012ab:	e8 c0 ee ff ff       	call   100170 <brelse>
        return b + bi;
  1012b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  1012b3:	83 c4 3c             	add    $0x3c,%esp
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
        return b + bi;
  1012b6:	01 d8                	add    %ebx,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  1012b8:	5b                   	pop    %ebx
  1012b9:	5e                   	pop    %esi
  1012ba:	5f                   	pop    %edi
  1012bb:	5d                   	pop    %ebp
  1012bc:	c3                   	ret    
  1012bd:	8d 76 00             	lea    0x0(%esi),%esi
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  1012c0:	89 34 24             	mov    %esi,(%esp)
  1012c3:	e8 a8 ee ff ff       	call   100170 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  1012c8:	81 45 d4 00 10 00 00 	addl   $0x1000,-0x2c(%ebp)
  1012cf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1012d2:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  1012d5:	0f 87 6b ff ff ff    	ja     101246 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  1012db:	c7 04 24 ca 60 10 00 	movl   $0x1060ca,(%esp)
  1012e2:	e8 19 f6 ff ff       	call   100900 <panic>
  1012e7:	89 f6                	mov    %esi,%esi
  1012e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  1012f0:	55                   	push   %ebp
  1012f1:	89 e5                	mov    %esp,%ebp
  1012f3:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1012f6:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  1012f9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1012fc:	89 c3                	mov    %eax,%ebx
  1012fe:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101301:	89 ce                	mov    %ecx,%esi
  101303:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101306:	77 28                	ja     101330 <bmap+0x40>
    if((addr = ip->addrs[bn]) == 0){
  101308:	8d 7a 04             	lea    0x4(%edx),%edi
  10130b:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
  10130f:	85 c0                	test   %eax,%eax
  101311:	75 09                	jne    10131c <bmap+0x2c>
      if(!alloc)
  101313:	85 c9                	test   %ecx,%ecx
        return -1;
  101315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0){
      if(!alloc)
  10131a:	75 74                	jne    101390 <bmap+0xa0>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  10131c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10131f:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101322:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101325:	89 ec                	mov    %ebp,%esp
  101327:	5d                   	pop    %ebp
  101328:	c3                   	ret    
  101329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
    }
    return addr;
  }
  bn -= NDIRECT;
  101330:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
  101333:	83 ff 7f             	cmp    $0x7f,%edi
  101336:	0f 87 a7 00 00 00    	ja     1013e3 <bmap+0xf3>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
  10133c:	8b 40 4c             	mov    0x4c(%eax),%eax
  10133f:	85 c0                	test   %eax,%eax
  101341:	75 13                	jne    101356 <bmap+0x66>
      if(!alloc)
  101343:	85 c9                	test   %ecx,%ecx
        return -1;
  101345:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
  10134a:	74 d0                	je     10131c <bmap+0x2c>
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
  10134c:	8b 03                	mov    (%ebx),%eax
  10134e:	e8 cd fe ff ff       	call   101220 <balloc>
  101353:	89 43 4c             	mov    %eax,0x4c(%ebx)
    }
    bp = bread(ip->dev, addr);
  101356:	89 44 24 04          	mov    %eax,0x4(%esp)
  10135a:	8b 03                	mov    (%ebx),%eax
  10135c:	89 04 24             	mov    %eax,(%esp)
  10135f:	e8 fc ec ff ff       	call   100060 <bread>
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101364:	8d 7c b8 18          	lea    0x18(%eax,%edi,4),%edi
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
    }
    bp = bread(ip->dev, addr);
  101368:	89 c2                	mov    %eax,%edx
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  10136a:	8b 07                	mov    (%edi),%eax
  10136c:	85 c0                	test   %eax,%eax
  10136e:	75 58                	jne    1013c8 <bmap+0xd8>
      if(!alloc){
  101370:	85 f6                	test   %esi,%esi
  101372:	75 34                	jne    1013a8 <bmap+0xb8>
        brelse(bp);
  101374:	89 14 24             	mov    %edx,(%esp)
  101377:	e8 f4 ed ff ff       	call   100170 <brelse>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  10137c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
      if(!alloc){
        brelse(bp);
        return -1;
  10137f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  101384:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101387:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10138a:	89 ec                	mov    %ebp,%esp
  10138c:	5d                   	pop    %ebp
  10138d:	c3                   	ret    
  10138e:	66 90                	xchg   %ax,%ax

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
  101390:	8b 03                	mov    (%ebx),%eax
  101392:	e8 89 fe ff ff       	call   101220 <balloc>
  101397:	89 44 bb 0c          	mov    %eax,0xc(%ebx,%edi,4)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  10139b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10139e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013a1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1013a4:	89 ec                	mov    %ebp,%esp
  1013a6:	5d                   	pop    %ebp
  1013a7:	c3                   	ret    
    if((addr = a[bn]) == 0){
      if(!alloc){
        brelse(bp);
        return -1;
      }
      a[bn] = addr = balloc(ip->dev);
  1013a8:	8b 03                	mov    (%ebx),%eax
  1013aa:	89 55 e0             	mov    %edx,-0x20(%ebp)
  1013ad:	e8 6e fe ff ff       	call   101220 <balloc>
      bwrite(bp);
  1013b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    if((addr = a[bn]) == 0){
      if(!alloc){
        brelse(bp);
        return -1;
      }
      a[bn] = addr = balloc(ip->dev);
  1013b5:	89 07                	mov    %eax,(%edi)
      bwrite(bp);
  1013b7:	89 14 24             	mov    %edx,(%esp)
  1013ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1013bd:	e8 7e ed ff ff       	call   100140 <bwrite>
  1013c2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1013c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
  1013c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1013cb:	89 14 24             	mov    %edx,(%esp)
  1013ce:	e8 9d ed ff ff       	call   100170 <brelse>
    return addr;
  1013d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }

  panic("bmap: out of range");
}
  1013d6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1013d9:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013dc:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1013df:	89 ec                	mov    %ebp,%esp
  1013e1:	5d                   	pop    %ebp
  1013e2:	c3                   	ret    
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  1013e3:	c7 04 24 e0 60 10 00 	movl   $0x1060e0,(%esp)
  1013ea:	e8 11 f5 ff ff       	call   100900 <panic>
  1013ef:	90                   	nop

001013f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  1013f0:	55                   	push   %ebp
  1013f1:	89 e5                	mov    %esp,%ebp
  1013f3:	57                   	push   %edi
  1013f4:	56                   	push   %esi
  1013f5:	89 c6                	mov    %eax,%esi
  1013f7:	53                   	push   %ebx
  1013f8:	89 d3                	mov    %edx,%ebx
  1013fa:	83 ec 2c             	sub    $0x2c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1013fd:	89 54 24 04          	mov    %edx,0x4(%esp)
  101401:	89 04 24             	mov    %eax,(%esp)
  101404:	e8 57 ec ff ff       	call   100060 <bread>
  memset(bp->data, 0, BSIZE);
  101409:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  101410:	00 
  101411:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101418:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  101419:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  10141b:	8d 40 18             	lea    0x18(%eax),%eax
  10141e:	89 04 24             	mov    %eax,(%esp)
  101421:	e8 fa 2b 00 00       	call   104020 <memset>
  bwrite(bp);
  101426:	89 3c 24             	mov    %edi,(%esp)
  101429:	e8 12 ed ff ff       	call   100140 <bwrite>
  brelse(bp);
  10142e:	89 3c 24             	mov    %edi,(%esp)
  101431:	e8 3a ed ff ff       	call   100170 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  101436:	89 f0                	mov    %esi,%eax
  101438:	8d 55 dc             	lea    -0x24(%ebp),%edx
  10143b:	e8 90 fd ff ff       	call   1011d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101440:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101443:	89 da                	mov    %ebx,%edx
  101445:	c1 ea 0c             	shr    $0xc,%edx
  101448:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  10144b:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101450:	c1 e8 03             	shr    $0x3,%eax
  101453:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101457:	89 44 24 04          	mov    %eax,0x4(%esp)
  10145b:	e8 00 ec ff ff       	call   100060 <bread>
  bi = b % BPB;
  101460:	89 da                	mov    %ebx,%edx
  m = 1 << (bi % 8);
  101462:	89 d9                	mov    %ebx,%ecx

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  101464:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
  10146a:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  10146d:	c1 fa 03             	sar    $0x3,%edx
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  101470:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  101472:	0f b6 4c 10 18       	movzbl 0x18(%eax,%edx,1),%ecx
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101477:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  101479:	0f b6 c1             	movzbl %cl,%eax
  10147c:	85 f0                	test   %esi,%eax
  10147e:	74 22                	je     1014a2 <bfree+0xb2>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101480:	89 f0                	mov    %esi,%eax
  101482:	f7 d0                	not    %eax
  101484:	21 c8                	and    %ecx,%eax
  101486:	88 44 17 18          	mov    %al,0x18(%edi,%edx,1)
  bwrite(bp);
  10148a:	89 3c 24             	mov    %edi,(%esp)
  10148d:	e8 ae ec ff ff       	call   100140 <bwrite>
  brelse(bp);
  101492:	89 3c 24             	mov    %edi,(%esp)
  101495:	e8 d6 ec ff ff       	call   100170 <brelse>
}
  10149a:	83 c4 2c             	add    $0x2c,%esp
  10149d:	5b                   	pop    %ebx
  10149e:	5e                   	pop    %esi
  10149f:	5f                   	pop    %edi
  1014a0:	5d                   	pop    %ebp
  1014a1:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  1014a2:	c7 04 24 f3 60 10 00 	movl   $0x1060f3,(%esp)
  1014a9:	e8 52 f4 ff ff       	call   100900 <panic>
  1014ae:	66 90                	xchg   %ax,%ax

001014b0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  1014b0:	55                   	push   %ebp
  1014b1:	89 e5                	mov    %esp,%ebp
  1014b3:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache.lock");
  1014b6:	c7 44 24 04 06 61 10 	movl   $0x106106,0x4(%esp)
  1014bd:	00 
  1014be:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  1014c5:	e8 26 29 00 00       	call   103df0 <initlock>
}
  1014ca:	c9                   	leave  
  1014cb:	c3                   	ret    
  1014cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001014d0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  1014d0:	55                   	push   %ebp
  1014d1:	89 e5                	mov    %esp,%ebp
  1014d3:	53                   	push   %ebx
  1014d4:	83 ec 14             	sub    $0x14,%esp
  1014d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  1014da:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  1014e1:	e8 0a 2a 00 00       	call   103ef0 <acquire>
  ip->ref++;
  1014e6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  1014ea:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  1014f1:	e8 ea 2a 00 00       	call   103fe0 <release>
  return ip;
}
  1014f6:	89 d8                	mov    %ebx,%eax
  1014f8:	83 c4 14             	add    $0x14,%esp
  1014fb:	5b                   	pop    %ebx
  1014fc:	5d                   	pop    %ebp
  1014fd:	c3                   	ret    
  1014fe:	66 90                	xchg   %ax,%ax

00101500 <ilock>:

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101500:	55                   	push   %ebp
  101501:	89 e5                	mov    %esp,%ebp
  101503:	56                   	push   %esi
  101504:	53                   	push   %ebx
  101505:	83 ec 10             	sub    $0x10,%esp
  101508:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  10150b:	85 db                	test   %ebx,%ebx
  10150d:	0f 84 e5 00 00 00    	je     1015f8 <ilock+0xf8>
  101513:	8b 53 08             	mov    0x8(%ebx),%edx
  101516:	85 d2                	test   %edx,%edx
  101518:	0f 8e da 00 00 00    	jle    1015f8 <ilock+0xf8>
    panic("ilock");

  acquire(&icache.lock);
  10151e:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  101525:	e8 c6 29 00 00       	call   103ef0 <acquire>
  while(ip->flags & I_BUSY)
  10152a:	8b 43 0c             	mov    0xc(%ebx),%eax
  10152d:	a8 01                	test   $0x1,%al
  10152f:	74 1e                	je     10154f <ilock+0x4f>
  101531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101538:	c7 44 24 04 a0 9a 10 	movl   $0x109aa0,0x4(%esp)
  10153f:	00 
  101540:	89 1c 24             	mov    %ebx,(%esp)
  101543:	e8 98 23 00 00       	call   1038e0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101548:	8b 43 0c             	mov    0xc(%ebx),%eax
  10154b:	a8 01                	test   $0x1,%al
  10154d:	75 e9                	jne    101538 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  10154f:	83 c8 01             	or     $0x1,%eax
  101552:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  101555:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  10155c:	e8 7f 2a 00 00       	call   103fe0 <release>

  if(!(ip->flags & I_VALID)){
  101561:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  101565:	74 09                	je     101570 <ilock+0x70>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101567:	83 c4 10             	add    $0x10,%esp
  10156a:	5b                   	pop    %ebx
  10156b:	5e                   	pop    %esi
  10156c:	5d                   	pop    %ebp
  10156d:	c3                   	ret    
  10156e:	66 90                	xchg   %ax,%ax
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101570:	8b 43 04             	mov    0x4(%ebx),%eax
  101573:	c1 e8 03             	shr    $0x3,%eax
  101576:	83 c0 02             	add    $0x2,%eax
  101579:	89 44 24 04          	mov    %eax,0x4(%esp)
  10157d:	8b 03                	mov    (%ebx),%eax
  10157f:	89 04 24             	mov    %eax,(%esp)
  101582:	e8 d9 ea ff ff       	call   100060 <bread>
  101587:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101589:	8b 43 04             	mov    0x4(%ebx),%eax
  10158c:	83 e0 07             	and    $0x7,%eax
  10158f:	c1 e0 06             	shl    $0x6,%eax
  101592:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  101596:	0f b7 10             	movzwl (%eax),%edx
  101599:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  10159d:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  1015a1:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  1015a5:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  1015a9:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  1015ad:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  1015b1:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  1015b5:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1015b8:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  1015bb:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1015be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1015c2:	8d 43 1c             	lea    0x1c(%ebx),%eax
  1015c5:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  1015cc:	00 
  1015cd:	89 04 24             	mov    %eax,(%esp)
  1015d0:	e8 db 2a 00 00       	call   1040b0 <memmove>
    brelse(bp);
  1015d5:	89 34 24             	mov    %esi,(%esp)
  1015d8:	e8 93 eb ff ff       	call   100170 <brelse>
    ip->flags |= I_VALID;
  1015dd:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  1015e1:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  1015e6:	0f 85 7b ff ff ff    	jne    101567 <ilock+0x67>
      panic("ilock: no type");
  1015ec:	c7 04 24 18 61 10 00 	movl   $0x106118,(%esp)
  1015f3:	e8 08 f3 ff ff       	call   100900 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  1015f8:	c7 04 24 12 61 10 00 	movl   $0x106112,(%esp)
  1015ff:	e8 fc f2 ff ff       	call   100900 <panic>
  101604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10160a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101610 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  101610:	55                   	push   %ebp
  101611:	89 e5                	mov    %esp,%ebp
  101613:	53                   	push   %ebx
  101614:	83 ec 14             	sub    $0x14,%esp
  101617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  10161a:	85 db                	test   %ebx,%ebx
  10161c:	74 36                	je     101654 <iunlock+0x44>
  10161e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101622:	74 30                	je     101654 <iunlock+0x44>
  101624:	8b 4b 08             	mov    0x8(%ebx),%ecx
  101627:	85 c9                	test   %ecx,%ecx
  101629:	7e 29                	jle    101654 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
  10162b:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  101632:	e8 b9 28 00 00       	call   103ef0 <acquire>
  ip->flags &= ~I_BUSY;
  101637:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  10163b:	89 1c 24             	mov    %ebx,(%esp)
  10163e:	e8 6d 23 00 00       	call   1039b0 <wakeup>
  release(&icache.lock);
  101643:	c7 45 08 a0 9a 10 00 	movl   $0x109aa0,0x8(%ebp)
}
  10164a:	83 c4 14             	add    $0x14,%esp
  10164d:	5b                   	pop    %ebx
  10164e:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  10164f:	e9 8c 29 00 00       	jmp    103fe0 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101654:	c7 04 24 27 61 10 00 	movl   $0x106127,(%esp)
  10165b:	e8 a0 f2 ff ff       	call   100900 <panic>

00101660 <ialloc>:
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101660:	55                   	push   %ebp
  101661:	89 e5                	mov    %esp,%ebp
  101663:	57                   	push   %edi
  101664:	56                   	push   %esi
  101665:	53                   	push   %ebx
  101666:	83 ec 3c             	sub    $0x3c,%esp
  101669:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  10166d:	8d 55 dc             	lea    -0x24(%ebp),%edx
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101670:	66 89 45 d6          	mov    %ax,-0x2a(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101674:	8b 45 08             	mov    0x8(%ebp),%eax
  101677:	e8 54 fb ff ff       	call   1011d0 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10167c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  101680:	0f 86 96 00 00 00    	jbe    10171c <ialloc+0xbc>
  101686:	be 01 00 00 00       	mov    $0x1,%esi
  10168b:	bb 01 00 00 00       	mov    $0x1,%ebx
  101690:	eb 18                	jmp    1016aa <ialloc+0x4a>
  101692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101698:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  10169b:	89 3c 24             	mov    %edi,(%esp)
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10169e:	89 de                	mov    %ebx,%esi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  1016a0:	e8 cb ea ff ff       	call   100170 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1016a5:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  1016a8:	76 72                	jbe    10171c <ialloc+0xbc>
    bp = bread(dev, IBLOCK(inum));
  1016aa:	89 f0                	mov    %esi,%eax
  1016ac:	c1 e8 03             	shr    $0x3,%eax
  1016af:	83 c0 02             	add    $0x2,%eax
  1016b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1016b9:	89 04 24             	mov    %eax,(%esp)
  1016bc:	e8 9f e9 ff ff       	call   100060 <bread>
  1016c1:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
  1016c3:	89 f0                	mov    %esi,%eax
  1016c5:	83 e0 07             	and    $0x7,%eax
  1016c8:	c1 e0 06             	shl    $0x6,%eax
  1016cb:	8d 54 07 18          	lea    0x18(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  1016cf:	66 83 3a 00          	cmpw   $0x0,(%edx)
  1016d3:	75 c3                	jne    101698 <ialloc+0x38>
      memset(dip, 0, sizeof(*dip));
  1016d5:	89 14 24             	mov    %edx,(%esp)
  1016d8:	89 55 d0             	mov    %edx,-0x30(%ebp)
  1016db:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  1016e2:	00 
  1016e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1016ea:	00 
  1016eb:	e8 30 29 00 00       	call   104020 <memset>
      dip->type = type;
  1016f0:	8b 55 d0             	mov    -0x30(%ebp),%edx
  1016f3:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  1016f7:	66 89 02             	mov    %ax,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  1016fa:	89 3c 24             	mov    %edi,(%esp)
  1016fd:	e8 3e ea ff ff       	call   100140 <bwrite>
      brelse(bp);
  101702:	89 3c 24             	mov    %edi,(%esp)
  101705:	e8 66 ea ff ff       	call   100170 <brelse>
      return iget(dev, inum);
  10170a:	8b 45 08             	mov    0x8(%ebp),%eax
  10170d:	89 f2                	mov    %esi,%edx
  10170f:	e8 fc f9 ff ff       	call   101110 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  101714:	83 c4 3c             	add    $0x3c,%esp
  101717:	5b                   	pop    %ebx
  101718:	5e                   	pop    %esi
  101719:	5f                   	pop    %edi
  10171a:	5d                   	pop    %ebp
  10171b:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  10171c:	c7 04 24 2f 61 10 00 	movl   $0x10612f,(%esp)
  101723:	e8 d8 f1 ff ff       	call   100900 <panic>
  101728:	90                   	nop
  101729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101730 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101730:	55                   	push   %ebp
  101731:	89 e5                	mov    %esp,%ebp
  101733:	56                   	push   %esi
  101734:	53                   	push   %ebx
  101735:	83 ec 10             	sub    $0x10,%esp
  101738:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10173b:	8b 43 04             	mov    0x4(%ebx),%eax
  10173e:	c1 e8 03             	shr    $0x3,%eax
  101741:	83 c0 02             	add    $0x2,%eax
  101744:	89 44 24 04          	mov    %eax,0x4(%esp)
  101748:	8b 03                	mov    (%ebx),%eax
  10174a:	89 04 24             	mov    %eax,(%esp)
  10174d:	e8 0e e9 ff ff       	call   100060 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  101752:	0f b7 53 10          	movzwl 0x10(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  101756:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101758:	8b 43 04             	mov    0x4(%ebx),%eax
  10175b:	83 e0 07             	and    $0x7,%eax
  10175e:	c1 e0 06             	shl    $0x6,%eax
  101761:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  101765:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  101768:	0f b7 53 12          	movzwl 0x12(%ebx),%edx
  10176c:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  101770:	0f b7 53 14          	movzwl 0x14(%ebx),%edx
  101774:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  101778:	0f b7 53 16          	movzwl 0x16(%ebx),%edx
  10177c:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  101780:	8b 53 18             	mov    0x18(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101783:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  101786:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101789:	83 c0 0c             	add    $0xc,%eax
  10178c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101790:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101797:	00 
  101798:	89 04 24             	mov    %eax,(%esp)
  10179b:	e8 10 29 00 00       	call   1040b0 <memmove>
  bwrite(bp);
  1017a0:	89 34 24             	mov    %esi,(%esp)
  1017a3:	e8 98 e9 ff ff       	call   100140 <bwrite>
  brelse(bp);
  1017a8:	89 75 08             	mov    %esi,0x8(%ebp)
}
  1017ab:	83 c4 10             	add    $0x10,%esp
  1017ae:	5b                   	pop    %ebx
  1017af:	5e                   	pop    %esi
  1017b0:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  1017b1:	e9 ba e9 ff ff       	jmp    100170 <brelse>
  1017b6:	8d 76 00             	lea    0x0(%esi),%esi
  1017b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001017c0 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  1017c0:	55                   	push   %ebp
  1017c1:	89 e5                	mov    %esp,%ebp
  1017c3:	57                   	push   %edi
  1017c4:	56                   	push   %esi
  1017c5:	53                   	push   %ebx
  1017c6:	83 ec 2c             	sub    $0x2c,%esp
  1017c9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  1017cc:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  1017d3:	e8 18 27 00 00       	call   103ef0 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  1017d8:	8b 46 08             	mov    0x8(%esi),%eax
  1017db:	83 f8 01             	cmp    $0x1,%eax
  1017de:	0f 85 9e 00 00 00    	jne    101882 <iput+0xc2>
  1017e4:	8b 56 0c             	mov    0xc(%esi),%edx
  1017e7:	f6 c2 02             	test   $0x2,%dl
  1017ea:	0f 84 92 00 00 00    	je     101882 <iput+0xc2>
  1017f0:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  1017f5:	0f 85 87 00 00 00    	jne    101882 <iput+0xc2>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  1017fb:	f6 c2 01             	test   $0x1,%dl
  1017fe:	0f 85 f0 00 00 00    	jne    1018f4 <iput+0x134>
      panic("iput busy");
    ip->flags |= I_BUSY;
  101804:	83 ca 01             	or     $0x1,%edx
    release(&icache.lock);
  101807:	89 f3                	mov    %esi,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  101809:	89 56 0c             	mov    %edx,0xc(%esi)
  release(&icache.lock);
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
  10180c:	8d 7e 30             	lea    0x30(%esi),%edi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
  10180f:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  101816:	e8 c5 27 00 00       	call   103fe0 <release>
  10181b:	eb 0a                	jmp    101827 <iput+0x67>
  10181d:	8d 76 00             	lea    0x0(%esi),%esi
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
  101820:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101823:	39 fb                	cmp    %edi,%ebx
  101825:	74 1c                	je     101843 <iput+0x83>
    if(ip->addrs[i]){
  101827:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10182a:	85 d2                	test   %edx,%edx
  10182c:	74 f2                	je     101820 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
  10182e:	8b 06                	mov    (%esi),%eax
  101830:	e8 bb fb ff ff       	call   1013f0 <bfree>
      ip->addrs[i] = 0;
  101835:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  10183c:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  10183f:	39 fb                	cmp    %edi,%ebx
  101841:	75 e4                	jne    101827 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
  101843:	8b 46 4c             	mov    0x4c(%esi),%eax
  101846:	85 c0                	test   %eax,%eax
  101848:	75 56                	jne    1018a0 <iput+0xe0>
    }
    brelse(bp);
    ip->addrs[INDIRECT] = 0;
  }

  ip->size = 0;
  10184a:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  101851:	89 34 24             	mov    %esi,(%esp)
  101854:	e8 d7 fe ff ff       	call   101730 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101859:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  10185f:	89 34 24             	mov    %esi,(%esp)
  101862:	e8 c9 fe ff ff       	call   101730 <iupdate>
    acquire(&icache.lock);
  101867:	c7 04 24 a0 9a 10 00 	movl   $0x109aa0,(%esp)
  10186e:	e8 7d 26 00 00       	call   103ef0 <acquire>
    ip->flags &= ~I_BUSY;
  101873:	83 66 0c fe          	andl   $0xfffffffe,0xc(%esi)
    wakeup(ip);
  101877:	89 34 24             	mov    %esi,(%esp)
  10187a:	e8 31 21 00 00       	call   1039b0 <wakeup>
  10187f:	8b 46 08             	mov    0x8(%esi),%eax
  }
  ip->ref--;
  101882:	83 e8 01             	sub    $0x1,%eax
  101885:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  101888:	c7 45 08 a0 9a 10 00 	movl   $0x109aa0,0x8(%ebp)
}
  10188f:	83 c4 2c             	add    $0x2c,%esp
  101892:	5b                   	pop    %ebx
  101893:	5e                   	pop    %esi
  101894:	5f                   	pop    %edi
  101895:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags &= ~I_BUSY;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101896:	e9 45 27 00 00       	jmp    103fe0 <release>
  10189b:	90                   	nop
  10189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  1018a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018a4:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
  1018a6:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  1018a8:	89 04 24             	mov    %eax,(%esp)
  1018ab:	e8 b0 e7 ff ff       	call   100060 <bread>
    a = (uint*)bp->data;
  1018b0:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  1018b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
  1018b5:	83 c7 18             	add    $0x18,%edi
    for(j = 0; j < NINDIRECT; j++){
  1018b8:	31 c0                	xor    %eax,%eax
  1018ba:	eb 11                	jmp    1018cd <iput+0x10d>
  1018bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1018c0:	83 c3 01             	add    $0x1,%ebx
  1018c3:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  1018c9:	89 d8                	mov    %ebx,%eax
  1018cb:	74 10                	je     1018dd <iput+0x11d>
      if(a[j])
  1018cd:	8b 14 87             	mov    (%edi,%eax,4),%edx
  1018d0:	85 d2                	test   %edx,%edx
  1018d2:	74 ec                	je     1018c0 <iput+0x100>
        bfree(ip->dev, a[j]);
  1018d4:	8b 06                	mov    (%esi),%eax
  1018d6:	e8 15 fb ff ff       	call   1013f0 <bfree>
  1018db:	eb e3                	jmp    1018c0 <iput+0x100>
    }
    brelse(bp);
  1018dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1018e0:	89 04 24             	mov    %eax,(%esp)
  1018e3:	e8 88 e8 ff ff       	call   100170 <brelse>
    ip->addrs[INDIRECT] = 0;
  1018e8:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  1018ef:	e9 56 ff ff ff       	jmp    10184a <iput+0x8a>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  1018f4:	c7 04 24 41 61 10 00 	movl   $0x106141,(%esp)
  1018fb:	e8 00 f0 ff ff       	call   100900 <panic>

00101900 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101900:	55                   	push   %ebp
  101901:	89 e5                	mov    %esp,%ebp
  101903:	53                   	push   %ebx
  101904:	83 ec 14             	sub    $0x14,%esp
  101907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  10190a:	89 1c 24             	mov    %ebx,(%esp)
  10190d:	e8 fe fc ff ff       	call   101610 <iunlock>
  iput(ip);
  101912:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101915:	83 c4 14             	add    $0x14,%esp
  101918:	5b                   	pop    %ebx
  101919:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  10191a:	e9 a1 fe ff ff       	jmp    1017c0 <iput>
  10191f:	90                   	nop

00101920 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  101920:	55                   	push   %ebp
  101921:	89 e5                	mov    %esp,%ebp
  101923:	8b 55 08             	mov    0x8(%ebp),%edx
  101926:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
  101929:	8b 0a                	mov    (%edx),%ecx
  10192b:	89 08                	mov    %ecx,(%eax)
  st->ino = ip->inum;
  10192d:	8b 4a 04             	mov    0x4(%edx),%ecx
  101930:	89 48 04             	mov    %ecx,0x4(%eax)
  st->type = ip->type;
  101933:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  101937:	66 89 48 08          	mov    %cx,0x8(%eax)
  st->nlink = ip->nlink;
  10193b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  st->size = ip->size;
  10193f:	8b 52 18             	mov    0x18(%edx),%edx
stati(struct inode *ip, struct stat *st)
{
  st->dev = ip->dev;
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  101942:	66 89 48 0a          	mov    %cx,0xa(%eax)
  st->size = ip->size;
  101946:	89 50 0c             	mov    %edx,0xc(%eax)
}
  101949:	5d                   	pop    %ebp
  10194a:	c3                   	ret    
  10194b:	90                   	nop
  10194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101950 <readi>:

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101950:	55                   	push   %ebp
  101951:	89 e5                	mov    %esp,%ebp
  101953:	83 ec 38             	sub    $0x38,%esp
  101956:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101959:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10195c:	8b 45 14             	mov    0x14(%ebp),%eax
  10195f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101962:	8b 75 10             	mov    0x10(%ebp),%esi
  101965:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101968:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10196b:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101970:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101973:	74 1b                	je     101990 <readi+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  101975:	8b 53 18             	mov    0x18(%ebx),%edx
    return -1;
  101978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  10197d:	39 f2                	cmp    %esi,%edx
  10197f:	73 47                	jae    1019c8 <readi+0x78>
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  101981:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101984:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101987:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10198a:	89 ec                	mov    %ebp,%esp
  10198c:	5d                   	pop    %ebp
  10198d:	c3                   	ret    
  10198e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  101990:	0f b7 53 12          	movzwl 0x12(%ebx),%edx
      return -1;
  101994:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  101999:	66 83 fa 09          	cmp    $0x9,%dx
  10199d:	77 e2                	ja     101981 <readi+0x31>
  10199f:	0f bf d2             	movswl %dx,%edx
  1019a2:	8b 14 d5 40 9a 10 00 	mov    0x109a40(,%edx,8),%edx
  1019a9:	85 d2                	test   %edx,%edx
  1019ab:	74 d4                	je     101981 <readi+0x31>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1019ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1019b0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1019b3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1019b6:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1019b9:	89 45 10             	mov    %eax,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1019bc:	89 ec                	mov    %ebp,%esp
  1019be:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1019bf:	ff e2                	jmp    *%edx
  1019c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  if(off > ip->size || off + n < off)
  1019c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  1019cb:	01 f1                	add    %esi,%ecx
  1019cd:	72 b2                	jb     101981 <readi+0x31>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  1019cf:	89 d0                	mov    %edx,%eax
  1019d1:	29 f0                	sub    %esi,%eax
  1019d3:	39 ca                	cmp    %ecx,%edx
  1019d5:	0f 43 45 e4          	cmovae -0x1c(%ebp),%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019d9:	85 c0                	test   %eax,%eax
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  1019db:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019de:	74 7c                	je     101a5c <readi+0x10c>
  1019e0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  1019e7:	89 7d dc             	mov    %edi,-0x24(%ebp)
  1019ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  1019f0:	89 f2                	mov    %esi,%edx
  1019f2:	31 c9                	xor    %ecx,%ecx
  1019f4:	c1 ea 09             	shr    $0x9,%edx
  1019f7:	89 d8                	mov    %ebx,%eax
  1019f9:	e8 f2 f8 ff ff       	call   1012f0 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  1019fe:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  101a03:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a07:	8b 03                	mov    (%ebx),%eax
  101a09:	89 04 24             	mov    %eax,(%esp)
  101a0c:	e8 4f e6 ff ff       	call   100060 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101a11:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  101a14:	2b 4d e0             	sub    -0x20(%ebp),%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  101a17:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101a19:	89 f0                	mov    %esi,%eax
  101a1b:	25 ff 01 00 00       	and    $0x1ff,%eax
  101a20:	29 c7                	sub    %eax,%edi
    memmove(dst, bp->data + off%BSIZE, m);
  101a22:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  101a26:	39 cf                	cmp    %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
  101a28:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  101a2f:	0f 47 f9             	cmova  %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
  101a32:	89 55 d8             	mov    %edx,-0x28(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101a35:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  101a37:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101a3b:	89 04 24             	mov    %eax,(%esp)
  101a3e:	e8 6d 26 00 00       	call   1040b0 <memmove>
    brelse(bp);
  101a43:	8b 55 d8             	mov    -0x28(%ebp),%edx
  101a46:	89 14 24             	mov    %edx,(%esp)
  101a49:	e8 22 e7 ff ff       	call   100170 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101a4e:	01 7d e0             	add    %edi,-0x20(%ebp)
  101a51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101a54:	01 7d dc             	add    %edi,-0x24(%ebp)
  101a57:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  101a5a:	77 94                	ja     1019f0 <readi+0xa0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101a5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101a5f:	e9 1d ff ff ff       	jmp    101981 <readi+0x31>
  101a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101a70 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101a70:	55                   	push   %ebp
  101a71:	89 e5                	mov    %esp,%ebp
  101a73:	57                   	push   %edi
  101a74:	56                   	push   %esi
  101a75:	53                   	push   %ebx
  101a76:	83 ec 2c             	sub    $0x2c,%esp
  101a79:	8b 75 08             	mov    0x8(%ebp),%esi
  101a7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101a7f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101a82:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101a85:	66 83 7e 10 03       	cmpw   $0x3,0x10(%esi)
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101a8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  101a8d:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101a90:	0f 84 ca 00 00 00    	je     101b60 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  101a96:	8b 55 dc             	mov    -0x24(%ebp),%edx
    return -1;
  101a99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  101a9e:	01 da                	add    %ebx,%edx
  101aa0:	0f 82 ac 00 00 00    	jb     101b52 <writei+0xe2>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  101aa6:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
  101aac:	76 0a                	jbe    101ab8 <writei+0x48>
    n = MAXFILE*BSIZE - off;
  101aae:	c7 45 dc 00 18 01 00 	movl   $0x11800,-0x24(%ebp)
  101ab5:	29 5d dc             	sub    %ebx,-0x24(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101ab8:	8b 7d dc             	mov    -0x24(%ebp),%edi
  101abb:	85 ff                	test   %edi,%edi
  101abd:	0f 84 8c 00 00 00    	je     101b4f <writei+0xdf>
  101ac3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  101aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101ad0:	89 da                	mov    %ebx,%edx
  101ad2:	b9 01 00 00 00       	mov    $0x1,%ecx
  101ad7:	c1 ea 09             	shr    $0x9,%edx
  101ada:	89 f0                	mov    %esi,%eax
  101adc:	e8 0f f8 ff ff       	call   1012f0 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  101ae1:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aea:	8b 06                	mov    (%esi),%eax
  101aec:	89 04 24             	mov    %eax,(%esp)
  101aef:	e8 6c e5 ff ff       	call   100060 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101af4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101af7:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101afa:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101afc:	89 d8                	mov    %ebx,%eax
  101afe:	25 ff 01 00 00       	and    $0x1ff,%eax
  101b03:	29 c7                	sub    %eax,%edi
  101b05:	39 cf                	cmp    %ecx,%edi
  101b07:	0f 47 f9             	cmova  %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
  101b0a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101b0d:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101b11:	01 fb                	add    %edi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  101b13:	89 55 d8             	mov    %edx,-0x28(%ebp)
  101b16:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101b1a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  101b1e:	89 04 24             	mov    %eax,(%esp)
  101b21:	e8 8a 25 00 00       	call   1040b0 <memmove>
    bwrite(bp);
  101b26:	8b 55 d8             	mov    -0x28(%ebp),%edx
  101b29:	89 14 24             	mov    %edx,(%esp)
  101b2c:	e8 0f e6 ff ff       	call   100140 <bwrite>
    brelse(bp);
  101b31:	8b 55 d8             	mov    -0x28(%ebp),%edx
  101b34:	89 14 24             	mov    %edx,(%esp)
  101b37:	e8 34 e6 ff ff       	call   100170 <brelse>
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101b3c:	01 7d e4             	add    %edi,-0x1c(%ebp)
  101b3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101b42:	01 7d e0             	add    %edi,-0x20(%ebp)
  101b45:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  101b48:	77 86                	ja     101ad0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  101b4a:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101b4d:	72 41                	jb     101b90 <writei+0x120>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  101b4f:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  101b52:	83 c4 2c             	add    $0x2c,%esp
  101b55:	5b                   	pop    %ebx
  101b56:	5e                   	pop    %esi
  101b57:	5f                   	pop    %edi
  101b58:	5d                   	pop    %ebp
  101b59:	c3                   	ret    
  101b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101b60:	0f b7 56 12          	movzwl 0x12(%esi),%edx
      return -1;
  101b64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101b69:	66 83 fa 09          	cmp    $0x9,%dx
  101b6d:	77 e3                	ja     101b52 <writei+0xe2>
  101b6f:	0f bf d2             	movswl %dx,%edx
  101b72:	8b 14 d5 44 9a 10 00 	mov    0x109a44(,%edx,8),%edx
  101b79:	85 d2                	test   %edx,%edx
  101b7b:	74 d5                	je     101b52 <writei+0xe2>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101b7d:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101b80:	83 c4 2c             	add    $0x2c,%esp
  101b83:	5b                   	pop    %ebx
  101b84:	5e                   	pop    %esi
  101b85:	5f                   	pop    %edi
  101b86:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101b87:	ff e2                	jmp    *%edx
  101b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  101b90:	89 5e 18             	mov    %ebx,0x18(%esi)
    iupdate(ip);
  101b93:	89 34 24             	mov    %esi,(%esp)
  101b96:	e8 95 fb ff ff       	call   101730 <iupdate>
  101b9b:	eb b2                	jmp    101b4f <writei+0xdf>
  101b9d:	8d 76 00             	lea    0x0(%esi),%esi

00101ba0 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101ba0:	55                   	push   %ebp
  101ba1:	89 e5                	mov    %esp,%ebp
  101ba3:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
  101ba9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101bb0:	00 
  101bb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb8:	89 04 24             	mov    %eax,(%esp)
  101bbb:	e8 50 25 00 00       	call   104110 <strncmp>
}
  101bc0:	c9                   	leave  
  101bc1:	c3                   	ret    
  101bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101bd0 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101bd0:	55                   	push   %ebp
  101bd1:	89 e5                	mov    %esp,%ebp
  101bd3:	57                   	push   %edi
  101bd4:	56                   	push   %esi
  101bd5:	53                   	push   %ebx
  101bd6:	83 ec 3c             	sub    $0x3c,%esp
  101bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bdc:	8b 55 10             	mov    0x10(%ebp),%edx
  101bdf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101be2:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101be7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  101bea:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101bed:	0f 85 d0 00 00 00    	jne    101cc3 <dirlookup+0xf3>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101bf3:	8b 50 18             	mov    0x18(%eax),%edx
  101bf6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  101bfd:	85 d2                	test   %edx,%edx
  101bff:	0f 84 b4 00 00 00    	je     101cb9 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
  101c05:	8b 55 e0             	mov    -0x20(%ebp),%edx
  101c08:	31 c9                	xor    %ecx,%ecx
  101c0a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101c0d:	c1 ea 09             	shr    $0x9,%edx
  101c10:	e8 db f6 ff ff       	call   1012f0 <bmap>
  101c15:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101c18:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c1c:	8b 01                	mov    (%ecx),%eax
  101c1e:	89 04 24             	mov    %eax,(%esp)
  101c21:	e8 3a e4 ff ff       	call   100060 <bread>
  101c26:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  101c29:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  101c2c:	83 c0 18             	add    $0x18,%eax
  101c2f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  101c32:	89 c6                	mov    %eax,%esi

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  101c34:	81 c7 18 02 00 00    	add    $0x218,%edi
  101c3a:	eb 0b                	jmp    101c47 <dirlookup+0x77>
  101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
  101c40:	83 c6 10             	add    $0x10,%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  101c43:	39 fe                	cmp    %edi,%esi
  101c45:	74 51                	je     101c98 <dirlookup+0xc8>
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
  101c47:	66 83 3e 00          	cmpw   $0x0,(%esi)
  101c4b:	74 f3                	je     101c40 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  101c4d:	8d 46 02             	lea    0x2(%esi),%eax
  101c50:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c54:	89 1c 24             	mov    %ebx,(%esp)
  101c57:	e8 44 ff ff ff       	call   101ba0 <namecmp>
  101c5c:	85 c0                	test   %eax,%eax
  101c5e:	75 e0                	jne    101c40 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  101c60:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101c63:	85 c0                	test   %eax,%eax
  101c65:	74 0e                	je     101c75 <dirlookup+0xa5>
          *poff = off + (uchar*)de - bp->data;
  101c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101c6a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  101c6d:	8d 04 06             	lea    (%esi,%eax,1),%eax
  101c70:	2b 45 d8             	sub    -0x28(%ebp),%eax
  101c73:	89 02                	mov    %eax,(%edx)
        inum = de->inum;
        brelse(bp);
  101c75:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        continue;
      if(namecmp(name, de->name) == 0){
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
  101c78:	0f b7 1e             	movzwl (%esi),%ebx
        brelse(bp);
  101c7b:	89 0c 24             	mov    %ecx,(%esp)
  101c7e:	e8 ed e4 ff ff       	call   100170 <brelse>
        return iget(dp->dev, inum);
  101c83:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101c86:	89 da                	mov    %ebx,%edx
  101c88:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  101c8a:	83 c4 3c             	add    $0x3c,%esp
  101c8d:	5b                   	pop    %ebx
  101c8e:	5e                   	pop    %esi
  101c8f:	5f                   	pop    %edi
  101c90:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101c91:	e9 7a f4 ff ff       	jmp    101110 <iget>
  101c96:	66 90                	xchg   %ax,%ax
      }
    }
    brelse(bp);
  101c98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101c9b:	89 04 24             	mov    %eax,(%esp)
  101c9e:	e8 cd e4 ff ff       	call   100170 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101ca3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101ca6:	81 45 e0 00 02 00 00 	addl   $0x200,-0x20(%ebp)
  101cad:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101cb0:	39 4a 18             	cmp    %ecx,0x18(%edx)
  101cb3:	0f 87 4c ff ff ff    	ja     101c05 <dirlookup+0x35>
      }
    }
    brelse(bp);
  }
  return 0;
}
  101cb9:	83 c4 3c             	add    $0x3c,%esp
  101cbc:	31 c0                	xor    %eax,%eax
  101cbe:	5b                   	pop    %ebx
  101cbf:	5e                   	pop    %esi
  101cc0:	5f                   	pop    %edi
  101cc1:	5d                   	pop    %ebp
  101cc2:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101cc3:	c7 04 24 4b 61 10 00 	movl   $0x10614b,(%esp)
  101cca:	e8 31 ec ff ff       	call   100900 <panic>
  101ccf:	90                   	nop

00101cd0 <_namei>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
_namei(char *path, int parent, char *name)
{
  101cd0:	55                   	push   %ebp
  101cd1:	89 e5                	mov    %esp,%ebp
  101cd3:	57                   	push   %edi
  101cd4:	56                   	push   %esi
  101cd5:	53                   	push   %ebx
  101cd6:	89 c3                	mov    %eax,%ebx
  101cd8:	83 ec 2c             	sub    $0x2c,%esp
  101cdb:	89 55 e0             	mov    %edx,-0x20(%ebp)
  101cde:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101ce1:	80 38 2f             	cmpb   $0x2f,(%eax)
  101ce4:	0f 84 29 01 00 00    	je     101e13 <_namei+0x143>
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);
  101cea:	e8 21 19 00 00       	call   103610 <curproc>
  101cef:	8b 40 60             	mov    0x60(%eax),%eax
  101cf2:	89 04 24             	mov    %eax,(%esp)
  101cf5:	e8 d6 f7 ff ff       	call   1014d0 <idup>
  101cfa:	89 c7                	mov    %eax,%edi
  101cfc:	eb 05                	jmp    101d03 <_namei+0x33>
  101cfe:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101d00:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101d03:	0f b6 03             	movzbl (%ebx),%eax
  101d06:	3c 2f                	cmp    $0x2f,%al
  101d08:	74 f6                	je     101d00 <_namei+0x30>
    path++;
  if(*path == 0)
  101d0a:	84 c0                	test   %al,%al
  101d0c:	75 1a                	jne    101d28 <_namei+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
  101d0e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101d11:	85 c9                	test   %ecx,%ecx
  101d13:	0f 85 22 01 00 00    	jne    101e3b <_namei+0x16b>
    iput(ip);
    return 0;
  }
  return ip;
}
  101d19:	83 c4 2c             	add    $0x2c,%esp
  101d1c:	89 f8                	mov    %edi,%eax
  101d1e:	5b                   	pop    %ebx
  101d1f:	5e                   	pop    %esi
  101d20:	5f                   	pop    %edi
  101d21:	5d                   	pop    %ebp
  101d22:	c3                   	ret    
  101d23:	90                   	nop
  101d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101d28:	3c 2f                	cmp    $0x2f,%al
  101d2a:	0f 84 9f 00 00 00    	je     101dcf <_namei+0xff>
  101d30:	89 de                	mov    %ebx,%esi
  101d32:	eb 08                	jmp    101d3c <_namei+0x6c>
  101d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101d38:	3c 2f                	cmp    $0x2f,%al
  101d3a:	74 0a                	je     101d46 <_namei+0x76>
    path++;
  101d3c:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101d3f:	0f b6 06             	movzbl (%esi),%eax
  101d42:	84 c0                	test   %al,%al
  101d44:	75 f2                	jne    101d38 <_namei+0x68>
  101d46:	89 f2                	mov    %esi,%edx
  101d48:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  101d4a:	83 fa 0d             	cmp    $0xd,%edx
  101d4d:	0f 8e 85 00 00 00    	jle    101dd8 <_namei+0x108>
    memmove(name, s, DIRSIZ);
  101d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101d56:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  101d5a:	89 f3                	mov    %esi,%ebx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  101d5c:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101d63:	00 
  101d64:	89 04 24             	mov    %eax,(%esp)
  101d67:	e8 44 23 00 00       	call   1040b0 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d6c:	80 3e 2f             	cmpb   $0x2f,(%esi)
  101d6f:	75 0f                	jne    101d80 <_namei+0xb0>
  101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    path++;
  101d78:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d7b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  101d7e:	74 f8                	je     101d78 <_namei+0xa8>
  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
  101d80:	85 db                	test   %ebx,%ebx
  101d82:	74 8a                	je     101d0e <_namei+0x3e>
    ilock(ip);
  101d84:	89 3c 24             	mov    %edi,(%esp)
  101d87:	e8 74 f7 ff ff       	call   101500 <ilock>
    if(ip->type != T_DIR){
  101d8c:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  101d91:	75 6c                	jne    101dff <_namei+0x12f>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
  101d93:	8b 75 e0             	mov    -0x20(%ebp),%esi
  101d96:	85 f6                	test   %esi,%esi
  101d98:	74 09                	je     101da3 <_namei+0xd3>
  101d9a:	80 3b 00             	cmpb   $0x0,(%ebx)
  101d9d:	0f 84 86 00 00 00    	je     101e29 <_namei+0x159>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101da3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101da6:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101dad:	00 
  101dae:	89 3c 24             	mov    %edi,(%esp)
  101db1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101db5:	e8 16 fe ff ff       	call   101bd0 <dirlookup>
  101dba:	85 c0                	test   %eax,%eax
  101dbc:	89 c6                	mov    %eax,%esi
  101dbe:	74 3f                	je     101dff <_namei+0x12f>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101dc0:	89 3c 24             	mov    %edi,(%esp)
    ip = next;
  101dc3:	89 f7                	mov    %esi,%edi
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101dc5:	e8 36 fb ff ff       	call   101900 <iunlockput>
  101dca:	e9 34 ff ff ff       	jmp    101d03 <_namei+0x33>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101dcf:	89 de                	mov    %ebx,%esi
  101dd1:	31 d2                	xor    %edx,%edx
  101dd3:	90                   	nop
  101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101dd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101ddb:	89 54 24 08          	mov    %edx,0x8(%esp)
  101ddf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0;
  101de3:	89 f3                	mov    %esi,%ebx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101de5:	89 55 dc             	mov    %edx,-0x24(%ebp)
  101de8:	89 04 24             	mov    %eax,(%esp)
  101deb:	e8 c0 22 00 00       	call   1040b0 <memmove>
    name[len] = 0;
  101df0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101df3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101df6:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
  101dfa:	e9 6d ff ff ff       	jmp    101d6c <_namei+0x9c>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101dff:	89 3c 24             	mov    %edi,(%esp)
      return 0;
  101e02:	31 ff                	xor    %edi,%edi
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101e04:	e8 f7 fa ff ff       	call   101900 <iunlockput>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101e09:	83 c4 2c             	add    $0x2c,%esp
  101e0c:	89 f8                	mov    %edi,%eax
  101e0e:	5b                   	pop    %ebx
  101e0f:	5e                   	pop    %esi
  101e10:	5f                   	pop    %edi
  101e11:	5d                   	pop    %ebp
  101e12:	c3                   	ret    
_namei(char *path, int parent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  101e13:	ba 01 00 00 00       	mov    $0x1,%edx
  101e18:	b8 01 00 00 00       	mov    $0x1,%eax
  101e1d:	e8 ee f2 ff ff       	call   101110 <iget>
  101e22:	89 c7                	mov    %eax,%edi
  101e24:	e9 da fe ff ff       	jmp    101d03 <_namei+0x33>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101e29:	89 3c 24             	mov    %edi,(%esp)
  101e2c:	e8 df f7 ff ff       	call   101610 <iunlock>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101e31:	83 c4 2c             	add    $0x2c,%esp
  101e34:	89 f8                	mov    %edi,%eax
  101e36:	5b                   	pop    %ebx
  101e37:	5e                   	pop    %esi
  101e38:	5f                   	pop    %edi
  101e39:	5d                   	pop    %ebp
  101e3a:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  101e3b:	89 3c 24             	mov    %edi,(%esp)
    return 0;
  101e3e:	31 ff                	xor    %edi,%edi
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  101e40:	e8 7b f9 ff ff       	call   1017c0 <iput>
    return 0;
  101e45:	e9 cf fe ff ff       	jmp    101d19 <_namei+0x49>
  101e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101e50 <dirlink>:
}

// Write a new directory entry (name, ino) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint ino)
{
  101e50:	55                   	push   %ebp
  101e51:	89 e5                	mov    %esp,%ebp
  101e53:	57                   	push   %edi
  101e54:	56                   	push   %esi
  101e55:	53                   	push   %ebx
  101e56:	83 ec 2c             	sub    $0x2c,%esp
  101e59:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  101e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101e5f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101e66:	00 
  101e67:	89 34 24             	mov    %esi,(%esp)
  101e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e6e:	e8 5d fd ff ff       	call   101bd0 <dirlookup>
  101e73:	85 c0                	test   %eax,%eax
  101e75:	0f 85 89 00 00 00    	jne    101f04 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101e7b:	8b 7e 18             	mov    0x18(%esi),%edi
  101e7e:	85 ff                	test   %edi,%edi
  101e80:	0f 84 8d 00 00 00    	je     101f13 <dirlink+0xc3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101e86:	8d 7d d8             	lea    -0x28(%ebp),%edi
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101e89:	31 db                	xor    %ebx,%ebx
  101e8b:	eb 0b                	jmp    101e98 <dirlink+0x48>
  101e8d:	8d 76 00             	lea    0x0(%esi),%esi
  101e90:	83 c3 10             	add    $0x10,%ebx
  101e93:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101e96:	76 24                	jbe    101ebc <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101e98:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101e9f:	00 
  101ea0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101ea4:	89 7c 24 04          	mov    %edi,0x4(%esp)
  101ea8:	89 34 24             	mov    %esi,(%esp)
  101eab:	e8 a0 fa ff ff       	call   101950 <readi>
  101eb0:	83 f8 10             	cmp    $0x10,%eax
  101eb3:	75 65                	jne    101f1a <dirlink+0xca>
      panic("dirlink read");
    if(de.inum == 0)
  101eb5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
  101eba:	75 d4                	jne    101e90 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
  101ebf:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101ec6:	00 
  101ec7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ecb:	8d 45 da             	lea    -0x26(%ebp),%eax
  101ece:	89 04 24             	mov    %eax,(%esp)
  101ed1:	e8 9a 22 00 00       	call   104170 <strncpy>
  de.inum = ino;
  101ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101ed9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101ee0:	00 
  101ee1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101ee5:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  101ee9:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101eed:	89 34 24             	mov    %esi,(%esp)
  101ef0:	e8 7b fb ff ff       	call   101a70 <writei>
  101ef5:	83 f8 10             	cmp    $0x10,%eax
  101ef8:	75 2c                	jne    101f26 <dirlink+0xd6>
    panic("dirlink");
  
  return 0;
  101efa:	31 c0                	xor    %eax,%eax
}
  101efc:	83 c4 2c             	add    $0x2c,%esp
  101eff:	5b                   	pop    %ebx
  101f00:	5e                   	pop    %esi
  101f01:	5f                   	pop    %edi
  101f02:	5d                   	pop    %ebp
  101f03:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101f04:	89 04 24             	mov    %eax,(%esp)
  101f07:	e8 b4 f8 ff ff       	call   1017c0 <iput>
    return -1;
  101f0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101f11:	eb e9                	jmp    101efc <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101f13:	8d 7d d8             	lea    -0x28(%ebp),%edi
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101f16:	31 db                	xor    %ebx,%ebx
  101f18:	eb a2                	jmp    101ebc <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101f1a:	c7 04 24 5d 61 10 00 	movl   $0x10615d,(%esp)
  101f21:	e8 da e9 ff ff       	call   100900 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101f26:	c7 04 24 6a 61 10 00 	movl   $0x10616a,(%esp)
  101f2d:	e8 ce e9 ff ff       	call   100900 <panic>
  101f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f40 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101f40:	55                   	push   %ebp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101f41:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101f43:	89 e5                	mov    %esp,%ebp
  101f45:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101f48:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  101f4e:	e8 7d fd ff ff       	call   101cd0 <_namei>
}
  101f53:	c9                   	leave  
  101f54:	c3                   	ret    
  101f55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f60 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  101f60:	55                   	push   %ebp
  return _namei(path, 1, name);
  101f61:	ba 01 00 00 00       	mov    $0x1,%edx
  return _namei(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101f66:	89 e5                	mov    %esp,%ebp
  101f68:	83 ec 08             	sub    $0x8,%esp
  return _namei(path, 1, name);
  101f6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  101f6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  101f71:	c9                   	leave  
}

struct inode*
nameiparent(char *path, char *name)
{
  return _namei(path, 1, name);
  101f72:	e9 59 fd ff ff       	jmp    101cd0 <_namei>
  101f77:	90                   	nop
  101f78:	90                   	nop
  101f79:	90                   	nop
  101f7a:	90                   	nop
  101f7b:	90                   	nop
  101f7c:	90                   	nop
  101f7d:	90                   	nop
  101f7e:	90                   	nop
  101f7f:	90                   	nop

00101f80 <ide_wait_ready>:
static void ide_start_request();

// Wait for IDE disk to become ready.
static int
ide_wait_ready(int check_error)
{
  101f80:	55                   	push   %ebp
  101f81:	89 c1                	mov    %eax,%ecx
  101f83:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101f85:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101f90:	ec                   	in     (%dx),%al
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  101f91:	0f b6 c0             	movzbl %al,%eax
  101f94:	a8 80                	test   $0x80,%al
  101f96:	75 f8                	jne    101f90 <ide_wait_ready+0x10>
  101f98:	a8 40                	test   $0x40,%al
  101f9a:	74 f4                	je     101f90 <ide_wait_ready+0x10>
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
    return -1;
  return 0;
  101f9c:	31 d2                	xor    %edx,%edx
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
  101f9e:	85 c9                	test   %ecx,%ecx
  101fa0:	75 04                	jne    101fa6 <ide_wait_ready+0x26>
    return -1;
  return 0;
}
  101fa2:	89 d0                	mov    %edx,%eax
  101fa4:	5d                   	pop    %ebp
  101fa5:	c3                   	ret    
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
  101fa6:	83 e0 21             	and    $0x21,%eax
    return -1;
  return 0;
  101fa9:	83 f8 01             	cmp    $0x1,%eax
  101fac:	19 d2                	sbb    %edx,%edx
  101fae:	f7 d2                	not    %edx
  101fb0:	eb f0                	jmp    101fa2 <ide_wait_ready+0x22>
  101fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101fc0 <ide_start_request>:
}

// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  101fc0:	55                   	push   %ebp
  101fc1:	89 e5                	mov    %esp,%ebp
  101fc3:	56                   	push   %esi
  101fc4:	89 c6                	mov    %eax,%esi
  101fc6:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
  101fc9:	85 c0                	test   %eax,%eax
  101fcb:	0f 84 7d 00 00 00    	je     10204e <ide_start_request+0x8e>
    panic("ide_start_request");

  ide_wait_ready(0);
  101fd1:	31 c0                	xor    %eax,%eax
  101fd3:	e8 a8 ff ff ff       	call   101f80 <ide_wait_ready>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101fd8:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101fdd:	31 c0                	xor    %eax,%eax
  101fdf:	ee                   	out    %al,(%dx)
  101fe0:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101fe5:	b8 01 00 00 00       	mov    $0x1,%eax
  101fea:	ee                   	out    %al,(%dx)
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101feb:	8b 4e 08             	mov    0x8(%esi),%ecx
  101fee:	b2 f3                	mov    $0xf3,%dl
  101ff0:	89 c8                	mov    %ecx,%eax
  101ff2:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  101ff3:	89 c8                	mov    %ecx,%eax
  101ff5:	b2 f4                	mov    $0xf4,%dl
  101ff7:	c1 e8 08             	shr    $0x8,%eax
  101ffa:	ee                   	out    %al,(%dx)
  outb(0x1f5, (b->sector >> 16) & 0xff);
  101ffb:	89 c8                	mov    %ecx,%eax
  101ffd:	b2 f5                	mov    $0xf5,%dl
  101fff:	c1 e8 10             	shr    $0x10,%eax
  102002:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  102003:	8b 46 04             	mov    0x4(%esi),%eax
  102006:	c1 e9 18             	shr    $0x18,%ecx
  102009:	b2 f6                	mov    $0xf6,%dl
  10200b:	83 e1 0f             	and    $0xf,%ecx
  10200e:	83 e0 01             	and    $0x1,%eax
  102011:	c1 e0 04             	shl    $0x4,%eax
  102014:	09 c8                	or     %ecx,%eax
  102016:	83 c8 e0             	or     $0xffffffe0,%eax
  102019:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
  10201a:	f6 06 04             	testb  $0x4,(%esi)
  10201d:	75 11                	jne    102030 <ide_start_request+0x70>
  10201f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102024:	b8 20 00 00 00       	mov    $0x20,%eax
  102029:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  10202a:	83 c4 14             	add    $0x14,%esp
  10202d:	5e                   	pop    %esi
  10202e:	5d                   	pop    %ebp
  10202f:	c3                   	ret    
  102030:	b2 f7                	mov    $0xf7,%dl
  102032:	b8 30 00 00 00       	mov    $0x30,%eax
  102037:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\toutsl"    :
  102038:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  10203d:	83 c6 18             	add    $0x18,%esi
  102040:	ba f0 01 00 00       	mov    $0x1f0,%edx
  102045:	fc                   	cld    
  102046:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  102048:	83 c4 14             	add    $0x14,%esp
  10204b:	5e                   	pop    %esi
  10204c:	5d                   	pop    %ebp
  10204d:	c3                   	ret    
// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  if(b == 0)
    panic("ide_start_request");
  10204e:	c7 04 24 72 61 10 00 	movl   $0x106172,(%esp)
  102055:	e8 a6 e8 ff ff       	call   100900 <panic>
  10205a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102060 <ide_init>:
  return 0;
}

void
ide_init(void)
{
  102060:	55                   	push   %ebp
  102061:	89 e5                	mov    %esp,%ebp
  102063:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&ide_lock, "ide");
  102066:	c7 44 24 04 84 61 10 	movl   $0x106184,0x4(%esp)
  10206d:	00 
  10206e:	c7 04 24 20 78 10 00 	movl   $0x107820,(%esp)
  102075:	e8 76 1d 00 00       	call   103df0 <initlock>
  pic_enable(IRQ_IDE);
  10207a:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102081:	e8 8a 0c 00 00       	call   102d10 <pic_enable>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  102086:	a1 40 b1 10 00       	mov    0x10b140,%eax
  10208b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102092:	83 e8 01             	sub    $0x1,%eax
  102095:	89 44 24 04          	mov    %eax,0x4(%esp)
  102099:	e8 52 02 00 00       	call   1022f0 <ioapic_enable>
  ide_wait_ready(0);
  10209e:	31 c0                	xor    %eax,%eax
  1020a0:	e8 db fe ff ff       	call   101f80 <ide_wait_ready>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1020a5:	ba f6 01 00 00       	mov    $0x1f6,%edx
  1020aa:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  1020af:	ee                   	out    %al,(%dx)
  1020b0:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1020b5:	b2 f7                	mov    $0xf7,%dl
  1020b7:	eb 0c                	jmp    1020c5 <ide_init+0x65>
  1020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  1020c0:	83 e9 01             	sub    $0x1,%ecx
  1020c3:	74 0f                	je     1020d4 <ide_init+0x74>
  1020c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  1020c6:	84 c0                	test   %al,%al
  1020c8:	74 f6                	je     1020c0 <ide_init+0x60>
      disk_1_present = 1;
  1020ca:	c7 05 00 78 10 00 01 	movl   $0x1,0x107800
  1020d1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1020d4:	ba f6 01 00 00       	mov    $0x1f6,%edx
  1020d9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  1020de:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  1020df:	c9                   	leave  
  1020e0:	c3                   	ret    
  1020e1:	eb 0d                	jmp    1020f0 <ide_intr>
  1020e3:	90                   	nop
  1020e4:	90                   	nop
  1020e5:	90                   	nop
  1020e6:	90                   	nop
  1020e7:	90                   	nop
  1020e8:	90                   	nop
  1020e9:	90                   	nop
  1020ea:	90                   	nop
  1020eb:	90                   	nop
  1020ec:	90                   	nop
  1020ed:	90                   	nop
  1020ee:	90                   	nop
  1020ef:	90                   	nop

001020f0 <ide_intr>:
}

// Interrupt handler.
void
ide_intr(void)
{
  1020f0:	55                   	push   %ebp
  1020f1:	89 e5                	mov    %esp,%ebp
  1020f3:	57                   	push   %edi
  1020f4:	53                   	push   %ebx
  1020f5:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  acquire(&ide_lock);
  1020f8:	c7 04 24 20 78 10 00 	movl   $0x107820,(%esp)
  1020ff:	e8 ec 1d 00 00       	call   103ef0 <acquire>
  if((b = ide_queue) == 0){
  102104:	8b 1d 54 78 10 00    	mov    0x107854,%ebx
  10210a:	85 db                	test   %ebx,%ebx
  10210c:	74 27                	je     102135 <ide_intr+0x45>
    release(&ide_lock);
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
  10210e:	8b 03                	mov    (%ebx),%eax
  102110:	a8 04                	test   $0x4,%al
  102112:	74 34                	je     102148 <ide_intr+0x58>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  102114:	83 c8 02             	or     $0x2,%eax
  b->flags &= ~B_DIRTY;
  102117:	83 e0 fb             	and    $0xfffffffb,%eax
  10211a:	89 03                	mov    %eax,(%ebx)
  wakeup(b);
  10211c:	89 1c 24             	mov    %ebx,(%esp)
  10211f:	e8 8c 18 00 00       	call   1039b0 <wakeup>
  
  // Start disk on next buf in queue.
  if((ide_queue = b->qnext) != 0)
  102124:	8b 43 14             	mov    0x14(%ebx),%eax
  102127:	85 c0                	test   %eax,%eax
  102129:	a3 54 78 10 00       	mov    %eax,0x107854
  10212e:	74 05                	je     102135 <ide_intr+0x45>
    ide_start_request(ide_queue);
  102130:	e8 8b fe ff ff       	call   101fc0 <ide_start_request>

  release(&ide_lock);
  102135:	c7 04 24 20 78 10 00 	movl   $0x107820,(%esp)
  10213c:	e8 9f 1e 00 00       	call   103fe0 <release>
}
  102141:	83 c4 10             	add    $0x10,%esp
  102144:	5b                   	pop    %ebx
  102145:	5f                   	pop    %edi
  102146:	5d                   	pop    %ebp
  102147:	c3                   	ret    
    release(&ide_lock);
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
  102148:	b8 01 00 00 00       	mov    $0x1,%eax
  10214d:	e8 2e fe ff ff       	call   101f80 <ide_wait_ready>
  102152:	85 c0                	test   %eax,%eax
  102154:	78 10                	js     102166 <ide_intr+0x76>
    insl(0x1f0, b->data, 512/4);
  102156:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
  102159:	b9 80 00 00 00       	mov    $0x80,%ecx
  10215e:	ba f0 01 00 00       	mov    $0x1f0,%edx
  102163:	fc                   	cld    
  102164:	f2 6d                	repnz insl (%dx),%es:(%edi)
  102166:	8b 03                	mov    (%ebx),%eax
  102168:	eb aa                	jmp    102114 <ide_intr+0x24>
  10216a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102170 <ide_rw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
ide_rw(struct buf *b)
{
  102170:	55                   	push   %ebp
  102171:	89 e5                	mov    %esp,%ebp
  102173:	53                   	push   %ebx
  102174:	83 ec 14             	sub    $0x14,%esp
  102177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  10217a:	8b 03                	mov    (%ebx),%eax
  10217c:	a8 01                	test   $0x1,%al
  10217e:	0f 84 90 00 00 00    	je     102214 <ide_rw+0xa4>
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  102184:	83 e0 06             	and    $0x6,%eax
  102187:	83 f8 02             	cmp    $0x2,%eax
  10218a:	0f 84 9c 00 00 00    	je     10222c <ide_rw+0xbc>
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
  102190:	8b 53 04             	mov    0x4(%ebx),%edx
  102193:	85 d2                	test   %edx,%edx
  102195:	74 0d                	je     1021a4 <ide_rw+0x34>
  102197:	a1 00 78 10 00       	mov    0x107800,%eax
  10219c:	85 c0                	test   %eax,%eax
  10219e:	0f 84 7c 00 00 00    	je     102220 <ide_rw+0xb0>
    panic("ide disk 1 not present");

  acquire(&ide_lock);
  1021a4:	c7 04 24 20 78 10 00 	movl   $0x107820,(%esp)
  1021ab:	e8 40 1d 00 00       	call   103ef0 <acquire>

  // Append b to ide_queue.
  b->qnext = 0;
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1021b0:	a1 54 78 10 00       	mov    0x107854,%eax
  1021b5:	ba 54 78 10 00       	mov    $0x107854,%edx
    panic("ide disk 1 not present");

  acquire(&ide_lock);

  // Append b to ide_queue.
  b->qnext = 0;
  1021ba:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1021c1:	85 c0                	test   %eax,%eax
  1021c3:	74 0d                	je     1021d2 <ide_rw+0x62>
  1021c5:	8d 76 00             	lea    0x0(%esi),%esi
  1021c8:	8d 50 14             	lea    0x14(%eax),%edx
  1021cb:	8b 40 14             	mov    0x14(%eax),%eax
  1021ce:	85 c0                	test   %eax,%eax
  1021d0:	75 f6                	jne    1021c8 <ide_rw+0x58>
    ;
  *pp = b;
  1021d2:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(ide_queue == b)
  1021d4:	39 1d 54 78 10 00    	cmp    %ebx,0x107854
  1021da:	75 14                	jne    1021f0 <ide_rw+0x80>
  1021dc:	eb 2d                	jmp    10220b <ide_rw+0x9b>
  1021de:	66 90                	xchg   %ax,%ax
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);
  1021e0:	c7 44 24 04 20 78 10 	movl   $0x107820,0x4(%esp)
  1021e7:	00 
  1021e8:	89 1c 24             	mov    %ebx,(%esp)
  1021eb:	e8 f0 16 00 00       	call   1038e0 <sleep>
  if(ide_queue == b)
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1021f0:	8b 03                	mov    (%ebx),%eax
  1021f2:	83 e0 06             	and    $0x6,%eax
  1021f5:	83 f8 02             	cmp    $0x2,%eax
  1021f8:	75 e6                	jne    1021e0 <ide_rw+0x70>
    sleep(b, &ide_lock);

  release(&ide_lock);
  1021fa:	c7 45 08 20 78 10 00 	movl   $0x107820,0x8(%ebp)
}
  102201:	83 c4 14             	add    $0x14,%esp
  102204:	5b                   	pop    %ebx
  102205:	5d                   	pop    %ebp
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);

  release(&ide_lock);
  102206:	e9 d5 1d 00 00       	jmp    103fe0 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(ide_queue == b)
    ide_start_request(b);
  10220b:	89 d8                	mov    %ebx,%eax
  10220d:	e8 ae fd ff ff       	call   101fc0 <ide_start_request>
  102212:	eb dc                	jmp    1021f0 <ide_rw+0x80>
ide_rw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  102214:	c7 04 24 88 61 10 00 	movl   $0x106188,(%esp)
  10221b:	e8 e0 e6 ff ff       	call   100900 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
    panic("ide disk 1 not present");
  102220:	c7 04 24 b3 61 10 00 	movl   $0x1061b3,(%esp)
  102227:	e8 d4 e6 ff ff       	call   100900 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  10222c:	c7 04 24 9d 61 10 00 	movl   $0x10619d,(%esp)
  102233:	e8 c8 e6 ff ff       	call   100900 <panic>
  102238:	90                   	nop
  102239:	90                   	nop
  10223a:	90                   	nop
  10223b:	90                   	nop
  10223c:	90                   	nop
  10223d:	90                   	nop
  10223e:	90                   	nop
  10223f:	90                   	nop

00102240 <ioapic_init>:
  ioapic->data = data;
}

void
ioapic_init(void)
{
  102240:	55                   	push   %ebp
  102241:	89 e5                	mov    %esp,%ebp
  102243:	56                   	push   %esi
  102244:	53                   	push   %ebx
  102245:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
  102248:	a1 c0 aa 10 00       	mov    0x10aac0,%eax
  10224d:	85 c0                	test   %eax,%eax
  10224f:	0f 84 87 00 00 00    	je     1022dc <ioapic_init+0x9c>
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  102255:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  10225c:	00 00 00 
  return ioapic->data;
  10225f:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  102265:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  10226a:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  102271:	00 00 00 
  return ioapic->data;
  102274:	8b 15 10 00 c0 fe    	mov    0xfec00010,%edx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  10227a:	0f b6 0d c4 aa 10 00 	movzbl 0x10aac4,%ecx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  102281:	c7 05 74 aa 10 00 00 	movl   $0xfec00000,0x10aa74
  102288:	00 c0 fe 
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  10228b:	c1 ee 10             	shr    $0x10,%esi
  id = ioapic_read(REG_ID) >> 24;
  10228e:	c1 ea 18             	shr    $0x18,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  102291:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  102297:	39 d1                	cmp    %edx,%ecx
  102299:	74 11                	je     1022ac <ioapic_init+0x6c>
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
  10229b:	c7 04 24 cc 61 10 00 	movl   $0x1061cc,(%esp)
  1022a2:	e8 a9 e2 ff ff       	call   100550 <cprintf>
  1022a7:	a1 74 aa 10 00       	mov    0x10aa74,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  1022ac:	b9 10 00 00 00       	mov    $0x10,%ecx
  1022b1:	31 d2                	xor    %edx,%edx
  1022b3:	90                   	nop
  1022b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
  ioapic->data = data;
}

void
ioapic_init(void)
  1022b8:	8d 5a 20             	lea    0x20(%edx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1022bb:	83 c2 01             	add    $0x1,%edx
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  1022be:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  1022c4:	89 08                	mov    %ecx,(%eax)
  ioapic->data = data;
  1022c6:	89 58 10             	mov    %ebx,0x10(%eax)
  1022c9:	8d 59 01             	lea    0x1(%ecx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1022cc:	83 c1 02             	add    $0x2,%ecx
  1022cf:	39 d6                	cmp    %edx,%esi
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  1022d1:	89 18                	mov    %ebx,(%eax)
  ioapic->data = data;
  1022d3:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1022da:	7d dc                	jge    1022b8 <ioapic_init+0x78>
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
    ioapic_write(REG_TABLE+2*i+1, 0);
  }
}
  1022dc:	83 c4 10             	add    $0x10,%esp
  1022df:	5b                   	pop    %ebx
  1022e0:	5e                   	pop    %esi
  1022e1:	5d                   	pop    %ebp
  1022e2:	c3                   	ret    
  1022e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001022f0 <ioapic_enable>:

void
ioapic_enable(int irq, int cpunum)
{
  if(!ismp)
  1022f0:	8b 15 c0 aa 10 00    	mov    0x10aac0,%edx
  }
}

void
ioapic_enable(int irq, int cpunum)
{
  1022f6:	55                   	push   %ebp
  1022f7:	89 e5                	mov    %esp,%ebp
  1022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
  1022fc:	85 d2                	test   %edx,%edx
  1022fe:	74 1f                	je     10231f <ioapic_enable+0x2f>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  102300:	8d 48 20             	lea    0x20(%eax),%ecx
  102303:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102307:	a1 74 aa 10 00       	mov    0x10aa74,%eax
  10230c:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  10230e:	83 c2 01             	add    $0x1,%edx

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  102311:	89 48 10             	mov    %ecx,0x10(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  102314:	8b 4d 0c             	mov    0xc(%ebp),%ecx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102317:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  102319:	c1 e1 18             	shl    $0x18,%ecx

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  10231c:	89 48 10             	mov    %ecx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
}
  10231f:	5d                   	pop    %ebp
  102320:	c3                   	ret    
  102321:	90                   	nop
  102322:	90                   	nop
  102323:	90                   	nop
  102324:	90                   	nop
  102325:	90                   	nop
  102326:	90                   	nop
  102327:	90                   	nop
  102328:	90                   	nop
  102329:	90                   	nop
  10232a:	90                   	nop
  10232b:	90                   	nop
  10232c:	90                   	nop
  10232d:	90                   	nop
  10232e:	90                   	nop
  10232f:	90                   	nop

00102330 <kfree>:
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102330:	55                   	push   %ebp
  102331:	89 e5                	mov    %esp,%ebp
  102333:	57                   	push   %edi
  102334:	56                   	push   %esi
  102335:	53                   	push   %ebx
  102336:	83 ec 2c             	sub    $0x2c,%esp
  102339:	8b 45 0c             	mov    0xc(%ebp),%eax
  10233c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  10233f:	85 c0                	test   %eax,%eax
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102341:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  102344:	0f 8e dc 00 00 00    	jle    102426 <kfree+0xf6>
  10234a:	a9 ff 0f 00 00       	test   $0xfff,%eax
  10234f:	0f 85 d1 00 00 00    	jne    102426 <kfree+0xf6>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102355:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102358:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10235f:	00 
  102360:	89 1c 24             	mov    %ebx,(%esp)
  102363:	89 54 24 08          	mov    %edx,0x8(%esp)
  102367:	e8 b4 1c 00 00       	call   104020 <memset>

  acquire(&kalloc_lock);
  10236c:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  102373:	e8 78 1b 00 00       	call   103ef0 <acquire>
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102378:	a1 b4 aa 10 00       	mov    0x10aab4,%eax
  10237d:	85 c0                	test   %eax,%eax
  10237f:	74 59                	je     1023da <kfree+0xaa>
  // Fill with junk to catch dangling refs.
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  102381:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  102384:	8d 0c 0b             	lea    (%ebx,%ecx,1),%ecx
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102387:	39 c1                	cmp    %eax,%ecx
  102389:	72 4f                	jb     1023da <kfree+0xaa>
    rend = (struct run*)((char*)r + r->len);
  10238b:	8b 70 04             	mov    0x4(%eax),%esi
    if(r <= p && p < rend)
  10238e:	39 c3                	cmp    %eax,%ebx

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
  102390:	8d 14 30             	lea    (%eax,%esi,1),%edx
    if(r <= p && p < rend)
  102393:	0f 83 99 00 00 00    	jae    102432 <kfree+0x102>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  102399:	39 c1                	cmp    %eax,%ecx
  10239b:	75 1d                	jne    1023ba <kfree+0x8a>
  10239d:	eb 5e                	jmp    1023fd <kfree+0xcd>
  10239f:	90                   	nop
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023a0:	89 c7                	mov    %eax,%edi
  1023a2:	8b 00                	mov    (%eax),%eax
  1023a4:	85 c0                	test   %eax,%eax
  1023a6:	74 38                	je     1023e0 <kfree+0xb0>
  1023a8:	39 c1                	cmp    %eax,%ecx
  1023aa:	72 34                	jb     1023e0 <kfree+0xb0>
    rend = (struct run*)((char*)r + r->len);
  1023ac:	8b 70 04             	mov    0x4(%eax),%esi
  1023af:	8d 14 30             	lea    (%eax,%esi,1),%edx
    if(r <= p && p < rend)
  1023b2:	39 d3                	cmp    %edx,%ebx
  1023b4:	72 60                	jb     102416 <kfree+0xe6>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  1023b6:	39 c1                	cmp    %eax,%ecx
  1023b8:	74 4e                	je     102408 <kfree+0xd8>
      p->len = len + r->len;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
  1023ba:	39 da                	cmp    %ebx,%edx
  1023bc:	75 e2                	jne    1023a0 <kfree+0x70>
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
  1023be:	8b 10                	mov    (%eax),%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  1023c0:	03 75 e4             	add    -0x1c(%ebp),%esi
      if(r->next && r->next == pend){  // r now next to r->next?
  1023c3:	85 d2                	test   %edx,%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  1023c5:	89 70 04             	mov    %esi,0x4(%eax)
      if(r->next && r->next == pend){  // r now next to r->next?
  1023c8:	74 20                	je     1023ea <kfree+0xba>
  1023ca:	39 d1                	cmp    %edx,%ecx
  1023cc:	75 1c                	jne    1023ea <kfree+0xba>
        r->len += r->next->len;
        r->next = r->next->next;
  1023ce:	8b 11                	mov    (%ecx),%edx
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->len += r->next->len;
  1023d0:	03 71 04             	add    0x4(%ecx),%esi
        r->next = r->next->next;
  1023d3:	89 10                	mov    %edx,(%eax)
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->len += r->next->len;
  1023d5:	89 70 04             	mov    %esi,0x4(%eax)
  1023d8:	eb 10                	jmp    1023ea <kfree+0xba>
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023da:	bf b4 aa 10 00       	mov    $0x10aab4,%edi
  1023df:	90                   	nop
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1023e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  p->next = r;
  1023e3:	89 03                	mov    %eax,(%ebx)
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1023e5:	89 53 04             	mov    %edx,0x4(%ebx)
  p->next = r;
  *rp = p;
  1023e8:	89 1f                	mov    %ebx,(%edi)

 out:
  release(&kalloc_lock);
  1023ea:	c7 45 08 80 aa 10 00 	movl   $0x10aa80,0x8(%ebp)
}
  1023f1:	83 c4 2c             	add    $0x2c,%esp
  1023f4:	5b                   	pop    %ebx
  1023f5:	5e                   	pop    %esi
  1023f6:	5f                   	pop    %edi
  1023f7:	5d                   	pop    %ebp
  p->len = len;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  1023f8:	e9 e3 1b 00 00       	jmp    103fe0 <release>
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023fd:	bf b4 aa 10 00       	mov    $0x10aab4,%edi
  102402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
      p->next = r->next;
  102408:	8b 00                	mov    (%eax),%eax
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
  10240a:	03 75 e4             	add    -0x1c(%ebp),%esi
      p->next = r->next;
  10240d:	89 03                	mov    %eax,(%ebx)
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
  10240f:	89 73 04             	mov    %esi,0x4(%ebx)
      p->next = r->next;
      *rp = p;
  102412:	89 1f                	mov    %ebx,(%edi)
      goto out;
  102414:	eb d4                	jmp    1023ea <kfree+0xba>
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
  102416:	39 c3                	cmp    %eax,%ebx
  102418:	72 9c                	jb     1023b6 <kfree+0x86>
      panic("freeing free page");
  10241a:	c7 04 24 06 62 10 00 	movl   $0x106206,(%esp)
  102421:	e8 da e4 ff ff       	call   100900 <panic>
kfree(char *v, int len)
{
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
    panic("kfree");
  102426:	c7 04 24 00 62 10 00 	movl   $0x106200,(%esp)
  10242d:	e8 ce e4 ff ff       	call   100900 <panic>
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
  102432:	39 d3                	cmp    %edx,%ebx
  102434:	0f 83 5f ff ff ff    	jae    102399 <kfree+0x69>
  10243a:	eb de                	jmp    10241a <kfree+0xea>
  10243c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102440 <kinit>:
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  102440:	55                   	push   %ebp
  102441:	89 e5                	mov    %esp,%ebp
  102443:	83 ec 18             	sub    $0x18,%esp
  extern int end;
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  102446:	c7 44 24 04 18 62 10 	movl   $0x106218,0x4(%esp)
  10244d:	00 
  10244e:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  102455:	e8 96 19 00 00       	call   103df0 <initlock>
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  10245a:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  102461:	00 
  102462:	c7 04 24 1f 62 10 00 	movl   $0x10621f,(%esp)
  102469:	e8 e2 e0 ff ff       	call   100550 <cprintf>
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  10246e:	b8 e4 ef 10 00       	mov    $0x10efe4,%eax
  102473:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  kfree(start, mem * PAGE);
  102478:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10247f:	00 
  102480:	89 04 24             	mov    %eax,(%esp)
  102483:	e8 a8 fe ff ff       	call   102330 <kfree>
}
  102488:	c9                   	leave  
  102489:	c3                   	ret    
  10248a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102490 <kalloc>:
// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(int n)
{
  102490:	55                   	push   %ebp
  102491:	89 e5                	mov    %esp,%ebp
  102493:	56                   	push   %esi
  102494:	53                   	push   %ebx
  102495:	83 ec 10             	sub    $0x10,%esp
  102498:	8b 75 08             	mov    0x8(%ebp),%esi
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  10249b:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  1024a1:	0f 85 9a 00 00 00    	jne    102541 <kalloc+0xb1>
  1024a7:	85 f6                	test   %esi,%esi
  1024a9:	0f 8e 92 00 00 00    	jle    102541 <kalloc+0xb1>
    panic("kalloc");

  acquire(&kalloc_lock);
  1024af:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  1024b6:	e8 35 1a 00 00       	call   103ef0 <acquire>
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  1024bb:	8b 1d b4 aa 10 00    	mov    0x10aab4,%ebx
  1024c1:	85 db                	test   %ebx,%ebx
  1024c3:	74 3b                	je     102500 <kalloc+0x70>
    if(r->len == n){
  1024c5:	8b 43 04             	mov    0x4(%ebx),%eax
  1024c8:	39 f0                	cmp    %esi,%eax
  1024ca:	75 13                	jne    1024df <kalloc+0x4f>
  1024cc:	eb 55                	jmp    102523 <kalloc+0x93>
  1024ce:	66 90                	xchg   %ax,%ax

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  1024d0:	89 da                	mov    %ebx,%edx
  1024d2:	8b 1b                	mov    (%ebx),%ebx
  1024d4:	85 db                	test   %ebx,%ebx
  1024d6:	74 28                	je     102500 <kalloc+0x70>
    if(r->len == n){
  1024d8:	8b 43 04             	mov    0x4(%ebx),%eax
  1024db:	39 f0                	cmp    %esi,%eax
  1024dd:	74 49                	je     102528 <kalloc+0x98>
      *rp = r->next;
      release(&kalloc_lock);
      return (char*)r;
    }
    if(r->len > n){
  1024df:	39 c6                	cmp    %eax,%esi
  1024e1:	7d ed                	jge    1024d0 <kalloc+0x40>
      r->len -= n;
  1024e3:	29 f0                	sub    %esi,%eax
  1024e5:	89 43 04             	mov    %eax,0x4(%ebx)
      p = (char*)r + r->len;
  1024e8:	01 c3                	add    %eax,%ebx
      release(&kalloc_lock);
  1024ea:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  1024f1:	e8 ea 1a 00 00       	call   103fe0 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  1024f6:	83 c4 10             	add    $0x10,%esp
  1024f9:	89 d8                	mov    %ebx,%eax
  1024fb:	5b                   	pop    %ebx
  1024fc:	5e                   	pop    %esi
  1024fd:	5d                   	pop    %ebp
  1024fe:	c3                   	ret    
  1024ff:	90                   	nop
    }
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
  102500:	31 db                	xor    %ebx,%ebx
      p = (char*)r + r->len;
      release(&kalloc_lock);
      return p;
    }
  }
  release(&kalloc_lock);
  102502:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  102509:	e8 d2 1a 00 00       	call   103fe0 <release>

  cprintf("kalloc: out of memory\n");
  10250e:	c7 04 24 29 62 10 00 	movl   $0x106229,(%esp)
  102515:	e8 36 e0 ff ff       	call   100550 <cprintf>
  return 0;
}
  10251a:	83 c4 10             	add    $0x10,%esp
  10251d:	89 d8                	mov    %ebx,%eax
  10251f:	5b                   	pop    %ebx
  102520:	5e                   	pop    %esi
  102521:	5d                   	pop    %ebp
  102522:	c3                   	ret    

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  102523:	ba b4 aa 10 00       	mov    $0x10aab4,%edx
    if(r->len == n){
      *rp = r->next;
  102528:	8b 03                	mov    (%ebx),%eax
  10252a:	89 02                	mov    %eax,(%edx)
      release(&kalloc_lock);
  10252c:	c7 04 24 80 aa 10 00 	movl   $0x10aa80,(%esp)
  102533:	e8 a8 1a 00 00       	call   103fe0 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  102538:	83 c4 10             	add    $0x10,%esp
  10253b:	89 d8                	mov    %ebx,%eax
  10253d:	5b                   	pop    %ebx
  10253e:	5e                   	pop    %esi
  10253f:	5d                   	pop    %ebp
  102540:	c3                   	ret    
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
    panic("kalloc");
  102541:	c7 04 24 18 62 10 00 	movl   $0x106218,(%esp)
  102548:	e8 b3 e3 ff ff       	call   100900 <panic>
  10254d:	90                   	nop
  10254e:	90                   	nop
  10254f:	90                   	nop

00102550 <kbd_getc>:
#include "defs.h"
#include "kbd.h"

int
kbd_getc(void)
{
  102550:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102551:	ba 64 00 00 00       	mov    $0x64,%edx
  102556:	89 e5                	mov    %esp,%ebp
  102558:	ec                   	in     (%dx),%al
  102559:	89 c2                	mov    %eax,%edx
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  10255b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  102560:	83 e2 01             	and    $0x1,%edx
  102563:	74 41                	je     1025a6 <kbd_getc+0x56>
  102565:	ba 60 00 00 00       	mov    $0x60,%edx
  10256a:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  10256b:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
  10256e:	3d e0 00 00 00       	cmp    $0xe0,%eax
  102573:	0f 84 7f 00 00 00    	je     1025f8 <kbd_getc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102579:	a8 80                	test   $0x80,%al
  10257b:	74 2b                	je     1025a8 <kbd_getc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  10257d:	8b 15 58 78 10 00    	mov    0x107858,%edx
  102583:	89 c1                	mov    %eax,%ecx
  102585:	83 e1 7f             	and    $0x7f,%ecx
  102588:	f6 c2 40             	test   $0x40,%dl
  10258b:	0f 44 c1             	cmove  %ecx,%eax
    shift &= ~(shiftcode[data] | E0ESC);
  10258e:	0f b6 80 40 62 10 00 	movzbl 0x106240(%eax),%eax
  102595:	83 c8 40             	or     $0x40,%eax
  102598:	0f b6 c0             	movzbl %al,%eax
  10259b:	f7 d0                	not    %eax
  10259d:	21 d0                	and    %edx,%eax
  10259f:	a3 58 78 10 00       	mov    %eax,0x107858
    return 0;
  1025a4:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1025a6:	5d                   	pop    %ebp
  1025a7:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  1025a8:	8b 0d 58 78 10 00    	mov    0x107858,%ecx
  1025ae:	f6 c1 40             	test   $0x40,%cl
  1025b1:	74 05                	je     1025b8 <kbd_getc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1025b3:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
  1025b5:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  1025b8:	0f b6 90 40 62 10 00 	movzbl 0x106240(%eax),%edx
  1025bf:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
  1025c1:	0f b6 88 40 63 10 00 	movzbl 0x106340(%eax),%ecx
  1025c8:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
  1025ca:	89 d1                	mov    %edx,%ecx
  1025cc:	83 e1 03             	and    $0x3,%ecx
  1025cf:	8b 0c 8d 40 64 10 00 	mov    0x106440(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025d6:	89 15 58 78 10 00    	mov    %edx,0x107858
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
  1025dc:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  1025df:	0f b6 04 01          	movzbl (%ecx,%eax,1),%eax
  if(shift & CAPSLOCK){
  1025e3:	74 c1                	je     1025a6 <kbd_getc+0x56>
    if('a' <= c && c <= 'z')
  1025e5:	8d 50 9f             	lea    -0x61(%eax),%edx
  1025e8:	83 fa 19             	cmp    $0x19,%edx
  1025eb:	77 1b                	ja     102608 <kbd_getc+0xb8>
      c += 'A' - 'a';
  1025ed:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1025f0:	5d                   	pop    %ebp
  1025f1:	c3                   	ret    
  1025f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  1025f8:	30 c0                	xor    %al,%al
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  1025fa:	83 0d 58 78 10 00 40 	orl    $0x40,0x107858
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102601:	5d                   	pop    %ebp
  102602:	c3                   	ret    
  102603:	90                   	nop
  102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102608:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
  10260b:	8d 50 20             	lea    0x20(%eax),%edx
  10260e:	83 f9 19             	cmp    $0x19,%ecx
  102611:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
  102614:	5d                   	pop    %ebp
  102615:	c3                   	ret    
  102616:	8d 76 00             	lea    0x0(%esi),%esi
  102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102620 <kbd_intr>:

void
kbd_intr(void)
{
  102620:	55                   	push   %ebp
  102621:	89 e5                	mov    %esp,%ebp
  102623:	83 ec 18             	sub    $0x18,%esp
  console_intr(kbd_getc);
  102626:	c7 04 24 50 25 10 00 	movl   $0x102550,(%esp)
  10262d:	e8 ce e0 ff ff       	call   100700 <console_intr>
}
  102632:	c9                   	leave  
  102633:	c3                   	ret    
  102634:	90                   	nop
  102635:	90                   	nop
  102636:	90                   	nop
  102637:	90                   	nop
  102638:	90                   	nop
  102639:	90                   	nop
  10263a:	90                   	nop
  10263b:	90                   	nop
  10263c:	90                   	nop
  10263d:	90                   	nop
  10263e:	90                   	nop
  10263f:	90                   	nop

00102640 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  102640:	55                   	push   %ebp
  102641:	89 e5                	mov    %esp,%ebp
  102643:	83 ec 10             	sub    $0x10,%esp
  volatile int j = 0;
  
  while(us-- > 0)
  102646:	85 c0                	test   %eax,%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  102648:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  
  while(us-- > 0)
  10264f:	7e 3a                	jle    10268b <microdelay+0x4b>
  102651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(j=0; j<10000; j++);
  102658:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10265f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  102662:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  102668:	7f 1a                	jg     102684 <microdelay+0x44>
  10266a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102670:	8b 55 fc             	mov    -0x4(%ebp),%edx
  102673:	83 c2 01             	add    $0x1,%edx
  102676:	89 55 fc             	mov    %edx,-0x4(%ebp)
  102679:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10267c:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  102682:	7e ec                	jle    102670 <microdelay+0x30>
  102684:	83 e8 01             	sub    $0x1,%eax
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  102687:	85 c0                	test   %eax,%eax
  102689:	7f cd                	jg     102658 <microdelay+0x18>
    for(j=0; j<10000; j++);
}
  10268b:	c9                   	leave  
  10268c:	c3                   	ret    
  10268d:	8d 76 00             	lea    0x0(%esi),%esi

00102690 <lapic_init>:
}

void
lapic_init(int c)
{
  if(!lapic) 
  102690:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapic_init(int c)
{
  102695:	55                   	push   %ebp
  102696:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
  102698:	85 c0                	test   %eax,%eax
  10269a:	0f 84 c4 00 00 00    	je     102764 <lapic_init+0xd4>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026a0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  1026a7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026aa:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026ad:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  1026b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026b7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026ba:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  1026c1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  1026c4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026c7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  1026ce:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  1026d1:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026d4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  1026db:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026de:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026e1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  1026e8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1026ee:	8b 50 30             	mov    0x30(%eax),%edx
  1026f1:	c1 ea 10             	shr    $0x10,%edx
  1026f4:	80 fa 03             	cmp    $0x3,%dl
  1026f7:	77 6f                	ja     102768 <lapic_init+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026f9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  102700:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102703:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102706:	8d 88 00 03 00 00    	lea    0x300(%eax),%ecx
  10270c:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102713:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102716:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102719:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102720:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102723:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102726:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  10272d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102730:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102733:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  10273a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10273d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102740:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  102747:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  10274a:	8b 50 20             	mov    0x20(%eax),%edx
  10274d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  102750:	8b 11                	mov    (%ecx),%edx
  102752:	80 e6 10             	and    $0x10,%dh
  102755:	75 f9                	jne    102750 <lapic_init+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102757:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  10275e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102761:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  102764:	5d                   	pop    %ebp
  102765:	c3                   	ret    
  102766:	66 90                	xchg   %ax,%ax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102768:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  10276f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102772:	8b 50 20             	mov    0x20(%eax),%edx
  102775:	eb 82                	jmp    1026f9 <lapic_init+0x69>
  102777:	89 f6                	mov    %esi,%esi
  102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102780 <cpu>:
  lapicw(TPR, 0);
}

int
cpu(void)
{
  102780:	55                   	push   %ebp
  102781:	89 e5                	mov    %esp,%ebp
  102783:	83 ec 18             	sub    $0x18,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102786:	9c                   	pushf  
  102787:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
  102788:	f6 c4 02             	test   $0x2,%ah
  10278b:	74 12                	je     10279f <cpu+0x1f>
    static int n;
    if(n++ == 0)
  10278d:	a1 5c 78 10 00       	mov    0x10785c,%eax
  102792:	8d 50 01             	lea    0x1(%eax),%edx
  102795:	85 c0                	test   %eax,%eax
  102797:	89 15 5c 78 10 00    	mov    %edx,0x10785c
  10279d:	74 19                	je     1027b8 <cpu+0x38>
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  10279f:	8b 15 b8 aa 10 00    	mov    0x10aab8,%edx
    return lapic[ID]>>24;
  return 0;
  1027a5:	31 c0                	xor    %eax,%eax
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  1027a7:	85 d2                	test   %edx,%edx
  1027a9:	74 06                	je     1027b1 <cpu+0x31>
    return lapic[ID]>>24;
  1027ab:	8b 42 20             	mov    0x20(%edx),%eax
  1027ae:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  1027b1:	c9                   	leave  
  1027b2:	c3                   	ret    
  1027b3:	90                   	nop
  1027b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uint
read_ebp(void)
{
  uint ebp;
  
  asm volatile("movl %%ebp, %0" : "=a" (ebp));
  1027b8:	89 e8                	mov    %ebp,%eax
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  1027ba:	8b 40 04             	mov    0x4(%eax),%eax
  1027bd:	c7 04 24 50 64 10 00 	movl   $0x106450,(%esp)
  1027c4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1027c8:	e8 83 dd ff ff       	call   100550 <cprintf>
  1027cd:	eb d0                	jmp    10279f <cpu+0x1f>
  1027cf:	90                   	nop

001027d0 <lapic_eoi>:

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  if(lapic)
  1027d0:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
}

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  1027d5:	55                   	push   %ebp
  1027d6:	89 e5                	mov    %esp,%ebp
  if(lapic)
  1027d8:	85 c0                	test   %eax,%eax
  1027da:	74 0d                	je     1027e9 <lapic_eoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027dc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1027e3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1027e6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapic_eoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
  1027e9:	5d                   	pop    %ebp
  1027ea:	c3                   	ret    
  1027eb:	90                   	nop
  1027ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001027f0 <lapic_startap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapic_startap(uchar apicid, uint addr)
{
  1027f0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1027f1:	ba 70 00 00 00       	mov    $0x70,%edx
  1027f6:	89 e5                	mov    %esp,%ebp
  1027f8:	b8 0f 00 00 00       	mov    $0xf,%eax
  1027fd:	56                   	push   %esi
  1027fe:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
  102802:	53                   	push   %ebx
  102803:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  102806:	ee                   	out    %al,(%dx)
  102807:	b8 0a 00 00 00       	mov    $0xa,%eax
  10280c:	b2 71                	mov    $0x71,%dl
  10280e:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  10280f:	89 d8                	mov    %ebx,%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102811:	89 ce                	mov    %ecx,%esi
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  102813:	c1 e8 04             	shr    $0x4,%eax
  102816:	66 a3 69 04 00 00    	mov    %ax,0x469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10281c:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102821:	c1 e6 18             	shl    $0x18,%esi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  102824:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  10282b:	00 00 
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  microdelay(100);	// should be 10ms, but too slow in Bochs!
  10282d:	c1 eb 0c             	shr    $0xc,%ebx
  102830:	80 cf 06             	or     $0x6,%bh
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102833:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102839:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10283c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  102843:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102846:	8b 40 20             	mov    0x20(%eax),%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  102849:	b8 c8 00 00 00       	mov    $0xc8,%eax
  10284e:	e8 ed fd ff ff       	call   102640 <microdelay>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102853:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
  102858:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  10285f:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102862:	8b 40 20             	mov    0x20(%eax),%eax
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  microdelay(100);	// should be 10ms, but too slow in Bochs!
  102865:	b8 64 00 00 00       	mov    $0x64,%eax
  10286a:	e8 d1 fd ff ff       	call   102640 <microdelay>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10286f:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
  102874:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10287a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10287d:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102883:	8b 40 20             	mov    0x20(%eax),%eax
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  102886:	b8 c8 00 00 00       	mov    $0xc8,%eax
  10288b:	e8 b0 fd ff ff       	call   102640 <microdelay>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102890:	a1 b8 aa 10 00       	mov    0x10aab8,%eax
  102895:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10289b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10289e:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1028a4:	8b 40 20             	mov    0x20(%eax),%eax
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  1028a7:	b8 c8 00 00 00       	mov    $0xc8,%eax
  }
}
  1028ac:	5b                   	pop    %ebx
  1028ad:	5e                   	pop    %esi
  1028ae:	5d                   	pop    %ebp
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  1028af:	e9 8c fd ff ff       	jmp    102640 <microdelay>
  1028b4:	90                   	nop
  1028b5:	90                   	nop
  1028b6:	90                   	nop
  1028b7:	90                   	nop
  1028b8:	90                   	nop
  1028b9:	90                   	nop
  1028ba:	90                   	nop
  1028bb:	90                   	nop
  1028bc:	90                   	nop
  1028bd:	90                   	nop
  1028be:	90                   	nop
  1028bf:	90                   	nop

001028c0 <mpmain>:

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  1028c0:	55                   	push   %ebp
  1028c1:	89 e5                	mov    %esp,%ebp
  1028c3:	53                   	push   %ebx
  1028c4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: mpmain\n", cpu());
  1028c7:	e8 b4 fe ff ff       	call   102780 <cpu>
  1028cc:	c7 04 24 7c 64 10 00 	movl   $0x10647c,(%esp)
  1028d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1028d7:	e8 74 dc ff ff       	call   100550 <cprintf>
  idtinit();
  1028dc:	e8 2f 2a 00 00       	call   105310 <idtinit>
  if(cpu() != mp_bcpu())
  1028e1:	e8 9a fe ff ff       	call   102780 <cpu>
  1028e6:	89 c3                	mov    %eax,%ebx
  1028e8:	e8 23 02 00 00       	call   102b10 <mp_bcpu>
  1028ed:	39 c3                	cmp    %eax,%ebx
  1028ef:	74 0d                	je     1028fe <mpmain+0x3e>
    lapic_init(cpu());
  1028f1:	e8 8a fe ff ff       	call   102780 <cpu>
  1028f6:	89 04 24             	mov    %eax,(%esp)
  1028f9:	e8 92 fd ff ff       	call   102690 <lapic_init>
  setupsegs(0);
  1028fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  102905:	e8 66 08 00 00       	call   103170 <setupsegs>
  xchg(&cpus[cpu()].booted, 1);
  10290a:	e8 71 fe ff ff       	call   102780 <cpu>
  10290f:	69 d0 cc 00 00 00    	imul   $0xcc,%eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102915:	b8 01 00 00 00       	mov    $0x1,%eax
  10291a:	81 c2 c0 00 00 00    	add    $0xc0,%edx
  102920:	f0 87 82 e0 aa 10 00 	lock xchg %eax,0x10aae0(%edx)

  cprintf("cpu%d: scheduling\n");
  102927:	c7 04 24 8b 64 10 00 	movl   $0x10648b,(%esp)
  10292e:	e8 1d dc ff ff       	call   100550 <cprintf>
  scheduler();
  102933:	e8 f8 0d 00 00       	call   103730 <scheduler>
  102938:	90                   	nop
  102939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102940 <main>:
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  102940:	55                   	push   %ebp
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  102941:	b8 e4 df 10 00       	mov    $0x10dfe4,%eax
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  102946:	89 e5                	mov    %esp,%ebp
  102948:	83 e4 f0             	and    $0xfffffff0,%esp
  10294b:	53                   	push   %ebx
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  10294c:	2d 8e 77 10 00       	sub    $0x10778e,%eax
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  102951:	83 ec 1c             	sub    $0x1c,%esp
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  102954:	89 44 24 08          	mov    %eax,0x8(%esp)
  102958:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10295f:	00 
  102960:	c7 04 24 8e 77 10 00 	movl   $0x10778e,(%esp)
  102967:	e8 b4 16 00 00       	call   104020 <memset>

  mp_init(); // collect info about this machine
  10296c:	e8 bf 01 00 00       	call   102b30 <mp_init>
  lapic_init(mp_bcpu());
  102971:	e8 9a 01 00 00       	call   102b10 <mp_bcpu>
  102976:	89 04 24             	mov    %eax,(%esp)
  102979:	e8 12 fd ff ff       	call   102690 <lapic_init>
  cprintf("\ncpu%d: starting xv6\n\n", cpu());
  10297e:	e8 fd fd ff ff       	call   102780 <cpu>
  102983:	c7 04 24 9e 64 10 00 	movl   $0x10649e,(%esp)
  10298a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10298e:	e8 bd db ff ff       	call   100550 <cprintf>

  pinit();         // process table
  102993:	e8 b8 07 00 00       	call   103150 <pinit>
  binit();         // buffer cache
  102998:	e8 63 d6 ff ff       	call   100000 <binit>
  10299d:	8d 76 00             	lea    0x0(%esi),%esi
  pic_init();      // interrupt controller
  1029a0:	e8 9b 03 00 00       	call   102d40 <pic_init>
  ioapic_init();   // another interrupt controller
  1029a5:	e8 96 f8 ff ff       	call   102240 <ioapic_init>
  kinit();         // physical memory allocator
  1029aa:	e8 91 fa ff ff       	call   102440 <kinit>
  1029af:	90                   	nop
  tvinit();        // trap vectors
  1029b0:	e8 cb 28 00 00       	call   105280 <tvinit>
  fileinit();      // file table
  1029b5:	e8 c6 e3 ff ff       	call   100d80 <fileinit>
  iinit();         // inode cache
  1029ba:	e8 f1 ea ff ff       	call   1014b0 <iinit>
  1029bf:	90                   	nop
  console_init();  // I/O devices & their interrupts
  1029c0:	e8 cb de ff ff       	call   100890 <console_init>
  ide_init();      // disk
  1029c5:	e8 96 f6 ff ff       	call   102060 <ide_init>
  if(!ismp)
  1029ca:	a1 c0 aa 10 00       	mov    0x10aac0,%eax
  1029cf:	85 c0                	test   %eax,%eax
  1029d1:	0f 84 b1 00 00 00    	je     102a88 <main+0x148>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  1029d7:	e8 54 0b 00 00       	call   103530 <userinit>
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1029dc:	c7 44 24 08 5a 00 00 	movl   $0x5a,0x8(%esp)
  1029e3:	00 
  1029e4:	c7 44 24 04 34 77 10 	movl   $0x107734,0x4(%esp)
  1029eb:	00 
  1029ec:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1029f3:	e8 b8 16 00 00       	call   1040b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1029f8:	69 05 40 b1 10 00 cc 	imul   $0xcc,0x10b140,%eax
  1029ff:	00 00 00 
  102a02:	05 e0 aa 10 00       	add    $0x10aae0,%eax
  102a07:	3d e0 aa 10 00       	cmp    $0x10aae0,%eax
  102a0c:	76 75                	jbe    102a83 <main+0x143>
  102a0e:	bb e0 aa 10 00       	mov    $0x10aae0,%ebx
  102a13:	90                   	nop
  102a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpu())  // We've started already.
  102a18:	e8 63 fd ff ff       	call   102780 <cpu>
  102a1d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  102a23:	05 e0 aa 10 00       	add    $0x10aae0,%eax
  102a28:	39 c3                	cmp    %eax,%ebx
  102a2a:	74 3e                	je     102a6a <main+0x12a>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
  102a2c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  102a33:	e8 58 fa ff ff       	call   102490 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  102a38:	c7 05 f8 6f 00 00 c0 	movl   $0x1028c0,0x6ff8
  102a3f:	28 10 00 
    if(c == cpus+cpu())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
    *(void**)(code-4) = stack + KSTACKSIZE;
  102a42:	05 00 10 00 00       	add    $0x1000,%eax
  102a47:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapic_startap(c->apicid, (uint)code);
  102a4c:	0f b6 03             	movzbl (%ebx),%eax
  102a4f:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102a56:	00 
  102a57:	89 04 24             	mov    %eax,(%esp)
  102a5a:	e8 91 fd ff ff       	call   1027f0 <lapic_startap>
  102a5f:	90                   	nop

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
  102a60:	8b 83 c0 00 00 00    	mov    0xc0(%ebx),%eax
  102a66:	85 c0                	test   %eax,%eax
  102a68:	74 f6                	je     102a60 <main+0x120>

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  102a6a:	69 05 40 b1 10 00 cc 	imul   $0xcc,0x10b140,%eax
  102a71:	00 00 00 
  102a74:	81 c3 cc 00 00 00    	add    $0xcc,%ebx
  102a7a:	05 e0 aa 10 00       	add    $0x10aae0,%eax
  102a7f:	39 c3                	cmp    %eax,%ebx
  102a81:	72 95                	jb     102a18 <main+0xd8>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102a83:	e8 38 fe ff ff       	call   1028c0 <mpmain>
  fileinit();      // file table
  iinit();         // inode cache
  console_init();  // I/O devices & their interrupts
  ide_init();      // disk
  if(!ismp)
    timer_init();  // uniprocessor timer
  102a88:	e8 93 27 00 00       	call   105220 <timer_init>
  102a8d:	8d 76 00             	lea    0x0(%esi),%esi
  102a90:	e9 42 ff ff ff       	jmp    1029d7 <main+0x97>
  102a95:	90                   	nop
  102a96:	90                   	nop
  102a97:	90                   	nop
  102a98:	90                   	nop
  102a99:	90                   	nop
  102a9a:	90                   	nop
  102a9b:	90                   	nop
  102a9c:	90                   	nop
  102a9d:	90                   	nop
  102a9e:	90                   	nop
  102a9f:	90                   	nop

00102aa0 <mp_search1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102aa0:	55                   	push   %ebp
  102aa1:	89 e5                	mov    %esp,%ebp
  102aa3:	56                   	push   %esi
  102aa4:	53                   	push   %ebx
  102aa5:	89 c3                	mov    %eax,%ebx
  uchar *e, *p;

  e = addr+len;
  102aa7:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102aaa:	83 ec 10             	sub    $0x10,%esp

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
  102aad:	31 c0                	xor    %eax,%eax
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102aaf:	39 f3                	cmp    %esi,%ebx
  102ab1:	73 40                	jae    102af3 <mp_search1+0x53>
  102ab3:	90                   	nop
  102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102ab8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102abf:	00 
  102ac0:	c7 44 24 04 b5 64 10 	movl   $0x1064b5,0x4(%esp)
  102ac7:	00 
  102ac8:	89 1c 24             	mov    %ebx,(%esp)
  102acb:	e8 80 15 00 00       	call   104050 <memcmp>
  102ad0:	85 c0                	test   %eax,%eax
  102ad2:	75 16                	jne    102aea <mp_search1+0x4a>
  102ad4:	31 d2                	xor    %edx,%edx
  102ad6:	66 90                	xchg   %ax,%ax
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  102ad8:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102adc:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  102adf:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102ae1:	83 f8 10             	cmp    $0x10,%eax
  102ae4:	75 f2                	jne    102ad8 <mp_search1+0x38>
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102ae6:	84 d2                	test   %dl,%dl
  102ae8:	74 10                	je     102afa <mp_search1+0x5a>
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102aea:	83 c3 10             	add    $0x10,%ebx
  102aed:	39 de                	cmp    %ebx,%esi
  102aef:	77 c7                	ja     102ab8 <mp_search1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
  102af1:	31 c0                	xor    %eax,%eax
}
  102af3:	83 c4 10             	add    $0x10,%esp
  102af6:	5b                   	pop    %ebx
  102af7:	5e                   	pop    %esi
  102af8:	5d                   	pop    %ebp
  102af9:	c3                   	ret    
  102afa:	83 c4 10             	add    $0x10,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  102afd:	89 d8                	mov    %ebx,%eax
  return 0;
}
  102aff:	5b                   	pop    %ebx
  102b00:	5e                   	pop    %esi
  102b01:	5d                   	pop    %ebp
  102b02:	c3                   	ret    
  102b03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102b10 <mp_bcpu>:
uchar ioapic_id;

int
mp_bcpu(void)
{
  return bcpu-cpus;
  102b10:	a1 60 78 10 00       	mov    0x107860,%eax
int ncpu;
uchar ioapic_id;

int
mp_bcpu(void)
{
  102b15:	55                   	push   %ebp
  102b16:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  102b18:	5d                   	pop    %ebp
uchar ioapic_id;

int
mp_bcpu(void)
{
  return bcpu-cpus;
  102b19:	2d e0 aa 10 00       	sub    $0x10aae0,%eax
  102b1e:	c1 f8 02             	sar    $0x2,%eax
  102b21:	69 c0 fb fa fa fa    	imul   $0xfafafafb,%eax,%eax
}
  102b27:	c3                   	ret    
  102b28:	90                   	nop
  102b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102b30 <mp_init>:
  return conf;
}

void
mp_init(void)
{
  102b30:	55                   	push   %ebp
  102b31:	89 e5                	mov    %esp,%ebp
  102b33:	57                   	push   %edi
  102b34:	56                   	push   %esi
  102b35:	53                   	push   %ebx
  102b36:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102b39:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  102b40:	69 05 40 b1 10 00 cc 	imul   $0xcc,0x10b140,%eax
  102b47:	00 00 00 
  102b4a:	05 e0 aa 10 00       	add    $0x10aae0,%eax
  102b4f:	a3 60 78 10 00       	mov    %eax,0x107860
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102b54:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102b5b:	c1 e0 08             	shl    $0x8,%eax
  102b5e:	09 d0                	or     %edx,%eax
  102b60:	c1 e0 04             	shl    $0x4,%eax
  102b63:	85 c0                	test   %eax,%eax
  102b65:	75 1b                	jne    102b82 <mp_init+0x52>
    if((mp = mp_search1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  102b67:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102b6e:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102b75:	c1 e0 08             	shl    $0x8,%eax
  102b78:	09 d0                	or     %edx,%eax
  102b7a:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mp_search1((uchar*)p-1024, 1024)))
  102b7d:	2d 00 04 00 00       	sub    $0x400,%eax
  102b82:	ba 00 04 00 00       	mov    $0x400,%edx
  102b87:	e8 14 ff ff ff       	call   102aa0 <mp_search1>
  102b8c:	85 c0                	test   %eax,%eax
  102b8e:	89 c3                	mov    %eax,%ebx
  102b90:	0f 84 b2 00 00 00    	je     102c48 <mp_init+0x118>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102b96:	8b 73 04             	mov    0x4(%ebx),%esi
  102b99:	85 f6                	test   %esi,%esi
  102b9b:	75 0b                	jne    102ba8 <mp_init+0x78>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102b9d:	83 c4 2c             	add    $0x2c,%esp
  102ba0:	5b                   	pop    %ebx
  102ba1:	5e                   	pop    %esi
  102ba2:	5f                   	pop    %edi
  102ba3:	5d                   	pop    %ebp
  102ba4:	c3                   	ret    
  102ba5:	8d 76 00             	lea    0x0(%esi),%esi
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  102ba8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102baf:	00 
  102bb0:	c7 44 24 04 ba 64 10 	movl   $0x1064ba,0x4(%esp)
  102bb7:	00 
  102bb8:	89 34 24             	mov    %esi,(%esp)
  102bbb:	e8 90 14 00 00       	call   104050 <memcmp>
  102bc0:	85 c0                	test   %eax,%eax
  102bc2:	75 d9                	jne    102b9d <mp_init+0x6d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102bc4:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  102bc8:	3c 04                	cmp    $0x4,%al
  102bca:	74 04                	je     102bd0 <mp_init+0xa0>
  102bcc:	3c 01                	cmp    $0x1,%al
  102bce:	75 cd                	jne    102b9d <mp_init+0x6d>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102bd0:	0f b7 56 04          	movzwl 0x4(%esi),%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102bd4:	85 d2                	test   %edx,%edx
  102bd6:	74 15                	je     102bed <mp_init+0xbd>
  102bd8:	31 c9                	xor    %ecx,%ecx
  102bda:	31 c0                	xor    %eax,%eax
    sum += addr[i];
  102bdc:	0f b6 3c 06          	movzbl (%esi,%eax,1),%edi
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102be0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  102be3:	01 f9                	add    %edi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102be5:	39 c2                	cmp    %eax,%edx
  102be7:	7f f3                	jg     102bdc <mp_init+0xac>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102be9:	84 c9                	test   %cl,%cl
  102beb:	75 b0                	jne    102b9d <mp_init+0x6d>
  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102bed:	8b 46 24             	mov    0x24(%esi),%eax

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102bf0:	8d 14 16             	lea    (%esi,%edx,1),%edx

  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  102bf3:	c7 05 c0 aa 10 00 01 	movl   $0x1,0x10aac0
  102bfa:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102bfd:	a3 b8 aa 10 00       	mov    %eax,0x10aab8

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102c02:	8d 46 2c             	lea    0x2c(%esi),%eax
  102c05:	39 d0                	cmp    %edx,%eax
  102c07:	0f 83 83 00 00 00    	jae    102c90 <mp_init+0x160>
  102c0d:	8b 0d 60 78 10 00    	mov    0x107860,%ecx
  102c13:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    switch(*p){
  102c16:	0f b6 30             	movzbl (%eax),%esi
  102c19:	89 f3                	mov    %esi,%ebx
  102c1b:	80 fb 04             	cmp    $0x4,%bl
  102c1e:	76 50                	jbe    102c70 <mp_init+0x140>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102c20:	81 e6 ff 00 00 00    	and    $0xff,%esi
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  102c26:	89 0d 60 78 10 00    	mov    %ecx,0x107860
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102c2c:	89 74 24 04          	mov    %esi,0x4(%esp)
  102c30:	c7 04 24 c8 64 10 00 	movl   $0x1064c8,(%esp)
  102c37:	e8 14 d9 ff ff       	call   100550 <cprintf>
      panic("mp_init");
  102c3c:	c7 04 24 bf 64 10 00 	movl   $0x1064bf,(%esp)
  102c43:	e8 b8 dc ff ff       	call   100900 <panic>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102c48:	ba 00 00 01 00       	mov    $0x10000,%edx
  102c4d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102c52:	e8 49 fe ff ff       	call   102aa0 <mp_search1>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102c57:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102c59:	89 c3                	mov    %eax,%ebx
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102c5b:	0f 85 35 ff ff ff    	jne    102b96 <mp_init+0x66>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102c61:	83 c4 2c             	add    $0x2c,%esp
  102c64:	5b                   	pop    %ebx
  102c65:	5e                   	pop    %esi
  102c66:	5f                   	pop    %edi
  102c67:	5d                   	pop    %ebp
  102c68:	c3                   	ret    
  102c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102c70:	81 e6 ff 00 00 00    	and    $0xff,%esi
  102c76:	ff 24 b5 ec 64 10 00 	jmp    *0x1064ec(,%esi,4)
  102c7d:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102c80:	83 c0 08             	add    $0x8,%eax
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102c83:	39 c2                	cmp    %eax,%edx
  102c85:	77 8f                	ja     102c16 <mp_init+0xe6>
  102c87:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  102c8a:	89 0d 60 78 10 00    	mov    %ecx,0x107860
      cprintf("mp_init: unknown config type %x\n", *p);
      panic("mp_init");
    }
  }

  if(mp->imcrp){
  102c90:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
  102c94:	0f 84 03 ff ff ff    	je     102b9d <mp_init+0x6d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102c9a:	ba 22 00 00 00       	mov    $0x22,%edx
  102c9f:	b8 70 00 00 00       	mov    $0x70,%eax
  102ca4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102ca5:	b2 23                	mov    $0x23,%dl
  102ca7:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  102ca8:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102cab:	ee                   	out    %al,(%dx)
  102cac:	e9 ec fe ff ff       	jmp    102b9d <mp_init+0x6d>
  102cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102cb8:	0f b6 70 01          	movzbl 0x1(%eax),%esi
      p += sizeof(struct mpioapic);
  102cbc:	83 c0 08             	add    $0x8,%eax
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102cbf:	89 f3                	mov    %esi,%ebx
  102cc1:	88 1d c4 aa 10 00    	mov    %bl,0x10aac4
      p += sizeof(struct mpioapic);
      continue;
  102cc7:	eb ba                	jmp    102c83 <mp_init+0x153>
  102cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
  102cd0:	69 35 40 b1 10 00 cc 	imul   $0xcc,0x10b140,%esi
  102cd7:	00 00 00 
  102cda:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
  102cde:	8d be e0 aa 10 00    	lea    0x10aae0(%esi),%edi
  102ce4:	88 9e e0 aa 10 00    	mov    %bl,0x10aae0(%esi)
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      ncpu++;
  102cea:	8b 35 40 b1 10 00    	mov    0x10b140,%esi
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
  102cf0:	f6 40 03 02          	testb  $0x2,0x3(%eax)
  102cf4:	0f 45 cf             	cmovne %edi,%ecx
      ncpu++;
  102cf7:	83 c6 01             	add    $0x1,%esi
  102cfa:	89 35 40 b1 10 00    	mov    %esi,0x10b140
      p += sizeof(struct mpproc);
  102d00:	83 c0 14             	add    $0x14,%eax
      continue;
  102d03:	e9 7b ff ff ff       	jmp    102c83 <mp_init+0x153>
  102d08:	90                   	nop
  102d09:	90                   	nop
  102d0a:	90                   	nop
  102d0b:	90                   	nop
  102d0c:	90                   	nop
  102d0d:	90                   	nop
  102d0e:	90                   	nop
  102d0f:	90                   	nop

00102d10 <pic_enable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102d10:	55                   	push   %ebp
  pic_setmask(irqmask & ~(1<<irq));
  102d11:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102d16:	89 e5                	mov    %esp,%ebp
  102d18:	ba 21 00 00 00       	mov    $0x21,%edx
  pic_setmask(irqmask & ~(1<<irq));
  102d1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  102d20:	d3 c0                	rol    %cl,%eax
  102d22:	66 23 05 00 73 10 00 	and    0x107300,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  102d29:	66 a3 00 73 10 00    	mov    %ax,0x107300
  102d2f:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
  102d30:	66 c1 e8 08          	shr    $0x8,%ax
  102d34:	b2 a1                	mov    $0xa1,%dl
  102d36:	ee                   	out    %al,(%dx)

void
pic_enable(int irq)
{
  pic_setmask(irqmask & ~(1<<irq));
}
  102d37:	5d                   	pop    %ebp
  102d38:	c3                   	ret    
  102d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102d40 <pic_init>:

// Initialize the 8259A interrupt controllers.
void
pic_init(void)
{
  102d40:	55                   	push   %ebp
  102d41:	b9 21 00 00 00       	mov    $0x21,%ecx
  102d46:	89 e5                	mov    %esp,%ebp
  102d48:	83 ec 0c             	sub    $0xc,%esp
  102d4b:	89 1c 24             	mov    %ebx,(%esp)
  102d4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102d53:	89 ca                	mov    %ecx,%edx
  102d55:	89 74 24 04          	mov    %esi,0x4(%esp)
  102d59:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102d5d:	ee                   	out    %al,(%dx)
  102d5e:	bb a1 00 00 00       	mov    $0xa1,%ebx
  102d63:	89 da                	mov    %ebx,%edx
  102d65:	ee                   	out    %al,(%dx)
  102d66:	be 11 00 00 00       	mov    $0x11,%esi
  102d6b:	b2 20                	mov    $0x20,%dl
  102d6d:	89 f0                	mov    %esi,%eax
  102d6f:	ee                   	out    %al,(%dx)
  102d70:	b8 20 00 00 00       	mov    $0x20,%eax
  102d75:	89 ca                	mov    %ecx,%edx
  102d77:	ee                   	out    %al,(%dx)
  102d78:	b8 04 00 00 00       	mov    $0x4,%eax
  102d7d:	ee                   	out    %al,(%dx)
  102d7e:	bf 03 00 00 00       	mov    $0x3,%edi
  102d83:	89 f8                	mov    %edi,%eax
  102d85:	ee                   	out    %al,(%dx)
  102d86:	b1 a0                	mov    $0xa0,%cl
  102d88:	89 f0                	mov    %esi,%eax
  102d8a:	89 ca                	mov    %ecx,%edx
  102d8c:	ee                   	out    %al,(%dx)
  102d8d:	b8 28 00 00 00       	mov    $0x28,%eax
  102d92:	89 da                	mov    %ebx,%edx
  102d94:	ee                   	out    %al,(%dx)
  102d95:	b8 02 00 00 00       	mov    $0x2,%eax
  102d9a:	ee                   	out    %al,(%dx)
  102d9b:	89 f8                	mov    %edi,%eax
  102d9d:	ee                   	out    %al,(%dx)
  102d9e:	be 68 00 00 00       	mov    $0x68,%esi
  102da3:	b2 20                	mov    $0x20,%dl
  102da5:	89 f0                	mov    %esi,%eax
  102da7:	ee                   	out    %al,(%dx)
  102da8:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102dad:	89 d8                	mov    %ebx,%eax
  102daf:	ee                   	out    %al,(%dx)
  102db0:	89 f0                	mov    %esi,%eax
  102db2:	89 ca                	mov    %ecx,%edx
  102db4:	ee                   	out    %al,(%dx)
  102db5:	89 d8                	mov    %ebx,%eax
  102db7:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102db8:	0f b7 05 00 73 10 00 	movzwl 0x107300,%eax
  102dbf:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102dc3:	74 0a                	je     102dcf <pic_init+0x8f>
  102dc5:	b2 21                	mov    $0x21,%dl
  102dc7:	ee                   	out    %al,(%dx)
static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
  102dc8:	66 c1 e8 08          	shr    $0x8,%ax
  102dcc:	b2 a1                	mov    $0xa1,%dl
  102dce:	ee                   	out    %al,(%dx)
  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    pic_setmask(irqmask);
}
  102dcf:	8b 1c 24             	mov    (%esp),%ebx
  102dd2:	8b 74 24 04          	mov    0x4(%esp),%esi
  102dd6:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102dda:	89 ec                	mov    %ebp,%esp
  102ddc:	5d                   	pop    %ebp
  102ddd:	c3                   	ret    
  102dde:	90                   	nop
  102ddf:	90                   	nop

00102de0 <pipealloc>:
  char data[PIPESIZE];
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102de0:	55                   	push   %ebp
  102de1:	89 e5                	mov    %esp,%ebp
  102de3:	57                   	push   %edi
  102de4:	56                   	push   %esi
  102de5:	53                   	push   %ebx
  102de6:	83 ec 2c             	sub    $0x2c,%esp
  102de9:	8b 75 08             	mov    0x8(%ebp),%esi
  102dec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102def:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  102df5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102dfb:	e8 a0 df ff ff       	call   100da0 <filealloc>
  102e00:	85 c0                	test   %eax,%eax
  102e02:	89 06                	mov    %eax,(%esi)
  102e04:	0f 84 9a 00 00 00    	je     102ea4 <pipealloc+0xc4>
  102e0a:	e8 91 df ff ff       	call   100da0 <filealloc>
  102e0f:	85 c0                	test   %eax,%eax
  102e11:	89 03                	mov    %eax,(%ebx)
  102e13:	74 7b                	je     102e90 <pipealloc+0xb0>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  102e15:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  102e1c:	e8 6f f6 ff ff       	call   102490 <kalloc>
  102e21:	85 c0                	test   %eax,%eax
  102e23:	89 c7                	mov    %eax,%edi
  102e25:	74 69                	je     102e90 <pipealloc+0xb0>
    goto bad;
  p->readopen = 1;
  102e27:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  p->writeopen = 1;
  102e2d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
  p->writep = 0;
  102e34:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  p->readp = 0;
  102e3b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  initlock(&p->lock, "pipe");
  102e42:	8d 40 10             	lea    0x10(%eax),%eax
  102e45:	89 04 24             	mov    %eax,(%esp)
  102e48:	c7 44 24 04 00 65 10 	movl   $0x106500,0x4(%esp)
  102e4f:	00 
  102e50:	e8 9b 0f 00 00       	call   103df0 <initlock>
  (*f0)->type = FD_PIPE;
  102e55:	8b 06                	mov    (%esi),%eax
  (*f0)->readable = 1;
  102e57:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->readopen = 1;
  p->writeopen = 1;
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  102e5b:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  102e61:	8b 06                	mov    (%esi),%eax
  102e63:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102e67:	8b 06                	mov    (%esi),%eax
  102e69:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102e6c:	8b 03                	mov    (%ebx),%eax
  (*f1)->readable = 0;
  102e6e:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  102e72:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  102e78:	8b 03                	mov    (%ebx),%eax
  102e7a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102e7e:	8b 03                	mov    (%ebx),%eax
  102e80:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
  102e83:	31 c0                	xor    %eax,%eax
  if(*f1){
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
}
  102e85:	83 c4 2c             	add    $0x2c,%esp
  102e88:	5b                   	pop    %ebx
  102e89:	5e                   	pop    %esi
  102e8a:	5f                   	pop    %edi
  102e8b:	5d                   	pop    %ebp
  102e8c:	c3                   	ret    
  102e8d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;

 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0){
  102e90:	8b 06                	mov    (%esi),%eax
  102e92:	85 c0                	test   %eax,%eax
  102e94:	74 0e                	je     102ea4 <pipealloc+0xc4>
    (*f0)->type = FD_NONE;
  102e96:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    fileclose(*f0);
  102e9c:	89 04 24             	mov    %eax,(%esp)
  102e9f:	e8 cc df ff ff       	call   100e70 <fileclose>
  }
  if(*f1){
  102ea4:	8b 13                	mov    (%ebx),%edx
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
  102ea6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    kfree((char*)p, PAGE);
  if(*f0){
    (*f0)->type = FD_NONE;
    fileclose(*f0);
  }
  if(*f1){
  102eab:	85 d2                	test   %edx,%edx
  102ead:	74 d6                	je     102e85 <pipealloc+0xa5>
    (*f1)->type = FD_NONE;
  102eaf:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    fileclose(*f1);
  102eb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102eb8:	89 14 24             	mov    %edx,(%esp)
  102ebb:	e8 b0 df ff ff       	call   100e70 <fileclose>
  102ec0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102ec3:	eb c0                	jmp    102e85 <pipealloc+0xa5>
  102ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102ed0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  102ed0:	55                   	push   %ebp
  102ed1:	89 e5                	mov    %esp,%ebp
  102ed3:	83 ec 28             	sub    $0x28,%esp
  102ed6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  102ed9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102edc:	89 7d fc             	mov    %edi,-0x4(%ebp)
  102edf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  102ee2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquire(&p->lock);
  102ee5:	8d 73 10             	lea    0x10(%ebx),%esi
  102ee8:	89 34 24             	mov    %esi,(%esp)
  102eeb:	e8 00 10 00 00       	call   103ef0 <acquire>
  if(writable){
  102ef0:	85 ff                	test   %edi,%edi
  102ef2:	74 34                	je     102f28 <pipeclose+0x58>
    p->writeopen = 0;
  102ef4:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    wakeup(&p->readp);
  102efb:	8d 43 0c             	lea    0xc(%ebx),%eax
  102efe:	89 04 24             	mov    %eax,(%esp)
  102f01:	e8 aa 0a 00 00       	call   1039b0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  }
  release(&p->lock);
  102f06:	89 34 24             	mov    %esi,(%esp)
  102f09:	e8 d2 10 00 00       	call   103fe0 <release>

  if(p->readopen == 0 && p->writeopen == 0)
  102f0e:	8b 13                	mov    (%ebx),%edx
  102f10:	85 d2                	test   %edx,%edx
  102f12:	75 07                	jne    102f1b <pipeclose+0x4b>
  102f14:	8b 43 04             	mov    0x4(%ebx),%eax
  102f17:	85 c0                	test   %eax,%eax
  102f19:	74 25                	je     102f40 <pipeclose+0x70>
    kfree((char*)p, PAGE);
}
  102f1b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102f1e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  102f21:	8b 7d fc             	mov    -0x4(%ebp),%edi
  102f24:	89 ec                	mov    %ebp,%esp
  102f26:	5d                   	pop    %ebp
  102f27:	c3                   	ret    
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
  102f28:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    wakeup(&p->writep);
  102f2e:	8d 43 08             	lea    0x8(%ebx),%eax
  102f31:	89 04 24             	mov    %eax,(%esp)
  102f34:	e8 77 0a 00 00       	call   1039b0 <wakeup>
  102f39:	eb cb                	jmp    102f06 <pipeclose+0x36>
  102f3b:	90                   	nop
  102f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  102f40:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  102f43:	8b 75 f8             	mov    -0x8(%ebp),%esi
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  102f46:	c7 45 0c 00 10 00 00 	movl   $0x1000,0xc(%ebp)
}
  102f4d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102f50:	8b 7d fc             	mov    -0x4(%ebp),%edi
  102f53:	89 ec                	mov    %ebp,%esp
  102f55:	5d                   	pop    %ebp
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  102f56:	e9 d5 f3 ff ff       	jmp    102330 <kfree>
  102f5b:	90                   	nop
  102f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102f60 <pipewrite>:
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102f60:	55                   	push   %ebp
  102f61:	89 e5                	mov    %esp,%ebp
  102f63:	57                   	push   %edi
  102f64:	56                   	push   %esi
  102f65:	53                   	push   %ebx
  102f66:	83 ec 3c             	sub    $0x3c,%esp
  102f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102f6c:	8d 73 10             	lea    0x10(%ebx),%esi
  102f6f:	89 34 24             	mov    %esi,(%esp)
  102f72:	e8 79 0f 00 00       	call   103ef0 <acquire>
  for(i = 0; i < n; i++){
  102f77:	8b 55 10             	mov    0x10(%ebp),%edx
  102f7a:	85 d2                	test   %edx,%edx
  102f7c:	0f 8e d9 00 00 00    	jle    10305b <pipewrite+0xfb>
  102f82:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
  102f85:	8d 53 08             	lea    0x8(%ebx),%edx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102f88:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102f8f:	8d 7b 0c             	lea    0xc(%ebx),%edi
      sleep(&p->writep, &p->lock);
  102f92:	89 55 e4             	mov    %edx,-0x1c(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  102f95:	8d 50 01             	lea    0x1(%eax),%edx
  102f98:	89 d1                	mov    %edx,%ecx
  102f9a:	c1 f9 1f             	sar    $0x1f,%ecx
  102f9d:	c1 e9 17             	shr    $0x17,%ecx
  102fa0:	01 ca                	add    %ecx,%edx
  102fa2:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102fa8:	29 ca                	sub    %ecx,%edx
  102faa:	3b 53 0c             	cmp    0xc(%ebx),%edx
  102fad:	74 48                	je     102ff7 <pipewrite+0x97>
  102faf:	e9 a0 00 00 00       	jmp    103054 <pipewrite+0xf4>
  102fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || cp->killed){
  102fb8:	e8 53 06 00 00       	call   103610 <curproc>
  102fbd:	8b 48 1c             	mov    0x1c(%eax),%ecx
  102fc0:	85 c9                	test   %ecx,%ecx
  102fc2:	75 39                	jne    102ffd <pipewrite+0x9d>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102fc4:	89 3c 24             	mov    %edi,(%esp)
  102fc7:	e8 e4 09 00 00       	call   1039b0 <wakeup>
      sleep(&p->writep, &p->lock);
  102fcc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  102fcf:	89 74 24 04          	mov    %esi,0x4(%esp)
  102fd3:	89 0c 24             	mov    %ecx,(%esp)
  102fd6:	e8 05 09 00 00       	call   1038e0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  102fdb:	8b 4b 08             	mov    0x8(%ebx),%ecx
  102fde:	8d 41 01             	lea    0x1(%ecx),%eax
  102fe1:	89 c2                	mov    %eax,%edx
  102fe3:	c1 fa 1f             	sar    $0x1f,%edx
  102fe6:	c1 ea 17             	shr    $0x17,%edx
  102fe9:	01 d0                	add    %edx,%eax
  102feb:	25 ff 01 00 00       	and    $0x1ff,%eax
  102ff0:	29 d0                	sub    %edx,%eax
  102ff2:	3b 43 0c             	cmp    0xc(%ebx),%eax
  102ff5:	75 21                	jne    103018 <pipewrite+0xb8>
      if(p->readopen == 0 || cp->killed){
  102ff7:	8b 03                	mov    (%ebx),%eax
  102ff9:	85 c0                	test   %eax,%eax
  102ffb:	75 bb                	jne    102fb8 <pipewrite+0x58>
        release(&p->lock);
  102ffd:	89 34 24             	mov    %esi,(%esp)
  103000:	e8 db 0f 00 00       	call   103fe0 <release>
        return -1;
  103005:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  release(&p->lock);
  return i;
}
  10300c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10300f:	83 c4 3c             	add    $0x3c,%esp
  103012:	5b                   	pop    %ebx
  103013:	5e                   	pop    %esi
  103014:	5f                   	pop    %edi
  103015:	5d                   	pop    %ebp
  103016:	c3                   	ret    
  103017:	90                   	nop
  103018:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  10301b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10301e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103021:	0f b6 14 11          	movzbl (%ecx,%edx,1),%edx
  103025:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    p->writep = (p->writep + 1) % PIPESIZE;
  103028:	89 43 08             	mov    %eax,0x8(%ebx)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  10302b:	88 54 0b 44          	mov    %dl,0x44(%ebx,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  10302f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  103033:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103036:	39 55 10             	cmp    %edx,0x10(%ebp)
  103039:	0f 8f 56 ff ff ff    	jg     102f95 <pipewrite+0x35>
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  10303f:	83 c3 0c             	add    $0xc,%ebx
  103042:	89 1c 24             	mov    %ebx,(%esp)
  103045:	e8 66 09 00 00       	call   1039b0 <wakeup>
  release(&p->lock);
  10304a:	89 34 24             	mov    %esi,(%esp)
  10304d:	e8 8e 0f 00 00       	call   103fe0 <release>
  return i;
  103052:	eb b8                	jmp    10300c <pipewrite+0xac>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  103054:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  103057:	89 d0                	mov    %edx,%eax
  103059:	eb c0                	jmp    10301b <pipewrite+0xbb>
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  10305b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  103062:	eb db                	jmp    10303f <pipewrite+0xdf>
  103064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10306a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103070 <piperead>:
  return i;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  103070:	55                   	push   %ebp
  103071:	89 e5                	mov    %esp,%ebp
  103073:	57                   	push   %edi
  103074:	56                   	push   %esi
  103075:	53                   	push   %ebx
  103076:	83 ec 2c             	sub    $0x2c,%esp
  103079:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  10307c:	8d 73 10             	lea    0x10(%ebx),%esi
  10307f:	89 34 24             	mov    %esi,(%esp)
  103082:	e8 69 0e 00 00       	call   103ef0 <acquire>
  while(p->readp == p->writep && p->writeopen){
  103087:	8b 53 0c             	mov    0xc(%ebx),%edx
  10308a:	3b 53 08             	cmp    0x8(%ebx),%edx
  10308d:	75 51                	jne    1030e0 <piperead+0x70>
  10308f:	8b 4b 04             	mov    0x4(%ebx),%ecx
  103092:	85 c9                	test   %ecx,%ecx
  103094:	74 4a                	je     1030e0 <piperead+0x70>
    if(cp->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  103096:	8d 7b 0c             	lea    0xc(%ebx),%edi
  103099:	eb 20                	jmp    1030bb <piperead+0x4b>
  10309b:	90                   	nop
  10309c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1030a0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1030a4:	89 3c 24             	mov    %edi,(%esp)
  1030a7:	e8 34 08 00 00       	call   1038e0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  1030ac:	8b 53 0c             	mov    0xc(%ebx),%edx
  1030af:	3b 53 08             	cmp    0x8(%ebx),%edx
  1030b2:	75 2c                	jne    1030e0 <piperead+0x70>
  1030b4:	8b 43 04             	mov    0x4(%ebx),%eax
  1030b7:	85 c0                	test   %eax,%eax
  1030b9:	74 25                	je     1030e0 <piperead+0x70>
    if(cp->killed){
  1030bb:	e8 50 05 00 00       	call   103610 <curproc>
  1030c0:	8b 50 1c             	mov    0x1c(%eax),%edx
  1030c3:	85 d2                	test   %edx,%edx
  1030c5:	74 d9                	je     1030a0 <piperead+0x30>
      release(&p->lock);
      return -1;
  1030c7:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
    if(cp->killed){
      release(&p->lock);
  1030cc:	89 34 24             	mov    %esi,(%esp)
  1030cf:	e8 0c 0f 00 00       	call   103fe0 <release>
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  release(&p->lock);
  return i;
}
  1030d4:	83 c4 2c             	add    $0x2c,%esp
  1030d7:	89 f8                	mov    %edi,%eax
  1030d9:	5b                   	pop    %ebx
  1030da:	5e                   	pop    %esi
  1030db:	5f                   	pop    %edi
  1030dc:	5d                   	pop    %ebp
  1030dd:	c3                   	ret    
  1030de:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  1030e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1030e3:	31 ff                	xor    %edi,%edi
  1030e5:	85 c9                	test   %ecx,%ecx
  1030e7:	7e 49                	jle    103132 <piperead+0xc2>
    if(p->readp == p->writep)
  1030e9:	3b 53 08             	cmp    0x8(%ebx),%edx
  1030ec:	74 44                	je     103132 <piperead+0xc2>
  1030ee:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  1030f1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1030f4:	8b 75 10             	mov    0x10(%ebp),%esi
  1030f7:	eb 0c                	jmp    103105 <piperead+0x95>
  1030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103100:	39 53 08             	cmp    %edx,0x8(%ebx)
  103103:	74 2a                	je     10312f <piperead+0xbf>
      break;
    addr[i] = p->data[p->readp];
  103105:	0f b6 44 13 44       	movzbl 0x44(%ebx,%edx,1),%eax
  10310a:	88 04 39             	mov    %al,(%ecx,%edi,1)
    p->readp = (p->readp + 1) % PIPESIZE;
  10310d:	8b 53 0c             	mov    0xc(%ebx),%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103110:	83 c7 01             	add    $0x1,%edi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  103113:	83 c2 01             	add    $0x1,%edx
  103116:	89 d0                	mov    %edx,%eax
  103118:	c1 f8 1f             	sar    $0x1f,%eax
  10311b:	c1 e8 17             	shr    $0x17,%eax
  10311e:	01 c2                	add    %eax,%edx
  103120:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  103126:	29 c2                	sub    %eax,%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103128:	39 fe                	cmp    %edi,%esi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  10312a:	89 53 0c             	mov    %edx,0xc(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  10312d:	7f d1                	jg     103100 <piperead+0x90>
  10312f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  103132:	83 c3 08             	add    $0x8,%ebx
  103135:	89 1c 24             	mov    %ebx,(%esp)
  103138:	e8 73 08 00 00       	call   1039b0 <wakeup>
  release(&p->lock);
  10313d:	89 34 24             	mov    %esi,(%esp)
  103140:	e8 9b 0e 00 00       	call   103fe0 <release>
  return i;
}
  103145:	83 c4 2c             	add    $0x2c,%esp
  103148:	89 f8                	mov    %edi,%eax
  10314a:	5b                   	pop    %ebx
  10314b:	5e                   	pop    %esi
  10314c:	5f                   	pop    %edi
  10314d:	5d                   	pop    %ebp
  10314e:	c3                   	ret    
  10314f:	90                   	nop

00103150 <pinit>:
extern void forkret(void);
extern void forkret1(struct trapframe*);

void
pinit(void)
{
  103150:	55                   	push   %ebp
  103151:	89 e5                	mov    %esp,%ebp
  103153:	83 ec 18             	sub    $0x18,%esp
  initlock(&proc_table_lock, "proc_table");
  103156:	c7 44 24 04 05 65 10 	movl   $0x106505,0x4(%esp)
  10315d:	00 
  10315e:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103165:	e8 86 0c 00 00       	call   103df0 <initlock>
}
  10316a:	c9                   	leave  
  10316b:	c3                   	ret    
  10316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103170 <setupsegs>:

// Set up CPU's segment descriptors and task state for a given process.
// If p==0, set up for "idle" state for when scheduler() is running.
void
setupsegs(struct proc *p)
{
  103170:	55                   	push   %ebp
  103171:	89 e5                	mov    %esp,%ebp
  103173:	57                   	push   %edi
  103174:	56                   	push   %esi
  103175:	53                   	push   %ebx
  103176:	83 ec 3c             	sub    $0x3c,%esp
  103179:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct cpu *c;
  
  pushcli();
  10317c:	e8 1f 0d 00 00       	call   103ea0 <pushcli>
  c = &cpus[cpu()];
  103181:	e8 fa f5 ff ff       	call   102780 <cpu>
  c->ts.ss0 = SEG_KDATA << 3;
  103186:	69 d0 cc 00 00 00    	imul   $0xcc,%eax,%edx
  if(p)
  10318c:	85 db                	test   %ebx,%ebx
setupsegs(struct proc *p)
{
  struct cpu *c;
  
  pushcli();
  c = &cpus[cpu()];
  10318e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  c->ts.ss0 = SEG_KDATA << 3;
  103191:	66 c7 82 10 ab 10 00 	movw   $0x10,0x10ab10(%edx)
  103198:	10 00 
  if(p)
  10319a:	0f 84 90 01 00 00    	je     103330 <setupsegs+0x1c0>
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  1031a0:	8b 4b 08             	mov    0x8(%ebx),%ecx
  1031a3:	81 c1 00 10 00 00    	add    $0x1000,%ecx
  1031a9:	89 8a 0c ab 10 00    	mov    %ecx,0x10ab0c(%edx)
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  1031af:	69 55 c4 cc 00 00 00 	imul   $0xcc,-0x3c(%ebp),%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1031b6:	8d 8a 78 ab 10 00    	lea    0x10ab78(%edx),%ecx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1031bc:	8d b2 08 ab 10 00    	lea    0x10ab08(%edx),%esi
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  1031c2:	c7 82 70 ab 10 00 00 	movl   $0x0,0x10ab70(%edx)
  1031c9:	00 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1031cc:	89 f7                	mov    %esi,%edi
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  1031ce:	c7 82 74 ab 10 00 00 	movl   $0x0,0x10ab74(%edx)
  1031d5:	00 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1031d8:	c1 ef 10             	shr    $0x10,%edi
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1031db:	66 c7 82 78 ab 10 00 	movw   $0x10f,0x10ab78(%edx)
  1031e2:	0f 01 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1031e4:	89 f8                	mov    %edi,%eax
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1031e6:	c6 41 05 9a          	movb   $0x9a,0x5(%ecx)
  1031ea:	c6 41 06 c0          	movb   $0xc0,0x6(%ecx)
  1031ee:	66 c7 41 02 00 00    	movw   $0x0,0x2(%ecx)
  1031f4:	c6 41 04 00          	movb   $0x0,0x4(%ecx)
  1031f8:	c6 41 07 00          	movb   $0x0,0x7(%ecx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1031fc:	8d 8a 80 ab 10 00    	lea    0x10ab80(%edx),%ecx
  103202:	66 c7 82 80 ab 10 00 	movw   $0xffff,0x10ab80(%edx)
  103209:	ff ff 
  10320b:	66 c7 41 02 00 00    	movw   $0x0,0x2(%ecx)
  103211:	c6 41 05 92          	movb   $0x92,0x5(%ecx)
  103215:	c6 41 06 cf          	movb   $0xcf,0x6(%ecx)
  103219:	c6 41 04 00          	movb   $0x0,0x4(%ecx)
  10321d:	c6 41 07 00          	movb   $0x0,0x7(%ecx)
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  103221:	8d 8a 98 ab 10 00    	lea    0x10ab98(%edx),%ecx
  103227:	66 89 71 02          	mov    %si,0x2(%ecx)
  10322b:	c1 ee 18             	shr    $0x18,%esi
  c->gdt[SEG_TSS].s = 0;
  if(p){
  10322e:	85 db                	test   %ebx,%ebx
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  103230:	88 41 04             	mov    %al,0x4(%ecx)
  103233:	89 f0                	mov    %esi,%eax
  103235:	66 c7 82 98 ab 10 00 	movw   $0x67,0x10ab98(%edx)
  10323c:	67 00 
  10323e:	88 41 07             	mov    %al,0x7(%ecx)
  103241:	c6 41 06 40          	movb   $0x40,0x6(%ecx)
  c->gdt[SEG_TSS].s = 0;
  103245:	c6 41 05 89          	movb   $0x89,0x5(%ecx)
  if(p){
  103249:	0f 84 b1 00 00 00    	je     103300 <setupsegs+0x190>
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  10324f:	8b 4b 04             	mov    0x4(%ebx),%ecx
  103252:	8b 1b                	mov    (%ebx),%ebx
  103254:	83 e9 01             	sub    $0x1,%ecx
  103257:	89 de                	mov    %ebx,%esi
  103259:	89 d8                	mov    %ebx,%eax
  10325b:	89 cf                	mov    %ecx,%edi
  10325d:	c1 ee 10             	shr    $0x10,%esi
  103260:	c1 e8 18             	shr    $0x18,%eax
  103263:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  103266:	c1 ef 0c             	shr    $0xc,%edi
  103269:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10326c:	8d 8a 88 ab 10 00    	lea    0x10ab88(%edx),%ecx
  103272:	89 f0                	mov    %esi,%eax
  103274:	66 89 ba 88 ab 10 00 	mov    %di,0x10ab88(%edx)
  10327b:	88 41 04             	mov    %al,0x4(%ecx)
  10327e:	c6 41 05 fa          	movb   $0xfa,0x5(%ecx)
  103282:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103285:	66 89 59 02          	mov    %bx,0x2(%ecx)
  103289:	c1 e8 1c             	shr    $0x1c,%eax
  10328c:	88 45 d4             	mov    %al,-0x2c(%ebp)
  10328f:	83 c8 c0             	or     $0xffffffc0,%eax
  103292:	88 41 06             	mov    %al,0x6(%ecx)
  103295:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103299:	66 89 ba 90 ab 10 00 	mov    %di,0x10ab90(%edx)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  1032a0:	88 41 07             	mov    %al,0x7(%ecx)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  1032a3:	8d 8a 90 ab 10 00    	lea    0x10ab90(%edx),%ecx
  1032a9:	89 f0                	mov    %esi,%eax
  1032ab:	c6 41 05 f2          	movb   $0xf2,0x5(%ecx)
  1032af:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  1032b3:	88 41 04             	mov    %al,0x4(%ecx)
  1032b6:	66 89 59 02          	mov    %bx,0x2(%ecx)
  1032ba:	83 ca c0             	or     $0xffffffc0,%edx
  1032bd:	88 51 06             	mov    %dl,0x6(%ecx)
  1032c0:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
  1032c4:	88 41 07             	mov    %al,0x7(%ecx)
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }

  lgdt(c->gdt, sizeof(c->gdt));
  1032c7:	69 45 c4 cc 00 00 00 	imul   $0xcc,-0x3c(%ebp),%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1032ce:	66 c7 45 e2 2f 00    	movw   $0x2f,-0x1e(%ebp)
  1032d4:	05 70 ab 10 00       	add    $0x10ab70,%eax
  pd[1] = (uint)p;
  1032d9:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  pd[2] = (uint)p >> 16;
  1032dd:	c1 e8 10             	shr    $0x10,%eax
  1032e0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  1032e4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  1032e7:	0f 01 10             	lgdtl  (%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  1032ea:	b8 28 00 00 00       	mov    $0x28,%eax
  1032ef:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  popcli();
  1032f2:	e8 69 0c 00 00       	call   103f60 <popcli>
}
  1032f7:	83 c4 3c             	add    $0x3c,%esp
  1032fa:	5b                   	pop    %ebx
  1032fb:	5e                   	pop    %esi
  1032fc:	5f                   	pop    %edi
  1032fd:	5d                   	pop    %ebp
  1032fe:	c3                   	ret    
  1032ff:	90                   	nop
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
  103300:	c7 82 88 ab 10 00 00 	movl   $0x0,0x10ab88(%edx)
  103307:	00 00 00 
  10330a:	c7 82 8c ab 10 00 00 	movl   $0x0,0x10ab8c(%edx)
  103311:	00 00 00 
    c->gdt[SEG_UDATA] = SEG_NULL;
  103314:	c7 82 90 ab 10 00 00 	movl   $0x0,0x10ab90(%edx)
  10331b:	00 00 00 
  10331e:	c7 82 94 ab 10 00 00 	movl   $0x0,0x10ab94(%edx)
  103325:	00 00 00 
  103328:	eb 9d                	jmp    1032c7 <setupsegs+0x157>
  10332a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c = &cpus[cpu()];
  c->ts.ss0 = SEG_KDATA << 3;
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;
  103330:	c7 82 0c ab 10 00 ff 	movl   $0xffffffff,0x10ab0c(%edx)
  103337:	ff ff ff 
  10333a:	e9 70 fe ff ff       	jmp    1031af <setupsegs+0x3f>
  10333f:	90                   	nop

00103340 <copyproc>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103340:	55                   	push   %ebp
  103341:	89 e5                	mov    %esp,%ebp
  103343:	57                   	push   %edi
  103344:	56                   	push   %esi
  103345:	53                   	push   %ebx
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
  103346:	31 db                	xor    %ebx,%ebx
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103348:	83 ec 2c             	sub    $0x2c,%esp
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  10334b:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103352:	e8 99 0b 00 00       	call   103ef0 <acquire>
  103357:	b8 6c b1 10 00       	mov    $0x10b16c,%eax
  10335c:	eb 13                	jmp    103371 <copyproc+0x31>
  10335e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NPROC; i++){
  103360:	83 c3 01             	add    $0x1,%ebx
  103363:	05 98 00 00 00       	add    $0x98,%eax
  103368:	83 fb 40             	cmp    $0x40,%ebx
  10336b:	0f 84 5f 01 00 00    	je     1034d0 <copyproc+0x190>
    p = &proc[i];
  103371:	69 fb 98 00 00 00    	imul   $0x98,%ebx,%edi
    if(p->state == UNUSED){
  103377:	8b 08                	mov    (%eax),%ecx
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
  103379:	8d 97 60 b1 10 00    	lea    0x10b160(%edi),%edx
    if(p->state == UNUSED){
  10337f:	85 c9                	test   %ecx,%ecx
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
  103381:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    if(p->state == UNUSED){
  103384:	75 da                	jne    103360 <copyproc+0x20>
      p->state = EMBRYO;
      p->pid = nextpid++;
  103386:	a1 04 73 10 00       	mov    0x107304,%eax
  10338b:	8d b7 70 b1 10 00    	lea    0x10b170(%edi),%esi

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
      p->state = EMBRYO;
  103391:	c7 42 0c 01 00 00 00 	movl   $0x1,0xc(%edx)
      p->pid = nextpid++;
      release(&proc_table_lock);
  103398:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
      p->state = EMBRYO;
      p->pid = nextpid++;
  10339f:	89 87 70 b1 10 00    	mov    %eax,0x10b170(%edi)
  1033a5:	83 c0 01             	add    $0x1,%eax
  1033a8:	a3 04 73 10 00       	mov    %eax,0x107304
      release(&proc_table_lock);
  1033ad:	e8 2e 0c 00 00       	call   103fe0 <release>
  // Allocate process.
  if((np = allocproc()) == 0)
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
  1033b2:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  1033b9:	e8 d2 f0 ff ff       	call   102490 <kalloc>
  1033be:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  1033c1:	85 c0                	test   %eax,%eax
  1033c3:	89 41 08             	mov    %eax,0x8(%ecx)
  1033c6:	0f 84 22 01 00 00    	je     1034ee <copyproc+0x1ae>
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;

  if(p){  // Copy process state from p.
  1033cc:	8b 55 08             	mov    0x8(%ebp),%edx
  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  1033cf:	05 bc 0f 00 00       	add    $0xfbc,%eax
  1033d4:	89 87 e4 b1 10 00    	mov    %eax,0x10b1e4(%edi)

  if(p){  // Copy process state from p.
  1033da:	85 d2                	test   %edx,%edx
  1033dc:	0f 84 a0 00 00 00    	je     103482 <copyproc+0x142>
    np->parent = p;
  1033e2:	8b 55 08             	mov    0x8(%ebp),%edx
  1033e5:	89 56 04             	mov    %edx,0x4(%esi)
    memmove(np->tf, p->tf, sizeof(*np->tf));
  1033e8:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  1033ef:	00 
  1033f0:	8b 92 84 00 00 00    	mov    0x84(%edx),%edx
  1033f6:	89 04 24             	mov    %eax,(%esp)
  1033f9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033fd:	e8 ae 0c 00 00       	call   1040b0 <memmove>
  
    np->sz = p->sz;
  103402:	8b 55 08             	mov    0x8(%ebp),%edx
  103405:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  103408:	8b 42 04             	mov    0x4(%edx),%eax
  10340b:	89 41 04             	mov    %eax,0x4(%ecx)
    if((np->mem = kalloc(np->sz)) == 0){
  10340e:	89 04 24             	mov    %eax,(%esp)
  103411:	e8 7a f0 ff ff       	call   102490 <kalloc>
  103416:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103419:	85 c0                	test   %eax,%eax
  10341b:	89 02                	mov    %eax,(%edx)
  10341d:	0f 84 de 00 00 00    	je     103501 <copyproc+0x1c1>
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  103423:	8b 4d e4             	mov    -0x1c(%ebp),%ecx

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
  103426:	81 c7 80 b1 10 00    	add    $0x10b180,%edi
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);

    for(i = 0; i < NOFILE; i++)
  10342c:	31 f6                	xor    %esi,%esi
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  10342e:	8b 51 04             	mov    0x4(%ecx),%edx
  103431:	8b 4d 08             	mov    0x8(%ebp),%ecx
  103434:	89 54 24 08          	mov    %edx,0x8(%esp)
  103438:	8b 11                	mov    (%ecx),%edx
  10343a:	89 04 24             	mov    %eax,(%esp)
  10343d:	89 54 24 04          	mov    %edx,0x4(%esp)
  103441:	e8 6a 0c 00 00       	call   1040b0 <memmove>
  103446:	66 90                	xchg   %ax,%ax

    for(i = 0; i < NOFILE; i++)
      if(p->ofile[i])
  103448:	8b 55 08             	mov    0x8(%ebp),%edx
  10344b:	8b 44 b2 20          	mov    0x20(%edx,%esi,4),%eax
  10344f:	85 c0                	test   %eax,%eax
  103451:	74 0a                	je     10345d <copyproc+0x11d>
        np->ofile[i] = filedup(p->ofile[i]);
  103453:	89 04 24             	mov    %eax,(%esp)
  103456:	e8 c5 d9 ff ff       	call   100e20 <filedup>
  10345b:	89 07                	mov    %eax,(%edi)
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);

    for(i = 0; i < NOFILE; i++)
  10345d:	83 c6 01             	add    $0x1,%esi
  103460:	83 c7 04             	add    $0x4,%edi
  103463:	83 fe 10             	cmp    $0x10,%esi
  103466:	75 e0                	jne    103448 <copyproc+0x108>
      if(p->ofile[i])
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  103468:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10346b:	8b 41 60             	mov    0x60(%ecx),%eax
  10346e:	89 04 24             	mov    %eax,(%esp)
  103471:	e8 5a e0 ff ff       	call   1014d0 <idup>
  103476:	69 d3 98 00 00 00    	imul   $0x98,%ebx,%edx
  10347c:	89 82 c0 b1 10 00    	mov    %eax,0x10b1c0(%edx)
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  103482:	69 db 98 00 00 00    	imul   $0x98,%ebx,%ebx
  103488:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  10348f:	00 
  103490:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103497:	00 
  103498:	8d 83 c4 b1 10 00    	lea    0x10b1c4(%ebx),%eax
  10349e:	89 04 24             	mov    %eax,(%esp)
  1034a1:	e8 7a 0b 00 00       	call   104020 <memset>
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;
  1034a6:	8b 83 e4 b1 10 00    	mov    0x10b1e4(%ebx),%eax
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  np->context.eip = (uint)forkret;
  1034ac:	8d 93 c0 b1 10 00    	lea    0x10b1c0(%ebx),%edx
  1034b2:	c7 42 04 40 36 10 00 	movl   $0x103640,0x4(%edx)
  np->context.esp = (uint)np->tf;
  1034b9:	89 42 08             	mov    %eax,0x8(%edx)

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  1034bc:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  return np;
}
  1034c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034c6:	83 c4 2c             	add    $0x2c,%esp
  1034c9:	5b                   	pop    %ebx
  1034ca:	5e                   	pop    %esi
  1034cb:	5f                   	pop    %edi
  1034cc:	5d                   	pop    %ebp
  1034cd:	c3                   	ret    
  1034ce:	66 90                	xchg   %ax,%ax
      p->pid = nextpid++;
      release(&proc_table_lock);
      return p;
    }
  }
  release(&proc_table_lock);
  1034d0:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  1034d7:	e8 04 0b 00 00       	call   103fe0 <release>
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return 0;
  1034dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  return np;
}
  1034e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034e6:	83 c4 2c             	add    $0x2c,%esp
  1034e9:	5b                   	pop    %ebx
  1034ea:	5e                   	pop    %esi
  1034eb:	5f                   	pop    %edi
  1034ec:	5d                   	pop    %ebp
  1034ed:	c3                   	ret    
  if((np = allocproc()) == 0)
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
  1034ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    return 0;
  1034f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  if((np = allocproc()) == 0)
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
  1034f8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
  1034ff:	eb c2                	jmp    1034c3 <copyproc+0x183>
    np->parent = p;
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
  103501:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103508:	00 
  103509:	8b 42 08             	mov    0x8(%edx),%eax
  10350c:	89 04 24             	mov    %eax,(%esp)
  10350f:	e8 1c ee ff ff       	call   102330 <kfree>
      np->kstack = 0;
  103514:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      np->state = UNUSED;
      return 0;
  103517:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
  10351e:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%ecx)
      np->state = UNUSED;
  103525:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
      return 0;
  10352c:	eb 95                	jmp    1034c3 <copyproc+0x183>
  10352e:	66 90                	xchg   %ax,%ax

00103530 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103530:	55                   	push   %ebp
  103531:	89 e5                	mov    %esp,%ebp
  103533:	53                   	push   %ebx
  103534:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  103537:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10353e:	e8 fd fd ff ff       	call   103340 <copyproc>
  p->sz = PAGE;
  103543:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
userinit(void)
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  10354a:	89 c3                	mov    %eax,%ebx
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  10354c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103553:	e8 38 ef ff ff       	call   102490 <kalloc>
  103558:	89 03                	mov    %eax,(%ebx)
  p->cwd = namei("/");
  10355a:	c7 04 24 10 65 10 00 	movl   $0x106510,(%esp)
  103561:	e8 da e9 ff ff       	call   101f40 <namei>
  103566:	89 43 60             	mov    %eax,0x60(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  103569:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  103570:	00 
  103571:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103578:	00 
  103579:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  10357f:	89 04 24             	mov    %eax,(%esp)
  103582:	e8 99 0a 00 00       	call   104020 <memset>
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  103587:	8b 4b 04             	mov    0x4(%ebx),%ecx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  10358a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  103590:	8d 51 fc             	lea    -0x4(%ecx),%edx
  103593:	89 50 3c             	mov    %edx,0x3c(%eax)
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103596:	8b 13                	mov    (%ebx),%edx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103598:	66 c7 40 34 1b 00    	movw   $0x1b,0x34(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  10359e:	66 c7 40 24 23 00    	movw   $0x23,0x24(%eax)
  p->tf->es = p->tf->ds;
  1035a4:	66 c7 40 20 23 00    	movw   $0x23,0x20(%eax)
  p->tf->ss = p->tf->ds;
  1035aa:	66 c7 40 40 23 00    	movw   $0x23,0x40(%eax)
  p->tf->eflags = FL_IF;
  1035b0:	c7 40 38 00 02 00 00 	movl   $0x200,0x38(%eax)
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  1035b7:	c7 44 0a fc ef ef ef 	movl   $0xefefefef,-0x4(%edx,%ecx,1)
  1035be:	ef 

  // On entry to user space, start executing at beginning of initcode.S.
  p->tf->eip = 0;
  1035bf:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  1035c6:	89 14 24             	mov    %edx,(%esp)
  1035c9:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  1035d0:	00 
  1035d1:	c7 44 24 04 08 77 10 	movl   $0x107708,0x4(%esp)
  1035d8:	00 
  1035d9:	e8 d2 0a 00 00       	call   1040b0 <memmove>
  safestrcpy(p->name, "initcode", sizeof(p->name));
  1035de:	8d 83 88 00 00 00    	lea    0x88(%ebx),%eax
  1035e4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1035eb:	00 
  1035ec:	c7 44 24 04 12 65 10 	movl   $0x106512,0x4(%esp)
  1035f3:	00 
  1035f4:	89 04 24             	mov    %eax,(%esp)
  1035f7:	e8 d4 0b 00 00       	call   1041d0 <safestrcpy>
  p->state = RUNNABLE;
  1035fc:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  
  initproc = p;
  103603:	89 1d 64 78 10 00    	mov    %ebx,0x107864
}
  103609:	83 c4 14             	add    $0x14,%esp
  10360c:	5b                   	pop    %ebx
  10360d:	5d                   	pop    %ebp
  10360e:	c3                   	ret    
  10360f:	90                   	nop

00103610 <curproc>:

// Return currently running process.
struct proc*
curproc(void)
{
  103610:	55                   	push   %ebp
  103611:	89 e5                	mov    %esp,%ebp
  103613:	53                   	push   %ebx
  103614:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;

  pushcli();
  103617:	e8 84 08 00 00       	call   103ea0 <pushcli>
  p = cpus[cpu()].curproc;
  10361c:	e8 5f f1 ff ff       	call   102780 <cpu>
  103621:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103627:	8b 98 e4 aa 10 00    	mov    0x10aae4(%eax),%ebx
  popcli();
  10362d:	e8 2e 09 00 00       	call   103f60 <popcli>
  return p;
}
  103632:	83 c4 04             	add    $0x4,%esp
  103635:	89 d8                	mov    %ebx,%eax
  103637:	5b                   	pop    %ebx
  103638:	5d                   	pop    %ebp
  103639:	c3                   	ret    
  10363a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103640 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  103640:	55                   	push   %ebp
  103641:	89 e5                	mov    %esp,%ebp
  103643:	83 ec 18             	sub    $0x18,%esp
  // Still holding proc_table_lock from scheduler.
  release(&proc_table_lock);
  103646:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  10364d:	e8 8e 09 00 00       	call   103fe0 <release>

  // Jump into assembly, never to return.
  forkret1(cp->tf);
  103652:	e8 b9 ff ff ff       	call   103610 <curproc>
  103657:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  10365d:	89 04 24             	mov    %eax,(%esp)
  103660:	e8 07 1c 00 00       	call   10526c <forkret1>
}
  103665:	c9                   	leave  
  103666:	c3                   	ret    
  103667:	89 f6                	mov    %esi,%esi
  103669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103670 <growproc>:

// Grow current process's memory by n bytes.
// Return old size on success, -1 on failure.
int
growproc(int n)
{
  103670:	55                   	push   %ebp
  103671:	89 e5                	mov    %esp,%ebp
  103673:	57                   	push   %edi
  103674:	56                   	push   %esi
  103675:	53                   	push   %ebx
  103676:	83 ec 1c             	sub    $0x1c,%esp
  103679:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  10367c:	e8 8f ff ff ff       	call   103610 <curproc>
  103681:	8b 40 04             	mov    0x4(%eax),%eax
  103684:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  103687:	89 04 24             	mov    %eax,(%esp)
  10368a:	e8 01 ee ff ff       	call   102490 <kalloc>
  10368f:	89 c6                	mov    %eax,%esi
  if(newmem == 0)
    return -1;
  103691:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
growproc(int n)
{
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  if(newmem == 0)
  103696:	85 f6                	test   %esi,%esi
  103698:	74 7f                	je     103719 <growproc+0xa9>
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  10369a:	e8 71 ff ff ff       	call   103610 <curproc>
  10369f:	8b 78 04             	mov    0x4(%eax),%edi
  1036a2:	e8 69 ff ff ff       	call   103610 <curproc>
  1036a7:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1036ab:	8b 00                	mov    (%eax),%eax
  1036ad:	89 34 24             	mov    %esi,(%esp)
  1036b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036b4:	e8 f7 09 00 00       	call   1040b0 <memmove>
  memset(newmem + cp->sz, 0, n);
  1036b9:	e8 52 ff ff ff       	call   103610 <curproc>
  1036be:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1036c2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1036c9:	00 
  1036ca:	8b 40 04             	mov    0x4(%eax),%eax
  1036cd:	8d 04 06             	lea    (%esi,%eax,1),%eax
  1036d0:	89 04 24             	mov    %eax,(%esp)
  1036d3:	e8 48 09 00 00       	call   104020 <memset>
  oldmem = cp->mem;
  1036d8:	e8 33 ff ff ff       	call   103610 <curproc>
  1036dd:	8b 38                	mov    (%eax),%edi
  cp->mem = newmem;
  1036df:	e8 2c ff ff ff       	call   103610 <curproc>
  1036e4:	89 30                	mov    %esi,(%eax)
  kfree(oldmem, cp->sz);
  1036e6:	e8 25 ff ff ff       	call   103610 <curproc>
  1036eb:	8b 40 04             	mov    0x4(%eax),%eax
  1036ee:	89 3c 24             	mov    %edi,(%esp)
  1036f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036f5:	e8 36 ec ff ff       	call   102330 <kfree>
  cp->sz += n;
  1036fa:	e8 11 ff ff ff       	call   103610 <curproc>
  1036ff:	01 58 04             	add    %ebx,0x4(%eax)
  setupsegs(cp);
  103702:	e8 09 ff ff ff       	call   103610 <curproc>
  103707:	89 04 24             	mov    %eax,(%esp)
  10370a:	e8 61 fa ff ff       	call   103170 <setupsegs>
  return cp->sz - n;
  10370f:	e8 fc fe ff ff       	call   103610 <curproc>
  103714:	8b 40 04             	mov    0x4(%eax),%eax
  103717:	29 d8                	sub    %ebx,%eax
}
  103719:	83 c4 1c             	add    $0x1c,%esp
  10371c:	5b                   	pop    %ebx
  10371d:	5e                   	pop    %esi
  10371e:	5f                   	pop    %edi
  10371f:	5d                   	pop    %ebp
  103720:	c3                   	ret    
  103721:	eb 0d                	jmp    103730 <scheduler>
  103723:	90                   	nop
  103724:	90                   	nop
  103725:	90                   	nop
  103726:	90                   	nop
  103727:	90                   	nop
  103728:	90                   	nop
  103729:	90                   	nop
  10372a:	90                   	nop
  10372b:	90                   	nop
  10372c:	90                   	nop
  10372d:	90                   	nop
  10372e:	90                   	nop
  10372f:	90                   	nop

00103730 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  103730:	55                   	push   %ebp
  103731:	89 e5                	mov    %esp,%ebp
  103733:	57                   	push   %edi
  103734:	56                   	push   %esi
  103735:	53                   	push   %ebx
  103736:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *p;
  struct cpu *c;
  int i;

  c = &cpus[cpu()];
  103739:	e8 42 f0 ff ff       	call   102780 <cpu>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
  10373e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103744:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      setupsegs(p);
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  103747:	05 e8 aa 10 00       	add    $0x10aae8,%eax
  10374c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10374f:	90                   	nop
}

static inline void
sti(void)
{
  asm volatile("sti");
  103750:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  103751:	be 6c b1 10 00       	mov    $0x10b16c,%esi
    for(i = 0; i < NPROC; i++){
  103756:	31 db                	xor    %ebx,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  103758:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  10375f:	e8 8c 07 00 00       	call   103ef0 <acquire>
  103764:	eb 10                	jmp    103776 <scheduler+0x46>
  103766:	66 90                	xchg   %ax,%ax
    for(i = 0; i < NPROC; i++){
  103768:	83 c3 01             	add    $0x1,%ebx
  10376b:	81 c6 98 00 00 00    	add    $0x98,%esi
  103771:	83 fb 40             	cmp    $0x40,%ebx
  103774:	74 6a                	je     1037e0 <scheduler+0xb0>
      p = &proc[i];
      if(p->state != RUNNABLE)
  103776:	83 3e 03             	cmpl   $0x3,(%esi)
  103779:	75 ed                	jne    103768 <scheduler+0x38>
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
  10377b:	69 fb 98 00 00 00    	imul   $0x98,%ebx,%edi
        continue;

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
  103781:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  103784:	83 c3 01             	add    $0x1,%ebx
      p = &proc[i];
  103787:	8d 87 60 b1 10 00    	lea    0x10b160(%edi),%eax
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  10378d:	81 c7 c4 b1 10 00    	add    $0x10b1c4,%edi
        continue;

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
  103793:	89 82 e4 aa 10 00    	mov    %eax,0x10aae4(%edx)
      setupsegs(p);
  103799:	89 04 24             	mov    %eax,(%esp)
  10379c:	e8 cf f9 ff ff       	call   103170 <setupsegs>
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  1037a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
  1037a4:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  1037aa:	81 c6 98 00 00 00    	add    $0x98,%esi
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  1037b0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1037b4:	89 04 24             	mov    %eax,(%esp)
  1037b7:	e8 70 0a 00 00       	call   10422c <swtch>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
  1037bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      setupsegs(0);
  1037bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      p->state = RUNNING;
      swtch(&c->context, &p->context);

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
  1037c6:	c7 82 e4 aa 10 00 00 	movl   $0x0,0x10aae4(%edx)
  1037cd:	00 00 00 
      setupsegs(0);
  1037d0:	e8 9b f9 ff ff       	call   103170 <setupsegs>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  1037d5:	83 fb 40             	cmp    $0x40,%ebx
  1037d8:	75 9c                	jne    103776 <scheduler+0x46>
  1037da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
      setupsegs(0);
    }
    release(&proc_table_lock);
  1037e0:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  1037e7:	e8 f4 07 00 00       	call   103fe0 <release>

  }
  1037ec:	e9 5f ff ff ff       	jmp    103750 <scheduler+0x20>
  1037f1:	eb 0d                	jmp    103800 <sched>
  1037f3:	90                   	nop
  1037f4:	90                   	nop
  1037f5:	90                   	nop
  1037f6:	90                   	nop
  1037f7:	90                   	nop
  1037f8:	90                   	nop
  1037f9:	90                   	nop
  1037fa:	90                   	nop
  1037fb:	90                   	nop
  1037fc:	90                   	nop
  1037fd:	90                   	nop
  1037fe:	90                   	nop
  1037ff:	90                   	nop

00103800 <sched>:

// Enter scheduler.  Must already hold proc_table_lock
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  103800:	55                   	push   %ebp
  103801:	89 e5                	mov    %esp,%ebp
  103803:	53                   	push   %ebx
  103804:	83 ec 14             	sub    $0x14,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103807:	9c                   	pushf  
  103808:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  103809:	f6 c4 02             	test   $0x2,%ah
  10380c:	75 5c                	jne    10386a <sched+0x6a>
    panic("sched interruptible");
  if(cp->state == RUNNING)
  10380e:	e8 fd fd ff ff       	call   103610 <curproc>
  103813:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  103817:	74 75                	je     10388e <sched+0x8e>
    panic("sched running");
  if(!holding(&proc_table_lock))
  103819:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103820:	e8 3b 06 00 00       	call   103e60 <holding>
  103825:	85 c0                	test   %eax,%eax
  103827:	74 59                	je     103882 <sched+0x82>
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
  103829:	e8 52 ef ff ff       	call   102780 <cpu>
  10382e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103834:	83 b8 a4 ab 10 00 01 	cmpl   $0x1,0x10aba4(%eax)
  10383b:	75 39                	jne    103876 <sched+0x76>
    panic("sched locks");

  swtch(&cp->context, &cpus[cpu()].context);
  10383d:	e8 3e ef ff ff       	call   102780 <cpu>
  103842:	89 c3                	mov    %eax,%ebx
  103844:	e8 c7 fd ff ff       	call   103610 <curproc>
  103849:	69 db cc 00 00 00    	imul   $0xcc,%ebx,%ebx
  10384f:	81 c3 e8 aa 10 00    	add    $0x10aae8,%ebx
  103855:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103859:	83 c0 64             	add    $0x64,%eax
  10385c:	89 04 24             	mov    %eax,(%esp)
  10385f:	e8 c8 09 00 00       	call   10422c <swtch>
}
  103864:	83 c4 14             	add    $0x14,%esp
  103867:	5b                   	pop    %ebx
  103868:	5d                   	pop    %ebp
  103869:	c3                   	ret    
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  10386a:	c7 04 24 1b 65 10 00 	movl   $0x10651b,(%esp)
  103871:	e8 8a d0 ff ff       	call   100900 <panic>
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
    panic("sched locks");
  103876:	c7 04 24 53 65 10 00 	movl   $0x106553,(%esp)
  10387d:	e8 7e d0 ff ff       	call   100900 <panic>
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  103882:	c7 04 24 3d 65 10 00 	movl   $0x10653d,(%esp)
  103889:	e8 72 d0 ff ff       	call   100900 <panic>
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  10388e:	c7 04 24 2f 65 10 00 	movl   $0x10652f,(%esp)
  103895:	e8 66 d0 ff ff       	call   100900 <panic>
  10389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001038a0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  1038a0:	55                   	push   %ebp
  1038a1:	89 e5                	mov    %esp,%ebp
  1038a3:	83 ec 18             	sub    $0x18,%esp
  acquire(&proc_table_lock);
  1038a6:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  1038ad:	e8 3e 06 00 00       	call   103ef0 <acquire>
  cp->state = RUNNABLE;
  1038b2:	e8 59 fd ff ff       	call   103610 <curproc>
  1038b7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  1038be:	e8 3d ff ff ff       	call   103800 <sched>
  release(&proc_table_lock);
  1038c3:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  1038ca:	e8 11 07 00 00       	call   103fe0 <release>
}
  1038cf:	c9                   	leave  
  1038d0:	c3                   	ret    
  1038d1:	eb 0d                	jmp    1038e0 <sleep>
  1038d3:	90                   	nop
  1038d4:	90                   	nop
  1038d5:	90                   	nop
  1038d6:	90                   	nop
  1038d7:	90                   	nop
  1038d8:	90                   	nop
  1038d9:	90                   	nop
  1038da:	90                   	nop
  1038db:	90                   	nop
  1038dc:	90                   	nop
  1038dd:	90                   	nop
  1038de:	90                   	nop
  1038df:	90                   	nop

001038e0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1038e0:	55                   	push   %ebp
  1038e1:	89 e5                	mov    %esp,%ebp
  1038e3:	56                   	push   %esi
  1038e4:	53                   	push   %ebx
  1038e5:	83 ec 10             	sub    $0x10,%esp
  1038e8:	8b 75 08             	mov    0x8(%ebp),%esi
  1038eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(cp == 0)
  1038ee:	e8 1d fd ff ff       	call   103610 <curproc>
  1038f3:	85 c0                	test   %eax,%eax
  1038f5:	0f 84 9d 00 00 00    	je     103998 <sleep+0xb8>
    panic("sleep");

  if(lk == 0)
  1038fb:	85 db                	test   %ebx,%ebx
  1038fd:	0f 84 89 00 00 00    	je     10398c <sleep+0xac>
  // change p->state and then call sched.
  // Once we hold proc_table_lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with proc_table_lock locked),
  // so it's okay to release lk.
  if(lk != &proc_table_lock){
  103903:	81 fb 60 d7 10 00    	cmp    $0x10d760,%ebx
  103909:	74 55                	je     103960 <sleep+0x80>
    acquire(&proc_table_lock);
  10390b:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103912:	e8 d9 05 00 00       	call   103ef0 <acquire>
    release(lk);
  103917:	89 1c 24             	mov    %ebx,(%esp)
  10391a:	e8 c1 06 00 00       	call   103fe0 <release>
  }

  // Go to sleep.
  cp->chan = chan;
  10391f:	e8 ec fc ff ff       	call   103610 <curproc>
  103924:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  103927:	e8 e4 fc ff ff       	call   103610 <curproc>
  10392c:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103933:	e8 c8 fe ff ff       	call   103800 <sched>

  // Tidy up.
  cp->chan = 0;
  103938:	e8 d3 fc ff ff       	call   103610 <curproc>
  10393d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
  103944:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  10394b:	e8 90 06 00 00       	call   103fe0 <release>
    acquire(lk);
  103950:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  103953:	83 c4 10             	add    $0x10,%esp
  103956:	5b                   	pop    %ebx
  103957:	5e                   	pop    %esi
  103958:	5d                   	pop    %ebp
  cp->chan = 0;

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  103959:	e9 92 05 00 00       	jmp    103ef0 <acquire>
  10395e:	66 90                	xchg   %ax,%ax
    acquire(&proc_table_lock);
    release(lk);
  }

  // Go to sleep.
  cp->chan = chan;
  103960:	e8 ab fc ff ff       	call   103610 <curproc>
  103965:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  103968:	e8 a3 fc ff ff       	call   103610 <curproc>
  10396d:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103974:	e8 87 fe ff ff       	call   103800 <sched>

  // Tidy up.
  cp->chan = 0;
  103979:	e8 92 fc ff ff       	call   103610 <curproc>
  10397e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  }
}
  103985:	83 c4 10             	add    $0x10,%esp
  103988:	5b                   	pop    %ebx
  103989:	5e                   	pop    %esi
  10398a:	5d                   	pop    %ebp
  10398b:	c3                   	ret    
{
  if(cp == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
  10398c:	c7 04 24 65 65 10 00 	movl   $0x106565,(%esp)
  103993:	e8 68 cf ff ff       	call   100900 <panic>
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(cp == 0)
    panic("sleep");
  103998:	c7 04 24 5f 65 10 00 	movl   $0x10655f,(%esp)
  10399f:	e8 5c cf ff ff       	call   100900 <panic>
  1039a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1039aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001039b0 <wakeup>:

// Wake up all processes sleeping on chan.
// Proc_table_lock is acquired and released.
void
wakeup(void *chan)
{
  1039b0:	55                   	push   %ebp
  1039b1:	89 e5                	mov    %esp,%ebp
  1039b3:	53                   	push   %ebx
  1039b4:	83 ec 14             	sub    $0x14,%esp
  1039b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&proc_table_lock);
  1039ba:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  1039c1:	e8 2a 05 00 00       	call   103ef0 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  1039c6:	b8 60 b1 10 00       	mov    $0x10b160,%eax
  1039cb:	eb 0f                	jmp    1039dc <wakeup+0x2c>
  1039cd:	8d 76 00             	lea    0x0(%esi),%esi
  1039d0:	05 98 00 00 00       	add    $0x98,%eax
  1039d5:	3d 60 d7 10 00       	cmp    $0x10d760,%eax
  1039da:	74 24                	je     103a00 <wakeup+0x50>
    if(p->state == SLEEPING && p->chan == chan)
  1039dc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  1039e0:	75 ee                	jne    1039d0 <wakeup+0x20>
  1039e2:	3b 58 18             	cmp    0x18(%eax),%ebx
  1039e5:	75 e9                	jne    1039d0 <wakeup+0x20>
      p->state = RUNNABLE;
  1039e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  1039ee:	05 98 00 00 00       	add    $0x98,%eax
  1039f3:	3d 60 d7 10 00       	cmp    $0x10d760,%eax
  1039f8:	75 e2                	jne    1039dc <wakeup+0x2c>
  1039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  103a00:	c7 45 08 60 d7 10 00 	movl   $0x10d760,0x8(%ebp)
}
  103a07:	83 c4 14             	add    $0x14,%esp
  103a0a:	5b                   	pop    %ebx
  103a0b:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  103a0c:	e9 cf 05 00 00       	jmp    103fe0 <release>
  103a11:	eb 0d                	jmp    103a20 <kill>
  103a13:	90                   	nop
  103a14:	90                   	nop
  103a15:	90                   	nop
  103a16:	90                   	nop
  103a17:	90                   	nop
  103a18:	90                   	nop
  103a19:	90                   	nop
  103a1a:	90                   	nop
  103a1b:	90                   	nop
  103a1c:	90                   	nop
  103a1d:	90                   	nop
  103a1e:	90                   	nop
  103a1f:	90                   	nop

00103a20 <kill>:
// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  103a20:	55                   	push   %ebp
  103a21:	89 e5                	mov    %esp,%ebp
  103a23:	53                   	push   %ebx
  103a24:	83 ec 14             	sub    $0x14,%esp
  103a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&proc_table_lock);
  103a2a:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103a31:	e8 ba 04 00 00       	call   103ef0 <acquire>
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
  103a36:	39 1d 70 b1 10 00    	cmp    %ebx,0x10b170
  103a3c:	74 69                	je     103aa7 <kill+0x87>
kill(int pid)
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
  103a3e:	b8 f8 b1 10 00       	mov    $0x10b1f8,%eax
  103a43:	eb 0f                	jmp    103a54 <kill+0x34>
  103a45:	8d 76 00             	lea    0x0(%esi),%esi
  103a48:	05 98 00 00 00       	add    $0x98,%eax
  103a4d:	3d 60 d7 10 00       	cmp    $0x10d760,%eax
  103a52:	74 3c                	je     103a90 <kill+0x70>
    if(p->pid == pid){
  103a54:	39 58 10             	cmp    %ebx,0x10(%eax)
  103a57:	75 ef                	jne    103a48 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  103a59:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  103a5d:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  103a64:	74 1a                	je     103a80 <kill+0x60>
        p->state = RUNNABLE;
      release(&proc_table_lock);
  103a66:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103a6d:	e8 6e 05 00 00       	call   103fe0 <release>
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  103a72:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
  103a75:	31 c0                	xor    %eax,%eax
    }
  }
  release(&proc_table_lock);
  return -1;
}
  103a77:	5b                   	pop    %ebx
  103a78:	5d                   	pop    %ebp
  103a79:	c3                   	ret    
  103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  103a80:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103a87:	eb dd                	jmp    103a66 <kill+0x46>
  103a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  103a90:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103a97:	e8 44 05 00 00       	call   103fe0 <release>
  return -1;
}
  103a9c:	83 c4 14             	add    $0x14,%esp
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
  103a9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103aa4:	5b                   	pop    %ebx
  103aa5:	5d                   	pop    %ebp
  103aa6:	c3                   	ret    
kill(int pid)
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
  103aa7:	b8 60 b1 10 00       	mov    $0x10b160,%eax
  103aac:	eb ab                	jmp    103a59 <kill+0x39>
  103aae:	66 90                	xchg   %ax,%ax

00103ab0 <exit>:
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103ab0:	55                   	push   %ebp
  103ab1:	89 e5                	mov    %esp,%ebp
  103ab3:	57                   	push   %edi
  103ab4:	56                   	push   %esi
  103ab5:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(cp == initproc)
  103ab6:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103ab8:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  int fd;

  if(cp == initproc)
  103abb:	e8 50 fb ff ff       	call   103610 <curproc>
  103ac0:	3b 05 64 78 10 00    	cmp    0x107864,%eax
  103ac6:	0f 84 22 01 00 00    	je     103bee <exit+0x13e>
  103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd]){
  103ad0:	e8 3b fb ff ff       	call   103610 <curproc>
  103ad5:	8d 73 08             	lea    0x8(%ebx),%esi
  103ad8:	8b 3c b0             	mov    (%eax,%esi,4),%edi
  103adb:	85 ff                	test   %edi,%edi
  103add:	74 1c                	je     103afb <exit+0x4b>
      fileclose(cp->ofile[fd]);
  103adf:	e8 2c fb ff ff       	call   103610 <curproc>
  103ae4:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  103ae7:	89 04 24             	mov    %eax,(%esp)
  103aea:	e8 81 d3 ff ff       	call   100e70 <fileclose>
      cp->ofile[fd] = 0;
  103aef:	e8 1c fb ff ff       	call   103610 <curproc>
  103af4:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)

  if(cp == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  103afb:	83 c3 01             	add    $0x1,%ebx
  103afe:	83 fb 10             	cmp    $0x10,%ebx
  103b01:	75 cd                	jne    103ad0 <exit+0x20>
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  103b03:	e8 08 fb ff ff       	call   103610 <curproc>

// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
  103b08:	be 60 d7 10 00       	mov    $0x10d760,%esi
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  103b0d:	8b 40 60             	mov    0x60(%eax),%eax
  103b10:	89 04 24             	mov    %eax,(%esp)
  103b13:	e8 a8 dc ff ff       	call   1017c0 <iput>
  cp->cwd = 0;
  103b18:	e8 f3 fa ff ff       	call   103610 <curproc>
  103b1d:	c7 40 60 00 00 00 00 	movl   $0x0,0x60(%eax)

  acquire(&proc_table_lock);
  103b24:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103b2b:	e8 c0 03 00 00       	call   103ef0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  103b30:	e8 db fa ff ff       	call   103610 <curproc>
  103b35:	8b 50 14             	mov    0x14(%eax),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103b38:	b8 60 b1 10 00       	mov    $0x10b160,%eax
  103b3d:	eb 0d                	jmp    103b4c <exit+0x9c>
  103b3f:	90                   	nop
  103b40:	05 98 00 00 00       	add    $0x98,%eax
  103b45:	3d 60 d7 10 00       	cmp    $0x10d760,%eax
  103b4a:	74 1e                	je     103b6a <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
  103b4c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103b50:	75 ee                	jne    103b40 <exit+0x90>
  103b52:	3b 50 18             	cmp    0x18(%eax),%edx
  103b55:	75 e9                	jne    103b40 <exit+0x90>
      p->state = RUNNABLE;
  103b57:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103b5e:	05 98 00 00 00       	add    $0x98,%eax
  103b63:	3d 60 d7 10 00       	cmp    $0x10d760,%eax
  103b68:	75 e2                	jne    103b4c <exit+0x9c>
  103b6a:	bb 60 b1 10 00       	mov    $0x10b160,%ebx
  103b6f:	eb 15                	jmp    103b86 <exit+0xd6>
  103b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
  103b78:	81 c3 98 00 00 00    	add    $0x98,%ebx
  103b7e:	81 fb 60 d7 10 00    	cmp    $0x10d760,%ebx
  103b84:	74 3f                	je     103bc5 <exit+0x115>
    if(p->parent == cp){
  103b86:	8b 7b 14             	mov    0x14(%ebx),%edi
  103b89:	e8 82 fa ff ff       	call   103610 <curproc>
  103b8e:	39 c7                	cmp    %eax,%edi
  103b90:	75 e6                	jne    103b78 <exit+0xc8>
      p->parent = initproc;
  103b92:	8b 15 64 78 10 00    	mov    0x107864,%edx
      if(p->state == ZOMBIE)
  103b98:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  103b9c:	89 53 14             	mov    %edx,0x14(%ebx)
      if(p->state == ZOMBIE)
  103b9f:	75 d7                	jne    103b78 <exit+0xc8>
  103ba1:	b8 60 b1 10 00       	mov    $0x10b160,%eax
  103ba6:	eb 09                	jmp    103bb1 <exit+0x101>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103ba8:	05 98 00 00 00       	add    $0x98,%eax
  103bad:	39 c6                	cmp    %eax,%esi
  103baf:	74 c7                	je     103b78 <exit+0xc8>
    if(p->state == SLEEPING && p->chan == chan)
  103bb1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103bb5:	75 f1                	jne    103ba8 <exit+0xf8>
  103bb7:	3b 50 18             	cmp    0x18(%eax),%edx
  103bba:	75 ec                	jne    103ba8 <exit+0xf8>
      p->state = RUNNABLE;
  103bbc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103bc3:	eb e3                	jmp    103ba8 <exit+0xf8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  cp->killed = 0;
  103bc5:	e8 46 fa ff ff       	call   103610 <curproc>
  103bca:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  cp->state = ZOMBIE;
  103bd1:	e8 3a fa ff ff       	call   103610 <curproc>
  103bd6:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  103bdd:	e8 1e fc ff ff       	call   103800 <sched>
  panic("zombie exit");
  103be2:	c7 04 24 83 65 10 00 	movl   $0x106583,(%esp)
  103be9:	e8 12 cd ff ff       	call   100900 <panic>
{
  struct proc *p;
  int fd;

  if(cp == initproc)
    panic("init exiting");
  103bee:	c7 04 24 76 65 10 00 	movl   $0x106576,(%esp)
  103bf5:	e8 06 cd ff ff       	call   100900 <panic>
  103bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103c00 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103c00:	55                   	push   %ebp
  103c01:	89 e5                	mov    %esp,%ebp
  103c03:	57                   	push   %edi
  103c04:	56                   	push   %esi
  103c05:	53                   	push   %ebx

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103c06:	31 db                	xor    %ebx,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103c08:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  103c0b:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103c12:	e8 d9 02 00 00       	call   103ef0 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  103c17:	31 d2                	xor    %edx,%edx
    for(i = 0; i < NPROC; i++){
  103c19:	83 fb 3f             	cmp    $0x3f,%ebx
  103c1c:	7e 2b                	jle    103c49 <wait+0x49>
  103c1e:	66 90                	xchg   %ax,%ax
        havekids = 1;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
  103c20:	85 d2                	test   %edx,%edx
  103c22:	74 74                	je     103c98 <wait+0x98>
  103c24:	e8 e7 f9 ff ff       	call   103610 <curproc>
  103c29:	8b 40 1c             	mov    0x1c(%eax),%eax
  103c2c:	85 c0                	test   %eax,%eax
  103c2e:	75 68                	jne    103c98 <wait+0x98>
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  103c30:	e8 db f9 ff ff       	call   103610 <curproc>

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103c35:	31 db                	xor    %ebx,%ebx
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  103c37:	c7 44 24 04 60 d7 10 	movl   $0x10d760,0x4(%esp)
  103c3e:	00 
  103c3f:	89 04 24             	mov    %eax,(%esp)
  103c42:	e8 99 fc ff ff       	call   1038e0 <sleep>
  int i, havekids, pid;

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  103c47:	31 d2                	xor    %edx,%edx
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
      if(p->state == UNUSED)
  103c49:	69 f3 98 00 00 00    	imul   $0x98,%ebx,%esi
  103c4f:	8d be 60 b1 10 00    	lea    0x10b160(%esi),%edi
  103c55:	8b 4f 0c             	mov    0xc(%edi),%ecx
  103c58:	85 c9                	test   %ecx,%ecx
  103c5a:	75 0c                	jne    103c68 <wait+0x68>

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103c5c:	83 c3 01             	add    $0x1,%ebx
  103c5f:	83 fb 3f             	cmp    $0x3f,%ebx
  103c62:	7e e5                	jle    103c49 <wait+0x49>
  103c64:	eb ba                	jmp    103c20 <wait+0x20>
  103c66:	66 90                	xchg   %ax,%ax
      p = &proc[i];
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
  103c68:	8d 8e 70 b1 10 00    	lea    0x10b170(%esi),%ecx
  103c6e:	8b 41 04             	mov    0x4(%ecx),%eax
  103c71:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103c74:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  103c77:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103c7a:	e8 91 f9 ff ff       	call   103610 <curproc>
  103c7f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103c82:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  103c85:	75 d5                	jne    103c5c <wait+0x5c>
        if(p->state == ZOMBIE){
  103c87:	83 7f 0c 05          	cmpl   $0x5,0xc(%edi)
  103c8b:	74 24                	je     103cb1 <wait+0xb1>
          p->parent = 0;
          p->name[0] = 0;
          release(&proc_table_lock);
          return pid;
        }
        havekids = 1;
  103c8d:	ba 01 00 00 00       	mov    $0x1,%edx
  103c92:	eb c8                	jmp    103c5c <wait+0x5c>
  103c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
      release(&proc_table_lock);
  103c98:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103c9f:	e8 3c 03 00 00       	call   103fe0 <release>
      return -1;
  103ca4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  }
}
  103ca9:	83 c4 2c             	add    $0x2c,%esp
  103cac:	5b                   	pop    %ebx
  103cad:	5e                   	pop    %esi
  103cae:	5f                   	pop    %edi
  103caf:	5d                   	pop    %ebp
  103cb0:	c3                   	ret    
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
  103cb1:	8b 47 04             	mov    0x4(%edi),%eax
  103cb4:	89 44 24 04          	mov    %eax,0x4(%esp)
  103cb8:	8b 07                	mov    (%edi),%eax
  103cba:	89 04 24             	mov    %eax,(%esp)
  103cbd:	e8 6e e6 ff ff       	call   102330 <kfree>
          kfree(p->kstack, KSTACKSIZE);
  103cc2:	8b 47 08             	mov    0x8(%edi),%eax
  103cc5:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103ccc:	00 
  103ccd:	89 04 24             	mov    %eax,(%esp)
  103cd0:	e8 5b e6 ff ff       	call   102330 <kfree>
          pid = p->pid;
  103cd5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
          p->state = UNUSED;
  103cd8:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
          p->pid = 0;
          p->parent = 0;
          p->name[0] = 0;
  103cdf:	c6 86 e8 b1 10 00 00 	movb   $0x0,0x10b1e8(%esi)
      if(p->parent == cp){
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
          kfree(p->kstack, KSTACKSIZE);
          pid = p->pid;
  103ce6:	8b 01                	mov    (%ecx),%eax
          p->state = UNUSED;
          p->pid = 0;
          p->parent = 0;
  103ce8:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
          // Found one.
          kfree(p->mem, p->sz);
          kfree(p->kstack, KSTACKSIZE);
          pid = p->pid;
          p->state = UNUSED;
          p->pid = 0;
  103cef:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
          p->parent = 0;
          p->name[0] = 0;
          release(&proc_table_lock);
  103cf5:	c7 04 24 60 d7 10 00 	movl   $0x10d760,(%esp)
  103cfc:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103cff:	e8 dc 02 00 00       	call   103fe0 <release>
          return pid;
  103d04:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d07:	eb a0                	jmp    103ca9 <wait+0xa9>
  103d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103d10 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103d10:	55                   	push   %ebp
  103d11:	89 e5                	mov    %esp,%ebp
  103d13:	57                   	push   %edi
  103d14:	56                   	push   %esi
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
  103d15:	31 f6                	xor    %esi,%esi
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103d17:	53                   	push   %ebx
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
  103d18:	bb 6c b1 10 00       	mov    $0x10b16c,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103d1d:	83 ec 4c             	sub    $0x4c,%esp
  103d20:	eb 24                	jmp    103d46 <procdump+0x36>
  103d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  103d28:	c7 04 24 b3 64 10 00 	movl   $0x1064b3,(%esp)
  103d2f:	e8 1c c8 ff ff       	call   100550 <cprintf>
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
  103d34:	83 c6 01             	add    $0x1,%esi
  103d37:	81 c3 98 00 00 00    	add    $0x98,%ebx
  103d3d:	83 fe 40             	cmp    $0x40,%esi
  103d40:	0f 84 9a 00 00 00    	je     103de0 <procdump+0xd0>
    p = &proc[i];
    if(p->state == UNUSED)
  103d46:	8b 03                	mov    (%ebx),%eax
  103d48:	85 c0                	test   %eax,%eax
  103d4a:	74 e8                	je     103d34 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103d4c:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
  103d4f:	ba 8f 65 10 00       	mov    $0x10658f,%edx
  
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103d54:	77 11                	ja     103d67 <procdump+0x57>
  103d56:	8b 14 85 c8 65 10 00 	mov    0x1065c8(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
  103d5d:	b8 8f 65 10 00       	mov    $0x10658f,%eax
  103d62:	85 d2                	test   %edx,%edx
  103d64:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
  103d67:	69 c6 98 00 00 00    	imul   $0x98,%esi,%eax
  103d6d:	89 54 24 08          	mov    %edx,0x8(%esp)
  103d71:	c7 04 24 93 65 10 00 	movl   $0x106593,(%esp)
  103d78:	05 e8 b1 10 00       	add    $0x10b1e8,%eax
  103d7d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103d81:	8b 43 04             	mov    0x4(%ebx),%eax
  103d84:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d88:	e8 c3 c7 ff ff       	call   100550 <cprintf>
    if(p->state == SLEEPING){
  103d8d:	83 3b 02             	cmpl   $0x2,(%ebx)
  103d90:	75 96                	jne    103d28 <procdump+0x18>
      getcallerpcs((uint*)p->context.ebp+2, pc);
  103d92:	8d 45 c0             	lea    -0x40(%ebp),%eax
      for(j=0; j<10 && pc[j] != 0; j++)
  103d95:	31 ff                	xor    %edi,%edi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  103d97:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d9b:	8b 43 74             	mov    0x74(%ebx),%eax
  103d9e:	83 c0 08             	add    $0x8,%eax
  103da1:	89 04 24             	mov    %eax,(%esp)
  103da4:	e8 67 00 00 00       	call   103e10 <getcallerpcs>
  103da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(j=0; j<10 && pc[j] != 0; j++)
  103db0:	8b 44 bd c0          	mov    -0x40(%ebp,%edi,4),%eax
  103db4:	85 c0                	test   %eax,%eax
  103db6:	0f 84 6c ff ff ff    	je     103d28 <procdump+0x18>
  103dbc:	83 c7 01             	add    $0x1,%edi
        cprintf(" %p", pc[j]);
  103dbf:	89 44 24 04          	mov    %eax,0x4(%esp)
  103dc3:	c7 04 24 75 60 10 00 	movl   $0x106075,(%esp)
  103dca:	e8 81 c7 ff ff       	call   100550 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
  103dcf:	83 ff 0a             	cmp    $0xa,%edi
  103dd2:	75 dc                	jne    103db0 <procdump+0xa0>
  103dd4:	e9 4f ff ff ff       	jmp    103d28 <procdump+0x18>
  103dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  }
}
  103de0:	83 c4 4c             	add    $0x4c,%esp
  103de3:	5b                   	pop    %ebx
  103de4:	5e                   	pop    %esi
  103de5:	5f                   	pop    %edi
  103de6:	5d                   	pop    %ebp
  103de7:	c3                   	ret    
  103de8:	90                   	nop
  103de9:	90                   	nop
  103dea:	90                   	nop
  103deb:	90                   	nop
  103dec:	90                   	nop
  103ded:	90                   	nop
  103dee:	90                   	nop
  103def:	90                   	nop

00103df0 <initlock>:

extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  103df0:	55                   	push   %ebp
  103df1:	89 e5                	mov    %esp,%ebp
  103df3:	8b 45 08             	mov    0x8(%ebp),%eax
  lock->name = name;
  103df6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lock->locked = 0;
  103df9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  103dff:	89 50 04             	mov    %edx,0x4(%eax)
  lock->locked = 0;
  lock->cpu = 0xffffffff;
  103e02:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
}
  103e09:	5d                   	pop    %ebp
  103e0a:	c3                   	ret    
  103e0b:	90                   	nop
  103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103e10 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103e10:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e11:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103e13:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103e15:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103e18:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103e1b:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103e1c:	83 ea 08             	sub    $0x8,%edx
  103e1f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103e20:	8d 5a ff             	lea    -0x1(%edx),%ebx
  103e23:	83 fb fd             	cmp    $0xfffffffd,%ebx
  103e26:	77 18                	ja     103e40 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103e28:	8b 5a 04             	mov    0x4(%edx),%ebx
  103e2b:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e2e:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103e31:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e33:	83 f8 0a             	cmp    $0xa,%eax
  103e36:	75 e8                	jne    103e20 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  103e38:	5b                   	pop    %ebx
  103e39:	5d                   	pop    %ebp
  103e3a:	c3                   	ret    
  103e3b:	90                   	nop
  103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e40:	83 f8 09             	cmp    $0x9,%eax
  103e43:	7f f3                	jg     103e38 <getcallerpcs+0x28>
  103e45:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
  103e48:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e4f:	83 c0 01             	add    $0x1,%eax
  103e52:	83 f8 0a             	cmp    $0xa,%eax
  103e55:	75 f1                	jne    103e48 <getcallerpcs+0x38>
    pcs[i] = 0;
}
  103e57:	5b                   	pop    %ebx
  103e58:	5d                   	pop    %ebp
  103e59:	c3                   	ret    
  103e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103e60 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103e60:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu() + 10;
  103e61:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103e63:	89 e5                	mov    %esp,%ebp
  103e65:	53                   	push   %ebx
  103e66:	83 ec 04             	sub    $0x4,%esp
  103e69:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu() + 10;
  103e6c:	8b 0a                	mov    (%edx),%ecx
  103e6e:	85 c9                	test   %ecx,%ecx
  103e70:	75 06                	jne    103e78 <holding+0x18>
}
  103e72:	83 c4 04             	add    $0x4,%esp
  103e75:	5b                   	pop    %ebx
  103e76:	5d                   	pop    %ebp
  103e77:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103e78:	8b 5a 08             	mov    0x8(%edx),%ebx
  103e7b:	e8 00 e9 ff ff       	call   102780 <cpu>
  103e80:	83 c0 0a             	add    $0xa,%eax
    pcs[i] = 0;
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
  103e83:	39 c3                	cmp    %eax,%ebx
{
  return lock->locked && lock->cpu == cpu() + 10;
  103e85:	0f 94 c0             	sete   %al
}
  103e88:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103e8b:	0f b6 c0             	movzbl %al,%eax
}
  103e8e:	5b                   	pop    %ebx
  103e8f:	5d                   	pop    %ebp
  103e90:	c3                   	ret    
  103e91:	eb 0d                	jmp    103ea0 <pushcli>
  103e93:	90                   	nop
  103e94:	90                   	nop
  103e95:	90                   	nop
  103e96:	90                   	nop
  103e97:	90                   	nop
  103e98:	90                   	nop
  103e99:	90                   	nop
  103e9a:	90                   	nop
  103e9b:	90                   	nop
  103e9c:	90                   	nop
  103e9d:	90                   	nop
  103e9e:	90                   	nop
  103e9f:	90                   	nop

00103ea0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103ea0:	55                   	push   %ebp
  103ea1:	89 e5                	mov    %esp,%ebp
  103ea3:	53                   	push   %ebx
  103ea4:	83 ec 04             	sub    $0x4,%esp
  103ea7:	9c                   	pushf  
  103ea8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103ea9:	fa                   	cli    
  int eflags;
  
  eflags = read_eflags();
  cli();
  if(cpus[cpu()].ncli++ == 0)
  103eaa:	e8 d1 e8 ff ff       	call   102780 <cpu>
  103eaf:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103eb5:	05 e4 aa 10 00       	add    $0x10aae4,%eax
  103eba:	8b 90 c0 00 00 00    	mov    0xc0(%eax),%edx
  103ec0:	8d 4a 01             	lea    0x1(%edx),%ecx
  103ec3:	85 d2                	test   %edx,%edx
  103ec5:	89 88 c0 00 00 00    	mov    %ecx,0xc0(%eax)
  103ecb:	75 17                	jne    103ee4 <pushcli+0x44>
    cpus[cpu()].intena = eflags & FL_IF;
  103ecd:	e8 ae e8 ff ff       	call   102780 <cpu>
  103ed2:	81 e3 00 02 00 00    	and    $0x200,%ebx
  103ed8:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103ede:	89 98 a8 ab 10 00    	mov    %ebx,0x10aba8(%eax)
}
  103ee4:	83 c4 04             	add    $0x4,%esp
  103ee7:	5b                   	pop    %ebx
  103ee8:	5d                   	pop    %ebp
  103ee9:	c3                   	ret    
  103eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103ef0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  103ef0:	55                   	push   %ebp
  103ef1:	89 e5                	mov    %esp,%ebp
  103ef3:	53                   	push   %ebx
  103ef4:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  103ef7:	e8 a4 ff ff ff       	call   103ea0 <pushcli>
  if(holding(lock))
  103efc:	8b 45 08             	mov    0x8(%ebp),%eax
  103eff:	89 04 24             	mov    %eax,(%esp)
  103f02:	e8 59 ff ff ff       	call   103e60 <holding>
  103f07:	85 c0                	test   %eax,%eax
  103f09:	75 3d                	jne    103f48 <acquire+0x58>
  103f0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103f0e:	ba 01 00 00 00       	mov    $0x1,%edx
  103f13:	90                   	nop
  103f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103f18:	89 d0                	mov    %edx,%eax
  103f1a:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it.  
  while(xchg(&lock->locked, 1) == 1)
  103f1d:	83 f8 01             	cmp    $0x1,%eax
  103f20:	74 f6                	je     103f18 <acquire+0x28>

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  103f22:	e8 59 e8 ff ff       	call   102780 <cpu>
  103f27:	83 c0 0a             	add    $0xa,%eax
  103f2a:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lock, lock->pcs);
  103f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  103f30:	83 c0 0c             	add    $0xc,%eax
  103f33:	89 44 24 04          	mov    %eax,0x4(%esp)
  103f37:	8d 45 08             	lea    0x8(%ebp),%eax
  103f3a:	89 04 24             	mov    %eax,(%esp)
  103f3d:	e8 ce fe ff ff       	call   103e10 <getcallerpcs>
}
  103f42:	83 c4 14             	add    $0x14,%esp
  103f45:	5b                   	pop    %ebx
  103f46:	5d                   	pop    %ebp
  103f47:	c3                   	ret    
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
    panic("acquire");
  103f48:	c7 04 24 e0 65 10 00 	movl   $0x1065e0,(%esp)
  103f4f:	e8 ac c9 ff ff       	call   100900 <panic>
  103f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103f60 <popcli>:
    cpus[cpu()].intena = eflags & FL_IF;
}

void
popcli(void)
{
  103f60:	55                   	push   %ebp
  103f61:	89 e5                	mov    %esp,%ebp
  103f63:	83 ec 18             	sub    $0x18,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103f66:	9c                   	pushf  
  103f67:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  103f68:	f6 c4 02             	test   $0x2,%ah
  103f6b:	75 5f                	jne    103fcc <popcli+0x6c>
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
  103f6d:	e8 0e e8 ff ff       	call   102780 <cpu>
  103f72:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103f78:	05 e4 aa 10 00       	add    $0x10aae4,%eax
  103f7d:	8b 90 c0 00 00 00    	mov    0xc0(%eax),%edx
  103f83:	83 ea 01             	sub    $0x1,%edx
  103f86:	85 d2                	test   %edx,%edx
  103f88:	89 90 c0 00 00 00    	mov    %edx,0xc0(%eax)
  103f8e:	78 30                	js     103fc0 <popcli+0x60>
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  103f90:	e8 eb e7 ff ff       	call   102780 <cpu>
  103f95:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103f9b:	8b 90 a4 ab 10 00    	mov    0x10aba4(%eax),%edx
  103fa1:	85 d2                	test   %edx,%edx
  103fa3:	74 03                	je     103fa8 <popcli+0x48>
    sti();
}
  103fa5:	c9                   	leave  
  103fa6:	c3                   	ret    
  103fa7:	90                   	nop
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  103fa8:	e8 d3 e7 ff ff       	call   102780 <cpu>
  103fad:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103fb3:	8b 80 a8 ab 10 00    	mov    0x10aba8(%eax),%eax
  103fb9:	85 c0                	test   %eax,%eax
  103fbb:	74 e8                	je     103fa5 <popcli+0x45>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103fbd:	fb                   	sti    
    sti();
}
  103fbe:	c9                   	leave  
  103fbf:	c3                   	ret    
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  103fc0:	c7 04 24 ff 65 10 00 	movl   $0x1065ff,(%esp)
  103fc7:	e8 34 c9 ff ff       	call   100900 <panic>

void
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  103fcc:	c7 04 24 e8 65 10 00 	movl   $0x1065e8,(%esp)
  103fd3:	e8 28 c9 ff ff       	call   100900 <panic>
  103fd8:	90                   	nop
  103fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103fe0 <release>:
}

// Release the lock.
void
release(struct spinlock *lock)
{
  103fe0:	55                   	push   %ebp
  103fe1:	89 e5                	mov    %esp,%ebp
  103fe3:	53                   	push   %ebx
  103fe4:	83 ec 14             	sub    $0x14,%esp
  103fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lock))
  103fea:	89 1c 24             	mov    %ebx,(%esp)
  103fed:	e8 6e fe ff ff       	call   103e60 <holding>
  103ff2:	85 c0                	test   %eax,%eax
  103ff4:	74 1d                	je     104013 <release+0x33>
    panic("release");

  lock->pcs[0] = 0;
  103ff6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103ffd:	31 c0                	xor    %eax,%eax
  lock->cpu = 0xffffffff;
  103fff:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
  104006:	f0 87 03             	lock xchg %eax,(%ebx)
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
}
  104009:	83 c4 14             	add    $0x14,%esp
  10400c:	5b                   	pop    %ebx
  10400d:	5d                   	pop    %ebp
  // by the Intel manuals, but does not happen on current 
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
  10400e:	e9 4d ff ff ff       	jmp    103f60 <popcli>
// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");
  104013:	c7 04 24 06 66 10 00 	movl   $0x106606,(%esp)
  10401a:	e8 e1 c8 ff ff       	call   100900 <panic>
  10401f:	90                   	nop

00104020 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
  104020:	55                   	push   %ebp
  104021:	89 e5                	mov    %esp,%ebp
  104023:	8b 4d 10             	mov    0x10(%ebp),%ecx
  104026:	53                   	push   %ebx
  104027:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  10402a:	85 c9                	test   %ecx,%ecx
  10402c:	74 14                	je     104042 <memset+0x22>
  10402e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
  104032:	31 d2                	xor    %edx,%edx
  104034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  104038:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  10403b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  10403e:	39 ca                	cmp    %ecx,%edx
  104040:	75 f6                	jne    104038 <memset+0x18>
    *d++ = c;

  return dst;
}
  104042:	5b                   	pop    %ebx
  104043:	5d                   	pop    %ebp
  104044:	c3                   	ret    
  104045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104050 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  104050:	55                   	push   %ebp
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
  104051:	31 c0                	xor    %eax,%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
  104053:	89 e5                	mov    %esp,%ebp
  104055:	57                   	push   %edi
  104056:	8b 7d 10             	mov    0x10(%ebp),%edi
  104059:	56                   	push   %esi
  10405a:	8b 75 0c             	mov    0xc(%ebp),%esi
  10405d:	53                   	push   %ebx
  10405e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  104061:	85 ff                	test   %edi,%edi
  104063:	74 2a                	je     10408f <memcmp+0x3f>
    if(*s1 != *s2)
  104065:	0f b6 0b             	movzbl (%ebx),%ecx
  104068:	0f b6 16             	movzbl (%esi),%edx
  10406b:	38 d1                	cmp    %dl,%cl
  10406d:	75 29                	jne    104098 <memcmp+0x48>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  10406f:	83 ef 01             	sub    $0x1,%edi
  104072:	31 c0                	xor    %eax,%eax
  104074:	eb 13                	jmp    104089 <memcmp+0x39>
  104076:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
  104078:	0f b6 4c 03 01       	movzbl 0x1(%ebx,%eax,1),%ecx
  10407d:	0f b6 54 06 01       	movzbl 0x1(%esi,%eax,1),%edx
  104082:	83 c0 01             	add    $0x1,%eax
  104085:	38 d1                	cmp    %dl,%cl
  104087:	75 0f                	jne    104098 <memcmp+0x48>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  104089:	39 c7                	cmp    %eax,%edi
  10408b:	75 eb                	jne    104078 <memcmp+0x28>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
  10408d:	31 c0                	xor    %eax,%eax
}
  10408f:	5b                   	pop    %ebx
  104090:	5e                   	pop    %esi
  104091:	5f                   	pop    %edi
  104092:	5d                   	pop    %ebp
  104093:	c3                   	ret    
  104094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  104098:	0f b6 c1             	movzbl %cl,%eax
  10409b:	0f b6 d2             	movzbl %dl,%edx
  10409e:	29 d0                	sub    %edx,%eax
    s1++, s2++;
  }

  return 0;
}
  1040a0:	5b                   	pop    %ebx
  1040a1:	5e                   	pop    %esi
  1040a2:	5f                   	pop    %edi
  1040a3:	5d                   	pop    %ebp
  1040a4:	c3                   	ret    
  1040a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1040a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001040b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  1040b0:	55                   	push   %ebp
  1040b1:	89 e5                	mov    %esp,%ebp
  1040b3:	57                   	push   %edi
  1040b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1040b7:	56                   	push   %esi
  1040b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  1040bb:	53                   	push   %ebx
  1040bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  1040bf:	39 c6                	cmp    %eax,%esi
  1040c1:	73 2d                	jae    1040f0 <memmove+0x40>
  1040c3:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
  1040c6:	39 f8                	cmp    %edi,%eax
  1040c8:	73 26                	jae    1040f0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  1040ca:	85 db                	test   %ebx,%ebx
  1040cc:	74 1d                	je     1040eb <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
  1040ce:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  1040d1:	31 d2                	xor    %edx,%edx
  1040d3:	90                   	nop
  1040d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
  1040d8:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
  1040dd:	88 4c 16 ff          	mov    %cl,-0x1(%esi,%edx,1)
  1040e1:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  1040e4:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
  1040e7:	85 c9                	test   %ecx,%ecx
  1040e9:	75 ed                	jne    1040d8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  1040eb:	5b                   	pop    %ebx
  1040ec:	5e                   	pop    %esi
  1040ed:	5f                   	pop    %edi
  1040ee:	5d                   	pop    %ebp
  1040ef:	c3                   	ret    
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  1040f0:	31 d2                	xor    %edx,%edx
  1040f2:	85 db                	test   %ebx,%ebx
  1040f4:	74 f5                	je     1040eb <memmove+0x3b>
  1040f6:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  1040f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  1040fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1040ff:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  104102:	39 d3                	cmp    %edx,%ebx
  104104:	75 f2                	jne    1040f8 <memmove+0x48>
      *d++ = *s++;

  return dst;
}
  104106:	5b                   	pop    %ebx
  104107:	5e                   	pop    %esi
  104108:	5f                   	pop    %edi
  104109:	5d                   	pop    %ebp
  10410a:	c3                   	ret    
  10410b:	90                   	nop
  10410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104110 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  104110:	55                   	push   %ebp
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  104111:	31 c0                	xor    %eax,%eax
  return dst;
}

int
strncmp(const char *p, const char *q, uint n)
{
  104113:	89 e5                	mov    %esp,%ebp
  104115:	57                   	push   %edi
  104116:	8b 7d 10             	mov    0x10(%ebp),%edi
  104119:	56                   	push   %esi
  10411a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10411d:	53                   	push   %ebx
  10411e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
  104121:	85 ff                	test   %edi,%edi
  104123:	74 31                	je     104156 <strncmp+0x46>
  104125:	0f b6 01             	movzbl (%ecx),%eax
  104128:	84 c0                	test   %al,%al
  10412a:	75 16                	jne    104142 <strncmp+0x32>
  10412c:	eb 32                	jmp    104160 <strncmp+0x50>
  10412e:	66 90                	xchg   %ax,%ax
  104130:	83 ef 01             	sub    $0x1,%edi
  104133:	74 33                	je     104168 <strncmp+0x58>
    n--, p++, q++;
  104135:	83 c1 01             	add    $0x1,%ecx
  104138:	83 c3 01             	add    $0x1,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  10413b:	0f b6 01             	movzbl (%ecx),%eax
  10413e:	84 c0                	test   %al,%al
  104140:	74 1e                	je     104160 <strncmp+0x50>
  104142:	0f b6 33             	movzbl (%ebx),%esi
  104145:	89 f2                	mov    %esi,%edx
  104147:	38 d0                	cmp    %dl,%al
  104149:	74 e5                	je     104130 <strncmp+0x20>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  10414b:	0f b6 c0             	movzbl %al,%eax
  10414e:	81 e6 ff 00 00 00    	and    $0xff,%esi
  104154:	29 f0                	sub    %esi,%eax
}
  104156:	5b                   	pop    %ebx
  104157:	5e                   	pop    %esi
  104158:	5f                   	pop    %edi
  104159:	5d                   	pop    %ebp
  10415a:	c3                   	ret    
  10415b:	90                   	nop
  10415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  104160:	0f b6 33             	movzbl (%ebx),%esi
  104163:	eb e6                	jmp    10414b <strncmp+0x3b>
  104165:	8d 76 00             	lea    0x0(%esi),%esi
    n--, p++, q++;
  if(n == 0)
    return 0;
  104168:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
  10416a:	5b                   	pop    %ebx
  10416b:	5e                   	pop    %esi
  10416c:	5f                   	pop    %edi
  10416d:	5d                   	pop    %ebp
  10416e:	c3                   	ret    
  10416f:	90                   	nop

00104170 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  104170:	55                   	push   %ebp
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104171:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
  104173:	89 e5                	mov    %esp,%ebp
  104175:	57                   	push   %edi
  104176:	56                   	push   %esi
  104177:	53                   	push   %ebx
  104178:	83 ec 04             	sub    $0x4,%esp
  10417b:	8b 75 10             	mov    0x10(%ebp),%esi
  10417e:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104181:	8b 55 08             	mov    0x8(%ebp),%edx
  104184:	8d 4e ff             	lea    -0x1(%esi),%ecx
  104187:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  10418a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  104190:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  104193:	89 f3                	mov    %esi,%ebx
  104195:	29 c3                	sub    %eax,%ebx
  104197:	29 c1                	sub    %eax,%ecx
{
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104199:	85 db                	test   %ebx,%ebx
  10419b:	7e 10                	jle    1041ad <strncpy+0x3d>
  10419d:	0f b6 1c 07          	movzbl (%edi,%eax,1),%ebx
  1041a1:	83 c0 01             	add    $0x1,%eax
  1041a4:	88 1a                	mov    %bl,(%edx)
  1041a6:	83 c2 01             	add    $0x1,%edx
  1041a9:	84 db                	test   %bl,%bl
  1041ab:	75 e3                	jne    104190 <strncpy+0x20>
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  1041ad:	31 c0                	xor    %eax,%eax
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  1041af:	85 c9                	test   %ecx,%ecx
  1041b1:	7e 10                	jle    1041c3 <strncpy+0x53>
  1041b3:	90                   	nop
  1041b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
  1041b8:	c6 04 02 00          	movb   $0x0,(%edx,%eax,1)
  1041bc:	83 c0 01             	add    $0x1,%eax
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  1041bf:	39 c8                	cmp    %ecx,%eax
  1041c1:	75 f5                	jne    1041b8 <strncpy+0x48>
    *s++ = 0;
  return os;
}
  1041c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1041c6:	83 c4 04             	add    $0x4,%esp
  1041c9:	5b                   	pop    %ebx
  1041ca:	5e                   	pop    %esi
  1041cb:	5f                   	pop    %edi
  1041cc:	5d                   	pop    %ebp
  1041cd:	c3                   	ret    
  1041ce:	66 90                	xchg   %ax,%ax

001041d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  1041d0:	55                   	push   %ebp
  1041d1:	89 e5                	mov    %esp,%ebp
  1041d3:	8b 55 10             	mov    0x10(%ebp),%edx
  1041d6:	56                   	push   %esi
  1041d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1041da:	53                   	push   %ebx
  1041db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;
  
  os = s;
  if(n <= 0)
  1041de:	85 d2                	test   %edx,%edx
  1041e0:	7e 1f                	jle    104201 <safestrcpy+0x31>
  1041e2:	89 c1                	mov    %eax,%ecx
  1041e4:	eb 05                	jmp    1041eb <safestrcpy+0x1b>
  1041e6:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  1041e8:	83 c6 01             	add    $0x1,%esi
  1041eb:	83 ea 01             	sub    $0x1,%edx
  1041ee:	85 d2                	test   %edx,%edx
  1041f0:	7e 0c                	jle    1041fe <safestrcpy+0x2e>
  1041f2:	0f b6 1e             	movzbl (%esi),%ebx
  1041f5:	88 19                	mov    %bl,(%ecx)
  1041f7:	83 c1 01             	add    $0x1,%ecx
  1041fa:	84 db                	test   %bl,%bl
  1041fc:	75 ea                	jne    1041e8 <safestrcpy+0x18>
    ;
  *s = 0;
  1041fe:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  104201:	5b                   	pop    %ebx
  104202:	5e                   	pop    %esi
  104203:	5d                   	pop    %ebp
  104204:	c3                   	ret    
  104205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104210 <strlen>:

int
strlen(const char *s)
{
  104210:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  104211:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  104213:	89 e5                	mov    %esp,%ebp
  104215:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  104218:	80 3a 00             	cmpb   $0x0,(%edx)
  10421b:	74 0c                	je     104229 <strlen+0x19>
  10421d:	8d 76 00             	lea    0x0(%esi),%esi
  104220:	83 c0 01             	add    $0x1,%eax
  104223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  104227:	75 f7                	jne    104220 <strlen+0x10>
    ;
  return n;
}
  104229:	5d                   	pop    %ebp
  10422a:	c3                   	ret    
  10422b:	90                   	nop

0010422c <swtch>:
  10422c:	8b 44 24 04          	mov    0x4(%esp),%eax
  104230:	8f 00                	popl   (%eax)
  104232:	89 60 04             	mov    %esp,0x4(%eax)
  104235:	89 58 08             	mov    %ebx,0x8(%eax)
  104238:	89 48 0c             	mov    %ecx,0xc(%eax)
  10423b:	89 50 10             	mov    %edx,0x10(%eax)
  10423e:	89 70 14             	mov    %esi,0x14(%eax)
  104241:	89 78 18             	mov    %edi,0x18(%eax)
  104244:	89 68 1c             	mov    %ebp,0x1c(%eax)
  104247:	8b 44 24 04          	mov    0x4(%esp),%eax
  10424b:	8b 68 1c             	mov    0x1c(%eax),%ebp
  10424e:	8b 78 18             	mov    0x18(%eax),%edi
  104251:	8b 70 14             	mov    0x14(%eax),%esi
  104254:	8b 50 10             	mov    0x10(%eax),%edx
  104257:	8b 48 0c             	mov    0xc(%eax),%ecx
  10425a:	8b 58 08             	mov    0x8(%eax),%ebx
  10425d:	8b 60 04             	mov    0x4(%eax),%esp
  104260:	ff 30                	pushl  (%eax)
  104262:	c3                   	ret    
  104263:	90                   	nop
  104264:	90                   	nop
  104265:	90                   	nop
  104266:	90                   	nop
  104267:	90                   	nop
  104268:	90                   	nop
  104269:	90                   	nop
  10426a:	90                   	nop
  10426b:	90                   	nop
  10426c:	90                   	nop
  10426d:	90                   	nop
  10426e:	90                   	nop
  10426f:	90                   	nop

00104270 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  104270:	55                   	push   %ebp
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  104271:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  104276:	89 e5                	mov    %esp,%ebp
  104278:	83 ec 08             	sub    $0x8,%esp
  10427b:	89 1c 24             	mov    %ebx,(%esp)
  10427e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  104281:	89 74 24 04          	mov    %esi,0x4(%esp)
  104285:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(addr >= p->sz || addr+4 > p->sz)
  104288:	8b 4b 04             	mov    0x4(%ebx),%ecx
  10428b:	39 d1                	cmp    %edx,%ecx
  10428d:	77 11                	ja     1042a0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(p->mem + addr);
  return 0;
}
  10428f:	8b 1c 24             	mov    (%esp),%ebx
  104292:	8b 74 24 04          	mov    0x4(%esp),%esi
  104296:	89 ec                	mov    %ebp,%esp
  104298:	5d                   	pop    %ebp
  104299:	c3                   	ret    
  10429a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1042a0:	8d 72 04             	lea    0x4(%edx),%esi
  1042a3:	39 f1                	cmp    %esi,%ecx
  1042a5:	72 e8                	jb     10428f <fetchint+0x1f>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1042a7:	8b 03                	mov    (%ebx),%eax
  1042a9:	8b 14 10             	mov    (%eax,%edx,1),%edx
  1042ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1042af:	89 10                	mov    %edx,(%eax)
  return 0;
  1042b1:	31 c0                	xor    %eax,%eax
  1042b3:	eb da                	jmp    10428f <fetchint+0x1f>
  1042b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001042c0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  1042c0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  1042c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  1042c6:	89 e5                	mov    %esp,%ebp
  1042c8:	83 ec 08             	sub    $0x8,%esp
  1042cb:	8b 55 08             	mov    0x8(%ebp),%edx
  1042ce:	89 1c 24             	mov    %ebx,(%esp)
  1042d1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  1042d4:	89 74 24 04          	mov    %esi,0x4(%esp)
  char *s, *ep;

  if(addr >= p->sz)
  1042d8:	8b 4a 04             	mov    0x4(%edx),%ecx
  1042db:	39 d9                	cmp    %ebx,%ecx
  1042dd:	77 11                	ja     1042f0 <fetchstr+0x30>
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
  1042df:	8b 1c 24             	mov    (%esp),%ebx
  1042e2:	8b 74 24 04          	mov    0x4(%esp),%esi
  1042e6:	89 ec                	mov    %ebp,%esp
  1042e8:	5d                   	pop    %ebp
  1042e9:	c3                   	ret    
  1042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  1042f0:	8b 75 10             	mov    0x10(%ebp),%esi
  1042f3:	03 1a                	add    (%edx),%ebx
  1042f5:	89 1e                	mov    %ebx,(%esi)
  ep = p->mem + p->sz;
  1042f7:	03 0a                	add    (%edx),%ecx
  for(s = *pp; s < ep; s++)
  1042f9:	39 cb                	cmp    %ecx,%ebx
  1042fb:	73 e2                	jae    1042df <fetchstr+0x1f>
    if(*s == 0)
  1042fd:	31 c0                	xor    %eax,%eax
  1042ff:	80 3b 00             	cmpb   $0x0,(%ebx)
  104302:	74 db                	je     1042df <fetchstr+0x1f>
  104304:	89 d8                	mov    %ebx,%eax
  104306:	eb 05                	jmp    10430d <fetchstr+0x4d>
  104308:	80 38 00             	cmpb   $0x0,(%eax)
  10430b:	74 13                	je     104320 <fetchstr+0x60>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  10430d:	83 c0 01             	add    $0x1,%eax
  104310:	39 c1                	cmp    %eax,%ecx
  104312:	77 f4                	ja     104308 <fetchstr+0x48>
    if(*s == 0)
      return s - *pp;
  return -1;
  104314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104319:	eb c4                	jmp    1042df <fetchstr+0x1f>
  10431b:	90                   	nop
  10431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104320:	29 d8                	sub    %ebx,%eax
  104322:	eb bb                	jmp    1042df <fetchstr+0x1f>
  104324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10432a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104330 <argint>:
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  104330:	55                   	push   %ebp
  104331:	89 e5                	mov    %esp,%ebp
  104333:	83 ec 08             	sub    $0x8,%esp
  104336:	89 1c 24             	mov    %ebx,(%esp)
  104339:	89 74 24 04          	mov    %esi,0x4(%esp)
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  10433d:	e8 ce f2 ff ff       	call   103610 <curproc>
  104342:	8b 55 08             	mov    0x8(%ebp),%edx
  104345:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  10434b:	8b 40 3c             	mov    0x3c(%eax),%eax
  10434e:	8d 5c 90 04          	lea    0x4(%eax,%edx,4),%ebx
  104352:	e8 b9 f2 ff ff       	call   103610 <curproc>

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104357:	8b 50 04             	mov    0x4(%eax),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  10435a:	89 c1                	mov    %eax,%ecx
// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  10435c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104361:	39 d3                	cmp    %edx,%ebx
  104363:	72 0b                	jb     104370 <argint+0x40>
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  104365:	8b 1c 24             	mov    (%esp),%ebx
  104368:	8b 74 24 04          	mov    0x4(%esp),%esi
  10436c:	89 ec                	mov    %ebp,%esp
  10436e:	5d                   	pop    %ebp
  10436f:	c3                   	ret    

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104370:	8d 73 04             	lea    0x4(%ebx),%esi
  104373:	39 f2                	cmp    %esi,%edx
  104375:	72 ee                	jb     104365 <argint+0x35>
    return -1;
  *ip = *(int*)(p->mem + addr);
  104377:	8b 01                	mov    (%ecx),%eax
  104379:	8b 14 18             	mov    (%eax,%ebx,1),%edx
  10437c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10437f:	89 10                	mov    %edx,(%eax)
  return 0;
  104381:	31 c0                	xor    %eax,%eax
  104383:	eb e0                	jmp    104365 <argint+0x35>
  104385:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104390 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  104390:	55                   	push   %ebp
  104391:	89 e5                	mov    %esp,%ebp
  104393:	83 ec 28             	sub    $0x28,%esp
  int i;
  
  if(argint(n, &i) < 0)
  104396:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104399:	89 44 24 04          	mov    %eax,0x4(%esp)
  10439d:	8b 45 08             	mov    0x8(%ebp),%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  1043a0:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  1043a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  1043a8:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int i;
  
  if(argint(n, &i) < 0)
  1043ab:	89 04 24             	mov    %eax,(%esp)
  1043ae:	e8 7d ff ff ff       	call   104330 <argint>
  1043b3:	85 c0                	test   %eax,%eax
  1043b5:	79 11                	jns    1043c8 <argptr+0x38>
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
    return -1;
  *pp = cp->mem + i;
  return 0;
}
  1043b7:	89 d8                	mov    %ebx,%eax
  1043b9:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1043bc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1043bf:	89 ec                	mov    %ebp,%esp
  1043c1:	5d                   	pop    %ebp
  1043c2:	c3                   	ret    
  1043c3:	90                   	nop
  1043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
  1043c8:	8b 75 f4             	mov    -0xc(%ebp),%esi
  1043cb:	e8 40 f2 ff ff       	call   103610 <curproc>
  1043d0:	3b 70 04             	cmp    0x4(%eax),%esi
  1043d3:	73 e2                	jae    1043b7 <argptr+0x27>
  1043d5:	8b 75 10             	mov    0x10(%ebp),%esi
  1043d8:	03 75 f4             	add    -0xc(%ebp),%esi
  1043db:	e8 30 f2 ff ff       	call   103610 <curproc>
  1043e0:	3b 70 04             	cmp    0x4(%eax),%esi
  1043e3:	73 d2                	jae    1043b7 <argptr+0x27>
    return -1;
  *pp = cp->mem + i;
  1043e5:	e8 26 f2 ff ff       	call   103610 <curproc>
  1043ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  return 0;
  1043ed:	31 db                	xor    %ebx,%ebx
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
    return -1;
  *pp = cp->mem + i;
  1043ef:	8b 00                	mov    (%eax),%eax
  1043f1:	03 45 f4             	add    -0xc(%ebp),%eax
  1043f4:	89 02                	mov    %eax,(%edx)
  return 0;
  1043f6:	eb bf                	jmp    1043b7 <argptr+0x27>
  1043f8:	90                   	nop
  1043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104400 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  104400:	55                   	push   %ebp
  104401:	89 e5                	mov    %esp,%ebp
  104403:	56                   	push   %esi
  104404:	53                   	push   %ebx
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  104405:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  10440a:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
  10440d:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104410:	89 44 24 04          	mov    %eax,0x4(%esp)
  104414:	8b 45 08             	mov    0x8(%ebp),%eax
  104417:	89 04 24             	mov    %eax,(%esp)
  10441a:	e8 11 ff ff ff       	call   104330 <argint>
  10441f:	85 c0                	test   %eax,%eax
  104421:	78 45                	js     104468 <argstr+0x68>
    return -1;
  return fetchstr(cp, addr, pp);
  104423:	8b 75 f4             	mov    -0xc(%ebp),%esi
  104426:	e8 e5 f1 ff ff       	call   103610 <curproc>
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  10442b:	8b 50 04             	mov    0x4(%eax),%edx
  10442e:	39 d6                	cmp    %edx,%esi
  104430:	73 36                	jae    104468 <argstr+0x68>
    return -1;
  *pp = p->mem + addr;
  104432:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  104435:	03 30                	add    (%eax),%esi
  104437:	89 31                	mov    %esi,(%ecx)
  ep = p->mem + p->sz;
  104439:	03 10                	add    (%eax),%edx
  for(s = *pp; s < ep; s++)
  10443b:	39 d6                	cmp    %edx,%esi
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  10443d:	89 d0                	mov    %edx,%eax
  for(s = *pp; s < ep; s++)
  10443f:	73 27                	jae    104468 <argstr+0x68>
    if(*s == 0)
  104441:	31 db                	xor    %ebx,%ebx
  104443:	80 3e 00             	cmpb   $0x0,(%esi)
  104446:	74 20                	je     104468 <argstr+0x68>
  104448:	89 f3                	mov    %esi,%ebx
  10444a:	eb 09                	jmp    104455 <argstr+0x55>
  10444c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104450:	80 3b 00             	cmpb   $0x0,(%ebx)
  104453:	74 23                	je     104478 <argstr+0x78>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  104455:	83 c3 01             	add    $0x1,%ebx
  104458:	39 d8                	cmp    %ebx,%eax
  10445a:	77 f4                	ja     104450 <argstr+0x50>
    if(*s == 0)
      return s - *pp;
  return -1;
  10445c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104468:	83 c4 20             	add    $0x20,%esp
  10446b:	89 d8                	mov    %ebx,%eax
  10446d:	5b                   	pop    %ebx
  10446e:	5e                   	pop    %esi
  10446f:	5d                   	pop    %ebp
  104470:	c3                   	ret    
  104471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104478:	29 f3                	sub    %esi,%ebx
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  10447a:	83 c4 20             	add    $0x20,%esp
  10447d:	89 d8                	mov    %ebx,%eax
  10447f:	5b                   	pop    %ebx
  104480:	5e                   	pop    %esi
  104481:	5d                   	pop    %ebp
  104482:	c3                   	ret    
  104483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104490 <syscall>:
[SYS_write]   sys_write,
};

void
syscall(void)
{
  104490:	55                   	push   %ebp
  104491:	89 e5                	mov    %esp,%ebp
  104493:	83 ec 18             	sub    $0x18,%esp
  104496:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  104499:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  
  num = cp->tf->eax;
  10449c:	e8 6f f1 ff ff       	call   103610 <curproc>
  1044a1:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  1044a7:	8b 58 1c             	mov    0x1c(%eax),%ebx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  1044aa:	83 fb 14             	cmp    $0x14,%ebx
  1044ad:	77 29                	ja     1044d8 <syscall+0x48>
  1044af:	8b 34 9d 40 66 10 00 	mov    0x106640(,%ebx,4),%esi
  1044b6:	85 f6                	test   %esi,%esi
  1044b8:	74 1e                	je     1044d8 <syscall+0x48>
    cp->tf->eax = syscalls[num]();
  1044ba:	e8 51 f1 ff ff       	call   103610 <curproc>
  1044bf:	8b 98 84 00 00 00    	mov    0x84(%eax),%ebx
  1044c5:	ff d6                	call   *%esi
  1044c7:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  1044ca:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1044cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1044d0:	89 ec                	mov    %ebp,%esp
  1044d2:	5d                   	pop    %ebp
  1044d3:	c3                   	ret    
  1044d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
  1044d8:	e8 33 f1 ff ff       	call   103610 <curproc>
  1044dd:	89 c6                	mov    %eax,%esi
  1044df:	e8 2c f1 ff ff       	call   103610 <curproc>
  
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  1044e4:	81 c6 88 00 00 00    	add    $0x88,%esi
  1044ea:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1044ee:	89 74 24 08          	mov    %esi,0x8(%esp)
  1044f2:	8b 40 10             	mov    0x10(%eax),%eax
  1044f5:	c7 04 24 0e 66 10 00 	movl   $0x10660e,(%esp)
  1044fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  104500:	e8 4b c0 ff ff       	call   100550 <cprintf>
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  104505:	e8 06 f1 ff ff       	call   103610 <curproc>
  10450a:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104510:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  104517:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10451a:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10451d:	89 ec                	mov    %ebp,%esp
  10451f:	5d                   	pop    %ebp
  104520:	c3                   	ret    
  104521:	90                   	nop
  104522:	90                   	nop
  104523:	90                   	nop
  104524:	90                   	nop
  104525:	90                   	nop
  104526:	90                   	nop
  104527:	90                   	nop
  104528:	90                   	nop
  104529:	90                   	nop
  10452a:	90                   	nop
  10452b:	90                   	nop
  10452c:	90                   	nop
  10452d:	90                   	nop
  10452e:	90                   	nop
  10452f:	90                   	nop

00104530 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  104530:	55                   	push   %ebp
  104531:	89 e5                	mov    %esp,%ebp
  104533:	57                   	push   %edi
  104534:	89 c7                	mov    %eax,%edi
  104536:	56                   	push   %esi
  104537:	53                   	push   %ebx
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104538:	31 db                	xor    %ebx,%ebx

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  10453a:	83 ec 0c             	sub    $0xc,%esp
  10453d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
  104540:	e8 cb f0 ff ff       	call   103610 <curproc>
  104545:	8d 73 08             	lea    0x8(%ebx),%esi
  104548:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  10454b:	85 c0                	test   %eax,%eax
  10454d:	74 19                	je     104568 <fdalloc+0x38>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  10454f:	83 c3 01             	add    $0x1,%ebx
  104552:	83 fb 10             	cmp    $0x10,%ebx
  104555:	75 e9                	jne    104540 <fdalloc+0x10>
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
  104557:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  10455c:	83 c4 0c             	add    $0xc,%esp
  10455f:	89 d8                	mov    %ebx,%eax
  104561:	5b                   	pop    %ebx
  104562:	5e                   	pop    %esi
  104563:	5f                   	pop    %edi
  104564:	5d                   	pop    %ebp
  104565:	c3                   	ret    
  104566:	66 90                	xchg   %ax,%ax
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  104568:	e8 a3 f0 ff ff       	call   103610 <curproc>
  10456d:	89 3c b0             	mov    %edi,(%eax,%esi,4)
      return fd;
    }
  }
  return -1;
}
  104570:	83 c4 0c             	add    $0xc,%esp
  104573:	89 d8                	mov    %ebx,%eax
  104575:	5b                   	pop    %ebx
  104576:	5e                   	pop    %esi
  104577:	5f                   	pop    %edi
  104578:	5d                   	pop    %ebp
  104579:	c3                   	ret    
  10457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104580 <create>:
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  104580:	55                   	push   %ebp
  104581:	89 e5                	mov    %esp,%ebp
  104583:	57                   	push   %edi
  104584:	89 cf                	mov    %ecx,%edi
  104586:	56                   	push   %esi
  104587:	53                   	push   %ebx
  104588:	89 d3                	mov    %edx,%ebx
  10458a:	83 ec 4c             	sub    $0x4c,%esp
  10458d:	0f b7 55 08          	movzwl 0x8(%ebp),%edx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104591:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  104594:	89 74 24 04          	mov    %esi,0x4(%esp)
  104598:	89 04 24             	mov    %eax,(%esp)
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  10459b:	66 89 55 c6          	mov    %dx,-0x3a(%ebp)
  10459f:	0f b7 55 0c          	movzwl 0xc(%ebp),%edx
  1045a3:	66 89 55 c4          	mov    %dx,-0x3c(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  1045a7:	e8 b4 d9 ff ff       	call   101f60 <nameiparent>
  1045ac:	85 c0                	test   %eax,%eax
  1045ae:	0f 84 f4 00 00 00    	je     1046a8 <create+0x128>
    return 0;
  ilock(dp);
  1045b4:	89 04 24             	mov    %eax,(%esp)
  1045b7:	89 45 c0             	mov    %eax,-0x40(%ebp)
  1045ba:	e8 41 cf ff ff       	call   101500 <ilock>

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
  1045bf:	85 db                	test   %ebx,%ebx
  1045c1:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1045c4:	74 62                	je     104628 <create+0xa8>
  1045c6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1045c9:	89 14 24             	mov    %edx,(%esp)
  1045cc:	89 44 24 08          	mov    %eax,0x8(%esp)
  1045d0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1045d4:	e8 f7 d5 ff ff       	call   101bd0 <dirlookup>
  1045d9:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1045dc:	85 c0                	test   %eax,%eax
  1045de:	89 c3                	mov    %eax,%ebx
  1045e0:	74 46                	je     104628 <create+0xa8>
    iunlockput(dp);
  1045e2:	89 14 24             	mov    %edx,(%esp)
  1045e5:	e8 16 d3 ff ff       	call   101900 <iunlockput>
    ilock(ip);
  1045ea:	89 1c 24             	mov    %ebx,(%esp)
  1045ed:	e8 0e cf ff ff       	call   101500 <ilock>
    if(ip->type != type || ip->major != major || ip->minor != minor){
  1045f2:	66 39 7b 10          	cmp    %di,0x10(%ebx)
  1045f6:	75 18                	jne    104610 <create+0x90>
  1045f8:	0f b7 45 c6          	movzwl -0x3a(%ebp),%eax
  1045fc:	66 39 43 12          	cmp    %ax,0x12(%ebx)
  104600:	75 0e                	jne    104610 <create+0x90>
  104602:	0f b7 55 c4          	movzwl -0x3c(%ebp),%edx
  104606:	66 39 53 14          	cmp    %dx,0x14(%ebx)
  10460a:	0f 84 8d 00 00 00    	je     10469d <create+0x11d>
      iunlockput(ip);
  104610:	89 1c 24             	mov    %ebx,(%esp)
      return 0;
  104613:	31 db                	xor    %ebx,%ebx

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(ip->type != type || ip->major != major || ip->minor != minor){
      iunlockput(ip);
  104615:	e8 e6 d2 ff ff       	call   101900 <iunlockput>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  return ip;
}
  10461a:	83 c4 4c             	add    $0x4c,%esp
  10461d:	89 d8                	mov    %ebx,%eax
  10461f:	5b                   	pop    %ebx
  104620:	5e                   	pop    %esi
  104621:	5f                   	pop    %edi
  104622:	5d                   	pop    %ebp
  104623:	c3                   	ret    
  104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
  104628:	0f bf c7             	movswl %di,%eax
  10462b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10462f:	8b 02                	mov    (%edx),%eax
  104631:	89 55 c0             	mov    %edx,-0x40(%ebp)
  104634:	89 04 24             	mov    %eax,(%esp)
  104637:	e8 24 d0 ff ff       	call   101660 <ialloc>
  10463c:	8b 55 c0             	mov    -0x40(%ebp),%edx
  10463f:	85 c0                	test   %eax,%eax
  104641:	89 c3                	mov    %eax,%ebx
  104643:	74 50                	je     104695 <create+0x115>
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  104645:	89 55 c0             	mov    %edx,-0x40(%ebp)
  104648:	89 04 24             	mov    %eax,(%esp)
  10464b:	e8 b0 ce ff ff       	call   101500 <ilock>
  ip->major = major;
  104650:	0f b7 45 c6          	movzwl -0x3a(%ebp),%eax
  ip->minor = minor;
  ip->nlink = 1;
  104654:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  ip->major = major;
  10465a:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10465e:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
  104662:	66 89 43 14          	mov    %ax,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  104666:	89 1c 24             	mov    %ebx,(%esp)
  104669:	e8 c2 d0 ff ff       	call   101730 <iupdate>
  
  if(dirlink(dp, name, ip->inum) < 0){
  10466e:	8b 43 04             	mov    0x4(%ebx),%eax
  104671:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104674:	89 74 24 04          	mov    %esi,0x4(%esp)
  104678:	89 44 24 08          	mov    %eax,0x8(%esp)
  10467c:	89 14 24             	mov    %edx,(%esp)
  10467f:	e8 cc d7 ff ff       	call   101e50 <dirlink>
  104684:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104687:	85 c0                	test   %eax,%eax
  104689:	0f 88 81 00 00 00    	js     104710 <create+0x190>
    iunlockput(ip);
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
  10468f:	66 83 ff 01          	cmp    $0x1,%di
  104693:	74 23                	je     1046b8 <create+0x138>
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  104695:	89 14 24             	mov    %edx,(%esp)
  104698:	e8 63 d2 ff ff       	call   101900 <iunlockput>
  return ip;
}
  10469d:	83 c4 4c             	add    $0x4c,%esp
  1046a0:	89 d8                	mov    %ebx,%eax
  1046a2:	5b                   	pop    %ebx
  1046a3:	5e                   	pop    %esi
  1046a4:	5f                   	pop    %edi
  1046a5:	5d                   	pop    %ebp
  1046a6:	c3                   	ret    
  1046a7:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  1046a8:	31 db                	xor    %ebx,%ebx
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  return ip;
}
  1046aa:	83 c4 4c             	add    $0x4c,%esp
  1046ad:	89 d8                	mov    %ebx,%eax
  1046af:	5b                   	pop    %ebx
  1046b0:	5e                   	pop    %esi
  1046b1:	5f                   	pop    %edi
  1046b2:	5d                   	pop    %ebp
  1046b3:	c3                   	ret    
  1046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  1046b8:	66 83 42 16 01       	addw   $0x1,0x16(%edx)
    iupdate(dp);
  1046bd:	89 14 24             	mov    %edx,(%esp)
  1046c0:	89 55 c0             	mov    %edx,-0x40(%ebp)
  1046c3:	e8 68 d0 ff ff       	call   101730 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  1046c8:	8b 43 04             	mov    0x4(%ebx),%eax
  1046cb:	c7 44 24 04 95 66 10 	movl   $0x106695,0x4(%esp)
  1046d2:	00 
  1046d3:	89 1c 24             	mov    %ebx,(%esp)
  1046d6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1046da:	e8 71 d7 ff ff       	call   101e50 <dirlink>
  1046df:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1046e2:	85 c0                	test   %eax,%eax
  1046e4:	78 1e                	js     104704 <create+0x184>
  1046e6:	8b 42 04             	mov    0x4(%edx),%eax
  1046e9:	c7 44 24 04 94 66 10 	movl   $0x106694,0x4(%esp)
  1046f0:	00 
  1046f1:	89 1c 24             	mov    %ebx,(%esp)
  1046f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1046f8:	e8 53 d7 ff ff       	call   101e50 <dirlink>
  1046fd:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104700:	85 c0                	test   %eax,%eax
  104702:	79 91                	jns    104695 <create+0x115>
      panic("create dots");
  104704:	c7 04 24 97 66 10 00 	movl   $0x106697,(%esp)
  10470b:	e8 f0 c1 ff ff       	call   100900 <panic>
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
  104710:	66 c7 43 16 00 00    	movw   $0x0,0x16(%ebx)
    iunlockput(ip);
  104716:	89 1c 24             	mov    %ebx,(%esp)
    iunlockput(dp);
    return 0;
  104719:	31 db                	xor    %ebx,%ebx
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
    iunlockput(ip);
  10471b:	e8 e0 d1 ff ff       	call   101900 <iunlockput>
    iunlockput(dp);
  104720:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104723:	89 14 24             	mov    %edx,(%esp)
  104726:	e8 d5 d1 ff ff       	call   101900 <iunlockput>
    return 0;
  10472b:	e9 6d ff ff ff       	jmp    10469d <create+0x11d>

00104730 <argfd.clone.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104730:	55                   	push   %ebp
  104731:	89 e5                	mov    %esp,%ebp
  104733:	83 ec 38             	sub    $0x38,%esp
  104736:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104739:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  10473b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  10473e:	89 75 f8             	mov    %esi,-0x8(%ebp)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  104741:	be ff ff ff ff       	mov    $0xffffffff,%esi
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104746:	89 7d fc             	mov    %edi,-0x4(%ebp)
  104749:	89 d7                	mov    %edx,%edi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  10474b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10474f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104756:	e8 d5 fb ff ff       	call   104330 <argint>
  10475b:	85 c0                	test   %eax,%eax
  10475d:	79 11                	jns    104770 <argfd.clone.0+0x40>
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
  10475f:	89 f0                	mov    %esi,%eax
  104761:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104764:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104767:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10476a:	89 ec                	mov    %ebp,%esp
  10476c:	5d                   	pop    %ebp
  10476d:	c3                   	ret    
  10476e:	66 90                	xchg   %ax,%ax
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
  104770:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
  104774:	77 e9                	ja     10475f <argfd.clone.0+0x2f>
  104776:	e8 95 ee ff ff       	call   103610 <curproc>
  10477b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10477e:	8b 44 90 20          	mov    0x20(%eax,%edx,4),%eax
  104782:	85 c0                	test   %eax,%eax
  104784:	74 d9                	je     10475f <argfd.clone.0+0x2f>
    return -1;
  if(pfd)
  104786:	85 db                	test   %ebx,%ebx
  104788:	74 02                	je     10478c <argfd.clone.0+0x5c>
    *pfd = fd;
  10478a:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
  return 0;
  10478c:	31 f6                	xor    %esi,%esi
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
  10478e:	85 ff                	test   %edi,%edi
  104790:	74 cd                	je     10475f <argfd.clone.0+0x2f>
    *pf = f;
  104792:	89 07                	mov    %eax,(%edi)
  104794:	eb c9                	jmp    10475f <argfd.clone.0+0x2f>
  104796:	8d 76 00             	lea    0x0(%esi),%esi
  104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001047a0 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  1047a0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047a1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_read(void)
{
  1047a3:	89 e5                	mov    %esp,%ebp
  1047a5:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  1047a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return -1;
}

int
sys_read(void)
{
  1047ab:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047ae:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1047b1:	e8 7a ff ff ff       	call   104730 <argfd.clone.0>
  1047b6:	85 c0                	test   %eax,%eax
  1047b8:	79 0e                	jns    1047c8 <sys_read+0x28>
    return -1;
  return fileread(f, p, n);
}
  1047ba:	89 d8                	mov    %ebx,%eax
  1047bc:	83 c4 24             	add    $0x24,%esp
  1047bf:	5b                   	pop    %ebx
  1047c0:	5d                   	pop    %ebp
  1047c1:	c3                   	ret    
  1047c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047c8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1047cb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047cf:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1047d6:	e8 55 fb ff ff       	call   104330 <argint>
  1047db:	85 c0                	test   %eax,%eax
  1047dd:	78 db                	js     1047ba <sys_read+0x1a>
  1047df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1047e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1047e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1047ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1047f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047f4:	e8 97 fb ff ff       	call   104390 <argptr>
  1047f9:	85 c0                	test   %eax,%eax
  1047fb:	78 bd                	js     1047ba <sys_read+0x1a>
    return -1;
  return fileread(f, p, n);
  1047fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104800:	89 44 24 08          	mov    %eax,0x8(%esp)
  104804:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104807:	89 44 24 04          	mov    %eax,0x4(%esp)
  10480b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10480e:	89 04 24             	mov    %eax,(%esp)
  104811:	e8 7a c7 ff ff       	call   100f90 <fileread>
  104816:	89 c3                	mov    %eax,%ebx
  104818:	eb a0                	jmp    1047ba <sys_read+0x1a>
  10481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104820 <sys_write>:
}

int
sys_write(void)
{
  104820:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104821:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  104823:	89 e5                	mov    %esp,%ebp
  104825:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  104826:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return fileread(f, p, n);
}

int
sys_write(void)
{
  10482b:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10482e:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104831:	e8 fa fe ff ff       	call   104730 <argfd.clone.0>
  104836:	85 c0                	test   %eax,%eax
  104838:	79 0e                	jns    104848 <sys_write+0x28>
    return -1;
  return filewrite(f, p, n);
}
  10483a:	89 d8                	mov    %ebx,%eax
  10483c:	83 c4 24             	add    $0x24,%esp
  10483f:	5b                   	pop    %ebx
  104840:	5d                   	pop    %ebp
  104841:	c3                   	ret    
  104842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104848:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10484b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10484f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104856:	e8 d5 fa ff ff       	call   104330 <argint>
  10485b:	85 c0                	test   %eax,%eax
  10485d:	78 db                	js     10483a <sys_write+0x1a>
  10485f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104862:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104869:	89 44 24 08          	mov    %eax,0x8(%esp)
  10486d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104870:	89 44 24 04          	mov    %eax,0x4(%esp)
  104874:	e8 17 fb ff ff       	call   104390 <argptr>
  104879:	85 c0                	test   %eax,%eax
  10487b:	78 bd                	js     10483a <sys_write+0x1a>
    return -1;
  return filewrite(f, p, n);
  10487d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104880:	89 44 24 08          	mov    %eax,0x8(%esp)
  104884:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104887:	89 44 24 04          	mov    %eax,0x4(%esp)
  10488b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10488e:	89 04 24             	mov    %eax,(%esp)
  104891:	e8 ba c7 ff ff       	call   101050 <filewrite>
  104896:	89 c3                	mov    %eax,%ebx
  104898:	eb a0                	jmp    10483a <sys_write+0x1a>
  10489a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001048a0 <sys_dup>:
}

int
sys_dup(void)
{
  1048a0:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  1048a1:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  1048a3:	89 e5                	mov    %esp,%ebp
  1048a5:	53                   	push   %ebx
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  1048a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  1048ab:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  1048ae:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1048b1:	e8 7a fe ff ff       	call   104730 <argfd.clone.0>
  1048b6:	85 c0                	test   %eax,%eax
  1048b8:	79 0e                	jns    1048c8 <sys_dup+0x28>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
  1048ba:	89 d8                	mov    %ebx,%eax
  1048bc:	83 c4 24             	add    $0x24,%esp
  1048bf:	5b                   	pop    %ebx
  1048c0:	5d                   	pop    %ebp
  1048c1:	c3                   	ret    
  1048c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  1048c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1048cb:	e8 60 fc ff ff       	call   104530 <fdalloc>
  1048d0:	85 c0                	test   %eax,%eax
  1048d2:	89 c3                	mov    %eax,%ebx
  1048d4:	78 12                	js     1048e8 <sys_dup+0x48>
    return -1;
  filedup(f);
  1048d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1048d9:	89 04 24             	mov    %eax,(%esp)
  1048dc:	e8 3f c5 ff ff       	call   100e20 <filedup>
  return fd;
  1048e1:	eb d7                	jmp    1048ba <sys_dup+0x1a>
  1048e3:	90                   	nop
  1048e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  1048e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1048ed:	eb cb                	jmp    1048ba <sys_dup+0x1a>
  1048ef:	90                   	nop

001048f0 <sys_close>:
  return fd;
}

int
sys_close(void)
{
  1048f0:	55                   	push   %ebp
  1048f1:	89 e5                	mov    %esp,%ebp
  1048f3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  1048f6:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1048f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1048fc:	e8 2f fe ff ff       	call   104730 <argfd.clone.0>
  104901:	89 c2                	mov    %eax,%edx
    return -1;
  104903:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
sys_close(void)
{
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  104908:	85 d2                	test   %edx,%edx
  10490a:	78 1d                	js     104929 <sys_close+0x39>
    return -1;
  cp->ofile[fd] = 0;
  10490c:	e8 ff ec ff ff       	call   103610 <curproc>
  104911:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104914:	c7 44 90 20 00 00 00 	movl   $0x0,0x20(%eax,%edx,4)
  10491b:	00 
  fileclose(f);
  10491c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10491f:	89 04 24             	mov    %eax,(%esp)
  104922:	e8 49 c5 ff ff       	call   100e70 <fileclose>
  return 0;
  104927:	31 c0                	xor    %eax,%eax
}
  104929:	c9                   	leave  
  10492a:	c3                   	ret    
  10492b:	90                   	nop
  10492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104930 <sys_fstat>:

int
sys_fstat(void)
{
  104930:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104931:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104933:	89 e5                	mov    %esp,%ebp
  104935:	53                   	push   %ebx
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  104936:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_fstat(void)
{
  10493b:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  10493e:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104941:	e8 ea fd ff ff       	call   104730 <argfd.clone.0>
  104946:	85 c0                	test   %eax,%eax
  104948:	79 0e                	jns    104958 <sys_fstat+0x28>
    return -1;
  return filestat(f, st);
}
  10494a:	89 d8                	mov    %ebx,%eax
  10494c:	83 c4 24             	add    $0x24,%esp
  10494f:	5b                   	pop    %ebx
  104950:	5d                   	pop    %ebp
  104951:	c3                   	ret    
  104952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104958:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10495b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104962:	00 
  104963:	89 44 24 04          	mov    %eax,0x4(%esp)
  104967:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10496e:	e8 1d fa ff ff       	call   104390 <argptr>
  104973:	85 c0                	test   %eax,%eax
  104975:	78 d3                	js     10494a <sys_fstat+0x1a>
    return -1;
  return filestat(f, st);
  104977:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10497a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10497e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104981:	89 04 24             	mov    %eax,(%esp)
  104984:	e8 b7 c5 ff ff       	call   100f40 <filestat>
  104989:	89 c3                	mov    %eax,%ebx
  10498b:	eb bd                	jmp    10494a <sys_fstat+0x1a>
  10498d:	8d 76 00             	lea    0x0(%esi),%esi

00104990 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104990:	55                   	push   %ebp
  104991:	89 e5                	mov    %esp,%ebp
  104993:	83 ec 48             	sub    $0x48,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104996:	8d 45 e0             	lea    -0x20(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104999:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;
  10499c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  1049a1:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1049a4:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1049a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1049b2:	e8 49 fa ff ff       	call   104400 <argstr>
  1049b7:	85 c0                	test   %eax,%eax
  1049b9:	79 15                	jns    1049d0 <sys_link+0x40>
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
}
  1049bb:	89 d8                	mov    %ebx,%eax
  1049bd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1049c0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1049c3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1049c6:	89 ec                	mov    %ebp,%esp
  1049c8:	5d                   	pop    %ebp
  1049c9:	c3                   	ret    
  1049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1049d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1049d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1049de:	e8 1d fa ff ff       	call   104400 <argstr>
  1049e3:	85 c0                	test   %eax,%eax
  1049e5:	78 d4                	js     1049bb <sys_link+0x2b>
    return -1;
  if((ip = namei(old)) == 0)
  1049e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1049ea:	89 04 24             	mov    %eax,(%esp)
  1049ed:	e8 4e d5 ff ff       	call   101f40 <namei>
  1049f2:	85 c0                	test   %eax,%eax
  1049f4:	89 c6                	mov    %eax,%esi
  1049f6:	74 c3                	je     1049bb <sys_link+0x2b>
    return -1;
  ilock(ip);
  1049f8:	89 04 24             	mov    %eax,(%esp)
  1049fb:	e8 00 cb ff ff       	call   101500 <ilock>
  if(ip->type == T_DIR){
  104a00:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104a05:	0f 84 96 00 00 00    	je     104aa1 <sys_link+0x111>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  104a0b:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  104a10:	8d 7d d2             	lea    -0x2e(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  104a13:	89 34 24             	mov    %esi,(%esp)
  104a16:	e8 15 cd ff ff       	call   101730 <iupdate>
  iunlock(ip);
  104a1b:	89 34 24             	mov    %esi,(%esp)
  104a1e:	e8 ed cb ff ff       	call   101610 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  104a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104a26:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104a2a:	89 04 24             	mov    %eax,(%esp)
  104a2d:	e8 2e d5 ff ff       	call   101f60 <nameiparent>
  104a32:	85 c0                	test   %eax,%eax
  104a34:	89 c3                	mov    %eax,%ebx
  104a36:	74 44                	je     104a7c <sys_link+0xec>
    goto  bad;
  ilock(dp);
  104a38:	89 04 24             	mov    %eax,(%esp)
  104a3b:	e8 c0 ca ff ff       	call   101500 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
  104a40:	8b 06                	mov    (%esi),%eax
  104a42:	39 03                	cmp    %eax,(%ebx)
  104a44:	75 2e                	jne    104a74 <sys_link+0xe4>
  104a46:	8b 46 04             	mov    0x4(%esi),%eax
  104a49:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104a4d:	89 1c 24             	mov    %ebx,(%esp)
  104a50:	89 44 24 08          	mov    %eax,0x8(%esp)
  104a54:	e8 f7 d3 ff ff       	call   101e50 <dirlink>
  104a59:	85 c0                	test   %eax,%eax
  104a5b:	78 17                	js     104a74 <sys_link+0xe4>
    goto bad;
  iunlockput(dp);
  104a5d:	89 1c 24             	mov    %ebx,(%esp)
  iput(ip);
  return 0;
  104a60:	31 db                	xor    %ebx,%ebx
  if((dp = nameiparent(new, name)) == 0)
    goto  bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
    goto bad;
  iunlockput(dp);
  104a62:	e8 99 ce ff ff       	call   101900 <iunlockput>
  iput(ip);
  104a67:	89 34 24             	mov    %esi,(%esp)
  104a6a:	e8 51 cd ff ff       	call   1017c0 <iput>
  return 0;
  104a6f:	e9 47 ff ff ff       	jmp    1049bb <sys_link+0x2b>

bad:
  if(dp)
    iunlockput(dp);
  104a74:	89 1c 24             	mov    %ebx,(%esp)
  104a77:	e8 84 ce ff ff       	call   101900 <iunlockput>
  ilock(ip);
  104a7c:	89 34 24             	mov    %esi,(%esp)
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104a7f:	83 cb ff             	or     $0xffffffff,%ebx
  return 0;

bad:
  if(dp)
    iunlockput(dp);
  ilock(ip);
  104a82:	e8 79 ca ff ff       	call   101500 <ilock>
  ip->nlink--;
  104a87:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104a8c:	89 34 24             	mov    %esi,(%esp)
  104a8f:	e8 9c cc ff ff       	call   101730 <iupdate>
  iunlockput(ip);
  104a94:	89 34 24             	mov    %esi,(%esp)
  104a97:	e8 64 ce ff ff       	call   101900 <iunlockput>
  return -1;
  104a9c:	e9 1a ff ff ff       	jmp    1049bb <sys_link+0x2b>
    return -1;
  if((ip = namei(old)) == 0)
    return -1;
  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
  104aa1:	89 34 24             	mov    %esi,(%esp)
  104aa4:	e8 57 ce ff ff       	call   101900 <iunlockput>
    return -1;
  104aa9:	e9 0d ff ff ff       	jmp    1049bb <sys_link+0x2b>
  104aae:	66 90                	xchg   %ax,%ax

00104ab0 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104ab0:	55                   	push   %ebp
  104ab1:	89 e5                	mov    %esp,%ebp
  104ab3:	83 ec 68             	sub    $0x68,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104ab6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  104ab9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  104abc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 1;
}

int
sys_unlink(void)
{
  104ac1:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104ac4:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
  104acb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104ad2:	e8 29 f9 ff ff       	call   104400 <argstr>
  104ad7:	85 c0                	test   %eax,%eax
  104ad9:	79 15                	jns    104af0 <sys_unlink+0x40>

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  104adb:	89 d8                	mov    %ebx,%eax
  104add:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104ae0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104ae3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104ae6:	89 ec                	mov    %ebp,%esp
  104ae8:	5d                   	pop    %ebp
  104ae9:	c3                   	ret    
  104aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  104af0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104af3:	8d 75 d2             	lea    -0x2e(%ebp),%esi
  104af6:	89 74 24 04          	mov    %esi,0x4(%esp)
  104afa:	89 04 24             	mov    %eax,(%esp)
  104afd:	e8 5e d4 ff ff       	call   101f60 <nameiparent>
  104b02:	85 c0                	test   %eax,%eax
  104b04:	89 c7                	mov    %eax,%edi
  104b06:	74 d3                	je     104adb <sys_unlink+0x2b>
    return -1;
  ilock(dp);
  104b08:	89 04 24             	mov    %eax,(%esp)
  104b0b:	e8 f0 c9 ff ff       	call   101500 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104b10:	c7 44 24 04 95 66 10 	movl   $0x106695,0x4(%esp)
  104b17:	00 
  104b18:	89 34 24             	mov    %esi,(%esp)
  104b1b:	e8 80 d0 ff ff       	call   101ba0 <namecmp>
  104b20:	85 c0                	test   %eax,%eax
  104b22:	0f 84 93 00 00 00    	je     104bbb <sys_unlink+0x10b>
  104b28:	c7 44 24 04 94 66 10 	movl   $0x106694,0x4(%esp)
  104b2f:	00 
  104b30:	89 34 24             	mov    %esi,(%esp)
  104b33:	e8 68 d0 ff ff       	call   101ba0 <namecmp>
  104b38:	85 c0                	test   %eax,%eax
  104b3a:	74 7f                	je     104bbb <sys_unlink+0x10b>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104b3c:	8d 45 e0             	lea    -0x20(%ebp),%eax
  104b3f:	89 74 24 04          	mov    %esi,0x4(%esp)
  104b43:	89 44 24 08          	mov    %eax,0x8(%esp)
  104b47:	89 3c 24             	mov    %edi,(%esp)
  104b4a:	e8 81 d0 ff ff       	call   101bd0 <dirlookup>
  104b4f:	85 c0                	test   %eax,%eax
  104b51:	89 c6                	mov    %eax,%esi
  104b53:	0f 84 d6 00 00 00    	je     104c2f <sys_unlink+0x17f>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104b59:	89 04 24             	mov    %eax,(%esp)
  104b5c:	e8 9f c9 ff ff       	call   101500 <ilock>

  if(ip->nlink < 1)
  104b61:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104b66:	0f 8e dc 00 00 00    	jle    104c48 <sys_unlink+0x198>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104b6c:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104b71:	75 5d                	jne    104bd0 <sys_unlink+0x120>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104b73:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104b77:	76 57                	jbe    104bd0 <sys_unlink+0x120>
  104b79:	bb 20 00 00 00       	mov    $0x20,%ebx
  104b7e:	eb 08                	jmp    104b88 <sys_unlink+0xd8>
  104b80:	83 c3 10             	add    $0x10,%ebx
  104b83:	3b 5e 18             	cmp    0x18(%esi),%ebx
  104b86:	73 48                	jae    104bd0 <sys_unlink+0x120>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104b88:	8d 45 b2             	lea    -0x4e(%ebp),%eax
  104b8b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104b92:	00 
  104b93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104b97:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b9b:	89 34 24             	mov    %esi,(%esp)
  104b9e:	e8 ad cd ff ff       	call   101950 <readi>
  104ba3:	83 f8 10             	cmp    $0x10,%eax
  104ba6:	0f 85 90 00 00 00    	jne    104c3c <sys_unlink+0x18c>
      panic("isdirempty: readi");
    if(de.inum != 0)
  104bac:	66 83 7d b2 00       	cmpw   $0x0,-0x4e(%ebp)
  104bb1:	74 cd                	je     104b80 <sys_unlink+0xd0>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104bb3:	89 34 24             	mov    %esi,(%esp)
  104bb6:	e8 45 cd ff ff       	call   101900 <iunlockput>
    iunlockput(dp);
  104bbb:	89 3c 24             	mov    %edi,(%esp)
    return -1;
  104bbe:	bb ff ff ff ff       	mov    $0xffffffff,%ebx

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
  104bc3:	e8 38 cd ff ff       	call   101900 <iunlockput>
    return -1;
  104bc8:	e9 0e ff ff ff       	jmp    104adb <sys_unlink+0x2b>
  104bcd:	8d 76 00             	lea    0x0(%esi),%esi
  }

  memset(&de, 0, sizeof(de));
  104bd0:	8d 5d c2             	lea    -0x3e(%ebp),%ebx
  104bd3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104bda:	00 
  104bdb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104be2:	00 
  104be3:	89 1c 24             	mov    %ebx,(%esp)
  104be6:	e8 35 f4 ff ff       	call   104020 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104beb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104bee:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104bf5:	00 
  104bf6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104bfa:	89 3c 24             	mov    %edi,(%esp)
  104bfd:	89 44 24 08          	mov    %eax,0x8(%esp)
  104c01:	e8 6a ce ff ff       	call   101a70 <writei>
  104c06:	83 f8 10             	cmp    $0x10,%eax
  104c09:	75 49                	jne    104c54 <sys_unlink+0x1a4>
    panic("unlink: writei");
  iunlockput(dp);
  104c0b:	89 3c 24             	mov    %edi,(%esp)

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  104c0e:	31 db                	xor    %ebx,%ebx
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  iunlockput(dp);
  104c10:	e8 eb cc ff ff       	call   101900 <iunlockput>

  ip->nlink--;
  104c15:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104c1a:	89 34 24             	mov    %esi,(%esp)
  104c1d:	e8 0e cb ff ff       	call   101730 <iupdate>
  iunlockput(ip);
  104c22:	89 34 24             	mov    %esi,(%esp)
  104c25:	e8 d6 cc ff ff       	call   101900 <iunlockput>
  return 0;
  104c2a:	e9 ac fe ff ff       	jmp    104adb <sys_unlink+0x2b>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
    iunlockput(dp);
  104c2f:	89 3c 24             	mov    %edi,(%esp)
  104c32:	e8 c9 cc ff ff       	call   101900 <iunlockput>
    return -1;
  104c37:	e9 9f fe ff ff       	jmp    104adb <sys_unlink+0x2b>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  104c3c:	c7 04 24 b5 66 10 00 	movl   $0x1066b5,(%esp)
  104c43:	e8 b8 bc ff ff       	call   100900 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104c48:	c7 04 24 a3 66 10 00 	movl   $0x1066a3,(%esp)
  104c4f:	e8 ac bc ff ff       	call   100900 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104c54:	c7 04 24 c7 66 10 00 	movl   $0x1066c7,(%esp)
  104c5b:	e8 a0 bc ff ff       	call   100900 <panic>

00104c60 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104c60:	55                   	push   %ebp
  104c61:	89 e5                	mov    %esp,%ebp
  104c63:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104c66:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  104c69:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;
  104c6c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return ip;
}

int
sys_open(void)
{
  104c71:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104c74:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104c77:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c7b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c82:	e8 79 f7 ff ff       	call   104400 <argstr>
  104c87:	85 c0                	test   %eax,%eax
  104c89:	79 15                	jns    104ca0 <sys_open+0x40>
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
}
  104c8b:	89 d8                	mov    %ebx,%eax
  104c8d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104c90:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104c93:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104c96:	89 ec                	mov    %ebp,%esp
  104c98:	5d                   	pop    %ebp
  104c99:	c3                   	ret    
  104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104ca0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  104ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ca7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104cae:	e8 7d f6 ff ff       	call   104330 <argint>
  104cb3:	85 c0                	test   %eax,%eax
  104cb5:	78 d4                	js     104c8b <sys_open+0x2b>
    return -1;

  if(omode & O_CREATE){
  104cb7:	f6 45 e1 02          	testb  $0x2,-0x1f(%ebp)
  104cbb:	74 6b                	je     104d28 <sys_open+0xc8>
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
  104cbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104cc0:	b9 02 00 00 00       	mov    $0x2,%ecx
  104cc5:	ba 01 00 00 00       	mov    $0x1,%edx
  104cca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104cd1:	00 
  104cd2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104cd9:	e8 a2 f8 ff ff       	call   104580 <create>
  104cde:	85 c0                	test   %eax,%eax
  104ce0:	89 c7                	mov    %eax,%edi
  104ce2:	74 a7                	je     104c8b <sys_open+0x2b>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104ce4:	e8 b7 c0 ff ff       	call   100da0 <filealloc>
  104ce9:	85 c0                	test   %eax,%eax
  104ceb:	89 c6                	mov    %eax,%esi
  104ced:	74 79                	je     104d68 <sys_open+0x108>
  104cef:	e8 3c f8 ff ff       	call   104530 <fdalloc>
  104cf4:	85 c0                	test   %eax,%eax
  104cf6:	89 c3                	mov    %eax,%ebx
  104cf8:	78 66                	js     104d60 <sys_open+0x100>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104cfa:	89 3c 24             	mov    %edi,(%esp)
  104cfd:	e8 0e c9 ff ff       	call   101610 <iunlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104d02:	8b 45 e0             	mov    -0x20(%ebp),%eax
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  104d05:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
  f->ip = ip;
  104d0b:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104d0e:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104d15:	a8 01                	test   $0x1,%al
  104d17:	0f 94 46 08          	sete   0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104d1b:	a8 03                	test   $0x3,%al
  104d1d:	0f 95 46 09          	setne  0x9(%esi)

  return fd;
  104d21:	e9 65 ff ff ff       	jmp    104c8b <sys_open+0x2b>
  104d26:	66 90                	xchg   %ax,%ax

  if(omode & O_CREATE){
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104d28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104d2b:	89 04 24             	mov    %eax,(%esp)
  104d2e:	e8 0d d2 ff ff       	call   101f40 <namei>
  104d33:	85 c0                	test   %eax,%eax
  104d35:	89 c7                	mov    %eax,%edi
  104d37:	0f 84 4e ff ff ff    	je     104c8b <sys_open+0x2b>
      return -1;
    ilock(ip);
  104d3d:	89 04 24             	mov    %eax,(%esp)
  104d40:	e8 bb c7 ff ff       	call   101500 <ilock>
    if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
  104d45:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104d4a:	75 98                	jne    104ce4 <sys_open+0x84>
  104d4c:	f6 45 e0 03          	testb  $0x3,-0x20(%ebp)
  104d50:	74 92                	je     104ce4 <sys_open+0x84>
      iunlockput(ip);
  104d52:	89 3c 24             	mov    %edi,(%esp)
  104d55:	e8 a6 cb ff ff       	call   101900 <iunlockput>
      return -1;
  104d5a:	e9 2c ff ff ff       	jmp    104c8b <sys_open+0x2b>
  104d5f:	90                   	nop
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104d60:	89 34 24             	mov    %esi,(%esp)
  104d63:	e8 08 c1 ff ff       	call   100e70 <fileclose>
    iunlockput(ip);
  104d68:	89 3c 24             	mov    %edi,(%esp)
    return -1;
  104d6b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
  104d70:	e8 8b cb ff ff       	call   101900 <iunlockput>
    return -1;
  104d75:	e9 11 ff ff ff       	jmp    104c8b <sys_open+0x2b>
  104d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104d80 <sys_mknod>:
  return fd;
}

int
sys_mknod(void)
{
  104d80:	55                   	push   %ebp
  104d81:	89 e5                	mov    %esp,%ebp
  104d83:	53                   	push   %ebx
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  104d84:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return fd;
}

int
sys_mknod(void)
{
  104d89:	83 ec 24             	sub    $0x24,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104d8c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104d8f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104d93:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104d9a:	e8 61 f6 ff ff       	call   104400 <argstr>
  104d9f:	85 c0                	test   %eax,%eax
  104da1:	79 0d                	jns    104db0 <sys_mknod+0x30>
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
}
  104da3:	89 d8                	mov    %ebx,%eax
  104da5:	83 c4 24             	add    $0x24,%esp
  104da8:	5b                   	pop    %ebx
  104da9:	5d                   	pop    %ebp
  104daa:	c3                   	ret    
  104dab:	90                   	nop
  104dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  104db0:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104db3:	89 44 24 04          	mov    %eax,0x4(%esp)
  104db7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104dbe:	e8 6d f5 ff ff       	call   104330 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104dc3:	85 c0                	test   %eax,%eax
  104dc5:	78 dc                	js     104da3 <sys_mknod+0x23>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104dc7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104dca:	89 44 24 04          	mov    %eax,0x4(%esp)
  104dce:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104dd5:	e8 56 f5 ff ff       	call   104330 <argint>
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  104dda:	85 c0                	test   %eax,%eax
  104ddc:	78 c5                	js     104da3 <sys_mknod+0x23>
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
  104dde:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104de2:	31 d2                	xor    %edx,%edx
  104de4:	b9 03 00 00 00       	mov    $0x3,%ecx
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
  104de9:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ded:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
  104df1:	89 04 24             	mov    %eax,(%esp)
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104df7:	e8 84 f7 ff ff       	call   104580 <create>
  104dfc:	85 c0                	test   %eax,%eax
  104dfe:	74 a3                	je     104da3 <sys_mknod+0x23>
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104e00:	89 04 24             	mov    %eax,(%esp)
  return 0;
  104e03:	31 db                	xor    %ebx,%ebx
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104e05:	e8 f6 ca ff ff       	call   101900 <iunlockput>
  return 0;
  104e0a:	eb 97                	jmp    104da3 <sys_mknod+0x23>
  104e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104e10 <sys_mkdir>:
}

int
sys_mkdir(void)
{
  104e10:	55                   	push   %ebp
  104e11:	89 e5                	mov    %esp,%ebp
  104e13:	53                   	push   %ebx
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
    return -1;
  104e14:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_mkdir(void)
{
  104e19:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  104e1c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104e1f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e23:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104e2a:	e8 d1 f5 ff ff       	call   104400 <argstr>
  104e2f:	85 c0                	test   %eax,%eax
  104e31:	79 0d                	jns    104e40 <sys_mkdir+0x30>
    return -1;
  iunlockput(ip);
  return 0;
}
  104e33:	89 d8                	mov    %ebx,%eax
  104e35:	83 c4 24             	add    $0x24,%esp
  104e38:	5b                   	pop    %ebx
  104e39:	5d                   	pop    %ebp
  104e3a:	c3                   	ret    
  104e3b:	90                   	nop
  104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  104e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e43:	31 d2                	xor    %edx,%edx
  104e45:	b9 01 00 00 00       	mov    $0x1,%ecx
  104e4a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104e51:	00 
  104e52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104e59:	e8 22 f7 ff ff       	call   104580 <create>
  104e5e:	85 c0                	test   %eax,%eax
  104e60:	74 d1                	je     104e33 <sys_mkdir+0x23>
    return -1;
  iunlockput(ip);
  104e62:	89 04 24             	mov    %eax,(%esp)
  return 0;
  104e65:	31 db                	xor    %ebx,%ebx
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
    return -1;
  iunlockput(ip);
  104e67:	e8 94 ca ff ff       	call   101900 <iunlockput>
  return 0;
  104e6c:	eb c5                	jmp    104e33 <sys_mkdir+0x23>
  104e6e:	66 90                	xchg   %ax,%ax

00104e70 <sys_chdir>:
}

int
sys_chdir(void)
{
  104e70:	55                   	push   %ebp
  104e71:	89 e5                	mov    %esp,%ebp
  104e73:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104e76:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return 0;
}

int
sys_chdir(void)
{
  104e79:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  104e7c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_chdir(void)
{
  104e81:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104e84:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104e8f:	e8 6c f5 ff ff       	call   104400 <argstr>
  104e94:	85 c0                	test   %eax,%eax
  104e96:	79 10                	jns    104ea8 <sys_chdir+0x38>
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
}
  104e98:	89 d8                	mov    %ebx,%eax
  104e9a:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104e9d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  104ea0:	89 ec                	mov    %ebp,%esp
  104ea2:	5d                   	pop    %ebp
  104ea3:	c3                   	ret    
  104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104ea8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104eab:	89 04 24             	mov    %eax,(%esp)
  104eae:	e8 8d d0 ff ff       	call   101f40 <namei>
  104eb3:	85 c0                	test   %eax,%eax
  104eb5:	89 c6                	mov    %eax,%esi
  104eb7:	74 df                	je     104e98 <sys_chdir+0x28>
    return -1;
  ilock(ip);
  104eb9:	89 04 24             	mov    %eax,(%esp)
  104ebc:	e8 3f c6 ff ff       	call   101500 <ilock>
  if(ip->type != T_DIR){
  104ec1:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104ec6:	75 24                	jne    104eec <sys_chdir+0x7c>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104ec8:	89 34 24             	mov    %esi,(%esp)
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
  104ecb:	31 db                	xor    %ebx,%ebx
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104ecd:	e8 3e c7 ff ff       	call   101610 <iunlock>
  iput(cp->cwd);
  104ed2:	e8 39 e7 ff ff       	call   103610 <curproc>
  104ed7:	8b 40 60             	mov    0x60(%eax),%eax
  104eda:	89 04 24             	mov    %eax,(%esp)
  104edd:	e8 de c8 ff ff       	call   1017c0 <iput>
  cp->cwd = ip;
  104ee2:	e8 29 e7 ff ff       	call   103610 <curproc>
  104ee7:	89 70 60             	mov    %esi,0x60(%eax)
  return 0;
  104eea:	eb ac                	jmp    104e98 <sys_chdir+0x28>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104eec:	89 34 24             	mov    %esi,(%esp)
  104eef:	e8 0c ca ff ff       	call   101900 <iunlockput>
    return -1;
  104ef4:	eb a2                	jmp    104e98 <sys_chdir+0x28>
  104ef6:	8d 76 00             	lea    0x0(%esi),%esi
  104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f00 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  104f00:	55                   	push   %ebp
  104f01:	89 e5                	mov    %esp,%ebp
  104f03:	81 ec 88 00 00 00    	sub    $0x88,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104f09:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  104f0c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  104f0f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_exec(void)
{
  104f14:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104f17:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104f1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  104f1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104f25:	e8 d6 f4 ff ff       	call   104400 <argstr>
  104f2a:	85 c0                	test   %eax,%eax
  104f2c:	79 12                	jns    104f40 <sys_exec+0x40>
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  104f2e:	89 d8                	mov    %ebx,%eax
  104f30:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104f33:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104f36:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104f39:	89 ec                	mov    %ebp,%esp
  104f3b:	5d                   	pop    %ebp
  104f3c:	c3                   	ret    
  104f3d:	8d 76 00             	lea    0x0(%esi),%esi
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104f40:	8d 45 e0             	lea    -0x20(%ebp),%eax
  104f43:	89 44 24 04          	mov    %eax,0x4(%esp)
  104f47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104f4e:	e8 dd f3 ff ff       	call   104330 <argint>
  104f53:	85 c0                	test   %eax,%eax
  104f55:	78 d7                	js     104f2e <sys_exec+0x2e>
    return -1;
  memset(argv, 0, sizeof(argv));
  104f57:	8d 45 8c             	lea    -0x74(%ebp),%eax
  for(i=0;; i++){
    if(i >= NELEM(argv))
  104f5a:	31 ff                	xor    %edi,%edi
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  104f5c:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  104f63:	00 
  for(i=0;; i++){
  104f64:	31 db                	xor    %ebx,%ebx
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  104f66:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104f6d:	00 
  104f6e:	89 04 24             	mov    %eax,(%esp)
  104f71:	e8 aa f0 ff ff       	call   104020 <memset>
  104f76:	66 90                	xchg   %ax,%ax
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
  104f78:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
  104f7f:	03 75 e0             	add    -0x20(%ebp),%esi
  104f82:	e8 89 e6 ff ff       	call   103610 <curproc>
  104f87:	8d 55 dc             	lea    -0x24(%ebp),%edx
  104f8a:	89 54 24 08          	mov    %edx,0x8(%esp)
  104f8e:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f92:	89 04 24             	mov    %eax,(%esp)
  104f95:	e8 d6 f2 ff ff       	call   104270 <fetchint>
  104f9a:	85 c0                	test   %eax,%eax
  104f9c:	78 2e                	js     104fcc <sys_exec+0xcc>
      return -1;
    if(uarg == 0){
  104f9e:	8b 75 dc             	mov    -0x24(%ebp),%esi
  104fa1:	85 f6                	test   %esi,%esi
  104fa3:	74 31                	je     104fd6 <sys_exec+0xd6>
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
  104fa5:	e8 66 e6 ff ff       	call   103610 <curproc>
  104faa:	8d 54 bd 8c          	lea    -0x74(%ebp,%edi,4),%edx
  104fae:	89 54 24 08          	mov    %edx,0x8(%esp)
  104fb2:	89 74 24 04          	mov    %esi,0x4(%esp)
  104fb6:	89 04 24             	mov    %eax,(%esp)
  104fb9:	e8 02 f3 ff ff       	call   1042c0 <fetchstr>
  104fbe:	85 c0                	test   %eax,%eax
  104fc0:	78 0a                	js     104fcc <sys_exec+0xcc>
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104fc2:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104fc5:	83 fb 14             	cmp    $0x14,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104fc8:	89 df                	mov    %ebx,%edi
    if(i >= NELEM(argv))
  104fca:	75 ac                	jne    104f78 <sys_exec+0x78>
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  104fcc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104fd1:	e9 58 ff ff ff       	jmp    104f2e <sys_exec+0x2e>
  }
  return exec(path, argv);
  104fd6:	8d 45 8c             	lea    -0x74(%ebp),%eax
  104fd9:	89 44 24 04          	mov    %eax,0x4(%esp)
  104fdd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  104fe0:	c7 44 9d 8c 00 00 00 	movl   $0x0,-0x74(%ebp,%ebx,4)
  104fe7:	00 
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104fe8:	89 04 24             	mov    %eax,(%esp)
  104feb:	e8 a0 b9 ff ff       	call   100990 <exec>
  104ff0:	89 c3                	mov    %eax,%ebx
  104ff2:	e9 37 ff ff ff       	jmp    104f2e <sys_exec+0x2e>
  104ff7:	89 f6                	mov    %esi,%esi
  104ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105000 <sys_pipe>:
}

int
sys_pipe(void)
{
  105000:	55                   	push   %ebp
  105001:	89 e5                	mov    %esp,%ebp
  105003:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  105004:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return exec(path, argv);
}

int
sys_pipe(void)
{
  105009:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  10500c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10500f:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  105016:	00 
  105017:	89 44 24 04          	mov    %eax,0x4(%esp)
  10501b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105022:	e8 69 f3 ff ff       	call   104390 <argptr>
  105027:	85 c0                	test   %eax,%eax
  105029:	79 0d                	jns    105038 <sys_pipe+0x38>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
  10502b:	89 d8                	mov    %ebx,%eax
  10502d:	83 c4 24             	add    $0x24,%esp
  105030:	5b                   	pop    %ebx
  105031:	5d                   	pop    %ebp
  105032:	c3                   	ret    
  105033:	90                   	nop
  105034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  105038:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10503b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10503f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  105042:	89 04 24             	mov    %eax,(%esp)
  105045:	e8 96 dd ff ff       	call   102de0 <pipealloc>
  10504a:	85 c0                	test   %eax,%eax
  10504c:	78 dd                	js     10502b <sys_pipe+0x2b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  10504e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105051:	e8 da f4 ff ff       	call   104530 <fdalloc>
  105056:	85 c0                	test   %eax,%eax
  105058:	89 c3                	mov    %eax,%ebx
  10505a:	78 25                	js     105081 <sys_pipe+0x81>
  10505c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10505f:	e8 cc f4 ff ff       	call   104530 <fdalloc>
  105064:	85 c0                	test   %eax,%eax
  105066:	78 0c                	js     105074 <sys_pipe+0x74>
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  105068:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10506b:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
  return 0;
  10506d:	31 db                	xor    %ebx,%ebx
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  10506f:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
  105072:	eb b7                	jmp    10502b <sys_pipe+0x2b>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
  105074:	e8 97 e5 ff ff       	call   103610 <curproc>
  105079:	c7 44 98 20 00 00 00 	movl   $0x0,0x20(%eax,%ebx,4)
  105080:	00 
    fileclose(rf);
  105081:	8b 45 f0             	mov    -0x10(%ebp),%eax
    fileclose(wf);
    return -1;
  105084:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
    fileclose(rf);
  105089:	89 04 24             	mov    %eax,(%esp)
  10508c:	e8 df bd ff ff       	call   100e70 <fileclose>
    fileclose(wf);
  105091:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105094:	89 04 24             	mov    %eax,(%esp)
  105097:	e8 d4 bd ff ff       	call   100e70 <fileclose>
    return -1;
  10509c:	eb 8d                	jmp    10502b <sys_pipe+0x2b>
  10509e:	90                   	nop
  10509f:	90                   	nop

001050a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  1050a0:	55                   	push   %ebp
  1050a1:	89 e5                	mov    %esp,%ebp
  1050a3:	83 ec 18             	sub    $0x18,%esp
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
  1050a6:	e8 65 e5 ff ff       	call   103610 <curproc>
  1050ab:	89 04 24             	mov    %eax,(%esp)
  1050ae:	e8 8d e2 ff ff       	call   103340 <copyproc>
    return -1;
  1050b3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
sys_fork(void)
{
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
  1050b8:	85 c0                	test   %eax,%eax
  1050ba:	74 0a                	je     1050c6 <sys_fork+0x26>
    return -1;
  pid = np->pid;
  1050bc:	8b 50 10             	mov    0x10(%eax),%edx
  np->state = RUNNABLE;
  1050bf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  return pid;
}
  1050c6:	89 d0                	mov    %edx,%eax
  1050c8:	c9                   	leave  
  1050c9:	c3                   	ret    
  1050ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001050d0 <sys_exit>:

int
sys_exit(void)
{
  1050d0:	55                   	push   %ebp
  1050d1:	89 e5                	mov    %esp,%ebp
  1050d3:	83 ec 08             	sub    $0x8,%esp
  exit();
  1050d6:	e8 d5 e9 ff ff       	call   103ab0 <exit>
  return 0;  // not reached
}
  1050db:	31 c0                	xor    %eax,%eax
  1050dd:	c9                   	leave  
  1050de:	c3                   	ret    
  1050df:	90                   	nop

001050e0 <sys_wait>:

int
sys_wait(void)
{
  1050e0:	55                   	push   %ebp
  1050e1:	89 e5                	mov    %esp,%ebp
  1050e3:	83 ec 08             	sub    $0x8,%esp
  return wait();
}
  1050e6:	c9                   	leave  
}

int
sys_wait(void)
{
  return wait();
  1050e7:	e9 14 eb ff ff       	jmp    103c00 <wait>
  1050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001050f0 <sys_kill>:
}

int
sys_kill(void)
{
  1050f0:	55                   	push   %ebp
  1050f1:	89 e5                	mov    %esp,%ebp
  1050f3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
  1050f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1050f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105104:	e8 27 f2 ff ff       	call   104330 <argint>
  105109:	89 c2                	mov    %eax,%edx
    return -1;
  10510b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
  105110:	85 d2                	test   %edx,%edx
  105112:	78 0b                	js     10511f <sys_kill+0x2f>
    return -1;
  return kill(pid);
  105114:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105117:	89 04 24             	mov    %eax,(%esp)
  10511a:	e8 01 e9 ff ff       	call   103a20 <kill>
}
  10511f:	c9                   	leave  
  105120:	c3                   	ret    
  105121:	eb 0d                	jmp    105130 <sys_getpid>
  105123:	90                   	nop
  105124:	90                   	nop
  105125:	90                   	nop
  105126:	90                   	nop
  105127:	90                   	nop
  105128:	90                   	nop
  105129:	90                   	nop
  10512a:	90                   	nop
  10512b:	90                   	nop
  10512c:	90                   	nop
  10512d:	90                   	nop
  10512e:	90                   	nop
  10512f:	90                   	nop

00105130 <sys_getpid>:

int
sys_getpid(void)
{
  105130:	55                   	push   %ebp
  105131:	89 e5                	mov    %esp,%ebp
  105133:	83 ec 08             	sub    $0x8,%esp
  return cp->pid;
  105136:	e8 d5 e4 ff ff       	call   103610 <curproc>
  10513b:	8b 40 10             	mov    0x10(%eax),%eax
}
  10513e:	c9                   	leave  
  10513f:	c3                   	ret    

00105140 <sys_sbrk>:

int
sys_sbrk(void)
{
  105140:	55                   	push   %ebp
  105141:	89 e5                	mov    %esp,%ebp
  105143:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  105146:	8d 45 f4             	lea    -0xc(%ebp),%eax
  105149:	89 44 24 04          	mov    %eax,0x4(%esp)
  10514d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105154:	e8 d7 f1 ff ff       	call   104330 <argint>
  105159:	89 c2                	mov    %eax,%edx
    return -1;
  10515b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
  105160:	85 d2                	test   %edx,%edx
  105162:	79 04                	jns    105168 <sys_sbrk+0x28>
    return -1;
  if((addr = growproc(n)) < 0)
    return -1;
  return addr;
}
  105164:	c9                   	leave  
  105165:	c3                   	ret    
  105166:	66 90                	xchg   %ax,%ax
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  if((addr = growproc(n)) < 0)
  105168:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10516b:	89 04 24             	mov    %eax,(%esp)
  10516e:	e8 fd e4 ff ff       	call   103670 <growproc>
    return -1;
  105173:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  return addr;
}
  105178:	c9                   	leave  
  int n;

  if(argint(0, &n) < 0)
    return -1;
  if((addr = growproc(n)) < 0)
    return -1;
  105179:	85 c0                	test   %eax,%eax
  10517b:	0f 48 c2             	cmovs  %edx,%eax
  return addr;
}
  10517e:	c3                   	ret    
  10517f:	90                   	nop

00105180 <sys_sleep>:

int
sys_sleep(void)
{
  105180:	55                   	push   %ebp
  105181:	89 e5                	mov    %esp,%ebp
  105183:	53                   	push   %ebx
  105184:	83 ec 24             	sub    $0x24,%esp
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  105187:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10518a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10518e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105195:	e8 96 f1 ff ff       	call   104330 <argint>
  10519a:	89 c2                	mov    %eax,%edx
    return -1;
  10519c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
sys_sleep(void)
{
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  1051a1:	85 d2                	test   %edx,%edx
  1051a3:	78 58                	js     1051fd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
  1051a5:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
  1051ac:	e8 3f ed ff ff       	call   103ef0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  1051b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  1051b4:	8b 1d e0 df 10 00    	mov    0x10dfe0,%ebx
  while(ticks - ticks0 < n){
  1051ba:	85 d2                	test   %edx,%edx
  1051bc:	7f 22                	jg     1051e0 <sys_sleep+0x60>
  1051be:	eb 48                	jmp    105208 <sys_sleep+0x88>
    if(cp->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  1051c0:	c7 44 24 04 a0 d7 10 	movl   $0x10d7a0,0x4(%esp)
  1051c7:	00 
  1051c8:	c7 04 24 e0 df 10 00 	movl   $0x10dfe0,(%esp)
  1051cf:	e8 0c e7 ff ff       	call   1038e0 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  1051d4:	a1 e0 df 10 00       	mov    0x10dfe0,%eax
  1051d9:	29 d8                	sub    %ebx,%eax
  1051db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1051de:	7d 28                	jge    105208 <sys_sleep+0x88>
    if(cp->killed){
  1051e0:	e8 2b e4 ff ff       	call   103610 <curproc>
  1051e5:	8b 40 1c             	mov    0x1c(%eax),%eax
  1051e8:	85 c0                	test   %eax,%eax
  1051ea:	74 d4                	je     1051c0 <sys_sleep+0x40>
      release(&tickslock);
  1051ec:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
  1051f3:	e8 e8 ed ff ff       	call   103fe0 <release>
      return -1;
  1051f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  1051fd:	83 c4 24             	add    $0x24,%esp
  105200:	5b                   	pop    %ebx
  105201:	5d                   	pop    %ebp
  105202:	c3                   	ret    
  105203:	90                   	nop
  105204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  105208:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
  10520f:	e8 cc ed ff ff       	call   103fe0 <release>
  return 0;
}
  105214:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
  105217:	31 c0                	xor    %eax,%eax
}
  105219:	5b                   	pop    %ebx
  10521a:	5d                   	pop    %ebp
  10521b:	c3                   	ret    
  10521c:	90                   	nop
  10521d:	90                   	nop
  10521e:	90                   	nop
  10521f:	90                   	nop

00105220 <timer_init>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timer_init(void)
{
  105220:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105221:	ba 43 00 00 00       	mov    $0x43,%edx
  105226:	89 e5                	mov    %esp,%ebp
  105228:	83 ec 18             	sub    $0x18,%esp
  10522b:	b8 34 00 00 00       	mov    $0x34,%eax
  105230:	ee                   	out    %al,(%dx)
  105231:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  105236:	b2 40                	mov    $0x40,%dl
  105238:	ee                   	out    %al,(%dx)
  105239:	b8 2e 00 00 00       	mov    $0x2e,%eax
  10523e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  pic_enable(IRQ_TIMER);
  10523f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105246:	e8 c5 da ff ff       	call   102d10 <pic_enable>
}
  10524b:	c9                   	leave  
  10524c:	c3                   	ret    
  10524d:	90                   	nop
  10524e:	90                   	nop
  10524f:	90                   	nop

00105250 <alltraps>:
  105250:	1e                   	push   %ds
  105251:	06                   	push   %es
  105252:	60                   	pusha  
  105253:	b8 10 00 00 00       	mov    $0x10,%eax
  105258:	8e d8                	mov    %eax,%ds
  10525a:	8e c0                	mov    %eax,%es
  10525c:	54                   	push   %esp
  10525d:	e8 de 00 00 00       	call   105340 <trap>
  105262:	83 c4 04             	add    $0x4,%esp

00105265 <trapret>:
  105265:	61                   	popa   
  105266:	07                   	pop    %es
  105267:	1f                   	pop    %ds
  105268:	83 c4 08             	add    $0x8,%esp
  10526b:	cf                   	iret   

0010526c <forkret1>:
  10526c:	8b 64 24 04          	mov    0x4(%esp),%esp
  105270:	e9 f0 ff ff ff       	jmp    105265 <trapret>
  105275:	90                   	nop
  105276:	90                   	nop
  105277:	90                   	nop
  105278:	90                   	nop
  105279:	90                   	nop
  10527a:	90                   	nop
  10527b:	90                   	nop
  10527c:	90                   	nop
  10527d:	90                   	nop
  10527e:	90                   	nop
  10527f:	90                   	nop

00105280 <tvinit>:
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  105280:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
  105281:	31 c0                	xor    %eax,%eax
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  105283:	89 e5                	mov    %esp,%ebp
  105285:	ba e0 d7 10 00       	mov    $0x10d7e0,%edx
  10528a:	83 ec 18             	sub    $0x18,%esp
  10528d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  105290:	8b 0c 85 08 73 10 00 	mov    0x107308(,%eax,4),%ecx
  105297:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10529e:	66 89 0c c5 e0 d7 10 	mov    %cx,0x10d7e0(,%eax,8)
  1052a5:	00 
  1052a6:	c1 e9 10             	shr    $0x10,%ecx
  1052a9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1052ae:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1052b3:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  1052b8:	83 c0 01             	add    $0x1,%eax
  1052bb:	3d 00 01 00 00       	cmp    $0x100,%eax
  1052c0:	75 ce                	jne    105290 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1052c2:	a1 c8 73 10 00       	mov    0x1073c8,%eax
  
  initlock(&tickslock, "time");
  1052c7:	c7 44 24 04 d6 66 10 	movl   $0x1066d6,0x4(%esp)
  1052ce:	00 
  1052cf:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1052d6:	66 c7 05 62 d9 10 00 	movw   $0x8,0x10d962
  1052dd:	08 00 
  1052df:	66 a3 60 d9 10 00    	mov    %ax,0x10d960
  1052e5:	c1 e8 10             	shr    $0x10,%eax
  1052e8:	c6 05 64 d9 10 00 00 	movb   $0x0,0x10d964
  1052ef:	c6 05 65 d9 10 00 ef 	movb   $0xef,0x10d965
  1052f6:	66 a3 66 d9 10 00    	mov    %ax,0x10d966
  
  initlock(&tickslock, "time");
  1052fc:	e8 ef ea ff ff       	call   103df0 <initlock>
}
  105301:	c9                   	leave  
  105302:	c3                   	ret    
  105303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105310 <idtinit>:

void
idtinit(void)
{
  105310:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  105311:	b8 e0 d7 10 00       	mov    $0x10d7e0,%eax
  105316:	89 e5                	mov    %esp,%ebp
  105318:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  10531b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  105321:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  105325:	c1 e8 10             	shr    $0x10,%eax
  105328:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  10532c:	8d 45 fa             	lea    -0x6(%ebp),%eax
  10532f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  105332:	c9                   	leave  
  105333:	c3                   	ret    
  105334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10533a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105340 <trap>:

void
trap(struct trapframe *tf)
{
  105340:	55                   	push   %ebp
  105341:	89 e5                	mov    %esp,%ebp
  105343:	83 ec 48             	sub    $0x48,%esp
  105346:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105349:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10534c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10534f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
  105352:	8b 43 28             	mov    0x28(%ebx),%eax
  105355:	83 f8 30             	cmp    $0x30,%eax
  105358:	0f 84 82 01 00 00    	je     1054e0 <trap+0x1a0>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  10535e:	83 f8 21             	cmp    $0x21,%eax
  105361:	0f 84 61 01 00 00    	je     1054c8 <trap+0x188>
  105367:	76 47                	jbe    1053b0 <trap+0x70>
  105369:	83 f8 2e             	cmp    $0x2e,%eax
  10536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105370:	0f 84 42 01 00 00    	je     1054b8 <trap+0x178>
  105376:	83 f8 3f             	cmp    $0x3f,%eax
  105379:	75 3e                	jne    1053b9 <trap+0x79>
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  10537b:	8b 7b 30             	mov    0x30(%ebx),%edi
  10537e:	0f b7 73 34          	movzwl 0x34(%ebx),%esi
  105382:	e8 f9 d3 ff ff       	call   102780 <cpu>
  105387:	c7 04 24 e0 66 10 00 	movl   $0x1066e0,(%esp)
  10538e:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  105392:	89 74 24 08          	mov    %esi,0x8(%esp)
  105396:	89 44 24 04          	mov    %eax,0x4(%esp)
  10539a:	e8 b1 b1 ff ff       	call   100550 <cprintf>
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
  10539f:	e8 2c d4 ff ff       	call   1027d0 <lapic_eoi>
    break;
  1053a4:	e9 97 00 00 00       	jmp    105440 <trap+0x100>
  1053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  1053b0:	83 f8 20             	cmp    $0x20,%eax
  1053b3:	0f 84 e7 00 00 00    	je     1054a0 <trap+0x160>
  1053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
  1053c0:	e8 4b e2 ff ff       	call   103610 <curproc>
  1053c5:	85 c0                	test   %eax,%eax
  1053c7:	0f 84 8b 01 00 00    	je     105558 <trap+0x218>
  1053cd:	f6 43 34 03          	testb  $0x3,0x34(%ebx)
  1053d1:	0f 84 81 01 00 00    	je     105558 <trap+0x218>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1053d7:	8b 53 30             	mov    0x30(%ebx),%edx
  1053da:	89 55 e0             	mov    %edx,-0x20(%ebp)
  1053dd:	e8 9e d3 ff ff       	call   102780 <cpu>
  1053e2:	8b 4b 28             	mov    0x28(%ebx),%ecx
  1053e5:	8b 73 2c             	mov    0x2c(%ebx),%esi
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1053e8:	89 4d dc             	mov    %ecx,-0x24(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1053eb:	89 c7                	mov    %eax,%edi
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1053ed:	e8 1e e2 ff ff       	call   103610 <curproc>
  1053f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1053f5:	e8 16 e2 ff ff       	call   103610 <curproc>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1053fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1053fd:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  105400:	89 7c 24 14          	mov    %edi,0x14(%esp)
  105404:	89 74 24 10          	mov    %esi,0x10(%esp)
  105408:	89 54 24 18          	mov    %edx,0x18(%esp)
  10540c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10540f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  105413:	81 c2 88 00 00 00    	add    $0x88,%edx
  105419:	89 54 24 08          	mov    %edx,0x8(%esp)
  10541d:	8b 40 10             	mov    0x10(%eax),%eax
  105420:	c7 04 24 2c 67 10 00 	movl   $0x10672c,(%esp)
  105427:	89 44 24 04          	mov    %eax,0x4(%esp)
  10542b:	e8 20 b1 ff ff       	call   100550 <cprintf>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
    cp->killed = 1;
  105430:	e8 db e1 ff ff       	call   103610 <curproc>
  105435:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  10543c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  105440:	e8 cb e1 ff ff       	call   103610 <curproc>
  105445:	85 c0                	test   %eax,%eax
  105447:	74 1c                	je     105465 <trap+0x125>
  105449:	e8 c2 e1 ff ff       	call   103610 <curproc>
  10544e:	8b 40 1c             	mov    0x1c(%eax),%eax
  105451:	85 c0                	test   %eax,%eax
  105453:	74 10                	je     105465 <trap+0x125>
  105455:	0f b7 43 34          	movzwl 0x34(%ebx),%eax
  105459:	83 e0 03             	and    $0x3,%eax
  10545c:	83 f8 03             	cmp    $0x3,%eax
  10545f:	0f 84 23 01 00 00    	je     105588 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105465:	e8 a6 e1 ff ff       	call   103610 <curproc>
  10546a:	85 c0                	test   %eax,%eax
  10546c:	74 0d                	je     10547b <trap+0x13b>
  10546e:	66 90                	xchg   %ax,%ax
  105470:	e8 9b e1 ff ff       	call   103610 <curproc>
  105475:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  105479:	74 0d                	je     105488 <trap+0x148>
    yield();
}
  10547b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10547e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105481:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105484:	89 ec                	mov    %ebp,%esp
  105486:	5d                   	pop    %ebp
  105487:	c3                   	ret    
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105488:	83 7b 28 20          	cmpl   $0x20,0x28(%ebx)
  10548c:	75 ed                	jne    10547b <trap+0x13b>
    yield();
}
  10548e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105491:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105494:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105497:	89 ec                	mov    %ebp,%esp
  105499:	5d                   	pop    %ebp
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
  10549a:	e9 01 e4 ff ff       	jmp    1038a0 <yield>
  10549f:	90                   	nop
    return;
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
  1054a0:	e8 db d2 ff ff       	call   102780 <cpu>
  1054a5:	85 c0                	test   %eax,%eax
  1054a7:	74 7f                	je     105528 <trap+0x1e8>
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
    lapic_eoi();
  1054a9:	e8 22 d3 ff ff       	call   1027d0 <lapic_eoi>
  1054ae:	66 90                	xchg   %ax,%ax
    break;
  1054b0:	eb 8e                	jmp    105440 <trap+0x100>
  1054b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1054b8:	90                   	nop
  1054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
  1054c0:	e8 2b cc ff ff       	call   1020f0 <ide_intr>
  1054c5:	eb e2                	jmp    1054a9 <trap+0x169>
  1054c7:	90                   	nop
  1054c8:	90                   	nop
  1054c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
  1054d0:	e8 4b d1 ff ff       	call   102620 <kbd_intr>
    lapic_eoi();
  1054d5:	e8 f6 d2 ff ff       	call   1027d0 <lapic_eoi>
    break;
  1054da:	e9 61 ff ff ff       	jmp    105440 <trap+0x100>
  1054df:	90                   	nop

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
  1054e0:	e8 2b e1 ff ff       	call   103610 <curproc>
  1054e5:	8b 48 1c             	mov    0x1c(%eax),%ecx
  1054e8:	85 c9                	test   %ecx,%ecx
  1054ea:	0f 85 a8 00 00 00    	jne    105598 <trap+0x258>
      exit();
    cp->tf = tf;
  1054f0:	e8 1b e1 ff ff       	call   103610 <curproc>
  1054f5:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
  1054fb:	e8 90 ef ff ff       	call   104490 <syscall>
    if(cp->killed)
  105500:	e8 0b e1 ff ff       	call   103610 <curproc>
  105505:	8b 50 1c             	mov    0x1c(%eax),%edx
  105508:	85 d2                	test   %edx,%edx
  10550a:	0f 84 6b ff ff ff    	je     10547b <trap+0x13b>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
}
  105510:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105513:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105516:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105519:	89 ec                	mov    %ebp,%esp
  10551b:	5d                   	pop    %ebp
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
  10551c:	e9 8f e5 ff ff       	jmp    103ab0 <exit>
  105521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
  105528:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
  10552f:	e8 bc e9 ff ff       	call   103ef0 <acquire>
      ticks++;
  105534:	83 05 e0 df 10 00 01 	addl   $0x1,0x10dfe0
      wakeup(&ticks);
  10553b:	c7 04 24 e0 df 10 00 	movl   $0x10dfe0,(%esp)
  105542:	e8 69 e4 ff ff       	call   1039b0 <wakeup>
      release(&tickslock);
  105547:	c7 04 24 a0 d7 10 00 	movl   $0x10d7a0,(%esp)
  10554e:	e8 8d ea ff ff       	call   103fe0 <release>
  105553:	e9 51 ff ff ff       	jmp    1054a9 <trap+0x169>
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  105558:	8b 73 30             	mov    0x30(%ebx),%esi
  10555b:	e8 20 d2 ff ff       	call   102780 <cpu>
  105560:	89 74 24 0c          	mov    %esi,0xc(%esp)
  105564:	89 44 24 08          	mov    %eax,0x8(%esp)
  105568:	8b 43 28             	mov    0x28(%ebx),%eax
  10556b:	c7 04 24 04 67 10 00 	movl   $0x106704,(%esp)
  105572:	89 44 24 04          	mov    %eax,0x4(%esp)
  105576:	e8 d5 af ff ff       	call   100550 <cprintf>
              tf->trapno, cpu(), tf->eip);
      panic("trap");
  10557b:	c7 04 24 db 66 10 00 	movl   $0x1066db,(%esp)
  105582:	e8 79 b3 ff ff       	call   100900 <panic>
  105587:	90                   	nop

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
  105588:	e8 23 e5 ff ff       	call   103ab0 <exit>
  10558d:	e9 d3 fe ff ff       	jmp    105465 <trap+0x125>
  105592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105598:	90                   	nop
  105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
  1055a0:	e8 0b e5 ff ff       	call   103ab0 <exit>
  1055a5:	e9 46 ff ff ff       	jmp    1054f0 <trap+0x1b0>
  1055aa:	90                   	nop
  1055ab:	90                   	nop

001055ac <vector0>:
  1055ac:	6a 00                	push   $0x0
  1055ae:	6a 00                	push   $0x0
  1055b0:	e9 9b fc ff ff       	jmp    105250 <alltraps>

001055b5 <vector1>:
  1055b5:	6a 00                	push   $0x0
  1055b7:	6a 01                	push   $0x1
  1055b9:	e9 92 fc ff ff       	jmp    105250 <alltraps>

001055be <vector2>:
  1055be:	6a 00                	push   $0x0
  1055c0:	6a 02                	push   $0x2
  1055c2:	e9 89 fc ff ff       	jmp    105250 <alltraps>

001055c7 <vector3>:
  1055c7:	6a 00                	push   $0x0
  1055c9:	6a 03                	push   $0x3
  1055cb:	e9 80 fc ff ff       	jmp    105250 <alltraps>

001055d0 <vector4>:
  1055d0:	6a 00                	push   $0x0
  1055d2:	6a 04                	push   $0x4
  1055d4:	e9 77 fc ff ff       	jmp    105250 <alltraps>

001055d9 <vector5>:
  1055d9:	6a 00                	push   $0x0
  1055db:	6a 05                	push   $0x5
  1055dd:	e9 6e fc ff ff       	jmp    105250 <alltraps>

001055e2 <vector6>:
  1055e2:	6a 00                	push   $0x0
  1055e4:	6a 06                	push   $0x6
  1055e6:	e9 65 fc ff ff       	jmp    105250 <alltraps>

001055eb <vector7>:
  1055eb:	6a 00                	push   $0x0
  1055ed:	6a 07                	push   $0x7
  1055ef:	e9 5c fc ff ff       	jmp    105250 <alltraps>

001055f4 <vector8>:
  1055f4:	6a 08                	push   $0x8
  1055f6:	e9 55 fc ff ff       	jmp    105250 <alltraps>

001055fb <vector9>:
  1055fb:	6a 09                	push   $0x9
  1055fd:	e9 4e fc ff ff       	jmp    105250 <alltraps>

00105602 <vector10>:
  105602:	6a 0a                	push   $0xa
  105604:	e9 47 fc ff ff       	jmp    105250 <alltraps>

00105609 <vector11>:
  105609:	6a 0b                	push   $0xb
  10560b:	e9 40 fc ff ff       	jmp    105250 <alltraps>

00105610 <vector12>:
  105610:	6a 0c                	push   $0xc
  105612:	e9 39 fc ff ff       	jmp    105250 <alltraps>

00105617 <vector13>:
  105617:	6a 0d                	push   $0xd
  105619:	e9 32 fc ff ff       	jmp    105250 <alltraps>

0010561e <vector14>:
  10561e:	6a 0e                	push   $0xe
  105620:	e9 2b fc ff ff       	jmp    105250 <alltraps>

00105625 <vector15>:
  105625:	6a 00                	push   $0x0
  105627:	6a 0f                	push   $0xf
  105629:	e9 22 fc ff ff       	jmp    105250 <alltraps>

0010562e <vector16>:
  10562e:	6a 00                	push   $0x0
  105630:	6a 10                	push   $0x10
  105632:	e9 19 fc ff ff       	jmp    105250 <alltraps>

00105637 <vector17>:
  105637:	6a 11                	push   $0x11
  105639:	e9 12 fc ff ff       	jmp    105250 <alltraps>

0010563e <vector18>:
  10563e:	6a 00                	push   $0x0
  105640:	6a 12                	push   $0x12
  105642:	e9 09 fc ff ff       	jmp    105250 <alltraps>

00105647 <vector19>:
  105647:	6a 00                	push   $0x0
  105649:	6a 13                	push   $0x13
  10564b:	e9 00 fc ff ff       	jmp    105250 <alltraps>

00105650 <vector20>:
  105650:	6a 00                	push   $0x0
  105652:	6a 14                	push   $0x14
  105654:	e9 f7 fb ff ff       	jmp    105250 <alltraps>

00105659 <vector21>:
  105659:	6a 00                	push   $0x0
  10565b:	6a 15                	push   $0x15
  10565d:	e9 ee fb ff ff       	jmp    105250 <alltraps>

00105662 <vector22>:
  105662:	6a 00                	push   $0x0
  105664:	6a 16                	push   $0x16
  105666:	e9 e5 fb ff ff       	jmp    105250 <alltraps>

0010566b <vector23>:
  10566b:	6a 00                	push   $0x0
  10566d:	6a 17                	push   $0x17
  10566f:	e9 dc fb ff ff       	jmp    105250 <alltraps>

00105674 <vector24>:
  105674:	6a 00                	push   $0x0
  105676:	6a 18                	push   $0x18
  105678:	e9 d3 fb ff ff       	jmp    105250 <alltraps>

0010567d <vector25>:
  10567d:	6a 00                	push   $0x0
  10567f:	6a 19                	push   $0x19
  105681:	e9 ca fb ff ff       	jmp    105250 <alltraps>

00105686 <vector26>:
  105686:	6a 00                	push   $0x0
  105688:	6a 1a                	push   $0x1a
  10568a:	e9 c1 fb ff ff       	jmp    105250 <alltraps>

0010568f <vector27>:
  10568f:	6a 00                	push   $0x0
  105691:	6a 1b                	push   $0x1b
  105693:	e9 b8 fb ff ff       	jmp    105250 <alltraps>

00105698 <vector28>:
  105698:	6a 00                	push   $0x0
  10569a:	6a 1c                	push   $0x1c
  10569c:	e9 af fb ff ff       	jmp    105250 <alltraps>

001056a1 <vector29>:
  1056a1:	6a 00                	push   $0x0
  1056a3:	6a 1d                	push   $0x1d
  1056a5:	e9 a6 fb ff ff       	jmp    105250 <alltraps>

001056aa <vector30>:
  1056aa:	6a 00                	push   $0x0
  1056ac:	6a 1e                	push   $0x1e
  1056ae:	e9 9d fb ff ff       	jmp    105250 <alltraps>

001056b3 <vector31>:
  1056b3:	6a 00                	push   $0x0
  1056b5:	6a 1f                	push   $0x1f
  1056b7:	e9 94 fb ff ff       	jmp    105250 <alltraps>

001056bc <vector32>:
  1056bc:	6a 00                	push   $0x0
  1056be:	6a 20                	push   $0x20
  1056c0:	e9 8b fb ff ff       	jmp    105250 <alltraps>

001056c5 <vector33>:
  1056c5:	6a 00                	push   $0x0
  1056c7:	6a 21                	push   $0x21
  1056c9:	e9 82 fb ff ff       	jmp    105250 <alltraps>

001056ce <vector34>:
  1056ce:	6a 00                	push   $0x0
  1056d0:	6a 22                	push   $0x22
  1056d2:	e9 79 fb ff ff       	jmp    105250 <alltraps>

001056d7 <vector35>:
  1056d7:	6a 00                	push   $0x0
  1056d9:	6a 23                	push   $0x23
  1056db:	e9 70 fb ff ff       	jmp    105250 <alltraps>

001056e0 <vector36>:
  1056e0:	6a 00                	push   $0x0
  1056e2:	6a 24                	push   $0x24
  1056e4:	e9 67 fb ff ff       	jmp    105250 <alltraps>

001056e9 <vector37>:
  1056e9:	6a 00                	push   $0x0
  1056eb:	6a 25                	push   $0x25
  1056ed:	e9 5e fb ff ff       	jmp    105250 <alltraps>

001056f2 <vector38>:
  1056f2:	6a 00                	push   $0x0
  1056f4:	6a 26                	push   $0x26
  1056f6:	e9 55 fb ff ff       	jmp    105250 <alltraps>

001056fb <vector39>:
  1056fb:	6a 00                	push   $0x0
  1056fd:	6a 27                	push   $0x27
  1056ff:	e9 4c fb ff ff       	jmp    105250 <alltraps>

00105704 <vector40>:
  105704:	6a 00                	push   $0x0
  105706:	6a 28                	push   $0x28
  105708:	e9 43 fb ff ff       	jmp    105250 <alltraps>

0010570d <vector41>:
  10570d:	6a 00                	push   $0x0
  10570f:	6a 29                	push   $0x29
  105711:	e9 3a fb ff ff       	jmp    105250 <alltraps>

00105716 <vector42>:
  105716:	6a 00                	push   $0x0
  105718:	6a 2a                	push   $0x2a
  10571a:	e9 31 fb ff ff       	jmp    105250 <alltraps>

0010571f <vector43>:
  10571f:	6a 00                	push   $0x0
  105721:	6a 2b                	push   $0x2b
  105723:	e9 28 fb ff ff       	jmp    105250 <alltraps>

00105728 <vector44>:
  105728:	6a 00                	push   $0x0
  10572a:	6a 2c                	push   $0x2c
  10572c:	e9 1f fb ff ff       	jmp    105250 <alltraps>

00105731 <vector45>:
  105731:	6a 00                	push   $0x0
  105733:	6a 2d                	push   $0x2d
  105735:	e9 16 fb ff ff       	jmp    105250 <alltraps>

0010573a <vector46>:
  10573a:	6a 00                	push   $0x0
  10573c:	6a 2e                	push   $0x2e
  10573e:	e9 0d fb ff ff       	jmp    105250 <alltraps>

00105743 <vector47>:
  105743:	6a 00                	push   $0x0
  105745:	6a 2f                	push   $0x2f
  105747:	e9 04 fb ff ff       	jmp    105250 <alltraps>

0010574c <vector48>:
  10574c:	6a 00                	push   $0x0
  10574e:	6a 30                	push   $0x30
  105750:	e9 fb fa ff ff       	jmp    105250 <alltraps>

00105755 <vector49>:
  105755:	6a 00                	push   $0x0
  105757:	6a 31                	push   $0x31
  105759:	e9 f2 fa ff ff       	jmp    105250 <alltraps>

0010575e <vector50>:
  10575e:	6a 00                	push   $0x0
  105760:	6a 32                	push   $0x32
  105762:	e9 e9 fa ff ff       	jmp    105250 <alltraps>

00105767 <vector51>:
  105767:	6a 00                	push   $0x0
  105769:	6a 33                	push   $0x33
  10576b:	e9 e0 fa ff ff       	jmp    105250 <alltraps>

00105770 <vector52>:
  105770:	6a 00                	push   $0x0
  105772:	6a 34                	push   $0x34
  105774:	e9 d7 fa ff ff       	jmp    105250 <alltraps>

00105779 <vector53>:
  105779:	6a 00                	push   $0x0
  10577b:	6a 35                	push   $0x35
  10577d:	e9 ce fa ff ff       	jmp    105250 <alltraps>

00105782 <vector54>:
  105782:	6a 00                	push   $0x0
  105784:	6a 36                	push   $0x36
  105786:	e9 c5 fa ff ff       	jmp    105250 <alltraps>

0010578b <vector55>:
  10578b:	6a 00                	push   $0x0
  10578d:	6a 37                	push   $0x37
  10578f:	e9 bc fa ff ff       	jmp    105250 <alltraps>

00105794 <vector56>:
  105794:	6a 00                	push   $0x0
  105796:	6a 38                	push   $0x38
  105798:	e9 b3 fa ff ff       	jmp    105250 <alltraps>

0010579d <vector57>:
  10579d:	6a 00                	push   $0x0
  10579f:	6a 39                	push   $0x39
  1057a1:	e9 aa fa ff ff       	jmp    105250 <alltraps>

001057a6 <vector58>:
  1057a6:	6a 00                	push   $0x0
  1057a8:	6a 3a                	push   $0x3a
  1057aa:	e9 a1 fa ff ff       	jmp    105250 <alltraps>

001057af <vector59>:
  1057af:	6a 00                	push   $0x0
  1057b1:	6a 3b                	push   $0x3b
  1057b3:	e9 98 fa ff ff       	jmp    105250 <alltraps>

001057b8 <vector60>:
  1057b8:	6a 00                	push   $0x0
  1057ba:	6a 3c                	push   $0x3c
  1057bc:	e9 8f fa ff ff       	jmp    105250 <alltraps>

001057c1 <vector61>:
  1057c1:	6a 00                	push   $0x0
  1057c3:	6a 3d                	push   $0x3d
  1057c5:	e9 86 fa ff ff       	jmp    105250 <alltraps>

001057ca <vector62>:
  1057ca:	6a 00                	push   $0x0
  1057cc:	6a 3e                	push   $0x3e
  1057ce:	e9 7d fa ff ff       	jmp    105250 <alltraps>

001057d3 <vector63>:
  1057d3:	6a 00                	push   $0x0
  1057d5:	6a 3f                	push   $0x3f
  1057d7:	e9 74 fa ff ff       	jmp    105250 <alltraps>

001057dc <vector64>:
  1057dc:	6a 00                	push   $0x0
  1057de:	6a 40                	push   $0x40
  1057e0:	e9 6b fa ff ff       	jmp    105250 <alltraps>

001057e5 <vector65>:
  1057e5:	6a 00                	push   $0x0
  1057e7:	6a 41                	push   $0x41
  1057e9:	e9 62 fa ff ff       	jmp    105250 <alltraps>

001057ee <vector66>:
  1057ee:	6a 00                	push   $0x0
  1057f0:	6a 42                	push   $0x42
  1057f2:	e9 59 fa ff ff       	jmp    105250 <alltraps>

001057f7 <vector67>:
  1057f7:	6a 00                	push   $0x0
  1057f9:	6a 43                	push   $0x43
  1057fb:	e9 50 fa ff ff       	jmp    105250 <alltraps>

00105800 <vector68>:
  105800:	6a 00                	push   $0x0
  105802:	6a 44                	push   $0x44
  105804:	e9 47 fa ff ff       	jmp    105250 <alltraps>

00105809 <vector69>:
  105809:	6a 00                	push   $0x0
  10580b:	6a 45                	push   $0x45
  10580d:	e9 3e fa ff ff       	jmp    105250 <alltraps>

00105812 <vector70>:
  105812:	6a 00                	push   $0x0
  105814:	6a 46                	push   $0x46
  105816:	e9 35 fa ff ff       	jmp    105250 <alltraps>

0010581b <vector71>:
  10581b:	6a 00                	push   $0x0
  10581d:	6a 47                	push   $0x47
  10581f:	e9 2c fa ff ff       	jmp    105250 <alltraps>

00105824 <vector72>:
  105824:	6a 00                	push   $0x0
  105826:	6a 48                	push   $0x48
  105828:	e9 23 fa ff ff       	jmp    105250 <alltraps>

0010582d <vector73>:
  10582d:	6a 00                	push   $0x0
  10582f:	6a 49                	push   $0x49
  105831:	e9 1a fa ff ff       	jmp    105250 <alltraps>

00105836 <vector74>:
  105836:	6a 00                	push   $0x0
  105838:	6a 4a                	push   $0x4a
  10583a:	e9 11 fa ff ff       	jmp    105250 <alltraps>

0010583f <vector75>:
  10583f:	6a 00                	push   $0x0
  105841:	6a 4b                	push   $0x4b
  105843:	e9 08 fa ff ff       	jmp    105250 <alltraps>

00105848 <vector76>:
  105848:	6a 00                	push   $0x0
  10584a:	6a 4c                	push   $0x4c
  10584c:	e9 ff f9 ff ff       	jmp    105250 <alltraps>

00105851 <vector77>:
  105851:	6a 00                	push   $0x0
  105853:	6a 4d                	push   $0x4d
  105855:	e9 f6 f9 ff ff       	jmp    105250 <alltraps>

0010585a <vector78>:
  10585a:	6a 00                	push   $0x0
  10585c:	6a 4e                	push   $0x4e
  10585e:	e9 ed f9 ff ff       	jmp    105250 <alltraps>

00105863 <vector79>:
  105863:	6a 00                	push   $0x0
  105865:	6a 4f                	push   $0x4f
  105867:	e9 e4 f9 ff ff       	jmp    105250 <alltraps>

0010586c <vector80>:
  10586c:	6a 00                	push   $0x0
  10586e:	6a 50                	push   $0x50
  105870:	e9 db f9 ff ff       	jmp    105250 <alltraps>

00105875 <vector81>:
  105875:	6a 00                	push   $0x0
  105877:	6a 51                	push   $0x51
  105879:	e9 d2 f9 ff ff       	jmp    105250 <alltraps>

0010587e <vector82>:
  10587e:	6a 00                	push   $0x0
  105880:	6a 52                	push   $0x52
  105882:	e9 c9 f9 ff ff       	jmp    105250 <alltraps>

00105887 <vector83>:
  105887:	6a 00                	push   $0x0
  105889:	6a 53                	push   $0x53
  10588b:	e9 c0 f9 ff ff       	jmp    105250 <alltraps>

00105890 <vector84>:
  105890:	6a 00                	push   $0x0
  105892:	6a 54                	push   $0x54
  105894:	e9 b7 f9 ff ff       	jmp    105250 <alltraps>

00105899 <vector85>:
  105899:	6a 00                	push   $0x0
  10589b:	6a 55                	push   $0x55
  10589d:	e9 ae f9 ff ff       	jmp    105250 <alltraps>

001058a2 <vector86>:
  1058a2:	6a 00                	push   $0x0
  1058a4:	6a 56                	push   $0x56
  1058a6:	e9 a5 f9 ff ff       	jmp    105250 <alltraps>

001058ab <vector87>:
  1058ab:	6a 00                	push   $0x0
  1058ad:	6a 57                	push   $0x57
  1058af:	e9 9c f9 ff ff       	jmp    105250 <alltraps>

001058b4 <vector88>:
  1058b4:	6a 00                	push   $0x0
  1058b6:	6a 58                	push   $0x58
  1058b8:	e9 93 f9 ff ff       	jmp    105250 <alltraps>

001058bd <vector89>:
  1058bd:	6a 00                	push   $0x0
  1058bf:	6a 59                	push   $0x59
  1058c1:	e9 8a f9 ff ff       	jmp    105250 <alltraps>

001058c6 <vector90>:
  1058c6:	6a 00                	push   $0x0
  1058c8:	6a 5a                	push   $0x5a
  1058ca:	e9 81 f9 ff ff       	jmp    105250 <alltraps>

001058cf <vector91>:
  1058cf:	6a 00                	push   $0x0
  1058d1:	6a 5b                	push   $0x5b
  1058d3:	e9 78 f9 ff ff       	jmp    105250 <alltraps>

001058d8 <vector92>:
  1058d8:	6a 00                	push   $0x0
  1058da:	6a 5c                	push   $0x5c
  1058dc:	e9 6f f9 ff ff       	jmp    105250 <alltraps>

001058e1 <vector93>:
  1058e1:	6a 00                	push   $0x0
  1058e3:	6a 5d                	push   $0x5d
  1058e5:	e9 66 f9 ff ff       	jmp    105250 <alltraps>

001058ea <vector94>:
  1058ea:	6a 00                	push   $0x0
  1058ec:	6a 5e                	push   $0x5e
  1058ee:	e9 5d f9 ff ff       	jmp    105250 <alltraps>

001058f3 <vector95>:
  1058f3:	6a 00                	push   $0x0
  1058f5:	6a 5f                	push   $0x5f
  1058f7:	e9 54 f9 ff ff       	jmp    105250 <alltraps>

001058fc <vector96>:
  1058fc:	6a 00                	push   $0x0
  1058fe:	6a 60                	push   $0x60
  105900:	e9 4b f9 ff ff       	jmp    105250 <alltraps>

00105905 <vector97>:
  105905:	6a 00                	push   $0x0
  105907:	6a 61                	push   $0x61
  105909:	e9 42 f9 ff ff       	jmp    105250 <alltraps>

0010590e <vector98>:
  10590e:	6a 00                	push   $0x0
  105910:	6a 62                	push   $0x62
  105912:	e9 39 f9 ff ff       	jmp    105250 <alltraps>

00105917 <vector99>:
  105917:	6a 00                	push   $0x0
  105919:	6a 63                	push   $0x63
  10591b:	e9 30 f9 ff ff       	jmp    105250 <alltraps>

00105920 <vector100>:
  105920:	6a 00                	push   $0x0
  105922:	6a 64                	push   $0x64
  105924:	e9 27 f9 ff ff       	jmp    105250 <alltraps>

00105929 <vector101>:
  105929:	6a 00                	push   $0x0
  10592b:	6a 65                	push   $0x65
  10592d:	e9 1e f9 ff ff       	jmp    105250 <alltraps>

00105932 <vector102>:
  105932:	6a 00                	push   $0x0
  105934:	6a 66                	push   $0x66
  105936:	e9 15 f9 ff ff       	jmp    105250 <alltraps>

0010593b <vector103>:
  10593b:	6a 00                	push   $0x0
  10593d:	6a 67                	push   $0x67
  10593f:	e9 0c f9 ff ff       	jmp    105250 <alltraps>

00105944 <vector104>:
  105944:	6a 00                	push   $0x0
  105946:	6a 68                	push   $0x68
  105948:	e9 03 f9 ff ff       	jmp    105250 <alltraps>

0010594d <vector105>:
  10594d:	6a 00                	push   $0x0
  10594f:	6a 69                	push   $0x69
  105951:	e9 fa f8 ff ff       	jmp    105250 <alltraps>

00105956 <vector106>:
  105956:	6a 00                	push   $0x0
  105958:	6a 6a                	push   $0x6a
  10595a:	e9 f1 f8 ff ff       	jmp    105250 <alltraps>

0010595f <vector107>:
  10595f:	6a 00                	push   $0x0
  105961:	6a 6b                	push   $0x6b
  105963:	e9 e8 f8 ff ff       	jmp    105250 <alltraps>

00105968 <vector108>:
  105968:	6a 00                	push   $0x0
  10596a:	6a 6c                	push   $0x6c
  10596c:	e9 df f8 ff ff       	jmp    105250 <alltraps>

00105971 <vector109>:
  105971:	6a 00                	push   $0x0
  105973:	6a 6d                	push   $0x6d
  105975:	e9 d6 f8 ff ff       	jmp    105250 <alltraps>

0010597a <vector110>:
  10597a:	6a 00                	push   $0x0
  10597c:	6a 6e                	push   $0x6e
  10597e:	e9 cd f8 ff ff       	jmp    105250 <alltraps>

00105983 <vector111>:
  105983:	6a 00                	push   $0x0
  105985:	6a 6f                	push   $0x6f
  105987:	e9 c4 f8 ff ff       	jmp    105250 <alltraps>

0010598c <vector112>:
  10598c:	6a 00                	push   $0x0
  10598e:	6a 70                	push   $0x70
  105990:	e9 bb f8 ff ff       	jmp    105250 <alltraps>

00105995 <vector113>:
  105995:	6a 00                	push   $0x0
  105997:	6a 71                	push   $0x71
  105999:	e9 b2 f8 ff ff       	jmp    105250 <alltraps>

0010599e <vector114>:
  10599e:	6a 00                	push   $0x0
  1059a0:	6a 72                	push   $0x72
  1059a2:	e9 a9 f8 ff ff       	jmp    105250 <alltraps>

001059a7 <vector115>:
  1059a7:	6a 00                	push   $0x0
  1059a9:	6a 73                	push   $0x73
  1059ab:	e9 a0 f8 ff ff       	jmp    105250 <alltraps>

001059b0 <vector116>:
  1059b0:	6a 00                	push   $0x0
  1059b2:	6a 74                	push   $0x74
  1059b4:	e9 97 f8 ff ff       	jmp    105250 <alltraps>

001059b9 <vector117>:
  1059b9:	6a 00                	push   $0x0
  1059bb:	6a 75                	push   $0x75
  1059bd:	e9 8e f8 ff ff       	jmp    105250 <alltraps>

001059c2 <vector118>:
  1059c2:	6a 00                	push   $0x0
  1059c4:	6a 76                	push   $0x76
  1059c6:	e9 85 f8 ff ff       	jmp    105250 <alltraps>

001059cb <vector119>:
  1059cb:	6a 00                	push   $0x0
  1059cd:	6a 77                	push   $0x77
  1059cf:	e9 7c f8 ff ff       	jmp    105250 <alltraps>

001059d4 <vector120>:
  1059d4:	6a 00                	push   $0x0
  1059d6:	6a 78                	push   $0x78
  1059d8:	e9 73 f8 ff ff       	jmp    105250 <alltraps>

001059dd <vector121>:
  1059dd:	6a 00                	push   $0x0
  1059df:	6a 79                	push   $0x79
  1059e1:	e9 6a f8 ff ff       	jmp    105250 <alltraps>

001059e6 <vector122>:
  1059e6:	6a 00                	push   $0x0
  1059e8:	6a 7a                	push   $0x7a
  1059ea:	e9 61 f8 ff ff       	jmp    105250 <alltraps>

001059ef <vector123>:
  1059ef:	6a 00                	push   $0x0
  1059f1:	6a 7b                	push   $0x7b
  1059f3:	e9 58 f8 ff ff       	jmp    105250 <alltraps>

001059f8 <vector124>:
  1059f8:	6a 00                	push   $0x0
  1059fa:	6a 7c                	push   $0x7c
  1059fc:	e9 4f f8 ff ff       	jmp    105250 <alltraps>

00105a01 <vector125>:
  105a01:	6a 00                	push   $0x0
  105a03:	6a 7d                	push   $0x7d
  105a05:	e9 46 f8 ff ff       	jmp    105250 <alltraps>

00105a0a <vector126>:
  105a0a:	6a 00                	push   $0x0
  105a0c:	6a 7e                	push   $0x7e
  105a0e:	e9 3d f8 ff ff       	jmp    105250 <alltraps>

00105a13 <vector127>:
  105a13:	6a 00                	push   $0x0
  105a15:	6a 7f                	push   $0x7f
  105a17:	e9 34 f8 ff ff       	jmp    105250 <alltraps>

00105a1c <vector128>:
  105a1c:	6a 00                	push   $0x0
  105a1e:	68 80 00 00 00       	push   $0x80
  105a23:	e9 28 f8 ff ff       	jmp    105250 <alltraps>

00105a28 <vector129>:
  105a28:	6a 00                	push   $0x0
  105a2a:	68 81 00 00 00       	push   $0x81
  105a2f:	e9 1c f8 ff ff       	jmp    105250 <alltraps>

00105a34 <vector130>:
  105a34:	6a 00                	push   $0x0
  105a36:	68 82 00 00 00       	push   $0x82
  105a3b:	e9 10 f8 ff ff       	jmp    105250 <alltraps>

00105a40 <vector131>:
  105a40:	6a 00                	push   $0x0
  105a42:	68 83 00 00 00       	push   $0x83
  105a47:	e9 04 f8 ff ff       	jmp    105250 <alltraps>

00105a4c <vector132>:
  105a4c:	6a 00                	push   $0x0
  105a4e:	68 84 00 00 00       	push   $0x84
  105a53:	e9 f8 f7 ff ff       	jmp    105250 <alltraps>

00105a58 <vector133>:
  105a58:	6a 00                	push   $0x0
  105a5a:	68 85 00 00 00       	push   $0x85
  105a5f:	e9 ec f7 ff ff       	jmp    105250 <alltraps>

00105a64 <vector134>:
  105a64:	6a 00                	push   $0x0
  105a66:	68 86 00 00 00       	push   $0x86
  105a6b:	e9 e0 f7 ff ff       	jmp    105250 <alltraps>

00105a70 <vector135>:
  105a70:	6a 00                	push   $0x0
  105a72:	68 87 00 00 00       	push   $0x87
  105a77:	e9 d4 f7 ff ff       	jmp    105250 <alltraps>

00105a7c <vector136>:
  105a7c:	6a 00                	push   $0x0
  105a7e:	68 88 00 00 00       	push   $0x88
  105a83:	e9 c8 f7 ff ff       	jmp    105250 <alltraps>

00105a88 <vector137>:
  105a88:	6a 00                	push   $0x0
  105a8a:	68 89 00 00 00       	push   $0x89
  105a8f:	e9 bc f7 ff ff       	jmp    105250 <alltraps>

00105a94 <vector138>:
  105a94:	6a 00                	push   $0x0
  105a96:	68 8a 00 00 00       	push   $0x8a
  105a9b:	e9 b0 f7 ff ff       	jmp    105250 <alltraps>

00105aa0 <vector139>:
  105aa0:	6a 00                	push   $0x0
  105aa2:	68 8b 00 00 00       	push   $0x8b
  105aa7:	e9 a4 f7 ff ff       	jmp    105250 <alltraps>

00105aac <vector140>:
  105aac:	6a 00                	push   $0x0
  105aae:	68 8c 00 00 00       	push   $0x8c
  105ab3:	e9 98 f7 ff ff       	jmp    105250 <alltraps>

00105ab8 <vector141>:
  105ab8:	6a 00                	push   $0x0
  105aba:	68 8d 00 00 00       	push   $0x8d
  105abf:	e9 8c f7 ff ff       	jmp    105250 <alltraps>

00105ac4 <vector142>:
  105ac4:	6a 00                	push   $0x0
  105ac6:	68 8e 00 00 00       	push   $0x8e
  105acb:	e9 80 f7 ff ff       	jmp    105250 <alltraps>

00105ad0 <vector143>:
  105ad0:	6a 00                	push   $0x0
  105ad2:	68 8f 00 00 00       	push   $0x8f
  105ad7:	e9 74 f7 ff ff       	jmp    105250 <alltraps>

00105adc <vector144>:
  105adc:	6a 00                	push   $0x0
  105ade:	68 90 00 00 00       	push   $0x90
  105ae3:	e9 68 f7 ff ff       	jmp    105250 <alltraps>

00105ae8 <vector145>:
  105ae8:	6a 00                	push   $0x0
  105aea:	68 91 00 00 00       	push   $0x91
  105aef:	e9 5c f7 ff ff       	jmp    105250 <alltraps>

00105af4 <vector146>:
  105af4:	6a 00                	push   $0x0
  105af6:	68 92 00 00 00       	push   $0x92
  105afb:	e9 50 f7 ff ff       	jmp    105250 <alltraps>

00105b00 <vector147>:
  105b00:	6a 00                	push   $0x0
  105b02:	68 93 00 00 00       	push   $0x93
  105b07:	e9 44 f7 ff ff       	jmp    105250 <alltraps>

00105b0c <vector148>:
  105b0c:	6a 00                	push   $0x0
  105b0e:	68 94 00 00 00       	push   $0x94
  105b13:	e9 38 f7 ff ff       	jmp    105250 <alltraps>

00105b18 <vector149>:
  105b18:	6a 00                	push   $0x0
  105b1a:	68 95 00 00 00       	push   $0x95
  105b1f:	e9 2c f7 ff ff       	jmp    105250 <alltraps>

00105b24 <vector150>:
  105b24:	6a 00                	push   $0x0
  105b26:	68 96 00 00 00       	push   $0x96
  105b2b:	e9 20 f7 ff ff       	jmp    105250 <alltraps>

00105b30 <vector151>:
  105b30:	6a 00                	push   $0x0
  105b32:	68 97 00 00 00       	push   $0x97
  105b37:	e9 14 f7 ff ff       	jmp    105250 <alltraps>

00105b3c <vector152>:
  105b3c:	6a 00                	push   $0x0
  105b3e:	68 98 00 00 00       	push   $0x98
  105b43:	e9 08 f7 ff ff       	jmp    105250 <alltraps>

00105b48 <vector153>:
  105b48:	6a 00                	push   $0x0
  105b4a:	68 99 00 00 00       	push   $0x99
  105b4f:	e9 fc f6 ff ff       	jmp    105250 <alltraps>

00105b54 <vector154>:
  105b54:	6a 00                	push   $0x0
  105b56:	68 9a 00 00 00       	push   $0x9a
  105b5b:	e9 f0 f6 ff ff       	jmp    105250 <alltraps>

00105b60 <vector155>:
  105b60:	6a 00                	push   $0x0
  105b62:	68 9b 00 00 00       	push   $0x9b
  105b67:	e9 e4 f6 ff ff       	jmp    105250 <alltraps>

00105b6c <vector156>:
  105b6c:	6a 00                	push   $0x0
  105b6e:	68 9c 00 00 00       	push   $0x9c
  105b73:	e9 d8 f6 ff ff       	jmp    105250 <alltraps>

00105b78 <vector157>:
  105b78:	6a 00                	push   $0x0
  105b7a:	68 9d 00 00 00       	push   $0x9d
  105b7f:	e9 cc f6 ff ff       	jmp    105250 <alltraps>

00105b84 <vector158>:
  105b84:	6a 00                	push   $0x0
  105b86:	68 9e 00 00 00       	push   $0x9e
  105b8b:	e9 c0 f6 ff ff       	jmp    105250 <alltraps>

00105b90 <vector159>:
  105b90:	6a 00                	push   $0x0
  105b92:	68 9f 00 00 00       	push   $0x9f
  105b97:	e9 b4 f6 ff ff       	jmp    105250 <alltraps>

00105b9c <vector160>:
  105b9c:	6a 00                	push   $0x0
  105b9e:	68 a0 00 00 00       	push   $0xa0
  105ba3:	e9 a8 f6 ff ff       	jmp    105250 <alltraps>

00105ba8 <vector161>:
  105ba8:	6a 00                	push   $0x0
  105baa:	68 a1 00 00 00       	push   $0xa1
  105baf:	e9 9c f6 ff ff       	jmp    105250 <alltraps>

00105bb4 <vector162>:
  105bb4:	6a 00                	push   $0x0
  105bb6:	68 a2 00 00 00       	push   $0xa2
  105bbb:	e9 90 f6 ff ff       	jmp    105250 <alltraps>

00105bc0 <vector163>:
  105bc0:	6a 00                	push   $0x0
  105bc2:	68 a3 00 00 00       	push   $0xa3
  105bc7:	e9 84 f6 ff ff       	jmp    105250 <alltraps>

00105bcc <vector164>:
  105bcc:	6a 00                	push   $0x0
  105bce:	68 a4 00 00 00       	push   $0xa4
  105bd3:	e9 78 f6 ff ff       	jmp    105250 <alltraps>

00105bd8 <vector165>:
  105bd8:	6a 00                	push   $0x0
  105bda:	68 a5 00 00 00       	push   $0xa5
  105bdf:	e9 6c f6 ff ff       	jmp    105250 <alltraps>

00105be4 <vector166>:
  105be4:	6a 00                	push   $0x0
  105be6:	68 a6 00 00 00       	push   $0xa6
  105beb:	e9 60 f6 ff ff       	jmp    105250 <alltraps>

00105bf0 <vector167>:
  105bf0:	6a 00                	push   $0x0
  105bf2:	68 a7 00 00 00       	push   $0xa7
  105bf7:	e9 54 f6 ff ff       	jmp    105250 <alltraps>

00105bfc <vector168>:
  105bfc:	6a 00                	push   $0x0
  105bfe:	68 a8 00 00 00       	push   $0xa8
  105c03:	e9 48 f6 ff ff       	jmp    105250 <alltraps>

00105c08 <vector169>:
  105c08:	6a 00                	push   $0x0
  105c0a:	68 a9 00 00 00       	push   $0xa9
  105c0f:	e9 3c f6 ff ff       	jmp    105250 <alltraps>

00105c14 <vector170>:
  105c14:	6a 00                	push   $0x0
  105c16:	68 aa 00 00 00       	push   $0xaa
  105c1b:	e9 30 f6 ff ff       	jmp    105250 <alltraps>

00105c20 <vector171>:
  105c20:	6a 00                	push   $0x0
  105c22:	68 ab 00 00 00       	push   $0xab
  105c27:	e9 24 f6 ff ff       	jmp    105250 <alltraps>

00105c2c <vector172>:
  105c2c:	6a 00                	push   $0x0
  105c2e:	68 ac 00 00 00       	push   $0xac
  105c33:	e9 18 f6 ff ff       	jmp    105250 <alltraps>

00105c38 <vector173>:
  105c38:	6a 00                	push   $0x0
  105c3a:	68 ad 00 00 00       	push   $0xad
  105c3f:	e9 0c f6 ff ff       	jmp    105250 <alltraps>

00105c44 <vector174>:
  105c44:	6a 00                	push   $0x0
  105c46:	68 ae 00 00 00       	push   $0xae
  105c4b:	e9 00 f6 ff ff       	jmp    105250 <alltraps>

00105c50 <vector175>:
  105c50:	6a 00                	push   $0x0
  105c52:	68 af 00 00 00       	push   $0xaf
  105c57:	e9 f4 f5 ff ff       	jmp    105250 <alltraps>

00105c5c <vector176>:
  105c5c:	6a 00                	push   $0x0
  105c5e:	68 b0 00 00 00       	push   $0xb0
  105c63:	e9 e8 f5 ff ff       	jmp    105250 <alltraps>

00105c68 <vector177>:
  105c68:	6a 00                	push   $0x0
  105c6a:	68 b1 00 00 00       	push   $0xb1
  105c6f:	e9 dc f5 ff ff       	jmp    105250 <alltraps>

00105c74 <vector178>:
  105c74:	6a 00                	push   $0x0
  105c76:	68 b2 00 00 00       	push   $0xb2
  105c7b:	e9 d0 f5 ff ff       	jmp    105250 <alltraps>

00105c80 <vector179>:
  105c80:	6a 00                	push   $0x0
  105c82:	68 b3 00 00 00       	push   $0xb3
  105c87:	e9 c4 f5 ff ff       	jmp    105250 <alltraps>

00105c8c <vector180>:
  105c8c:	6a 00                	push   $0x0
  105c8e:	68 b4 00 00 00       	push   $0xb4
  105c93:	e9 b8 f5 ff ff       	jmp    105250 <alltraps>

00105c98 <vector181>:
  105c98:	6a 00                	push   $0x0
  105c9a:	68 b5 00 00 00       	push   $0xb5
  105c9f:	e9 ac f5 ff ff       	jmp    105250 <alltraps>

00105ca4 <vector182>:
  105ca4:	6a 00                	push   $0x0
  105ca6:	68 b6 00 00 00       	push   $0xb6
  105cab:	e9 a0 f5 ff ff       	jmp    105250 <alltraps>

00105cb0 <vector183>:
  105cb0:	6a 00                	push   $0x0
  105cb2:	68 b7 00 00 00       	push   $0xb7
  105cb7:	e9 94 f5 ff ff       	jmp    105250 <alltraps>

00105cbc <vector184>:
  105cbc:	6a 00                	push   $0x0
  105cbe:	68 b8 00 00 00       	push   $0xb8
  105cc3:	e9 88 f5 ff ff       	jmp    105250 <alltraps>

00105cc8 <vector185>:
  105cc8:	6a 00                	push   $0x0
  105cca:	68 b9 00 00 00       	push   $0xb9
  105ccf:	e9 7c f5 ff ff       	jmp    105250 <alltraps>

00105cd4 <vector186>:
  105cd4:	6a 00                	push   $0x0
  105cd6:	68 ba 00 00 00       	push   $0xba
  105cdb:	e9 70 f5 ff ff       	jmp    105250 <alltraps>

00105ce0 <vector187>:
  105ce0:	6a 00                	push   $0x0
  105ce2:	68 bb 00 00 00       	push   $0xbb
  105ce7:	e9 64 f5 ff ff       	jmp    105250 <alltraps>

00105cec <vector188>:
  105cec:	6a 00                	push   $0x0
  105cee:	68 bc 00 00 00       	push   $0xbc
  105cf3:	e9 58 f5 ff ff       	jmp    105250 <alltraps>

00105cf8 <vector189>:
  105cf8:	6a 00                	push   $0x0
  105cfa:	68 bd 00 00 00       	push   $0xbd
  105cff:	e9 4c f5 ff ff       	jmp    105250 <alltraps>

00105d04 <vector190>:
  105d04:	6a 00                	push   $0x0
  105d06:	68 be 00 00 00       	push   $0xbe
  105d0b:	e9 40 f5 ff ff       	jmp    105250 <alltraps>

00105d10 <vector191>:
  105d10:	6a 00                	push   $0x0
  105d12:	68 bf 00 00 00       	push   $0xbf
  105d17:	e9 34 f5 ff ff       	jmp    105250 <alltraps>

00105d1c <vector192>:
  105d1c:	6a 00                	push   $0x0
  105d1e:	68 c0 00 00 00       	push   $0xc0
  105d23:	e9 28 f5 ff ff       	jmp    105250 <alltraps>

00105d28 <vector193>:
  105d28:	6a 00                	push   $0x0
  105d2a:	68 c1 00 00 00       	push   $0xc1
  105d2f:	e9 1c f5 ff ff       	jmp    105250 <alltraps>

00105d34 <vector194>:
  105d34:	6a 00                	push   $0x0
  105d36:	68 c2 00 00 00       	push   $0xc2
  105d3b:	e9 10 f5 ff ff       	jmp    105250 <alltraps>

00105d40 <vector195>:
  105d40:	6a 00                	push   $0x0
  105d42:	68 c3 00 00 00       	push   $0xc3
  105d47:	e9 04 f5 ff ff       	jmp    105250 <alltraps>

00105d4c <vector196>:
  105d4c:	6a 00                	push   $0x0
  105d4e:	68 c4 00 00 00       	push   $0xc4
  105d53:	e9 f8 f4 ff ff       	jmp    105250 <alltraps>

00105d58 <vector197>:
  105d58:	6a 00                	push   $0x0
  105d5a:	68 c5 00 00 00       	push   $0xc5
  105d5f:	e9 ec f4 ff ff       	jmp    105250 <alltraps>

00105d64 <vector198>:
  105d64:	6a 00                	push   $0x0
  105d66:	68 c6 00 00 00       	push   $0xc6
  105d6b:	e9 e0 f4 ff ff       	jmp    105250 <alltraps>

00105d70 <vector199>:
  105d70:	6a 00                	push   $0x0
  105d72:	68 c7 00 00 00       	push   $0xc7
  105d77:	e9 d4 f4 ff ff       	jmp    105250 <alltraps>

00105d7c <vector200>:
  105d7c:	6a 00                	push   $0x0
  105d7e:	68 c8 00 00 00       	push   $0xc8
  105d83:	e9 c8 f4 ff ff       	jmp    105250 <alltraps>

00105d88 <vector201>:
  105d88:	6a 00                	push   $0x0
  105d8a:	68 c9 00 00 00       	push   $0xc9
  105d8f:	e9 bc f4 ff ff       	jmp    105250 <alltraps>

00105d94 <vector202>:
  105d94:	6a 00                	push   $0x0
  105d96:	68 ca 00 00 00       	push   $0xca
  105d9b:	e9 b0 f4 ff ff       	jmp    105250 <alltraps>

00105da0 <vector203>:
  105da0:	6a 00                	push   $0x0
  105da2:	68 cb 00 00 00       	push   $0xcb
  105da7:	e9 a4 f4 ff ff       	jmp    105250 <alltraps>

00105dac <vector204>:
  105dac:	6a 00                	push   $0x0
  105dae:	68 cc 00 00 00       	push   $0xcc
  105db3:	e9 98 f4 ff ff       	jmp    105250 <alltraps>

00105db8 <vector205>:
  105db8:	6a 00                	push   $0x0
  105dba:	68 cd 00 00 00       	push   $0xcd
  105dbf:	e9 8c f4 ff ff       	jmp    105250 <alltraps>

00105dc4 <vector206>:
  105dc4:	6a 00                	push   $0x0
  105dc6:	68 ce 00 00 00       	push   $0xce
  105dcb:	e9 80 f4 ff ff       	jmp    105250 <alltraps>

00105dd0 <vector207>:
  105dd0:	6a 00                	push   $0x0
  105dd2:	68 cf 00 00 00       	push   $0xcf
  105dd7:	e9 74 f4 ff ff       	jmp    105250 <alltraps>

00105ddc <vector208>:
  105ddc:	6a 00                	push   $0x0
  105dde:	68 d0 00 00 00       	push   $0xd0
  105de3:	e9 68 f4 ff ff       	jmp    105250 <alltraps>

00105de8 <vector209>:
  105de8:	6a 00                	push   $0x0
  105dea:	68 d1 00 00 00       	push   $0xd1
  105def:	e9 5c f4 ff ff       	jmp    105250 <alltraps>

00105df4 <vector210>:
  105df4:	6a 00                	push   $0x0
  105df6:	68 d2 00 00 00       	push   $0xd2
  105dfb:	e9 50 f4 ff ff       	jmp    105250 <alltraps>

00105e00 <vector211>:
  105e00:	6a 00                	push   $0x0
  105e02:	68 d3 00 00 00       	push   $0xd3
  105e07:	e9 44 f4 ff ff       	jmp    105250 <alltraps>

00105e0c <vector212>:
  105e0c:	6a 00                	push   $0x0
  105e0e:	68 d4 00 00 00       	push   $0xd4
  105e13:	e9 38 f4 ff ff       	jmp    105250 <alltraps>

00105e18 <vector213>:
  105e18:	6a 00                	push   $0x0
  105e1a:	68 d5 00 00 00       	push   $0xd5
  105e1f:	e9 2c f4 ff ff       	jmp    105250 <alltraps>

00105e24 <vector214>:
  105e24:	6a 00                	push   $0x0
  105e26:	68 d6 00 00 00       	push   $0xd6
  105e2b:	e9 20 f4 ff ff       	jmp    105250 <alltraps>

00105e30 <vector215>:
  105e30:	6a 00                	push   $0x0
  105e32:	68 d7 00 00 00       	push   $0xd7
  105e37:	e9 14 f4 ff ff       	jmp    105250 <alltraps>

00105e3c <vector216>:
  105e3c:	6a 00                	push   $0x0
  105e3e:	68 d8 00 00 00       	push   $0xd8
  105e43:	e9 08 f4 ff ff       	jmp    105250 <alltraps>

00105e48 <vector217>:
  105e48:	6a 00                	push   $0x0
  105e4a:	68 d9 00 00 00       	push   $0xd9
  105e4f:	e9 fc f3 ff ff       	jmp    105250 <alltraps>

00105e54 <vector218>:
  105e54:	6a 00                	push   $0x0
  105e56:	68 da 00 00 00       	push   $0xda
  105e5b:	e9 f0 f3 ff ff       	jmp    105250 <alltraps>

00105e60 <vector219>:
  105e60:	6a 00                	push   $0x0
  105e62:	68 db 00 00 00       	push   $0xdb
  105e67:	e9 e4 f3 ff ff       	jmp    105250 <alltraps>

00105e6c <vector220>:
  105e6c:	6a 00                	push   $0x0
  105e6e:	68 dc 00 00 00       	push   $0xdc
  105e73:	e9 d8 f3 ff ff       	jmp    105250 <alltraps>

00105e78 <vector221>:
  105e78:	6a 00                	push   $0x0
  105e7a:	68 dd 00 00 00       	push   $0xdd
  105e7f:	e9 cc f3 ff ff       	jmp    105250 <alltraps>

00105e84 <vector222>:
  105e84:	6a 00                	push   $0x0
  105e86:	68 de 00 00 00       	push   $0xde
  105e8b:	e9 c0 f3 ff ff       	jmp    105250 <alltraps>

00105e90 <vector223>:
  105e90:	6a 00                	push   $0x0
  105e92:	68 df 00 00 00       	push   $0xdf
  105e97:	e9 b4 f3 ff ff       	jmp    105250 <alltraps>

00105e9c <vector224>:
  105e9c:	6a 00                	push   $0x0
  105e9e:	68 e0 00 00 00       	push   $0xe0
  105ea3:	e9 a8 f3 ff ff       	jmp    105250 <alltraps>

00105ea8 <vector225>:
  105ea8:	6a 00                	push   $0x0
  105eaa:	68 e1 00 00 00       	push   $0xe1
  105eaf:	e9 9c f3 ff ff       	jmp    105250 <alltraps>

00105eb4 <vector226>:
  105eb4:	6a 00                	push   $0x0
  105eb6:	68 e2 00 00 00       	push   $0xe2
  105ebb:	e9 90 f3 ff ff       	jmp    105250 <alltraps>

00105ec0 <vector227>:
  105ec0:	6a 00                	push   $0x0
  105ec2:	68 e3 00 00 00       	push   $0xe3
  105ec7:	e9 84 f3 ff ff       	jmp    105250 <alltraps>

00105ecc <vector228>:
  105ecc:	6a 00                	push   $0x0
  105ece:	68 e4 00 00 00       	push   $0xe4
  105ed3:	e9 78 f3 ff ff       	jmp    105250 <alltraps>

00105ed8 <vector229>:
  105ed8:	6a 00                	push   $0x0
  105eda:	68 e5 00 00 00       	push   $0xe5
  105edf:	e9 6c f3 ff ff       	jmp    105250 <alltraps>

00105ee4 <vector230>:
  105ee4:	6a 00                	push   $0x0
  105ee6:	68 e6 00 00 00       	push   $0xe6
  105eeb:	e9 60 f3 ff ff       	jmp    105250 <alltraps>

00105ef0 <vector231>:
  105ef0:	6a 00                	push   $0x0
  105ef2:	68 e7 00 00 00       	push   $0xe7
  105ef7:	e9 54 f3 ff ff       	jmp    105250 <alltraps>

00105efc <vector232>:
  105efc:	6a 00                	push   $0x0
  105efe:	68 e8 00 00 00       	push   $0xe8
  105f03:	e9 48 f3 ff ff       	jmp    105250 <alltraps>

00105f08 <vector233>:
  105f08:	6a 00                	push   $0x0
  105f0a:	68 e9 00 00 00       	push   $0xe9
  105f0f:	e9 3c f3 ff ff       	jmp    105250 <alltraps>

00105f14 <vector234>:
  105f14:	6a 00                	push   $0x0
  105f16:	68 ea 00 00 00       	push   $0xea
  105f1b:	e9 30 f3 ff ff       	jmp    105250 <alltraps>

00105f20 <vector235>:
  105f20:	6a 00                	push   $0x0
  105f22:	68 eb 00 00 00       	push   $0xeb
  105f27:	e9 24 f3 ff ff       	jmp    105250 <alltraps>

00105f2c <vector236>:
  105f2c:	6a 00                	push   $0x0
  105f2e:	68 ec 00 00 00       	push   $0xec
  105f33:	e9 18 f3 ff ff       	jmp    105250 <alltraps>

00105f38 <vector237>:
  105f38:	6a 00                	push   $0x0
  105f3a:	68 ed 00 00 00       	push   $0xed
  105f3f:	e9 0c f3 ff ff       	jmp    105250 <alltraps>

00105f44 <vector238>:
  105f44:	6a 00                	push   $0x0
  105f46:	68 ee 00 00 00       	push   $0xee
  105f4b:	e9 00 f3 ff ff       	jmp    105250 <alltraps>

00105f50 <vector239>:
  105f50:	6a 00                	push   $0x0
  105f52:	68 ef 00 00 00       	push   $0xef
  105f57:	e9 f4 f2 ff ff       	jmp    105250 <alltraps>

00105f5c <vector240>:
  105f5c:	6a 00                	push   $0x0
  105f5e:	68 f0 00 00 00       	push   $0xf0
  105f63:	e9 e8 f2 ff ff       	jmp    105250 <alltraps>

00105f68 <vector241>:
  105f68:	6a 00                	push   $0x0
  105f6a:	68 f1 00 00 00       	push   $0xf1
  105f6f:	e9 dc f2 ff ff       	jmp    105250 <alltraps>

00105f74 <vector242>:
  105f74:	6a 00                	push   $0x0
  105f76:	68 f2 00 00 00       	push   $0xf2
  105f7b:	e9 d0 f2 ff ff       	jmp    105250 <alltraps>

00105f80 <vector243>:
  105f80:	6a 00                	push   $0x0
  105f82:	68 f3 00 00 00       	push   $0xf3
  105f87:	e9 c4 f2 ff ff       	jmp    105250 <alltraps>

00105f8c <vector244>:
  105f8c:	6a 00                	push   $0x0
  105f8e:	68 f4 00 00 00       	push   $0xf4
  105f93:	e9 b8 f2 ff ff       	jmp    105250 <alltraps>

00105f98 <vector245>:
  105f98:	6a 00                	push   $0x0
  105f9a:	68 f5 00 00 00       	push   $0xf5
  105f9f:	e9 ac f2 ff ff       	jmp    105250 <alltraps>

00105fa4 <vector246>:
  105fa4:	6a 00                	push   $0x0
  105fa6:	68 f6 00 00 00       	push   $0xf6
  105fab:	e9 a0 f2 ff ff       	jmp    105250 <alltraps>

00105fb0 <vector247>:
  105fb0:	6a 00                	push   $0x0
  105fb2:	68 f7 00 00 00       	push   $0xf7
  105fb7:	e9 94 f2 ff ff       	jmp    105250 <alltraps>

00105fbc <vector248>:
  105fbc:	6a 00                	push   $0x0
  105fbe:	68 f8 00 00 00       	push   $0xf8
  105fc3:	e9 88 f2 ff ff       	jmp    105250 <alltraps>

00105fc8 <vector249>:
  105fc8:	6a 00                	push   $0x0
  105fca:	68 f9 00 00 00       	push   $0xf9
  105fcf:	e9 7c f2 ff ff       	jmp    105250 <alltraps>

00105fd4 <vector250>:
  105fd4:	6a 00                	push   $0x0
  105fd6:	68 fa 00 00 00       	push   $0xfa
  105fdb:	e9 70 f2 ff ff       	jmp    105250 <alltraps>

00105fe0 <vector251>:
  105fe0:	6a 00                	push   $0x0
  105fe2:	68 fb 00 00 00       	push   $0xfb
  105fe7:	e9 64 f2 ff ff       	jmp    105250 <alltraps>

00105fec <vector252>:
  105fec:	6a 00                	push   $0x0
  105fee:	68 fc 00 00 00       	push   $0xfc
  105ff3:	e9 58 f2 ff ff       	jmp    105250 <alltraps>

00105ff8 <vector253>:
  105ff8:	6a 00                	push   $0x0
  105ffa:	68 fd 00 00 00       	push   $0xfd
  105fff:	e9 4c f2 ff ff       	jmp    105250 <alltraps>

00106004 <vector254>:
  106004:	6a 00                	push   $0x0
  106006:	68 fe 00 00 00       	push   $0xfe
  10600b:	e9 40 f2 ff ff       	jmp    105250 <alltraps>

00106010 <vector255>:
  106010:	6a 00                	push   $0x0
  106012:	68 ff 00 00 00       	push   $0xff
  106017:	e9 34 f2 ff ff       	jmp    105250 <alltraps>
