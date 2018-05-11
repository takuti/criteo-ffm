all: ffm-train ffm-predict

ffm-train:
	make -C solvers/libffm-1.13
	ln -sf solvers/libffm-1.13/ffm-train

ffm-predict:
	make -C solvers/libffm-1.13
	ln -sf solvers/libffm-1.13/ffm-predict

clean:
	rm -f ffm-train ffm-predict fc.trva.t10.txt *.ffm* *.out model
	make -C solvers/libffm-1.13 clean
