set -e

buildpage () {
	IN=$1
	CATEGORY=$2
	NAME=`basename -s .md $FILE`
	OUT=./man/$CATEGORY/$NAME.html
	TITLE="$NAME($CATEGORY)"
	
	cat doc.head.html > $OUT
	pandoc -f markdown -t html < $IN >> $OUT
	cat doc.tail.html >> $OUT
	sed -i "s/{{TITLE}}/$TITLE/g" $OUT
}

if test -e ./man
then
	rm -rf ./man
fi

mkdir ./man

for CATEGORY in `ls $GOPATH/src/github.com/buppyio/bpy/doc/man/`
do
	mkdir ./man/$CATEGORY/
	for FILE in $GOPATH/src/github.com/buppyio/bpy/doc/man/$CATEGORY/*.md
	do
		buildpage $FILE $CATEGORY
	done
done
