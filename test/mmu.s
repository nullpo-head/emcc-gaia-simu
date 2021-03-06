
.align 4096
pde:
    .space  4096
pte1:
    .space  4096
pte2:
    .space  4096
pte3:
    .space  4096
data:
    .int    65

.align 4096
.global main
main:
    mov     r1, pde
    mov     r2, pte1
    mov     r3, pte2
    mov     r4, pte3
    mov     r5, data
    mov     r6, output
    add     r7, r2, 1           # Create a valid PDE entry which contains the address of pte1. +1 is to validate entry.
    mov     [r1 +    0], r7     # Set pte1 to the first entry of PDE
    add     r7, r3, 1
    mov     [r1 +  288], r7     # Set pte2 to 72nd entry of PDE, 72 = 288 / 4.
    add     r7, r4, 1
    mov     [r1 + 2048], r7     # Set pte3 to 512th entry of PDE
    mov     r7, main
    shr     r7, r7, 10
    add     r7, r7, r2
    mov     [r7], main + 1      # Create an entry of pte1.
    add     r7, r5, 1
    mov     [r3 + 3348], r7     # Set the address of data to 837th entry of pte2. Map 0x12345000 to data
    add     r7, r6, 1
    mov     [r3 + 3204], r7     # Map 0x12321000 to output
    mov     [r4 + 4], 0x80001001# Create an entry of pte1. Map [0x80001000, 0x80002000) to [0x80001000, 0x80002000) for write operation.
    mov     r2, 0x80000000
    mov     [r2 + 0x1204], r1   # Register the address of PDE to the system memory
    mov     [r2 + 0x1200], 1    # Enable virtual memory
.space 40
    mov     r1, 0x12321000      # store the virtual address of output
    jr      r1

.align 4096
output:
    mov     r1, 0x12345000
    mov     r2, [r1]            # Read from 0x12345000, 0b0001001000(72) pde, 0b1101000101(837) pte
    mov     [r1 + 4], 10
    mov     r3, [r1 + 4]
    write   r2                  # Output "A\n"
    write   r3
    halt
