
str="Hello World"
count=$(echo $str | grep -o '[A-Z]' | wc -l)

echo "The string '$str' contains $count uppercase characters."

