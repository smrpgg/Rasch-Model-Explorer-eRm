<img width="851" height="315" alt="Untitled design" src="https://github.com/user-attachments/assets/6d7d9902-3e22-468d-bddb-6f35373265fe" />

# Rasch Model Explorer (Shiny + eRm)

An interactive Shiny application for exploring the Rasch model using the 'eRm' package in R.  
The app allows users to upload binary response data and visualize core components of Rasch analysis.

## Live app:  

## Features

- Interactive Item Characteristic Curves (ICC)
- Item difficulty estimates from the Rasch model
- Person–Item map (Wright map) visualization
- Upload your own binary response dataset (0/1)
The Rasch model is estimated using Conditional Maximum Likelihood (CML) implemented in the eRm package.

## Rasch Model
The probability of a correct response is defined as:

P(X = 1 | θ, β) = 1 / (1 + exp(-(θ − β)))

where  
θ = person ability  
β = item difficulty

Higher values of β correspond to more difficult items.

## Important Implementation Detail
The eRm package estimates k − 1 item parameters due to the Rasch model identification constraint.  
The first item difficulty is recovered using the sum‑to‑zero constraint:
β₁ = −∑ᵢ₌₂ᵏ βᵢ
This ensures the full set of item difficulty parameters can be visualized correctly.

## Example Data
An example dataset is included (listening_test.csv) that can be uploaded directly into the app to test the functionality.
The dataset contains simulated Rasch responses for multiple items.

## Running the App Locally
Install required packages:
install.packages(c("shiny", "eRm", "ggplot2", "bslib"))
Run the application:
shiny::runApp()


## Project Structure
app.R
example-data.csv
README.md
screenshots/


## Packages Used
- shiny
- eRm
- ggplot2
- bslib
