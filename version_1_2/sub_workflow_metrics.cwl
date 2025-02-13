###############################################################################################
# This workflow will align reads from a fastq file and print statistics for a SAM
# file to another file

###############################################################################################
#
cwlVersion: v1.2

# See documentation here https://www.commonwl.org/user_guide/

# The cwlVersion field indicates the version of the CWL spec used by the document.
# The class field indicates this document describes a workflow.
class: Workflow

label: A workflow that aligns a fasta file and provides statistics on the SAM file
doc: A workflow that aligns a fasta file and provides statistics on the SAM file

# Metadata about the tool or workflow itself (for example, authorship for use in citations)
# may be provided as additional fields on any object
# Once you add the namespace prefix, you can access it anywhere in the document as shown
# below. Otherwise one must use full URLs.
$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu

# Top level inputs and outputs of the workflow are described in the inputs and outputs fields respectively.

# The inputs section describes the inputs of the workflow.
# This is a list of input parameters where each parameter consists of an identifier
# and a data type.
# These parameters can be used as sources for input to specific workflows steps.
inputs:
    input_sam: File

# The outputs section describes the outputs of the workflow. This is a list of output
# parameters where each parameter consists of an identifier and a data type.
outputs:
  output_metrics:
    type: File
    outputSource: flagstat/metrics

requirements:
  SubworkflowFeatureRequirement: {}


# The steps section describes the actual steps of the workflow.
# Each step in a workflow must have its own CWL description.
# Workflow steps are not necessarily run in the order they are listed, instead
# the order is determined by the dependencies between steps (using source). In
# addition, workflow steps which do not depend on one another may run in parallel.
steps:
  flagstat:
    run: {"$import": "samtools/metrics.cwl"}
    in:
      input_sam: input_sam
    out: [metrics]

