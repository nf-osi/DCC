import synapseclient
from synapseclient import Project, Folder, File, Link, Wiki, Schema, Column, Table, Row, RowSet, as_table_columns, EntityViewSchema, EntityViewType

syn = synapseclient.Synapse()
syn = synapseclient.login()

# name project, and add wiki content; wiki markdown goes in between triple quotes
projectName = 'Add Project Name'

content = """
# Project Title
## Initiative and/or Funder Info

### Principal Investigator: 
### Project Lead / Data Coordinator:
### Institution: 

### Project Description: 
This is **test** wiki content. 
"""
project = Project(projectName)
project = syn.store(project)

wiki = Wiki(owner=project,
            title=projectName,
            markdown=content)

wiki = syn.store(wiki)

# name and create folders
data_folder1 = Folder('Analysis', parent=project)
data_folder1 = syn.store(data_folder1)
data_folder2 = Folder('Milestone Reports', parent=project)
data_folder2 = syn.store(data_folder2)
data_folder3 = Folder('Raw Data', parent=project)
data_folder3 = syn.store(data_folder3)


# set NF-OSI team permissions; currently sets to can edit & delete, want full admin
NFsharing = syn.setPermissions(entity=project, 
                             principalId=3378999, 
                             accessType=['DELETE', 'CHANGE_SETTINGS', 'MODERATE', 'CREATE', 'READ','DOWNLOAD', 'UPDATE', 'CHANGE_PERMISSIONS'])

# set funder team permissions; currently sets to can edit & delete, want full admin
fundersharing = syn.setPermissions(entity=project, 
                             principalId=Add, 
                             accessType=['DELETE', 'CHANGE_SETTINGS', 'MODERATE', 'CREATE', 'READ','DOWNLOAD', 'UPDATE', 'CHANGE_PERMISSIONS'])

# add Project Files and Metadata fileview, add NF schema; currently doesn't add facets
view = EntityViewSchema(name="Project Files and Metadata",
                        columns=[
                            Column(name="assay", columnType="STRING", maximumSize="57"),
                            Column(name="consortium", columnType="STRING", maximumSize="24"),
                            Column(name="dataSubtype", columnType="STRING", maximumSize="13"),
                            Column(name="dataType", columnType="STRING", maximumSize="30"),
                            Column(name="diagnosis", columnType="STRING", maximumSize="39"),
                            Column(name="tumorType", columnType="STRING", maximumSize="90"),
                            Column(name="fileFormat", columnType="STRING", maximumSize="13"),
                            Column(name="fundingAgency", columnType="STRING", maximumSize="12"),
                            Column(name="individualID", columnType="STRING", maximumSize="213"),
                            Column(name="nf1Genotype", columnType="STRING", maximumSize="8"),
                            Column(name="nf2Genotype", columnType="STRING", maximumSize="7"),
                            Column(name="species", columnType="STRING", maximumSize="15"),
                            Column(name="resourceType", columnType="STRING", maximumSize="50"),
                            Column(name="isCellLine", columnType="STRING", maximumSize="50"),
                            Column(name="isMultiSpecimen", columnType="STRING", maximumSize="50"),
                            Column(name="isMultiIndividual", columnType="STRING", maximumSize="50"),
                            Column(name="studyId", columnType="ENTITYID"),
                            Column(name="studyName", columnType="LARGETEXT"),
                            Column(name="specimenID", columnType="STRING", maximumSize="300"),
                            Column(name="sex", columnType="STRING", maximumSize="50"),
                            Column(name="age", columnType="STRING", maximumSize="50"),
                            Column(name="readPair", columnType="INTEGER"),
                            Column(name="reportMilestone", columnType="INTEGER"),
                            Column(name="accessType", columnType="STRING", maximumSize="50"),
                            Column(name="accessTeam", columnType="USERID"),
                            Column(name="cellType", columnType="STRING", maximumSize="300"),
                            Column(name="modelOf", columnType="STRING", maximumSize="50"),
                            Column(name="compoundName", columnType="STRING", maximumSize="156"),
                            Column(name="experimentalCondition", columnType="STRING", maximumSize="58"),
                            Column(name="modelSystemName", columnType="STRING", maximumSize="42"),
                            Column(name="isXenograft", columnType="STRING", maximumSize="5"),
                            Column(name="transplantationType", columnType="STRING", maximumSize="50")],
                        parent=project,
                        scopes=project,
                        includeEntityTypes=[EntityViewType.FILE],
                        add_default_columns=True)
view = syn.store(view)

# immediately takes you to Synapse project website; uncomment to activate
# seeProjectInBrowser = syn.onweb(project)