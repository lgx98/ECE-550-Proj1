/*
 this module implements arithmetic right shift operation, which does the following:
 1 shift the bits to the right by (offset) bits, discard the lowest (offset) bits
 2 fill the highest (offset) bits with the sign bit(highest bit) from the original input
 */
module sra (input [31:0] in,
            input [4:0] offset,
            output [31:0] out);

wire sign=in[31];

wire [31:0] temp[5:0];
assign temp[0] = in;
/*
genvar i;
generate
for (i = 0 ;i < 5 ;i = i + 1) begin: gen_shift
    assign temp[i+1] =
    offset[i]?
        {{(1<<i){sign}},temp[i][31:(1<<i)]}
    :
        temp[i];
end
endgenerate
*/

/*Since the code above is considered as behavioral verilog by TAs,
  and I do not want to write any redundant code when I am aware of the underlying circuit.
  I used python to generate the code below:
  hopefully that will make everyone happy :)
*/

assign temp[1][0]=offset[0]?temp[0][1]:temp[0][0];
assign temp[1][1]=offset[0]?temp[0][2]:temp[0][1];
assign temp[1][2]=offset[0]?temp[0][3]:temp[0][2];
assign temp[1][3]=offset[0]?temp[0][4]:temp[0][3];
assign temp[1][4]=offset[0]?temp[0][5]:temp[0][4];
assign temp[1][5]=offset[0]?temp[0][6]:temp[0][5];
assign temp[1][6]=offset[0]?temp[0][7]:temp[0][6];
assign temp[1][7]=offset[0]?temp[0][8]:temp[0][7];
assign temp[1][8]=offset[0]?temp[0][9]:temp[0][8];
assign temp[1][9]=offset[0]?temp[0][10]:temp[0][9];
assign temp[1][10]=offset[0]?temp[0][11]:temp[0][10];
assign temp[1][11]=offset[0]?temp[0][12]:temp[0][11];
assign temp[1][12]=offset[0]?temp[0][13]:temp[0][12];
assign temp[1][13]=offset[0]?temp[0][14]:temp[0][13];
assign temp[1][14]=offset[0]?temp[0][15]:temp[0][14];
assign temp[1][15]=offset[0]?temp[0][16]:temp[0][15];
assign temp[1][16]=offset[0]?temp[0][17]:temp[0][16];
assign temp[1][17]=offset[0]?temp[0][18]:temp[0][17];
assign temp[1][18]=offset[0]?temp[0][19]:temp[0][18];
assign temp[1][19]=offset[0]?temp[0][20]:temp[0][19];
assign temp[1][20]=offset[0]?temp[0][21]:temp[0][20];
assign temp[1][21]=offset[0]?temp[0][22]:temp[0][21];
assign temp[1][22]=offset[0]?temp[0][23]:temp[0][22];
assign temp[1][23]=offset[0]?temp[0][24]:temp[0][23];
assign temp[1][24]=offset[0]?temp[0][25]:temp[0][24];
assign temp[1][25]=offset[0]?temp[0][26]:temp[0][25];
assign temp[1][26]=offset[0]?temp[0][27]:temp[0][26];
assign temp[1][27]=offset[0]?temp[0][28]:temp[0][27];
assign temp[1][28]=offset[0]?temp[0][29]:temp[0][28];
assign temp[1][29]=offset[0]?temp[0][30]:temp[0][29];
assign temp[1][30]=offset[0]?temp[0][31]:temp[0][30];
assign temp[1][31]=offset[0]?sign:temp[0][31];
assign temp[2][0]=offset[1]?temp[1][2]:temp[1][0];
assign temp[2][1]=offset[1]?temp[1][3]:temp[1][1];
assign temp[2][2]=offset[1]?temp[1][4]:temp[1][2];
assign temp[2][3]=offset[1]?temp[1][5]:temp[1][3];
assign temp[2][4]=offset[1]?temp[1][6]:temp[1][4];
assign temp[2][5]=offset[1]?temp[1][7]:temp[1][5];
assign temp[2][6]=offset[1]?temp[1][8]:temp[1][6];
assign temp[2][7]=offset[1]?temp[1][9]:temp[1][7];
assign temp[2][8]=offset[1]?temp[1][10]:temp[1][8];
assign temp[2][9]=offset[1]?temp[1][11]:temp[1][9];
assign temp[2][10]=offset[1]?temp[1][12]:temp[1][10];
assign temp[2][11]=offset[1]?temp[1][13]:temp[1][11];
assign temp[2][12]=offset[1]?temp[1][14]:temp[1][12];
assign temp[2][13]=offset[1]?temp[1][15]:temp[1][13];
assign temp[2][14]=offset[1]?temp[1][16]:temp[1][14];
assign temp[2][15]=offset[1]?temp[1][17]:temp[1][15];
assign temp[2][16]=offset[1]?temp[1][18]:temp[1][16];
assign temp[2][17]=offset[1]?temp[1][19]:temp[1][17];
assign temp[2][18]=offset[1]?temp[1][20]:temp[1][18];
assign temp[2][19]=offset[1]?temp[1][21]:temp[1][19];
assign temp[2][20]=offset[1]?temp[1][22]:temp[1][20];
assign temp[2][21]=offset[1]?temp[1][23]:temp[1][21];
assign temp[2][22]=offset[1]?temp[1][24]:temp[1][22];
assign temp[2][23]=offset[1]?temp[1][25]:temp[1][23];
assign temp[2][24]=offset[1]?temp[1][26]:temp[1][24];
assign temp[2][25]=offset[1]?temp[1][27]:temp[1][25];
assign temp[2][26]=offset[1]?temp[1][28]:temp[1][26];
assign temp[2][27]=offset[1]?temp[1][29]:temp[1][27];
assign temp[2][28]=offset[1]?temp[1][30]:temp[1][28];
assign temp[2][29]=offset[1]?temp[1][31]:temp[1][29];
assign temp[2][30]=offset[1]?sign:temp[1][30];
assign temp[2][31]=offset[1]?sign:temp[1][31];
assign temp[3][0]=offset[2]?temp[2][4]:temp[2][0];
assign temp[3][1]=offset[2]?temp[2][5]:temp[2][1];
assign temp[3][2]=offset[2]?temp[2][6]:temp[2][2];
assign temp[3][3]=offset[2]?temp[2][7]:temp[2][3];
assign temp[3][4]=offset[2]?temp[2][8]:temp[2][4];
assign temp[3][5]=offset[2]?temp[2][9]:temp[2][5];
assign temp[3][6]=offset[2]?temp[2][10]:temp[2][6];
assign temp[3][7]=offset[2]?temp[2][11]:temp[2][7];
assign temp[3][8]=offset[2]?temp[2][12]:temp[2][8];
assign temp[3][9]=offset[2]?temp[2][13]:temp[2][9];
assign temp[3][10]=offset[2]?temp[2][14]:temp[2][10];
assign temp[3][11]=offset[2]?temp[2][15]:temp[2][11];
assign temp[3][12]=offset[2]?temp[2][16]:temp[2][12];
assign temp[3][13]=offset[2]?temp[2][17]:temp[2][13];
assign temp[3][14]=offset[2]?temp[2][18]:temp[2][14];
assign temp[3][15]=offset[2]?temp[2][19]:temp[2][15];
assign temp[3][16]=offset[2]?temp[2][20]:temp[2][16];
assign temp[3][17]=offset[2]?temp[2][21]:temp[2][17];
assign temp[3][18]=offset[2]?temp[2][22]:temp[2][18];
assign temp[3][19]=offset[2]?temp[2][23]:temp[2][19];
assign temp[3][20]=offset[2]?temp[2][24]:temp[2][20];
assign temp[3][21]=offset[2]?temp[2][25]:temp[2][21];
assign temp[3][22]=offset[2]?temp[2][26]:temp[2][22];
assign temp[3][23]=offset[2]?temp[2][27]:temp[2][23];
assign temp[3][24]=offset[2]?temp[2][28]:temp[2][24];
assign temp[3][25]=offset[2]?temp[2][29]:temp[2][25];
assign temp[3][26]=offset[2]?temp[2][30]:temp[2][26];
assign temp[3][27]=offset[2]?temp[2][31]:temp[2][27];
assign temp[3][28]=offset[2]?sign:temp[2][28];
assign temp[3][29]=offset[2]?sign:temp[2][29];
assign temp[3][30]=offset[2]?sign:temp[2][30];
assign temp[3][31]=offset[2]?sign:temp[2][31];
assign temp[4][0]=offset[3]?temp[3][8]:temp[3][0];
assign temp[4][1]=offset[3]?temp[3][9]:temp[3][1];
assign temp[4][2]=offset[3]?temp[3][10]:temp[3][2];
assign temp[4][3]=offset[3]?temp[3][11]:temp[3][3];
assign temp[4][4]=offset[3]?temp[3][12]:temp[3][4];
assign temp[4][5]=offset[3]?temp[3][13]:temp[3][5];
assign temp[4][6]=offset[3]?temp[3][14]:temp[3][6];
assign temp[4][7]=offset[3]?temp[3][15]:temp[3][7];
assign temp[4][8]=offset[3]?temp[3][16]:temp[3][8];
assign temp[4][9]=offset[3]?temp[3][17]:temp[3][9];
assign temp[4][10]=offset[3]?temp[3][18]:temp[3][10];
assign temp[4][11]=offset[3]?temp[3][19]:temp[3][11];
assign temp[4][12]=offset[3]?temp[3][20]:temp[3][12];
assign temp[4][13]=offset[3]?temp[3][21]:temp[3][13];
assign temp[4][14]=offset[3]?temp[3][22]:temp[3][14];
assign temp[4][15]=offset[3]?temp[3][23]:temp[3][15];
assign temp[4][16]=offset[3]?temp[3][24]:temp[3][16];
assign temp[4][17]=offset[3]?temp[3][25]:temp[3][17];
assign temp[4][18]=offset[3]?temp[3][26]:temp[3][18];
assign temp[4][19]=offset[3]?temp[3][27]:temp[3][19];
assign temp[4][20]=offset[3]?temp[3][28]:temp[3][20];
assign temp[4][21]=offset[3]?temp[3][29]:temp[3][21];
assign temp[4][22]=offset[3]?temp[3][30]:temp[3][22];
assign temp[4][23]=offset[3]?temp[3][31]:temp[3][23];
assign temp[4][24]=offset[3]?sign:temp[3][24];
assign temp[4][25]=offset[3]?sign:temp[3][25];
assign temp[4][26]=offset[3]?sign:temp[3][26];
assign temp[4][27]=offset[3]?sign:temp[3][27];
assign temp[4][28]=offset[3]?sign:temp[3][28];
assign temp[4][29]=offset[3]?sign:temp[3][29];
assign temp[4][30]=offset[3]?sign:temp[3][30];
assign temp[4][31]=offset[3]?sign:temp[3][31];
assign temp[5][0]=offset[4]?temp[4][16]:temp[4][0];
assign temp[5][1]=offset[4]?temp[4][17]:temp[4][1];
assign temp[5][2]=offset[4]?temp[4][18]:temp[4][2];
assign temp[5][3]=offset[4]?temp[4][19]:temp[4][3];
assign temp[5][4]=offset[4]?temp[4][20]:temp[4][4];
assign temp[5][5]=offset[4]?temp[4][21]:temp[4][5];
assign temp[5][6]=offset[4]?temp[4][22]:temp[4][6];
assign temp[5][7]=offset[4]?temp[4][23]:temp[4][7];
assign temp[5][8]=offset[4]?temp[4][24]:temp[4][8];
assign temp[5][9]=offset[4]?temp[4][25]:temp[4][9];
assign temp[5][10]=offset[4]?temp[4][26]:temp[4][10];
assign temp[5][11]=offset[4]?temp[4][27]:temp[4][11];
assign temp[5][12]=offset[4]?temp[4][28]:temp[4][12];
assign temp[5][13]=offset[4]?temp[4][29]:temp[4][13];
assign temp[5][14]=offset[4]?temp[4][30]:temp[4][14];
assign temp[5][15]=offset[4]?temp[4][31]:temp[4][15];
assign temp[5][16]=offset[4]?sign:temp[4][16];
assign temp[5][17]=offset[4]?sign:temp[4][17];
assign temp[5][18]=offset[4]?sign:temp[4][18];
assign temp[5][19]=offset[4]?sign:temp[4][19];
assign temp[5][20]=offset[4]?sign:temp[4][20];
assign temp[5][21]=offset[4]?sign:temp[4][21];
assign temp[5][22]=offset[4]?sign:temp[4][22];
assign temp[5][23]=offset[4]?sign:temp[4][23];
assign temp[5][24]=offset[4]?sign:temp[4][24];
assign temp[5][25]=offset[4]?sign:temp[4][25];
assign temp[5][26]=offset[4]?sign:temp[4][26];
assign temp[5][27]=offset[4]?sign:temp[4][27];
assign temp[5][28]=offset[4]?sign:temp[4][28];
assign temp[5][29]=offset[4]?sign:temp[4][29];
assign temp[5][30]=offset[4]?sign:temp[4][30];
assign temp[5][31]=offset[4]?sign:temp[4][31];

assign out=temp[5];

endmodule
