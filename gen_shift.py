#for sll
# for i in range(5):
#     for j in range(32):
#         if j<(2**i):
#             print("assign temp[%d][%d]=offset[%d]?1'b0:temp[%d][%d];" % (i+1,j,i,i,j))
#         else:
#             print("assign temp[%d][%d]=offset[%d]?temp[%d][%d]:temp[%d][%d];" % (i+1,j,i,i,j-2**i,i,j))
#for sra
for i in range(5):
    for j in range(32):
        if j<(32-2**i):
            print("assign temp[%d][%d]=offset[%d]?temp[%d][%d]:temp[%d][%d];" % (i+1,j,i,i,j+2**i,i,j))
        else:
            print("assign temp[%d][%d]=offset[%d]?sign:temp[%d][%d];" % (i+1,j,i,i,j))