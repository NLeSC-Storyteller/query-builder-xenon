# Should make a command similar to:
# java 
#   -Xmx2000m 
#   -cp "/src/StoryTeller/target/StoryTeller-v1.0-jar-with-dependencies.jar" \
#   vu.cltl.storyteller.json.JsonMakeStoryFromTripleData $QUERY \
#   --ks-limit $LIMIT \
#   --ks-service http://130.37.53.35:50053 \
#   --log \
#   --token-index /data/token.index.gz \
#   --eurovoc /src/vua-resources/mapping_eurovoc_skos.label.concept.gz \
#   1> /data/1.json \
#   2> /data/1.err

# java -Xmx2000m -cp "StoryTeller-v1.0-jar-with-dependencies.jar" vu.cltl.storyteller.json.JsonMakeStoryFromTripleData --entityType "http://dbpedia.org/ontology/Medicine;" --ks-limit 100 --ks-service http://130.37.53.82:50053 --log --token-index token.index.gz --eurovoc mapping_eurovoc_skos.label.concept.gz

cwlVersion: v1.0
class: CommandLineTool
baseCommand: java
arguments: ["-Xmx2000m"]
stdout: output.json 
stderr: stderr.txt 
inputs: 
  - id: ksQuery
    type: string
    doc: The KnowledgeStore query input string.
    inputBinding:
      position: 2
      prefix: vu.cltl.storyteller.json.JsonMakeStoryFromTripleData
  - id: ksQuerylimit
    type: int
    default: 5000
    doc: The maximum number of results.
    inputBinding:
      position: 3
      prefix: --ks-limit
  - id: classpath
    type: File
    doc: The JAR file "StoryTeller-v1.0-jar-with-dependencies.jar"
    inputBinding:
      position: 1
      prefix: -cp
  - id: ksServer
    type: string
    default: KNOWLEDGE_STORE_SERVER_URL
    doc: The Knowledge Store Server address
    inputBinding:
      position: 4
      prefix: --ks-service      
  - id: logging
    type: boolean
    doc: Enable logging of the query. Default true.
    default: true
    inputBinding:
      position: 5
      prefix: --log
  - id: tokenIndex
    type: File
    doc: The token index file.
    default: /data/token.index.gz
    inputBinding:
      position: 6
      prefix: --token-index
  - id: eurovoc
    type: File
    doc: The eurovoc mapping file.
    inputBinding:
      position: 7
      prefix: --eurovoc
  - id: outputname
    type: string
    default: output.json
    inputBinding:
      position: 8
      prefix: --out

outputs:
  - id: out
    type: stdout
  - id: err
    type: stderr
  - id: log
    type: File
    outputBinding:
      glob: log
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.outputname)

#stdout: $(runtime.outdir + '/' + inputs.id + '.json')
#stderr: $(runtime.outdir + '/' + inputs.id + '.err')
