### Techniques for improving regression testing in continuous integration development environments

#### Summary

This paper looked at traditional testing and applied it with novel ideas to the area of continuous integration environments to achieve better efficiency to save time. They focused on regression test selection (RTS) and test case prioritization (TCP) during different phases of testing and achieved improvement over testing without prioritizing. Their method looks at time window of different testing for executing tests. The dataset from Google is also a contribution of the paper. It consists of over 3 million test suites over 30 days covering many languages.

#### Things I would like to see discussed

- To my understanding CI are language specific, does this imply they wrote the algorithm for every language and tested it?

- Are there any similar datasets besides industrial setting? In the description the process how these data are collected seems almost impossible for FOS projects

- I would like to see more discussion on the difference between RTS, TCP in traditional testing and CI testing.
