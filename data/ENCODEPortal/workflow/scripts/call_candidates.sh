#! bin/bash 

input_file=$1
chrom_sizes=$2
regions_blacklist=$3
regions_whitelist=$4
peakExtend=$5
nStrongest=$6
datadir=$7
outdir=$8
code_dir=$9

while read p;
do
	a=($p)
	echo ${a[0]} ${a[1]}
	bedtools sort -faidx $chrom_sizes -i $outdir/Peaks_${a[0]}/NA_peaks.narrowPeak > $outdir/Peaks_${a[0]}/NA_peaks.narrowPeak.sorted
	python $code_dir/src/makeCandidateRegions.py --narrowPeak $outdir/Peaks_${a[0]}/NA_peaks.narrowPeak.sorted --bam $datadir/${a[1]} --outDir $outdir/Peaks_${a[0]} --chrom_sizes $chrom_sizes --regions_blacklist $regions_blacklist --regions_whitelist $regions_whitelist --peakExtendFromSummit $peakExtend --nStrongestPeaks $nStrongest --genome_tss $regions_whitelist
	#macs2 callpeak -f BAM -g hs -p $pvalue --call-summits --outdir $outdir/Peaks_${a[0]} -t $input_dir/${a[1]}
done < $input_file
