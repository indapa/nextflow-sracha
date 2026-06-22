process SRACHA_GET {
    tag "$experiment/$accession"

    errorStrategy 'retry'
    maxRetries 2

    cpus { 4 * task.attempt }
    memory { 8.GB * task.attempt }

    publishDir "${params.outdir}/${experiment}/${accession}", mode: 'copy', overwrite: true

    // Point this directly to your new Docker Hub image
    container 'indapa/my-sracha:latest'

    input:
    tuple val(experiment), val(accession)

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