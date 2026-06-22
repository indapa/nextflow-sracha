#!/usr/local/bin/nextflow

nextflow.enable.dsl=2

include { SRACHA_GET } from './modules/sracha'

def required_params = ['samplesheet']

for (param in required_params) {
    if (!params[param]) {
        error "Parameter '$param' is required!"
    }
} 

input_ch = Channel.fromPath(file(params.samplesheet, checkIfExists: true))
    .splitCsv(header: true)
    .map { row ->
        tuple(row.accesion, row.experiment)
    }

workflow {
    SRACHA_GET(input_ch)
}


