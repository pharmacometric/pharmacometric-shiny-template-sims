# <img src="www/logo.jpg"> Standardized R shiny template for PK/PD/QSP simulations

<img src="www/preview2.png">


__Sampled deployed template__: https://pharmacometric.shinyapps.io/pharmacometric-shiny-template/

Standardizing R scripts used to create shiny dashboards for reporting scientific findings, doing simulations and estimation, and regulatory submissions is important for several reasons. It allows pharmacometricians in different organizations and companies to share and reuse code more easily. 

Standardized scripts reduce redundancy and ensure consistency in how results are presented. This becomes critical when dashboards are used for regulatory purposes, to demonstrate reproducibility and reliability of analyses to agencies. Standard templates and conventions in the scripts also help train new practitioners more efficiently. They act as a guide for best practices in dashboard design and formatting results. This is beneficial given the growth of data-driven applications like shiny. 

Standardization facilitates collaborations between researchers by providing a common framework and language for developing interactive analyses and visualizations. Overall, it improves the rigor, transparency and quality of pharmacometrics work that uses interactive reporting tools.


### Usage 
```r

# Download and unzip the content of this repository
# Set working directory to the unzipped folder
setwd("pharmacometric-shiny-template")

# Load shiny and run app
library(shiny)
runApp()

```

### Features

The following features are available in the current template for you to get started.

 - __User customizable interface__. This means the user can move around the panels to desired locations on the screen. They may also change the title and color of the panels to suite their needs. 
 - __Panel location and features saved across sessions__. This means that after re-arrangement of panels, changing panel colors or titles, one may refresh the page and the settings are retained.
 - __Resizable Panels__. Panels are resizable to allow easy focus on specific contents, like plots or tables of result.
 - __Simulation inputs are already setup__. Input fields for setting up simulations, and regimen table for building regimen to compare groups are already set-up and configured in the server 
 - __Auto detection of parameters and creation of inputs__. Parameters within the mrgsolve file will be automatically detected and input fields will be created for them to allow the user to vary them.
 - __Plot creation is configured__. Simulation results will be used to create plots. Settings for plots can be toggled using the cog symbol on the right side of the plot panel. 
 - __Summary of results and raw output__. The results are configured to be automatically summarized to obtain key PK parameters, as well as provide access to raw data outputs.
 - __Configured for speed__. Continued effort is being made to improve the template to ensure great speed and performance for simulation apps.
 - __Aesthetics for completion__. App title are formatted to look professional. A sample icon is also provided, which may be replaced when updating the template to suit your need.
 
 
 
### Issues

If you have issues or questions, create an 'issue' or contribute to one within the issue tab of this github repository


### Contributors

Contributors interact with the project on GitHub by filing new issues, improving existing issues, or submitting pull requests. Anyone can become a contributor, which means there is no expectation of commitment to the project, no required set of skills, and no selection process.
