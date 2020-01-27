#!/bin/bash


mkdir hmm5
HHEd -H hmm4/macros -H hmm4/hmmdefs -M hmm5 sil.hed monophones1

mkdir hmm6
HERest -C config -I testprompts.phones.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm5/macros -H hmm5/hmmdefs -M hmm6 monophones1

mkdir hmm7
HERest -C config -I testprompts.phones.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm6/macros -H hmm6/hmmdefs -M hmm7 monophones1

HVite -l '*' -o SWT -b SILENCE -C config -a -H hmm7/macros -H hmm7/hmmdefs -i aligned.mlf -m -t 250.0 -y lab -I testprompts.mlf -S train.scp dict1 monophones1

mkdir hmm8
HERest -C config -I aligned.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm7/macros -H hmm7/hmmdefs -M hmm8 monophones1

mkdir hmm9
HERest -C config -I aligned.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm8/macros -H hmm8/hmmdefs -M hmm9 monophones1

HLEd -n triphones1 -l '*' -i wintri.mlf mktri.led aligned.mlf

---

mkdir hmm10
Hhed -B -H hmm9/macros -H hmm9/hmmdefs -M hmm10 mktri.hed monophones1

mkdir hmm11
HERest -C config -I wintri.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm10/macros -H hmm10/hmmdefs -M hmm11 triphones1

mkdir hmm12
HERest -C config -I wintri.mlf -t 250.0 150.0 1000.0 -s stats -S train.scp -H hmm11/macros -H hmm11/hmmdefs -M hmm12 triphones1

HHEd -B -H hmm12/macros -H hmm12/hmmdefs -M hmm13 tree.hed triphones1 > log

HVite -C config -H hmm3/macros -H hmm3/hmmdefs -S test.scp -l * -I result.mlf -w wdnet -p 0.0 -s 5.0 dict monophones1