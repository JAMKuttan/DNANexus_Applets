#!/bin/bash
# rnaalign 0.5.28
# Generated by dx-app-wizard.

main() {

    dx download "$fq1" -o ${pair_id}.trim.R1.fastq.gz
    dx download "$fq2" -o ${pair_id}.trim.R2.fastq.gz
    dx download "$reference" -o rnaref.tar.gz

    mkdir rnaref
    tar -I pigz -xvf rnaref.tar.gz --strip-components=1 -C rnaref

    umiopt=""
    if [[ ${mdup} == 'fgbio_umi' ]]
    then
	umiopt=" -u"
    fi
    
    docker run -v ${PWD}:/data docker.io/goalconsortium/ralign:0.5.28 -a ${aligner} -p ${pair_id} -r rnaref -x ${pair_id}.trim.R1.fastq.gz -y ${pair_id}.trim.R2.fastq.gz $umiopt

    bam=$(dx upload ${pair_id}.bam --brief)
    bai=$(dx upload ${pair_id}.bam.bai --brief)
    alignstats=$(dx upload ${pair_id}.alignerout.txt --brief)

    dx-jobutil-add-output bam "$bam" --class=file
    dx-jobutil-add-output bai "$bai" --class=file
    dx-jobutil-add-output alignstats "$alignstats" --class=file
}
