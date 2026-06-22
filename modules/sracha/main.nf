
process SRACHA_GET {

    tag "$accession"

    errorStrategy 'retry'
    maxRetries 2

    cpus { 4 * task.attempt }
    memory { 8.GB * task.attempt }

    publishDir "${params.outdir}/${experiment}/${accession}", mode: 'copy', overwrite: true

    container 'quay.io/biocontainers/sracha:0.3.10--h54198d6_0'

    input:
    tuple val(accession), val(experiment)

    output:
        tuple val(accession), path("*.fastq.gz")
    
    script:

    """
    sracha get ${accession} 
    """

    stub:
    """
    touch ${accession}_1.fastq.gz
    touch ${accession}_2.fastq.gz
    """
}