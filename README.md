# KentErlangMooc
Functional Programming In Erlang MOOC from University of Kent

## Programming challenge: Indexing a File
### Example Usage
```
c(index).
index:main(index:get_file_contents("filename.txt")).
```
### How I addressed the challenge
- Parsing line by line to get all the "words" from it and adding it to the output list.
- In the add function we decide (Filter, normalize, etc) which word gets into the list.
- On each success add the line occurrence list of the word is updated.
- And when all this is finished we sort list alphabetically.
