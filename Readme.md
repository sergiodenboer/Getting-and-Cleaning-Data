---
title: "Readme.md"
author: "Sérgio den Boer"
date: "20 de Abril de 2015"
output: html_document
---

This document serves has a global strategy mapping for my reasoning to transform the dataset.

The starting point of my analysis started with the analysis of the features and the overall characteristics of the dataset. This was performed by acessing the information found under the dataset's documentation to figure out the author's idea with the packing and context of the data.

The second step was to load the dataset and the features into R. Please reffer to the comments in run_analysis.R script.

By comparing the training and test sets dimensions with the feature's vector length (562 features) I've rappidly concluded that each row in the feacture's file corresponded to each column in the corresponding test and traind data frame. By applying a regular expressuin search with grep by mean and std respectivly, i've found all the columns that I was interset in.

The second step was to merge the traing and test set using rbind function to obtain the final dataset with correct colum names. The used column names are does presented in the feature information file. Activities and subject ids were also apended to their corresponding train and test set. All the date was merged into one huge dataset in a row basis.

To construct the final dataset, from the previously merged dataset, two splits were performed, one by subject id and another by activity ID. A mean calculation by column was performed and joined to the final dataset.


Using the variable name the components were found in the merged dataset. The activity label was added in the end.




