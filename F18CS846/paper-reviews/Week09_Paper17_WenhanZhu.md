###IccTA: Detecting Inter-Component Privacy Leaks in Android Apps

#### Summary

This paper introduces a tool IccTA that detects Inter-Component privacy leaks. The tool works by tracing data from ICC model and detect possibility of leaks. It uses the tool on some data set to compare the result with other similar tools. IccTA have clear advantage over all the other tools and provide more functionality. One of the results ran on dataset showed that Malware tend to contain more ICC leaks which make IccTA a good tool to detect such Malware.

#### Things I would like to see discussed

- The details of randomness. Based on some census we discussed in class a huge portion of the playstore apps are irrelevant, e.g. hello-world apps or apps with no rating. In my opinion a random set of apps of similar LOC or complexity if measurable would be a more reasonable compare.

- Performance evaluation. The way performance is evaluated is through testing on a testbench and compare the runtime in the same environment. I'm wondering is the complexity important in those kind of analysis?

- What a leak and what's a authorized share. I can't seem to figure out how IccTA would differentiable between a leak and a user agreed share of "privacy" data. 
