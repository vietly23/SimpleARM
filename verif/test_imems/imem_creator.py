import argparse

if __name__ == '__main__':
    my_args = argparse.ArgumentParser()
    my_args.add_argument('-f', '--file', type=str, help="Disassembly file")
    args = my_args.parse_args()
    f = open('newtb_mem.sv',mode='w')
    print('module newtb_mem(input logic [31:0] a, output logic [31:0] rd);',
          file=f)
    instructions = []
    with open(args.file, mode='r') as rf:
        for line in rf:
            if len(line) < 10:
                continue
            a = line.split()
            if len(a) < 3:
                continue
            if len(a[2]) != 8 or 'R' in a[2] or ',' in a[2]:
                continue
            instructions.append(a[2])
    print('logic [31:0] RAM[{}:0];'.format(len(instructions) - 1), file=f)
    for i,x in enumerate(instructions):
        print("assign RAM[{}] = 32'h{};".format(i,x), file=f)
    print('assign rd = RAM[a[31:2]];', file=f);
    print('endmodule', file=f)
    f.close()
