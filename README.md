Getting-and-Cleaning-Data-Course-Project
========================================
This repo contains project code for `Getting and Cleaning Data` course given by John Hopkins university on Coursera.

### Overview

The goal of this project is to take a dataset from the web, manipulate, add descriptions and produce
a compact, tidy dataset that can be used for later analysis. 

The data was collected from the accelerometers from the Samsung Galaxy S smartphone for the purpose of activity recognition. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

Included in this repo are:

* run_analysis.R - the main script from producing the tidy data set
* codebook.md - descibes the original dataset, the variables in the tidy data set and transformations used to obtain them
* tidy_data.txt (not required but here in case of online submission problems)

### Styles

I follow the [Google Style Guide](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#identifiers) when it comes to variable naming.

    Don't use underscores ( _ ) or hyphens ( - ) in identifiers. 
    Identifiers should be named according to the following conventions. 
    The preferred form for variable names is all lower case letters and words separated with dots (variable.name), 
    but variableName is also accepted; function names have initial capital letters and no dots (FunctionName); 
    constants are named like functions but with an initial k. 

This is somewhat at odds with the style laid out by Prof. Leek, but as many others have pointed out, other naming
conventions are more widely preferred in by the community.

So I have chosen to name variables using all lower case letters with words separated by dots.

For example, `freq.body.gyro.mean.z.averaged`