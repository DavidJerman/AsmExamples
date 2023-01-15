file=$(basename $1)
file=$(echo $file | grep -o -E ".+\.")
file=${file::-1}
nasm -f elf64 $file.asm -o $file.o && gcc $file.o -lc -fPIC -no-pie; ./a.out
rm $file.o 2> /dev/null
rm a.out 2> /dev/null
