#!/usr/bin/env nextflow

// Enable DSL2 for modular workflows
nextflow.enable.dsl=2

Channel.fromPath(params.assemblies)
    .set {assemblies}

process EZCLERMONT {    
    tag "${assembly.baseName}"

    container 'nickp60/ezclermont'

    publishDir "./ezclermont" , mode: 'copy'

    input:
        path(assembly)

    output:
        path("*_ezclermont.txt")

    script:
    """
    ezclermont ${assembly} > ${assembly.baseName}_ezclermont.txt
    """
}

workflow {
    EZCLERMONT(assemblies)
}
