#ifndef	_SYS_POLL_H
# include <io/sys/poll.h>

#ifndef _ISOMAC
extern int __poll (struct pollfd *__fds, unsigned long int __nfds,
		   int __timeout);
libc_hidden_proto (__poll)
libc_hidden_proto (ppoll)
#endif

#endif
