set -e

buildpage () {
	input=$1
	category=$2
	name=`basename -s .md $input`
	output=./man/$category/$name.html
	title="$name($category)"
	
	(cat doc.head.html
	 sed -r 's,([a-z_]+)\(([0-9])\),[\1(\2)](/man/\2/\1.html),g' $input | pandoc -f markdown -t html
	 cat doc.tail.html) |
	sed "s/{{TITLE}}/$title/g" > $output
}

if test -e ./man
then
	rm -rf ./man
fi

mkdir ./man

for category in `ls $GOPATH/src/github.com/buppyio/bpy/doc/man/`
do
	mkdir ./man/$category/
	for file in $GOPATH/src/github.com/buppyio/bpy/doc/man/$category/*.md
	do
		buildpage $file $category
	done
done
