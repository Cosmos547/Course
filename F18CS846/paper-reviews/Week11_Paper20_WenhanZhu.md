### An Empirical Study of Goto in C Code from GitHub Repositories

#### Summary

This paper examined the original paper by Dijkstra on goto statements and performed an empirical study on the usage of goto statements in github C projects and concludes that goto statements in practice are used in a structured way that does not cause harm. The data is collected from Github by looking at every C project that have more than 10 files. Then it is filtered to see which files contains goto statements. Then the authors manually examined a portion of the files containing goto statements to see the usage of goto statements and have a classification of the files that uses goto statements. The results shows that goto statements are mostly used for handling errors and cleaning resources. The authors also looked at whether goto statements are modified or removed by developers after release. The results of looking at 6 projects shows than 4 of which does not contain modification or removal of goto statements. And of the 2 projects, goto statements were only modified for bug fixes.

#### Things I would like to see discussed:

- The majority of the use case of goto in C is due to not having another elegant way to handle the usage. I wonder if it's still the case when goto is a choice and will it be used.

- If the above usage is removed what are the usage of goto in those cases.

- Many algorithms (pseudo code) uses goto and that's in the theory part. Is goto unavoidable?
