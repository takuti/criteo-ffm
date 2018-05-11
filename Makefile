all: ffm-train ffm-predict

ffm-train:
	make -C libffm
	ln -sf libffm/ffm-train

ffm-predict:
	make -C libffm
	ln -sf libffm/ffm-predict

clean:
	rm -f ffm-train ffm-predict fc.trva.t10.txt *.ffm* *.sp* *.out model
	make -C libffm clean
