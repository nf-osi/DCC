import synapseclient
from synapseclient import Project, Folder, File, Link, Wiki

syn = synapseclient.Synapse()
syn = synapseclient.login()

# name project, and add wiki content; wiki markdown goes in between triple quotes
projectName = 'Add Project Name'

content = """
# Project Title

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