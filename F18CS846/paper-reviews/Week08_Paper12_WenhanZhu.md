### Coverage Is Not Strongly Correlated with Test Suite Effectiveness

#### Summary

This paper looked at test suite effectiveness by coverage and size of test suite. It conducted study on a few major Java libraries that consists of very large code base and test suite size. The results showed that the amount of tests is highly correlated with effectiveness. And by comparison results from normalized and non-normalized results of coverage, it seems that coverage is not strongly correlated to effectiveness by Kendal's metric. 

#### Things I would like to see discussed

- Java? It seems like the majority of the paper we read are on Java. Is this due to Java being the most popular language in the past decade or it's just they are carefully picked?

- MSR scale on line of code or project number. This study seems to be very large scale at code base but very limited at the number of projects. Are those differences significant in MSR study?

- What does the results of coverage imply? Does in show that redundant tests only for every method is not very useful?
