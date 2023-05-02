dir=`ls -d x_* | head -n 1`
head -n 1 $dir/data.tsv > data_last_all.tsv
tail -qn 1 x_*/data.tsv >> data_last_all.tsv
