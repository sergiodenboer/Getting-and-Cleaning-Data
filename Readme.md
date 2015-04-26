---
title: "Readme.md"
author: "Sérgio den Boer"
date: "20 de Abril de 2015"
output: html_document
---

This document serves has a global strategy mapping for my reasoning to transform the dataset.

The starting point of my analysis started with the analysis of the features and the overall characteristics of the dataset. This was performed by assessing the information found under the dataset's documentation to figure out the author's idea with packing and the overall context of the data.

The second step was to load the dataset and the features into R. Please refer to the comments in run_analysis.R script to figure out my reasoning.

By comparing the training and test sets dimensions with the feature's vector length (562 features) I've rapidly concluded that each row in the feature's file corresponded to each column in the corresponding test and trained data frame. By applying a regular expression search with grep by mean and std respectively, I've found all the columns that I was interested in.

The second step was to merge the training and test set using rbind function to obtain the final dataset with correct column names. Before this process activities and subject ids were also appended to their corresponding train and test set. The used column names are does presented in the feature information file.  All the date was merged into one huge data set in a row basis.

To construct the final data set, from the previously merged data set, two splits were performed, one by subject id and another by activity ID. A mean calculation by column was performed and joined to the final data set.





