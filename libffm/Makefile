all: ffm-train ffm-predict

ffm-train:
	make -C solver
	ln -sf solver/ffm-train

ffm-predict:
	make -C solver
	ln -sf solver/ffm-predict

clean:
	rm -f ffm-train ffm-predict *.ffm.bin *.sp.bin
	make -C solver clean
