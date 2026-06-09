<img width="1279" height="430" alt="Untitled-2" src="https://github.com/user-attachments/assets/0b126725-262f-4b69-b629-24db2a1686e2" />

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


## Packages Used
- shiny
- eRm
- ggplot2
- bslib


<table border="3">
<tr>
<td><img src="https://github.com/user-attachments/assets/1b397d78-8573-4c4d-a21e-c931fad8f8f1" width="350"></td>
<td><img src="https://github.com/user-attachments/assets/50b24fb4-6fa6-4dc2-a2a4-dca7449e34e4" width="350"></td>
<tr>
<td><img src="https://github.com/user-attachments/assets/e5e0d58c-7ff5-40b4-a8e3-3afe32a75531" width="350"></td>
<td><img src="https://github.com/user-attachments/assets/fec967f7-c81d-4620-b912-7a1a911c498a" width="350"></td> 
</tr>
</table>
