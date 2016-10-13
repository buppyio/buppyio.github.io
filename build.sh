set -e

for FILE in $GOPATH/src/github.com/buppyio/bpy/doc/*.md
do
    OUT=`basename -s .md $FILE`.html
    cat doc.head.html > $OUT
    pandoc -f markdown -t html < $FILE >> $OUT
    cat doc.tail.html >> $OUT
    
    TITLE=`basename $FILE | sed 's/.\([0-9]\).md/(\1)/g'`
    sed -i "s/{{TITLE}}/$TITLE/g" $OUT
done
