# gedcom-parser
 A 4D project for parsing GEDCOM files. 

This is a 4D Project requiring v18R4+. 

## GEDCOM
Anyone who has spent any time at all reseraching genealogy has come accross the [GEDCOM file format](https://en.wikipedia.org/wiki/GEDCOM#:~:text=GEDCOM%20(%2F%CB%88d%CA%92%C9%9Bd,an%20aid%20to%20genealogical%20research). It's a very simple approach to building a data transmission file using human-readable text. it's simplicity tends to obscure the difficulty one quickly runs into when attempting to parse the data back out.

## This Project
This project provides a structure for importing and storing multiple GEDCOMS. The current status of the project is to read any number of GEDCOM files, create a record for each file and then parse the contents into separate records linked to that file. 

In the current state this is areally a develoer tool as it doesn't do anything more than reliably parse the contents of a GEDCOM. However, it will reliably do that. 

## USE
Download and open with 4D. The Gedcom Browser opens by default. The RESOURCES folder contains two `torture test` files which preseent every possible gedcom tag and field in various, technically legal, uses. 

Click the + button to add one or more files. I placed the emphasis here on reliably importing all the data. It's possible to construct searches on the data as is but my intent is to take the parsed data and distribute it to a more comprehensive database. 
