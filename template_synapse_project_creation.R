### Project Creation Template script

library(synapser)
library(glue)
synLogin()

############# Input project description ###########
projectName <- "{write project name here}"

# manually add in content using markdown syntax (may be helpful to use Synapse forms in the future)
content <- "
## This is my project
## Subgroup: 
Research subgroup
##Principal Investigator: 
John Doe
##Technical Abstract
"
############# Create the project on Synapse (behind the scenes) #########
project <- Project(projectName)
project <- synStore(project)
wiki <- Wiki(owner = project,
             title = projectName,
             markdown = content)
wiki <- synStore(wiki)
dataFolder1 <- Folder("Raw Data", parent = project)
dataFolder1 <- synStore(dataFolder1)
dataFolder2 <- Folder("Analysis", parent = project)
dataFolder2 <- synStore(dataFolder2)
dataFolder3 <- Folder("Milestone Reports", parent = project)
dataFolder3 <- synStore(dataFolder3)

############# View the web version of the project created ######## 

# Robert suggested:
id <- project$properties$id
browseURL(glue::glue("https://www.synapse.org/#!Synapse:{id}"))
