Nextflow pipeline to download data from [NCBI Sequence Read Archive](https://www.ncbi.nlm.nih.gov/sra) with 
[sracha-rs](https://github.com/rnabioco/sracha-rs)

Easiest way is to run this pipeline on [Seqera Platform](https://github.com/rnabioco/sracha-rs)


## Example Samplsheet

```
accession,experiment
ERR14732850,ERX14134275
```

## Example execution

Need to provide samplesheet and outdir parameters:

```
nextflow run main.nf --samplesheet test.sra.ss.csv --outdir path/to/results 
```