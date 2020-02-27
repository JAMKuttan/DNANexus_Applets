#!/bin/bash
# starfusion 0.0.1
# Generated by dx-app-wizard.
#
# Basic execution pattern: Your app will run on a single machine from
# beginning to end.
#
# Your job's input variables (if any) will be loaded as environment
# variables before this script runs.  Any array inputs will be loaded
# as bash arrays.
#
# Any code outside of main() (or any entry point you may add) is
# ALWAYS executed, followed by running the entry point itself.
#
# See https://documentation.dnanexus.com/developer for tutorials on how
# to modify this file.

main() {

    echo "Value of fusion: '$fusion'"
    echo "Value of pairs: '$pairs'"
    echo "Value of trimread1: '$trimread1'"
    echo "Value of trimread2: '$trimread2'"


    dx download "$trimread1" -o fq1
    dx download "$trimread2" -o fq2
		dx download "$reference" -o reference.tar.gz
		dx download "$agfusiondb" -o agfusiondb.gz

		tar xvfz reference.tar.gz
		tar svfz agfusiondb.gz

		docker run -v {JERMEY MAGIC} bash /usr/local/bin/starfusion.sh -p ${pair_id} -r reference -a fq1 -b fq2 -m trinity -f	

    fusionout=$(dx upload fusionout --brief)

    dx-jobutil-add-output fusionout "$fusionout" --class=file
}
