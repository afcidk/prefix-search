#!/usr/bin/python3

########################################################
# simple script to generate test file for benchmarking #
########################################################


if __name__ == '__main__':
    with open("cities.txt", "r") as f:
        lines = f.readlines()
    
    arr = []
    for line in lines:
        arr += [i.strip() for i in line.split(",")]
    
    total = 15000  # number of cities to output
    cnt = 0
    
    with open("tinput.txt", "w") as f:
        for st in arr:
            if len(st) >= 3:
                f.write(st[:3] + '\n') # only leave first three characters for prefix-search
                cnt += 1
                if cnt == total:
                    break

