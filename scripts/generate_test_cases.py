import sys

steps = int(sys.argv[1])
rows = int(sys.argv[2])
cols = int(sys.argv[3])
out = sys.argv[4]

f = open(out, "w")

x = [0] * cols

f.write(str(steps) + "\n")
f.write(str(rows) + "\n")
f.write(str(cols) + "\n")

for _ in range(rows):
    f.write(' '.join(str(i) for i in x))
    f.write("\n")

f.write("0\n")
