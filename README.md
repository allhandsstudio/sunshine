# sunshine

Climate modeling is very important, but it is also hidden away. Even motivated, technical folks can't play around with it.

Why are climate models hard to use?

- They were developed for traditional HPC and supercomputing environments, and those assumptions are baked into their 
- They use technologies that, while very reliable and performant, are not familiar to most developers. A typical stack will be Fortran, Perl, XML, NetCDF data files, and cshell scripts.
- They require a huge amount of domain knowledge to truly understand, both formal and informal. This knowledge has traditionally been kept within a small, tightly-knit research community. Many of these models have decades of history, and have been handed down from one generation of researchers to the next.

A standard reaction might be: it's ok that these things have very high barriers to entry. The outputs of these models are easy to misinterpret. Climate is very political, and making it easier for people to play with the models will open their results up to even more criticism. And besides: these models are just intrinsically complicated, so what does it matter if they are hard to run?

This project is an experiment - both technical and social - to determine whether all of the obstacles above can be overcome. Can an earth system model be ported to modern, accessible cloud infrastructure, and made easy to run and administer? Can the unfamiliar technologies at the heart of these models be tamed - whether through encapsulation or other means? And, perhaps most dauntingly, can the deep, distributed knowledge needed to use and make sense of these models be externalized?

Let's find out!

Most of the action will be on the [project wiki](https://github.com/beaucronin/sunshine/wiki), but a few preliminary notes to start.

There are a number of coupled earth system models that are under active development around the world. This project has chosen the Community Earth System Model because it is far and away the most accessible to outside development.

Major project components:

- Data repository
- Model code repo
- Model deployment
- Model run control and configuration
- Results post-processing and visualization

Principles and Assumptions:

- Accept the foundational model (CESM 1.2) as-is, and encapsulate it rather than adapting or (god forbid) writing a model from scratch
- Don't be afraid to provide defaults and otherwise reduce optionality and degrees of freedom in the interface, in the service of accessibility
- Take knowledge sharing seriously from day one, and develop tools for a community to form and learn together
