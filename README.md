# Rasch Model Explorer (Shiny + eRm)

An interactive Shiny application for exploring the Rasch model using the eRm package in R.  
The app allows users to upload binary response data and visualize core components of Rasch analysis.

## Live app:  
https://smrpgg.shinyapps.io/rasch-model-explorer-erm/

## Features

- Interactive Item Characteristic Curves (ICC)
- Item difficulty estimates from the Rasch model
- Person–Item map (Wright map) visualization
- Upload your own binary response dataset (0/1)

The Rasch model is estimated using Conditional Maximum Likelihood (CML) implemented in the eRm package.

## Rasch Model

The probability of a correct response is defined as:
