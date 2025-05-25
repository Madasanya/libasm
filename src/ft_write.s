; ----------------------------------------------------------------------------------------
; ft_write
; SYNOPSIS
;        ssize_t ft_write(int fd, const void buf[.count], size_t count);
; DESCRIPTION
;        write() writes up to count bytes from the buffer starting at buf
;        to the file referred to by the file descriptor fd.
;
;        The number of bytes written may be less than count if, for
;        example, there is insufficient space on the underlying physical
;        medium, or the RLIMIT_FSIZE resource limit is encountered (see
;        setrlimit(2)), or the call was interrupted by a signal handler
;        after having written less than count bytes.  (See also pipe(7).)
;
;        For a seekable file (i.e., one to which lseek(2) may be applied,
;        for example, a regular file) writing takes place at the file
;        offset, and the file offset is incremented by the number of bytes
;        actually written.  If the file was open(2)ed with O_APPEND, the
;        file offset is first set to the end of the file before writing.
;        The adjustment of the file offset and the write operation are
;        performed as an atomic step.
;
;        POSIX requires that a read(2) that can be proved to occur after a
;        write() has returned will return the new data.  Note that not all
;        filesystems are POSIX conforming.
;
;        According to POSIX.1, if count is greater than SSIZE_MAX, the
;        result is implementation-defined; see NOTES for the upper limit on
;        Linux.
; RETURN VALUE         top
;        On success, the number of bytes written is returned.  On error, -1
;        is returned, and errno is set to indicate the error.
;
;        Note that a successful write() may transfer fewer than count
;        bytes.  Such partial writes can occur for various reasons; for
;        example, because there was insufficient space on the disk device
;        to write all of the requested bytes, or because a blocked write()
;        to a socket, pipe, or similar was interrupted by a signal handler
;        after it had transferred some, but before it had transferred all
;        of the requested bytes.  In the event of a partial write, the
;        caller can make another write() call to transfer the remaining
;        bytes.  The subsequent call will either transfer further bytes or
;        may result in an error (e.g., if the disk is now full).
;
;        If count is zero and fd refers to a regular file, then write() may
;        return a failure status if one of the errors below is detected.
;        If no errors are detected, or error detection is not performed, 0
;        is returned without causing any other effect.  If count is zero
;        and fd refers to a file other than a regular file, the results are
;        not specified.
; ----------------------------------------------------------------------------------------

extern __errno_location
global    ft_write

section   .text
ft_write:   
            ; Arguments: rdi = fd, rsi = buf, rdx = count (as per syscall convention)
            mov     rax, 1           ; rax is syscall input and 1 the value for write
            syscall		     ; syscall will be called with rax (here set to 1 for write) as parameter
            test rax, rax		     ; the return value of the syscall is stored in rax. On success the number of bytes written is returned, -1 otherwise
            jge .exit
            ; setting of errno in case of error     
            neg rax		     ; errno is returned as negative value from -1 to -4095 and therefore needs to be negated
            mov rdi, rax	     ; rbx gets the errnos value, as the call of the errno location will be overwritten with this one
            call __errno_location wrt ..plt		; sets a pointer to errno location to rax and "wrt ..plt" is used to make this call through procedure linkage table (plt)
            mov [rax], rdi		; sets the value (negated return value of write syscall) to where rax points to (errno location); *errno = value
            mov rax, -1			; return value of our function for failed write
.exit:       
            ret                           ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
