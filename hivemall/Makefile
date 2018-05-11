all: preprocess

preprocess:
	../utils/count.py ../tr.csv > fc.trva.t10.txt
	../converters/parallelizer-b.py -s 10 ../converters/pre-b.py ../tr.csv tr.ffm
	../converters/change_format.py tr.ffm tr.ffm.formatted
	mv tr.ffm.formatted tr.ffm
	../converters/split.py tr.ffm tr.sp va.sp

clean:
	rm -f fc.trva.t10.txt *.ffm* *.sp*
