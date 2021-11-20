library(reticulate)
use_condaenv("r-reticulate", required = T)
synapse <- import('synapseclient')
syn <- synapse$Synapse()
syn$login()

# name project, and add wiki content; wiki markdown goes in between triple quotes
projectName <- 'Insert Project Title Here'

content <- glue::glue("
# {projectName}
## Initiative and/or Funder Info

### Principal Investigator: Insert PI name here
### Project Lead / Data Coordinator: Insert Data Coordinator name here
### Institution: Insert Institution name here

### Project Description: 
Insert Project Abstract here
")

project <- synapse$Project(projectName)
project <- syn$store(project)

wiki <- synapse$Wiki(owner=project,
            title=projectName,
            markdown=content)

wiki <- syn$store(wiki)

# name and create folders
data_folder1 = synapse$Folder('Analysis', parent=project)
data_folder1 = syn$store(data_folder1)
data_folder2 = synapse$Folder('Milestone Reports', parent=project)
data_folder2 = syn$store(data_folder2)
data_folder3 = synapse$Folder('Raw Data', parent=project)
data_folder3 = syn$store(data_folder3)


# set NF-OSI Sage Team permissions; currently sets to full admin
NFsharing <- syn$setPermissions(entity=project, 
                               principalId=3378999, 
                               accessType=list('DELETE', 'CHANGE_SETTINGS', 'MODERATE', 'CREATE', 'READ','DOWNLOAD', 'UPDATE', 'CHANGE_PERMISSIONS'))

# grant Funding partner team Admin permissions by uncommenting the line for the funder for this project
#funder <- 3359657 ##CTF team
#funder <- 3406072 ##GFF Admin team
#funder <- 3331266 ##NTAP Admin team

FunderSharing <- syn$setPermissions(entity=project, 
                               principalId=funder, 
                               accessType=list('DELETE', 'CHANGE_SETTINGS', 'MODERATE', 'CREATE', 'READ','DOWNLOAD', 'UPDATE', 'CHANGE_PERMISSIONS'))

# add Project Files and Metadata fileview, add NF schema; currently doesn't add facets
view <- synapse$EntityViewSchema(name="Project Files and Metadata",
                        columns=list(
                          synapse$Column(name="assay", columnType="STRING", maximumSize="57"),
                          synapse$Column(name="consortium", columnType="STRING", maximumSize="24"),
                          synapse$Column(name="dataSubtype", columnType="STRING", maximumSize="13"),
                          synapse$Column(name="dataType", columnType="STRING", maximumSize="30"),
                          synapse$Column(name="diagnosis", columnType="STRING", maximumSize="39"),
                          synapse$Column(name="tumorType", columnType="STRING", maximumSize="90"),
                          synapse$Column(name="fileFormat", columnType="STRING", maximumSize="13"),
                          synapse$Column(name="fundingAgency", columnType="STRING", maximumSize="12"),
                          synapse$Column(name="individualID", columnType="STRING", maximumSize="213"),
                          synapse$Column(name="nf1Genotype", columnType="STRING", maximumSize="8"),
                          synapse$Column(name="nf2Genotype", columnType="STRING", maximumSize="7"),
                          synapse$Column(name="species", columnType="STRING", maximumSize="15"),
                          synapse$Column(name="resourceType", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="isCellLine", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="isMultiSpecimen", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="isMultiIndividual", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="studyId", columnType="ENTITYID"),
                          synapse$Column(name="studyName", columnType="LARGETEXT"),
                          synapse$Column(name="specimenID", columnType="STRING", maximumSize="300"),
                          synapse$Column(name="sex", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="age", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="readPair", columnType="INTEGER"),
                          synapse$Column(name="progressReportNumber", columnType="INTEGER"),
                          synapse$Column(name="accessType", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="accessTeam", columnType="USERID"),
                          synapse$Column(name="cellType", columnType="STRING", maximumSize="300"),
                          synapse$Column(name="modelOf", columnType="STRING", maximumSize="50"),
                          synapse$Column(name="compoundName", columnType="STRING", maximumSize="156"),
                          synapse$Column(name="experimentalCondition", columnType="STRING", maximumSize="58"),
                          synapse$Column(name="modelSystemName", columnType="STRING", maximumSize="42"),
                          synapse$Column(name="isXenograft", columnType="STRING", maximumSize="5"),
                          synapse$Column(name="transplantationType", columnType="STRING", maximumSize="50")),
                        parent=project,
                        scopes=project,
                        includeEntityTypes=list(synapse$EntityViewType$FILE),
                        add_default_columns=TRUE)
view <- syn$store(view)

# takes you to Synapse project website; uncomment to activate
# seeProjectInBrowser <- syn$onweb(project)


#TODO: add snippet to add the project to the Portal Files view scope
#TODO: add snippet to add the project to the Portal Studies table as a row
